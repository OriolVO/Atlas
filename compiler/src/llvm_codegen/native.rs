use std::collections::HashMap;

use crate::error::AtlasError;
use crate::parser::{BinOp, Block, Expr, Item, SourceFile, Stmt, UnaryOp};
use crate::typechecker::{AtlasType, TypedAST};

pub struct NativeCodegen {
    typed_ast: TypedAST,
    output: String,
    temp_counter: usize,
    label_counter: usize,
    scopes: Vec<HashMap<String, (String, AtlasType)>>,
    block_terminated: bool,
    current_fn_is_main: bool,
}

impl NativeCodegen {
    pub fn new(typed_ast: TypedAST) -> Self {
        Self {
            typed_ast,
            output: String::new(),
            temp_counter: 0,
            label_counter: 0,
            scopes: Vec::new(),
            block_terminated: false,
            current_fn_is_main: false,
        }
    }

    pub fn generate(mut self, ast: &SourceFile) -> Result<String, AtlasError> {
        self.output.push_str("; Atlas compiler v0.1.0 — native backend slice\n");
        self.output.push_str("source_filename = \"input.atl\"\n");
        self.output.push_str("target datalayout = \"e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128\"\n");
        self.output.push_str("target triple = \"x86_64-unknown-linux-gnu\"\n\n");

        for item in &ast.items {
            if let Item::ExternFnDecl(decl, _) = item {
                self.emit_extern(decl)?;
            }
        }

        for item in &ast.items {
            if let Item::FunctionDecl(decl, _) = item {
                self.emit_function(decl)?;
            }
        }

        Ok(self.output)
    }

    fn emit_extern(&mut self, decl: &crate::parser::ExternFnDecl) -> Result<(), AtlasError> {
        let ret_ty = decl
            .ret_ty
            .as_ref()
            .map(|ret| map_type_expr(&ret.0))
            .unwrap_or_else(|| Ok("void".to_string()))?;
        let mut params = Vec::new();
        for param in &decl.params {
            params.push(map_type_expr(&param.ty.0)?);
        }
        self.output.push_str(&format!(
            "declare {} @{}({})\n",
            ret_ty,
            decl.name.0,
            params.join(", ")
        ));
        Ok(())
    }

    fn emit_function(&mut self, decl: &crate::parser::FunctionDecl) -> Result<(), AtlasError> {
        self.current_fn_is_main = decl.name.0 == "main";
        self.block_terminated = false;

        let ret_ty = if self.current_fn_is_main {
            "i32".to_string()
        } else {
            decl.ret_ty
                .as_ref()
                .map(|ret| map_type_expr(&ret.0))
                .unwrap_or_else(|| Ok("void".to_string()))?
        };

        let mut params = Vec::new();
        for param in &decl.params {
            params.push(format!("{} %{}", map_type_expr(&param.ty.0)?, param.name.0));
        }

        self.output.push_str(&format!(
            "define {} @{}({}) {{\nentry:\n",
            ret_ty,
            decl.name.0,
            params.join(", ")
        ));

        self.scopes.push(HashMap::new());
        for param in &decl.params {
            let llvm_ty = map_type_expr(&param.ty.0)?;
            let ptr = self.next_temp();
            self.output
                .push_str(&format!("    {} = alloca {}\n", ptr, llvm_ty));
            self.output.push_str(&format!(
                "    store {} %{}, {}* {}\n",
                llvm_ty, param.name.0, llvm_ty, ptr
            ));
            self.current_scope_mut()
                .insert(param.name.0.clone(), (ptr, resolve_simple_type(&param.ty.0)?));
        }

        self.emit_block(&decl.body)?;
        if !self.current_block_terminated() {
            if ret_ty == "void" {
                self.output.push_str("    ret void\n");
            } else if ret_ty == "i32" {
                self.output.push_str("    ret i32 0\n");
            } else if ret_ty == "i64" {
                self.output.push_str("    ret i64 0\n");
            } else {
                return Err(AtlasError::CodegenError {
                    message: format!("unsupported implicit return type '{}'", ret_ty),
                });
            }
        }
        self.scopes.pop();
        self.output.push_str("}\n\n");
        self.current_fn_is_main = false;
        Ok(())
    }

