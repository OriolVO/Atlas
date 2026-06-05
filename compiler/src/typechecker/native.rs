use std::collections::HashMap;

use crate::error::{AtlasError, Span};
use crate::lexer::IntSuffix;
use crate::parser::{
    BinOp, Expr, Item, SourceFile, Stmt, TypeExpr, UnaryOp,
};
use crate::resolver::Project;

use super::{AtlasType, FnSignature, TypedAST};

pub struct NativeTypeChecker;

pub enum NativeProjectCheck {
    Typed(TypedAST),
    Unsupported,
    Errors(Vec<(String, String, Vec<AtlasError>)>),
}

pub enum NativeSingleCheck {
    Typed(TypedAST),
    Unsupported,
    Errors(Vec<AtlasError>),
}

impl NativeTypeChecker {
    pub fn new() -> Self {
        Self
    }

    pub fn try_check(&self, ast: &mut SourceFile) -> NativeSingleCheck {
        match check_file(ast) {
            Ok(typed) => NativeSingleCheck::Typed(typed),
            Err(NativeCheckError::Unsupported) => NativeSingleCheck::Unsupported,
            Err(NativeCheckError::Errors(errors)) => NativeSingleCheck::Errors(errors),
        }
    }

    pub fn try_check_project(&self, project: &mut Project) -> NativeProjectCheck {
        let Some(main_ast) = project.modules.get_mut("main") else {
            return NativeProjectCheck::Errors(vec![(
                "<native>".to_string(),
                String::new(),
                vec![AtlasError::TypeError {
                    span: Span::new(0, 0),
                    message: "project is missing the 'main' module".to_string(),
                    hint: None,
                }],
            )]);
        };

        match check_file(main_ast) {
            Ok(typed) => NativeProjectCheck::Typed(typed),
            Err(NativeCheckError::Unsupported) => NativeProjectCheck::Unsupported,
            Err(NativeCheckError::Errors(errors)) => {
                let (path, source) = project
                    .sources
                    .get("main")
                    .map(|(path, source)| (path.to_string_lossy().into_owned(), source.clone()))
                    .unwrap_or_else(|| ("<main>".to_string(), String::new()));
                NativeProjectCheck::Errors(vec![(path, source, errors)])
            }
        }
    }
}

enum NativeCheckError {
    Unsupported,
    Errors(Vec<AtlasError>),
}

struct Checker {
    fn_sigs: HashMap<String, FnSignature>,
    errors: Vec<AtlasError>,
}

impl Checker {
    fn new() -> Self {
        Self {
            fn_sigs: HashMap::new(),
            errors: Vec::new(),
        }
    }

    fn build_signatures(&mut self, ast: &SourceFile) -> Result<(), NativeCheckError> {
        for item in &ast.items {
            match item {
                Item::FunctionDecl(decl, _) => {
                    if !decl.generic_params.is_empty() || !decl.where_clauses.is_empty() {
                        return Err(NativeCheckError::Unsupported);
                    }
                    let mut params = Vec::new();
                    for param in &decl.params {
                        let ty = resolve_native_type(&param.ty.0).ok_or(NativeCheckError::Unsupported)?;
                        params.push((param.name.0.clone(), ty));
                    }
                    let ret_ty = decl
                        .ret_ty
                        .as_ref()
                        .map(|ret| resolve_native_type(&ret.0).ok_or(NativeCheckError::Unsupported))
                        .transpose()?
                        .unwrap_or(AtlasType::Void);
                    self.fn_sigs.insert(decl.name.0.clone(), FnSignature { params, ret_ty });
                }
                Item::ExternFnDecl(decl, _) => {
                    let mut params = Vec::new();
                    for param in &decl.params {
                        let ty = resolve_native_type(&param.ty.0).ok_or(NativeCheckError::Unsupported)?;
                        params.push((param.name.0.clone(), ty));
                    }
                    let ret_ty = decl
                        .ret_ty
                        .as_ref()
                        .map(|ret| resolve_native_type(&ret.0).ok_or(NativeCheckError::Unsupported))
                        .transpose()?
                        .unwrap_or(AtlasType::Void);
                    self.fn_sigs.insert(decl.name.0.clone(), FnSignature { params, ret_ty });
                }
                Item::Import(_) => {}
                _ => return Err(NativeCheckError::Unsupported),
            }
        }
        Ok(())
    }

    fn check_file(mut self, ast: &SourceFile) -> Result<TypedAST, NativeCheckError> {
        self.build_signatures(ast)?;

        for item in &ast.items {
            if let Item::FunctionDecl(decl, _) = item {
                self.check_function(decl)?;
            }
        }

        if self.errors.is_empty() {
            Ok(TypedAST {
                fn_sigs: self.fn_sigs,
                expr_types: HashMap::new(),
                structs: HashMap::new(),
                classes: HashMap::new(),
                enums: HashMap::new(),
                choices: HashMap::new(),
                mangled_calls: HashMap::new(),
                overloaded_operators: HashMap::new(),
                precompiled_ir: None,
            })
        } else {
            Err(NativeCheckError::Errors(self.errors))
        }
    }

    fn check_function(&mut self, decl: &crate::parser::FunctionDecl) -> Result<(), NativeCheckError> {
        let sig = self.fn_sigs.get(&decl.name.0).cloned().ok_or(NativeCheckError::Unsupported)?;
        let mut locals: HashMap<String, AtlasType> = sig.params.into_iter().collect();
        self.check_block(&decl.body, &mut locals, &sig.ret_ty)
    }

    fn check_block(
        &mut self,
        block: &crate::parser::Block,
        locals: &mut HashMap<String, AtlasType>,
        expected_ret: &AtlasType,
    ) -> Result<(), NativeCheckError> {
        for stmt in &block.stmts {
            self.check_stmt(stmt, locals, expected_ret)?;
        }
        Ok(())
    }