    fn emit_block(&mut self, block: &Block) -> Result<(), AtlasError> {
        for stmt in &block.stmts {
            self.emit_stmt(stmt)?;
        }
        Ok(())
    }

    fn emit_scoped_block(&mut self, block: &Block) -> Result<(), AtlasError> {
        self.scopes.push(HashMap::new());
        let result = self.emit_block(block);
        self.scopes.pop();
        result
    }

    fn emit_stmt(&mut self, stmt: &Stmt) -> Result<(), AtlasError> {
        match stmt {
            Stmt::VarDecl(decl) => {
                let init = decl.init.as_ref().ok_or_else(|| AtlasError::CodegenError {
                    message: "native codegen requires initialized local variables".to_string(),
                })?;
                let (value, ty) = self.emit_expr(init)?;
                let llvm_ty = map_type(&ty)?;
                let ptr = self.next_temp();
                self.output
                    .push_str(&format!("    {} = alloca {}\n", ptr, llvm_ty));
                self.output
                    .push_str(&format!("    store {} {}, {}* {}\n", llvm_ty, value, llvm_ty, ptr));
                self.current_scope_mut()
                    .insert(decl.name.0.clone(), (ptr, ty));
            }
            Stmt::ConstDecl(decl) => {
                let (value, ty) = self.emit_expr(&decl.init)?;
                let llvm_ty = map_type(&ty)?;
                let ptr = self.next_temp();
                self.output
                    .push_str(&format!("    {} = alloca {}\n", ptr, llvm_ty));
                self.output
                    .push_str(&format!("    store {} {}, {}* {}\n", llvm_ty, value, llvm_ty, ptr));
                self.current_scope_mut()
                    .insert(decl.name.0.clone(), (ptr, ty));
            }
            Stmt::Assign(assign) => {
                let Expr::Var { name, .. } = &assign.target else {
                    return Err(AtlasError::CodegenError {
                        message: "native codegen only supports variable assignment targets".to_string(),
                    });
                };
                let (ptr, ty) = self.lookup_var(name).ok_or_else(|| AtlasError::CodegenError {
                    message: format!("unknown local '{}'", name),
                })?;
                let (value, value_ty) = self.emit_expr(&assign.value)?;
                if ty != value_ty {
                    return Err(AtlasError::CodegenError {
                        message: format!("assignment type mismatch for '{}'", name),
                    });
                }
                let llvm_ty = map_type(&ty)?;
                self.output
                    .push_str(&format!("    store {} {}, {}* {}\n", llvm_ty, value, llvm_ty, ptr));
            }
            Stmt::ExprStmt(expr) => {
                let _ = self.emit_expr(expr)?;
            }
            Stmt::Return(expr, _) => {
                if let Some(expr) = expr {
                    let (value, ty) = self.emit_expr(expr)?;
                    let mut llvm_ty = map_type(&ty)?;
                    let mut actual_value = value;
                    if self.current_fn_is_main && llvm_ty == "i64" {
                        let casted = self.next_temp();
                        self.output
                            .push_str(&format!("    {} = trunc i64 {} to i32\n", casted, actual_value));
                        llvm_ty = "i32".to_string();
                        actual_value = casted;
                    }
                    self.output
                        .push_str(&format!("    ret {} {}\n", llvm_ty, actual_value));
                } else {
                    self.output.push_str("    ret void\n");
                }
                self.block_terminated = true;
            }
            Stmt::If(if_stmt) => {
                let (cond, cond_ty) = self.emit_expr(&if_stmt.condition)?;
                if cond_ty != AtlasType::Bool {
                    return Err(AtlasError::CodegenError {
                        message: "if condition must lower to bool".to_string(),
                    });
                }
                let then_label = self.next_label("if_then");
                let else_label = self.next_label("if_else");
                let end_label = self.next_label("if_end");
                self.output.push_str(&format!(
                    "    br i1 {}, label %{}, label %{}\n",
                    cond, then_label, else_label
                ));
                self.block_terminated = true;
                self.emit_label(&then_label);
                self.emit_scoped_block(&if_stmt.then_block)?;
                if !self.current_block_terminated() {
                    self.output.push_str(&format!("    br label %{}\n", end_label));
                    self.block_terminated = true;
                }

                self.emit_label(&else_label);
                for (cond_expr, block) in &if_stmt.else_if_clauses {
                    let nested_then = self.next_label("elseif_then");
                    let nested_else = self.next_label("elseif_else");
                    let (nested_cond, _) = self.emit_expr(cond_expr)?;
                    self.output.push_str(&format!(
                        "    br i1 {}, label %{}, label %{}\n",
                        nested_cond, nested_then, nested_else
                    ));
                    self.block_terminated = true;
                    self.emit_label(&nested_then);
                    self.emit_scoped_block(block)?;
                    if !self.current_block_terminated() {
                        self.output.push_str(&format!("    br label %{}\n", end_label));
                        self.block_terminated = true;
                    }
                    self.emit_label(&nested_else);
                }
                if let Some(block) = &if_stmt.else_block {
                    self.emit_scoped_block(block)?;
                }
                if !self.current_block_terminated() {
                    self.output.push_str(&format!("    br label %{}\n", end_label));
                    self.block_terminated = true;
                }
                self.emit_label(&end_label);
            }
            Stmt::While(while_stmt) => {
                let cond_label = self.next_label("while_cond");
                let body_label = self.next_label("while_body");
                let end_label = self.next_label("while_end");
                self.output.push_str(&format!("    br label %{}\n", cond_label));
                self.block_terminated = true;
                self.emit_label(&cond_label);
                let (cond, cond_ty) = self.emit_expr(&while_stmt.condition)?;
                if cond_ty != AtlasType::Bool {
                    return Err(AtlasError::CodegenError {
                        message: "while condition must lower to bool".to_string(),
                    });
                }
                self.output.push_str(&format!(
                    "    br i1 {}, label %{}, label %{}\n",
                    cond, body_label, end_label
                ));
                self.block_terminated = true;
                self.emit_label(&body_label);
                self.emit_scoped_block(&while_stmt.body)?;
                if !self.current_block_terminated() {
                    self.output.push_str(&format!("    br label %{}\n", cond_label));
                    self.block_terminated = true;
                }
                self.emit_label(&end_label);
            }
            Stmt::Block(block) => self.emit_scoped_block(block)?,
            Stmt::StructDecl(_) => {
                return Err(AtlasError::CodegenError {
                    message: "native codegen does not support local structs".to_string(),
                });
            }
        }
        Ok(())
    }

    fn emit_expr(&mut self, expr: &Expr) -> Result<(String, AtlasType), AtlasError> {
        match expr {
            Expr::IntLit { value, suffix, .. } => Ok((
                value.to_string(),
                match suffix {
                    Some(crate::lexer::IntSuffix::I32) => AtlasType::Int32,
                    Some(crate::lexer::IntSuffix::I8) => AtlasType::Int8,
                    Some(crate::lexer::IntSuffix::I16) => AtlasType::Int16,
                    Some(crate::lexer::IntSuffix::I64) | None => AtlasType::Int,
                    Some(crate::lexer::IntSuffix::U8) => AtlasType::Uint8,
                    Some(crate::lexer::IntSuffix::U16) => AtlasType::Uint16,
                    Some(crate::lexer::IntSuffix::U32) => AtlasType::Uint32,
                    Some(crate::lexer::IntSuffix::U64) => AtlasType::Uint,
                },
            )),
            Expr::FloatLit { value, .. } => Ok((value.to_string(), AtlasType::Float)),
            Expr::BoolLit { value, .. } => Ok(((if *value { "1" } else { "0" }).to_string(), AtlasType::Bool)),
            Expr::CharLit { value, .. } => Ok(((*value as u32).to_string(), AtlasType::Char)),
            Expr::Var { name, .. } => {
                let (ptr, ty) = self.lookup_var(name).ok_or_else(|| AtlasError::CodegenError {
                    message: format!("unknown variable '{}'", name),
                })?;
                let reg = self.next_temp();
                let llvm_ty = map_type(&ty)?;
                self.output
                    .push_str(&format!("    {} = load {}, {}* {}\n", reg, llvm_ty, llvm_ty, ptr));
                Ok((reg, ty))
            }
            Expr::Group { inner, .. } => self.emit_expr(inner),
            Expr::Unary { op, operand, .. } => {
                let (value, ty) = self.emit_expr(operand)?;
                match op {
                    UnaryOp::Neg => {
                        let llvm_ty = map_type(&ty)?;
                        let reg = self.next_temp();
                        if is_float(&ty) {
                            self.output
                                .push_str(&format!("    {} = fsub {} 0.0, {}\n", reg, llvm_ty, value));
                        } else {
                            self.output
                                .push_str(&format!("    {} = sub {} 0, {}\n", reg, llvm_ty, value));
                        }
                        Ok((reg, ty))
                    }
                    UnaryOp::Not => {
                        let reg = self.next_temp();
                        self.output
                            .push_str(&format!("    {} = xor i1 {}, true\n", reg, value));
                        Ok((reg, AtlasType::Bool))
                    }
                    _ => Err(AtlasError::CodegenError {
                        message: "native codegen does not support this unary operator".to_string(),
                    }),
                }
            }
            Expr::Binary { op, lhs, rhs, .. } => {
                let (lhs_val, lhs_ty) = self.emit_expr(lhs)?;
                let (rhs_val, rhs_ty) = self.emit_expr(rhs)?;
                if lhs_ty != rhs_ty {
                    return Err(AtlasError::CodegenError {
                        message: "binary operand type mismatch".to_string(),
                    });
                }
                emit_binary(&mut self.output, &mut self.temp_counter, op, lhs_val, rhs_val, lhs_ty)
            }
            Expr::Call { callee, args, .. } => {
                let sig = self.typed_ast.fn_sigs.get(callee).cloned().ok_or_else(|| AtlasError::CodegenError {
                    message: format!("unknown function '{}'", callee),
                })?;
                let mut rendered_args = Vec::new();
                for (arg, (_, expected_ty)) in args.iter().zip(sig.params.iter()) {
                    let (value, actual_ty) = self.emit_expr(arg)?;
                    if &actual_ty != expected_ty {
                        return Err(AtlasError::CodegenError {
                            message: format!("call argument type mismatch for '{}'", callee),
                        });
                    }
                    rendered_args.push(format!("{} {}", map_type(expected_ty)?, value));
                }
                if sig.ret_ty == AtlasType::Void {
                    self.output.push_str(&format!(
                        "    call {} @{}({})\n",
                        map_type(&sig.ret_ty)?,
                        callee,
                        rendered_args.join(", ")
                    ));
                    Ok(("0".to_string(), AtlasType::Void))
                } else {
                    let reg = self.next_temp();
                    self.output.push_str(&format!(
                        "    {} = call {} @{}({})\n",
                        reg,
                        map_type(&sig.ret_ty)?,
                        callee,
                        rendered_args.join(", ")
                    ));
                    Ok((reg, sig.ret_ty.clone()))
                }
            }
            _ => Err(AtlasError::CodegenError {
                message: "expression not yet supported by native codegen".to_string(),
            }),
        }
    }