    fn check_stmt(
        &mut self,
        stmt: &Stmt,
        locals: &mut HashMap<String, AtlasType>,
        expected_ret: &AtlasType,
    ) -> Result<(), NativeCheckError> {
        match stmt {
            Stmt::VarDecl(decl) => {
                let Some(init) = &decl.init else {
                    return Err(NativeCheckError::Unsupported);
                };
                let init_ty = self.check_expr(init, locals)?;
                let var_ty = if let Some(hint) = &decl.ty_hint {
                    let hint_ty = resolve_native_type(&hint.0).ok_or(NativeCheckError::Unsupported)?;
                    if hint_ty != init_ty {
                        self.errors.push(AtlasError::TypeError {
                            span: decl.span,
                            message: format!("mismatched initializer type: expected '{:?}', found '{:?}'", hint_ty, init_ty),
                            hint: None,
                        });
                    }
                    hint_ty
                } else {
                    init_ty
                };
                locals.insert(decl.name.0.clone(), var_ty);
            }
            Stmt::ConstDecl(decl) => {
                let init_ty = self.check_expr(&decl.init, locals)?;
                if let Some(hint) = &decl.ty_hint {
                    let hint_ty = resolve_native_type(&hint.0).ok_or(NativeCheckError::Unsupported)?;
                    if hint_ty != init_ty {
                        self.errors.push(AtlasError::TypeError {
                            span: decl.span,
                            message: format!("mismatched initializer type: expected '{:?}', found '{:?}'", hint_ty, init_ty),
                            hint: None,
                        });
                    }
                }
                locals.insert(decl.name.0.clone(), init_ty);
            }
            Stmt::Assign(assign) => {
                let Expr::Var { name, .. } = &assign.target else {
                    return Err(NativeCheckError::Unsupported);
                };
                let Some(target_ty) = locals.get(name).cloned() else {
                    self.errors.push(AtlasError::TypeError {
                        span: assign.span,
                        message: format!("unknown variable '{}'", name),
                        hint: None,
                    });
                    return Ok(());
                };
                let value_ty = self.check_expr(&assign.value, locals)?;
                if target_ty != value_ty {
                    self.errors.push(AtlasError::TypeError {
                        span: assign.span,
                        message: format!("cannot assign '{:?}' to '{:?}'", value_ty, target_ty),
                        hint: None,
                    });
                }
            }
            Stmt::ExprStmt(expr) => {
                self.check_expr(expr, locals)?;
            }
            Stmt::Return(expr, span) => {
                let actual = if let Some(expr) = expr {
                    self.check_expr(expr, locals)?
                } else {
                    AtlasType::Void
                };
                if &actual != expected_ret {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: format!("return type mismatch: expected '{:?}', found '{:?}'", expected_ret, actual),
                        hint: None,
                    });
                }
            }
            Stmt::If(if_stmt) => {
                let cond_ty = self.check_expr(&if_stmt.condition, locals)?;
                if cond_ty != AtlasType::Bool {
                    self.errors.push(AtlasError::TypeError {
                        span: if_stmt.condition.span(),
                        message: "if condition must be bool".to_string(),
                        hint: None,
                    });
                }
                let mut then_locals = locals.clone();
                self.check_block(&if_stmt.then_block, &mut then_locals, expected_ret)?;
                for (cond, block) in &if_stmt.else_if_clauses {
                    let cond_ty = self.check_expr(cond, locals)?;
                    if cond_ty != AtlasType::Bool {
                        self.errors.push(AtlasError::TypeError {
                            span: cond.span(),
                            message: "else-if condition must be bool".to_string(),
                            hint: None,
                        });
                    }
                    let mut branch_locals = locals.clone();
                    self.check_block(block, &mut branch_locals, expected_ret)?;
                }
                if let Some(block) = &if_stmt.else_block {
                    let mut else_locals = locals.clone();
                    self.check_block(block, &mut else_locals, expected_ret)?;
                }
            }
            Stmt::While(while_stmt) => {
                let cond_ty = self.check_expr(&while_stmt.condition, locals)?;
                if cond_ty != AtlasType::Bool {
                    self.errors.push(AtlasError::TypeError {
                        span: while_stmt.condition.span(),
                        message: "while condition must be bool".to_string(),
                        hint: None,
                    });
                }
                let mut body_locals = locals.clone();
                self.check_block(&while_stmt.body, &mut body_locals, expected_ret)?;
            }
            Stmt::Block(block) => {
                let mut nested = locals.clone();
                self.check_block(block, &mut nested, expected_ret)?;
            }
            Stmt::StructDecl(_) => return Err(NativeCheckError::Unsupported),
        }
        Ok(())
    }

    fn check_expr(
        &mut self,
        expr: &Expr,
        locals: &HashMap<String, AtlasType>,
    ) -> Result<AtlasType, NativeCheckError> {
        match expr {
            Expr::IntLit { suffix, .. } => Ok(match suffix {
                Some(IntSuffix::I32) => AtlasType::Int32,
                Some(IntSuffix::I8) => AtlasType::Int8,
                Some(IntSuffix::I16) => AtlasType::Int16,
                Some(IntSuffix::I64) | None => AtlasType::Int,
                Some(IntSuffix::U8) => AtlasType::Uint8,
                Some(IntSuffix::U16) => AtlasType::Uint16,
                Some(IntSuffix::U32) => AtlasType::Uint32,
                Some(IntSuffix::U64) => AtlasType::Uint,
            }),
            Expr::FloatLit { .. } => Ok(AtlasType::Float),
            Expr::BoolLit { .. } => Ok(AtlasType::Bool),
            Expr::CharLit { .. } => Ok(AtlasType::Char),
            Expr::Var { name, span } => {
                if let Some(ty) = locals.get(name) {
                    Ok(ty.clone())
                } else if let Some(sig) = self.fn_sigs.get(name) {
                    Ok(sig.ret_ty.clone())
                } else {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: format!("unknown name '{}'", name),
                        hint: None,
                    });
                    Ok(AtlasType::Void)
                }
            }
            Expr::Group { inner, .. } => self.check_expr(inner, locals),
            Expr::Unary { op, operand, span } => {
                let ty = self.check_expr(operand, locals)?;
                match op {
                    UnaryOp::Neg if is_numeric(&ty) => Ok(ty),
                    UnaryOp::Not if ty == AtlasType::Bool => Ok(AtlasType::Bool),
                    _ => {
                        self.errors.push(AtlasError::TypeError {
                            span: *span,
                            message: format!("unsupported unary op '{:?}' for '{:?}'", op, ty),
                            hint: None,
                        });
                        Ok(ty)
                    }
                }
            }
            Expr::Binary { op, lhs, rhs, span } => {
                let lhs_ty = self.check_expr(lhs, locals)?;
                let rhs_ty = self.check_expr(rhs, locals)?;
                check_binary(op, lhs_ty, rhs_ty, *span, &mut self.errors)
            }
            Expr::Call { callee, args, span } => {
                let Some(sig) = self.fn_sigs.get(callee).cloned() else {
                    return Err(NativeCheckError::Unsupported);
                };
                if sig.params.len() != args.len() {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: format!("wrong argument count for '{}'", callee),
                        hint: None,
                    });
                    return Ok(sig.ret_ty);
                }
                for (arg, (_, expected_ty)) in args.iter().zip(sig.params.iter()) {
                    let actual = self.check_expr(arg, locals)?;
                    if &actual != expected_ty {
                        self.errors.push(AtlasError::TypeError {
                            span: arg.span(),
                            message: format!("argument type mismatch: expected '{:?}', found '{:?}'", expected_ty, actual),
                            hint: None,
                        });
                    }
                }
                Ok(sig.ret_ty)
            }
            Expr::SizeOf { .. } | Expr::Cast { .. } | Expr::Destroy { .. } => Err(NativeCheckError::Unsupported),
            _ => Err(NativeCheckError::Unsupported),
        }
    }
}