    fn lookup_var(&self, name: &str) -> Option<(String, AtlasType)> {
        self.scopes
            .iter()
            .rev()
            .find_map(|scope| scope.get(name).cloned())
    }

    fn current_scope_mut(&mut self) -> &mut HashMap<String, (String, AtlasType)> {
        self.scopes.last_mut().expect("scope stack is empty")
    }

    fn next_temp(&mut self) -> String {
        let name = format!("%tmp{}", self.temp_counter);
        self.temp_counter += 1;
        name
    }

    fn next_label(&mut self, prefix: &str) -> String {
        let name = format!("{}.{}", prefix, self.label_counter);
        self.label_counter += 1;
        name
    }

    fn emit_label(&mut self, label: &str) {
        self.output.push_str(&format!("{}:\n", label));
        self.block_terminated = false;
    }

    fn current_block_terminated(&self) -> bool {
        self.block_terminated
    }
}

fn emit_binary(
    output: &mut String,
    temp_counter: &mut usize,
    op: &BinOp,
    lhs: String,
    rhs: String,
    ty: AtlasType,
) -> Result<(String, AtlasType), AtlasError> {
    use BinOp::*;
    let reg = format!("%tmp{}", *temp_counter);
    *temp_counter += 1;
    let llvm_ty = map_type(&ty)?;
    let is_float_ty = is_float(&ty);
    match op {
        Add => output.push_str(&format!("    {} = {} {} {}, {}\n", reg, if is_float_ty { "fadd" } else { "add" }, llvm_ty, lhs, rhs)),
        Sub => output.push_str(&format!("    {} = {} {} {}, {}\n", reg, if is_float_ty { "fsub" } else { "sub" }, llvm_ty, lhs, rhs)),
        Mul => output.push_str(&format!("    {} = {} {} {}, {}\n", reg, if is_float_ty { "fmul" } else { "mul" }, llvm_ty, lhs, rhs)),
        Div => output.push_str(&format!("    {} = {} {} {}, {}\n", reg, if is_float_ty { "fdiv" } else { "sdiv" }, llvm_ty, lhs, rhs)),
        Mod => output.push_str(&format!("    {} = srem {} {}, {}\n", reg, llvm_ty, lhs, rhs)),
        Eq | NotEq | Lt | Gt | LtEq | GtEq => {
            let pred = match (op, is_float_ty) {
                (Eq, false) => "icmp eq",
                (NotEq, false) => "icmp ne",
                (Lt, false) => "icmp slt",
                (Gt, false) => "icmp sgt",
                (LtEq, false) => "icmp sle",
                (GtEq, false) => "icmp sge",
                (Eq, true) => "fcmp oeq",
                (NotEq, true) => "fcmp one",
                (Lt, true) => "fcmp olt",
                (Gt, true) => "fcmp ogt",
                (LtEq, true) => "fcmp ole",
                (GtEq, true) => "fcmp oge",
                _ => unreachable!(),
            };
            output.push_str(&format!("    {} = {} {} {}, {}\n", reg, pred, llvm_ty, lhs, rhs));
            return Ok((reg, AtlasType::Bool));
        }
        And => output.push_str(&format!("    {} = and i1 {}, {}\n", reg, lhs, rhs)),
        Or => output.push_str(&format!("    {} = or i1 {}, {}\n", reg, lhs, rhs)),
    }
    Ok((reg, ty))
}