fn check_file(ast: &SourceFile) -> Result<TypedAST, NativeCheckError> {
    Checker::new().check_file(ast)
}

fn resolve_native_type(ty: &TypeExpr) -> Option<AtlasType> {
    match ty {
        TypeExpr::Named(name) => match name.as_str() {
            "int" | "int64" => Some(AtlasType::Int),
            "int32" => Some(AtlasType::Int32),
            "int16" => Some(AtlasType::Int16),
            "int8" => Some(AtlasType::Int8),
            "uint" | "uint64" => Some(AtlasType::Uint),
            "uint32" => Some(AtlasType::Uint32),
            "uint16" => Some(AtlasType::Uint16),
            "uint8" => Some(AtlasType::Uint8),
            "float" | "float64" => Some(AtlasType::Float),
            "float32" => Some(AtlasType::Float32),
            "bool" => Some(AtlasType::Bool),
            "char" => Some(AtlasType::Char),
            "void" => Some(AtlasType::Void),
            _ => None,
        },
        _ => None,
    }
}

fn is_numeric(ty: &AtlasType) -> bool {
    matches!(
        ty,
        AtlasType::Int
            | AtlasType::Int8
            | AtlasType::Int16
            | AtlasType::Int32
            | AtlasType::Uint
            | AtlasType::Uint8
            | AtlasType::Uint16
            | AtlasType::Uint32
            | AtlasType::Float
            | AtlasType::Float32
    )
}

fn check_binary(
    op: &BinOp,
    lhs_ty: AtlasType,
    rhs_ty: AtlasType,
    span: Span,
    errors: &mut Vec<AtlasError>,
) -> Result<AtlasType, NativeCheckError> {
    use BinOp::*;
    match op {
        Add | Sub | Mul | Div | Mod => {
            if lhs_ty == rhs_ty && is_numeric(&lhs_ty) {
                Ok(lhs_ty)
            } else {
                errors.push(AtlasError::TypeError {
                    span,
                    message: format!("invalid arithmetic operands '{:?}' and '{:?}'", lhs_ty, rhs_ty),
                    hint: None,
                });
                Ok(lhs_ty)
            }
        }
        Eq | NotEq | Lt | Gt | LtEq | GtEq => {
            if lhs_ty == rhs_ty && (is_numeric(&lhs_ty) || lhs_ty == AtlasType::Bool || lhs_ty == AtlasType::Char) {
                Ok(AtlasType::Bool)
            } else {
                errors.push(AtlasError::TypeError {
                    span,
                    message: format!("invalid comparison operands '{:?}' and '{:?}'", lhs_ty, rhs_ty),
                    hint: None,
                });
                Ok(AtlasType::Bool)
            }
        }
        And | Or => {
            if lhs_ty == AtlasType::Bool && rhs_ty == AtlasType::Bool {
                Ok(AtlasType::Bool)
            } else {
                errors.push(AtlasError::TypeError {
                    span,
                    message: "logical operators require bool operands".to_string(),
                    hint: None,
                });
                Ok(AtlasType::Bool)
            }
        }
    }
}