fn map_type(ty: &AtlasType) -> Result<String, AtlasError> {
    match ty {
        AtlasType::Int | AtlasType::Uint => Ok("i64".to_string()),
        AtlasType::Int32 | AtlasType::Uint32 => Ok("i32".to_string()),
        AtlasType::Int16 | AtlasType::Uint16 => Ok("i16".to_string()),
        AtlasType::Int8 | AtlasType::Uint8 | AtlasType::Char => Ok("i8".to_string()),
        AtlasType::Float => Ok("double".to_string()),
        AtlasType::Float32 => Ok("float".to_string()),
        AtlasType::Bool => Ok("i1".to_string()),
        AtlasType::Void => Ok("void".to_string()),
        _ => Err(AtlasError::CodegenError {
            message: format!("native codegen does not support type '{:?}'", ty),
        }),
    }
}

fn map_type_expr(ty: &crate::parser::TypeExpr) -> Result<String, AtlasError> {
    map_type(&resolve_simple_type(ty)?)
}

fn resolve_simple_type(ty: &crate::parser::TypeExpr) -> Result<AtlasType, AtlasError> {
    match ty {
        crate::parser::TypeExpr::Named(name) => match name.as_str() {
            "int" | "int64" => Ok(AtlasType::Int),
            "int32" => Ok(AtlasType::Int32),
            "int16" => Ok(AtlasType::Int16),
            "int8" => Ok(AtlasType::Int8),
            "uint" | "uint64" => Ok(AtlasType::Uint),
            "uint32" => Ok(AtlasType::Uint32),
            "uint16" => Ok(AtlasType::Uint16),
            "uint8" => Ok(AtlasType::Uint8),
            "float" | "float64" => Ok(AtlasType::Float),
            "float32" => Ok(AtlasType::Float32),
            "bool" => Ok(AtlasType::Bool),
            "char" => Ok(AtlasType::Char),
            "void" => Ok(AtlasType::Void),
            other => Err(AtlasError::CodegenError {
                message: format!("native codegen does not support type '{}'", other),
            }),
        },
        _ => Err(AtlasError::CodegenError {
            message: "native codegen only supports primitive named types".to_string(),
        }),
    }
}

fn is_float(ty: &AtlasType) -> bool {
    matches!(ty, AtlasType::Float | AtlasType::Float32)
}
