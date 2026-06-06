use std::collections::HashMap;

use crate::error::AtlasError;
use crate::parser::{BinOp, Block, Expr, Item, Pattern, SourceFile, Stmt, UnaryOp};
use crate::typechecker::{AtlasType, ChoiceType, ClassType, StructType, TypedAST};

pub struct NativeCodegen {
    typed_ast: TypedAST,
    output: String,
    globals: String,
    temp_counter: usize,
    label_counter: usize,
    str_counter: usize,
    scopes: Vec<HashMap<String, (String, AtlasType)>>,
    cleanup_scopes: Vec<Vec<(String, AtlasType)>>,
    block_terminated: bool,
    current_fn_is_main: bool,
}

impl NativeCodegen {
    pub fn new(typed_ast: TypedAST) -> Self {
        Self {
            typed_ast,
            output: String::new(),
            globals: String::new(),
            temp_counter: 0,
            label_counter: 0,
            str_counter: 0,
            scopes: Vec::new(),
            cleanup_scopes: Vec::new(),
            block_terminated: false,
            current_fn_is_main: false,
        }
    }

    pub fn generate(mut self, ast: &SourceFile) -> Result<String, AtlasError> {
        self.output
            .push_str("; Atlas compiler v0.1.0 — native backend slice\n");
        self.output.push_str("source_filename = \"input.atl\"\n");
        self.output.push_str("target datalayout = \"e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128\"\n");
        self.output.push_str("target triple = \"x86_64-unknown-linux-gnu\"\n\n");

        self.emit_aggregate_types()?;

        for item in &ast.items {
            if let Item::ExternFnDecl(decl, _) = item {
                if self.typed_ast.fn_sigs.contains_key(&decl.name.0) {
                    self.emit_extern(decl)?;
                }
            }
        }

        if !self.typed_ast.structs.is_empty() || !self.typed_ast.classes.is_empty() || !self.typed_ast.choices.is_empty() {
            self.output.push('\n');
        }

        for item in &ast.items {
            if let Item::ClassDecl(decl, _) = item {
                if self.typed_ast.classes.contains_key(&decl.name.0) {
                    self.emit_class_decl(decl)?;
                }
            }
        }

        for item in &ast.items {
            if let Item::FunctionDecl(decl, _) = item {
                if self.typed_ast.fn_sigs.contains_key(&decl.name.0) {
                    self.emit_function(decl)?;
                }
            }
        }

        if !self.globals.is_empty() {
            self.output.push('\n');
            self.output.push_str(&self.globals);
        }

        Ok(self.output)
    }

    fn emit_aggregate_types(&mut self) -> Result<(), AtlasError> {
        let mut structs: Vec<_> = self.typed_ast.structs.values().cloned().collect();
        structs.sort_by(|a, b| a.name.cmp(&b.name));
        for struct_ty in structs {
            let fields: Vec<String> = struct_ty
                .fields
                .iter()
                .map(|(_, ty)| map_type(ty))
                .collect::<Result<_, _>>()
                .unwrap_or_default();
            self.output.push_str(&format!(
                "%struct.{} = type {{ {} }}\n",
                struct_ty.name,
                fields.join(", ")
            ));
        }
        let mut classes: Vec<_> = self.typed_ast.classes.values().cloned().collect();
        classes.sort_by(|a, b| a.name.cmp(&b.name));
        for class_ty in classes {
            let fields: Vec<String> = class_ty
                .fields
                .iter()
                .map(|field| map_type(&field.ty))
                .collect::<Result<_, _>>()
                .unwrap_or_default();
            self.output.push_str(&format!(
                "%class.{} = type {{ {} }}\n",
                class_ty.name,
                fields.join(", ")
            ));
        }
        let mut choices: Vec<_> = self.typed_ast.choices.values().cloned().collect();
        choices.sort_by(|a, b| a.name.cmp(&b.name));
        for choice_ty in choices {
            let payload_size = self.choice_payload_size(&choice_ty)?;
            self.output.push_str(&format!(
                "%choice.{} = type {{ i32, [{} x i8] }}\n",
                choice_ty.name, payload_size
            ));
        }
        if !self.typed_ast.structs.is_empty() || !self.typed_ast.classes.is_empty() || !self.typed_ast.choices.is_empty() {
            self.output.push('\n');
        }
        Ok(())
    }

    fn emit_extern(&mut self, decl: &crate::parser::ExternFnDecl) -> Result<(), AtlasError> {
        let ret_ty = decl
            .ret_ty
            .as_ref()
            .map(|ret| map_type_expr(&ret.0, &self.typed_ast.structs, &self.typed_ast.classes, &self.typed_ast.enums, &self.typed_ast.choices))
            .unwrap_or_else(|| Ok("void".to_string()))?;
        let mut params = Vec::new();
        for param in &decl.params {
            params.push(map_type_expr(&param.ty.0, &self.typed_ast.structs, &self.typed_ast.classes, &self.typed_ast.enums, &self.typed_ast.choices)?);
        }
        self.output.push_str(&format!(
            "declare {} @{}({})\n",
            ret_ty,
            decl.name.0,
            params.join(", ")
        ));
        Ok(())
    }

    fn choice_payload_size(&self, choice_ty: &ChoiceType) -> Result<usize, AtlasError> {
        let mut max_size = 0;
        for variant in &choice_ty.variants {
            if let Some(payload_ty) = &variant.payload {
                max_size = max_size.max(size_of_type(
                    payload_ty,
                    &self.typed_ast.structs,
                    &self.typed_ast.classes,
                    &self.typed_ast.choices,
                )?);
            }
        }
        Ok(max_size.max(1))
    }

    fn emit_class_decl(&mut self, decl: &crate::parser::ClassDecl) -> Result<(), AtlasError> {
        let class_name = decl.name.0.clone();
        let mut emitted = std::collections::HashSet::new();
        for method in &decl.methods {
            let qualified = format!("{}.{}", class_name, method.decl.name.0);
            if !self.typed_ast.fn_sigs.contains_key(&qualified) {
                continue;
            }
            emitted.insert(method.decl.name.0.clone());
            self.emit_named_function(&qualified, &method.decl)?;
        }

        if !emitted.contains("init") {
            self.emit_default_class_init(&class_name)?;
        }
        if !emitted.contains("destroy") {
            self.emit_default_class_destroy(&class_name)?;
        }
        if !emitted.contains("clone") {
            self.emit_default_class_clone(&class_name)?;
        }
        Ok(())
    }

    fn emit_function(&mut self, decl: &crate::parser::FunctionDecl) -> Result<(), AtlasError> {
        self.emit_named_function(&decl.name.0, decl)
    }

    fn emit_named_function(
        &mut self,
        llvm_name: &str,
        decl: &crate::parser::FunctionDecl,
    ) -> Result<(), AtlasError> {
        self.current_fn_is_main = decl.name.0 == "main";
        self.block_terminated = false;

        let ret_ty = if self.current_fn_is_main {
            "i32".to_string()
        } else {
            decl.ret_ty
                .as_ref()
                .map(|ret| map_type_expr(&ret.0, &self.typed_ast.structs, &self.typed_ast.classes, &self.typed_ast.enums, &self.typed_ast.choices))
                .unwrap_or_else(|| Ok("void".to_string()))?
        };

        let mut params = Vec::new();
        for param in &decl.params {
            params.push(format!(
                "{} %{}",
                map_type_expr(&param.ty.0, &self.typed_ast.structs, &self.typed_ast.classes, &self.typed_ast.enums, &self.typed_ast.choices)?,
                param.name.0
            ));
        }

        self.output.push_str(&format!(
            "define {} @{}({}) {{\nentry:\n",
            ret_ty,
            llvm_name,
            params.join(", ")
        ));

        self.scopes.push(HashMap::new());
        self.cleanup_scopes.push(Vec::new());
        for param in &decl.params {
            let ty = resolve_simple_type(&param.ty.0, &self.typed_ast.structs, &self.typed_ast.classes, &self.typed_ast.enums, &self.typed_ast.choices)?;
            let llvm_ty = map_type(&ty)?;
            let ptr = self.next_temp();
            self.output
                .push_str(&format!("    {} = alloca {}\n", ptr, llvm_ty));
            self.output.push_str(&format!(
                "    store {} %{}, {}* {}\n",
                llvm_ty, param.name.0, llvm_ty, ptr
            ));
            self.current_scope_mut()
                .insert(param.name.0.clone(), (ptr, ty));
        }

        self.emit_block(&decl.body)?;
        if !self.current_block_terminated() {
            self.emit_all_scope_cleanups()?;
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
        self.cleanup_scopes.pop();
        self.output.push_str("}\n\n");
        self.current_fn_is_main = false;
        Ok(())
    }

    fn emit_default_class_init(&mut self, class_name: &str) -> Result<(), AtlasError> {
        let class_ty = map_type(&AtlasType::Class(class_name.to_string()))?;
        self.output.push_str(&format!(
            "define void @{}.init({}* %self) {{\nentry:\n    ret void\n}}\n\n",
            class_name, class_ty
        ));
        Ok(())
    }

    fn emit_default_class_destroy(&mut self, class_name: &str) -> Result<(), AtlasError> {
        let class_ty = map_type(&AtlasType::Class(class_name.to_string()))?;
        self.output.push_str(&format!(
            "define void @{}.destroy({}* %self) {{\nentry:\n    ret void\n}}\n\n",
            class_name, class_ty
        ));
        Ok(())
    }

    fn emit_default_class_clone(&mut self, class_name: &str) -> Result<(), AtlasError> {
        let class_ty = map_type(&AtlasType::Class(class_name.to_string()))?;
        self.output.push_str(&format!(
            "define {} @{}.clone({}* %self) {{\nentry:\n    %tmp0 = load {}, {}* %self\n    ret {} %tmp0\n}}\n\n",
            class_ty, class_name, class_ty, class_ty, class_ty, class_ty
        ));
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
        self.cleanup_scopes.push(Vec::new());
        let result = self.emit_block(block);
        if result.is_ok() && !self.current_block_terminated() {
            self.emit_current_scope_cleanup()?;
        }
        self.scopes.pop();
        self.cleanup_scopes.pop();
        result
    }

    fn emit_stmt(&mut self, stmt: &Stmt) -> Result<(), AtlasError> {
        match stmt {
            Stmt::VarDecl(decl) => {
                let ty = if let Some(hint) = &decl.ty_hint {
                    Some(resolve_simple_type(&hint.0, &self.typed_ast.structs, &self.typed_ast.classes, &self.typed_ast.enums, &self.typed_ast.choices)?)
                } else {
                    None
                };
                let resolved_ty = if let Some(init) = &decl.init {
                    let (value, init_ty, final_ty) = if let Some(expected_ty) = ty.clone() {
                        let (value, init_ty) = self.emit_expr_coerced(init, &expected_ty)?;
                        (value, init_ty, expected_ty)
                    } else {
                        let (value, init_ty) = self.emit_expr(init)?;
                        (value, init_ty.clone(), init_ty)
                    };
                    if !is_assignable_to(&final_ty, &init_ty) {
                        return Err(AtlasError::CodegenError {
                            message: "variable initializer type mismatch".to_string(),
                        });
                    }
                    let llvm_ty = map_type(&final_ty)?;
                    let ptr = self.next_temp();
                    self.output
                        .push_str(&format!("    {} = alloca {}\n", ptr, llvm_ty));
                    self.output.push_str(&format!(
                        "    store {} {}, {}* {}\n",
                        llvm_ty, value, llvm_ty, ptr
                    ));
                    self.current_scope_mut()
                        .insert(decl.name.0.clone(), (ptr.clone(), final_ty.clone()));
                    self.maybe_register_cleanup(ptr, &final_ty);
                    final_ty
                } else {
                    let final_ty = ty.ok_or_else(|| AtlasError::CodegenError {
                        message: "native codegen requires initialized local variables unless an array type is declared".to_string(),
                    })?;
                    if !matches!(final_ty, AtlasType::Array { .. }) {
                        return Err(AtlasError::CodegenError {
                            message: "native codegen only supports uninitialized array locals".to_string(),
                        });
                    }
                    let llvm_ty = map_type(&final_ty)?;
                    let ptr = self.next_temp();
                    self.output
                        .push_str(&format!("    {} = alloca {}\n", ptr, llvm_ty));
                    self.output.push_str(&format!(
                        "    store {} zeroinitializer, {}* {}\n",
                        llvm_ty, llvm_ty, ptr
                    ));
                    self.current_scope_mut()
                        .insert(decl.name.0.clone(), (ptr.clone(), final_ty.clone()));
                    self.maybe_register_cleanup(ptr, &final_ty);
                    final_ty
                };
                let _ = resolved_ty;
            }
            Stmt::ConstDecl(decl) => {
                let (value, ty) = if let Some(hint) = &decl.ty_hint {
                    let expected_ty =
                        resolve_simple_type(&hint.0, &self.typed_ast.structs, &self.typed_ast.classes, &self.typed_ast.enums, &self.typed_ast.choices)?;
                    self.emit_expr_coerced(&decl.init, &expected_ty)?
                } else {
                    self.emit_expr(&decl.init)?
                };
                let llvm_ty = map_type(&ty)?;
                let ptr = self.next_temp();
                self.output
                    .push_str(&format!("    {} = alloca {}\n", ptr, llvm_ty));
                self.output.push_str(&format!(
                    "    store {} {}, {}* {}\n",
                    llvm_ty, value, llvm_ty, ptr
                ));
                self.current_scope_mut().insert(decl.name.0.clone(), (ptr.clone(), ty.clone()));
                self.maybe_register_cleanup(ptr, &ty);
            }
            Stmt::Assign(assign) => {
                let (ptr, ty) = self.emit_lvalue_address(&assign.target)?;
                let (value, value_ty) = self.emit_expr(&assign.value)?;
                if !is_assignable_to(&ty, &value_ty) {
                    return Err(AtlasError::CodegenError {
                        message: "assignment type mismatch".to_string(),
                    });
                }
                let llvm_ty = map_type(&ty)?;
                self.output.push_str(&format!(
                    "    store {} {}, {}* {}\n",
                    llvm_ty, value, llvm_ty, ptr
                ));
            }
            Stmt::ExprStmt(expr) => {
                if let Expr::Match { expr: matched, cases, .. } = expr {
                    self.emit_match_stmt(matched, cases)?;
                } else {
                    let _ = self.emit_expr(expr)?;
                }
            }
            Stmt::Return(expr, _) => {
                if let Some(expr) = expr {
                    let (value, ty) = self.emit_expr(expr)?;
                    let mut llvm_ty = map_type(&ty)?;
                    let mut actual_value = value;
                    if self.current_fn_is_main && llvm_ty == "i64" {
                        let casted = self.next_temp();
                        self.output.push_str(&format!(
                            "    {} = trunc i64 {} to i32\n",
                            casted, actual_value
                        ));
                        llvm_ty = "i32".to_string();
                        actual_value = casted;
                    }
                    let excluded_cleanup = self.returned_cleanup_ptr(expr);
                    self.emit_all_scope_cleanups_except(excluded_cleanup.as_deref())?;
                    self.output.push_str(&format!("    ret {} {}\n", llvm_ty, actual_value));
                } else {
                    self.emit_all_scope_cleanups()?;
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
            Expr::BoolLit { value, .. } => Ok((
                (if *value { "1" } else { "0" }).to_string(),
                AtlasType::Bool,
            )),
            Expr::CharLit { value, .. } => Ok(((*value as u32).to_string(), AtlasType::Char)),
            Expr::Null { .. } => Ok(("null".to_string(), AtlasType::Null)),
            Expr::StringLit { .. } => Err(AtlasError::CodegenError {
                message: "string literals require an expected coercion target in native codegen".to_string(),
            }),
            Expr::StaticMember {
                class_name,
                member_name,
                ..
            } => {
                if let Some(enum_ty) = self.typed_ast.enums.get(class_name) {
                    if let Some(index) = enum_ty.variants.iter().position(|variant| variant == member_name) {
                        return Ok((index.to_string(), AtlasType::Enum(class_name.clone())));
                    }
                }
                if let Some(choice_ty) = self.typed_ast.choices.get(class_name) {
                    if let Some(index) = choice_ty
                        .variants
                        .iter()
                        .position(|variant| variant.name == *member_name && variant.payload.is_none())
                    {
                        let reg = self.emit_choice_constructor(class_name, index, None, None)?;
                        return Ok((reg, AtlasType::Choice(class_name.clone())));
                    }
                }
                Err(AtlasError::CodegenError {
                    message: format!("unknown static member '{}.{}'", class_name, member_name),
                })
            }
            Expr::Var { .. } | Expr::ArrayIndex { .. } => {
                let (ptr, ty) = self.emit_lvalue_address(expr)?;
                let reg = self.next_temp();
                let llvm_ty = map_type(&ty)?;
                self.output
                    .push_str(&format!("    {} = load {}, {}* {}\n", reg, llvm_ty, llvm_ty, ptr));
                Ok((reg, ty))
            }
            Expr::MemberAccess { object, member, .. } => {
                let (object_value, object_ty) = self.emit_expr(object)?;
                match object_ty {
                    AtlasType::Slice(element) if member == "len" => {
                        let reg = self.next_temp();
                        let slice_ty = map_type(&AtlasType::Slice(element))?;
                        self.output.push_str(&format!(
                            "    {} = extractvalue {} {}, 1\n",
                            reg, slice_ty, object_value
                        ));
                        Ok((reg, AtlasType::Int))
                    }
                    _ => {
                        let (ptr, ty) = self.emit_lvalue_address(expr)?;
                        let reg = self.next_temp();
                        let llvm_ty = map_type(&ty)?;
                        self.output.push_str(&format!(
                            "    {} = load {}, {}* {}\n",
                            reg, llvm_ty, llvm_ty, ptr
                        ));
                        Ok((reg, ty))
                    }
                }
            }
            Expr::Group { inner, .. } => self.emit_expr(inner),
            Expr::Unary { op, operand, .. } => match op {
                UnaryOp::Neg => {
                    let (value, ty) = self.emit_expr(operand)?;
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
                    let (value, _) = self.emit_expr(operand)?;
                    let reg = self.next_temp();
                    self.output
                        .push_str(&format!("    {} = xor i1 {}, true\n", reg, value));
                    Ok((reg, AtlasType::Bool))
                }
                UnaryOp::AddressOf => {
                    let (ptr, ty) = self.emit_lvalue_address(operand)?;
                    Ok((
                        ptr,
                        AtlasType::Pointer {
                            target: Box::new(ty),
                            nullable: false,
                        },
                    ))
                }
                UnaryOp::Dereference => {
                    let (ptr, ty) = self.emit_lvalue_address(expr)?;
                    let reg = self.next_temp();
                    let llvm_ty = map_type(&ty)?;
                    self.output
                        .push_str(&format!("    {} = load {}, {}* {}\n", reg, llvm_ty, llvm_ty, ptr));
                    Ok((reg, ty))
                }
            },
            Expr::Binary { op, lhs, rhs, .. } => {
                let (lhs_val, lhs_ty, rhs_val, rhs_ty) =
                    self.emit_binary_operands(lhs, rhs)?;
                if lhs_ty != rhs_ty {
                    return Err(AtlasError::CodegenError {
                        message: "binary operand type mismatch".to_string(),
                    });
                }
                emit_binary(
                    &mut self.output,
                    &mut self.temp_counter,
                    op,
                    lhs_val,
                    rhs_val,
                    lhs_ty,
                )
            }
            Expr::Call { callee, args, .. } => {
                if self.typed_ast.classes.contains_key(callee) {
                    let class_ty = AtlasType::Class(callee.clone());
                    let llvm_class_ty = map_type(&class_ty)?;
                    let tmp_ptr = self.next_temp();
                    self.output
                        .push_str(&format!("    {} = alloca {}\n", tmp_ptr, llvm_class_ty));
                    if let Some(method) = self
                        .typed_ast
                        .classes
                        .get(callee)
                        .and_then(|class_ty| class_ty.methods.get("init"))
                        .cloned()
                    {
                        let mut rendered_args = vec![format!("{}* {}", llvm_class_ty, tmp_ptr)];
                        for (arg, (_, expected_ty)) in args.iter().zip(method.sig.params.iter().skip(1)) {
                            let (value, _) = self.emit_expr_coerced(arg, expected_ty)?;
                            rendered_args.push(format!("{} {}", map_type(expected_ty)?, value));
                        }
                        self.output.push_str(&format!(
                            "    call void @{}.init({})\n",
                            callee,
                            rendered_args.join(", ")
                        ));
                    }
                    let reg = self.next_temp();
                    self.output
                        .push_str(&format!("    {} = load {}, {}* {}\n", reg, llvm_class_ty, llvm_class_ty, tmp_ptr));
                    return Ok((reg, class_ty));
                }
                let sig = self
                    .typed_ast
                    .fn_sigs
                    .get(callee)
                    .cloned()
                    .ok_or_else(|| AtlasError::CodegenError {
                        message: format!("unknown function '{}'", callee),
                    })?;
                let mut rendered_args = Vec::new();
                for (arg, (_, expected_ty)) in args.iter().zip(sig.params.iter()) {
                    let (value, actual_ty) = self.emit_expr_coerced(arg, expected_ty)?;
                    if !is_assignable_to(expected_ty, &actual_ty) {
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
            Expr::MethodCall {
                object,
                method_name,
                args,
                ..
            } => {
                let (self_arg, class_name) = self.emit_method_receiver(object)?;
                let method = self
                    .typed_ast
                    .classes
                    .get(&class_name)
                    .and_then(|class_ty| class_ty.methods.get(method_name))
                    .cloned()
                    .ok_or_else(|| AtlasError::CodegenError {
                        message: format!("unknown method '{}.{}'", class_name, method_name),
                    })?;
                let mut rendered_args =
                    vec![format!("{}* {}", map_type(&AtlasType::Class(class_name.clone()))?, self_arg)];
                for (arg, (_, expected_ty)) in args.iter().zip(method.sig.params.iter().skip(1)) {
                    let (value, _) = self.emit_expr_coerced(arg, expected_ty)?;
                    rendered_args.push(format!("{} {}", map_type(expected_ty)?, value));
                }
                if method.sig.ret_ty == AtlasType::Void {
                    self.output.push_str(&format!(
                        "    call void @{}.{}({})\n",
                        class_name,
                        method_name,
                        rendered_args.join(", ")
                    ));
                    Ok(("0".to_string(), AtlasType::Void))
                } else {
                    let reg = self.next_temp();
                    self.output.push_str(&format!(
                        "    {} = call {} @{}.{}({})\n",
                        reg,
                        map_type(&method.sig.ret_ty)?,
                        class_name,
                        method_name,
                        rendered_args.join(", ")
                    ));
                    Ok((reg, method.sig.ret_ty.clone()))
                }
            }
            Expr::StaticCall {
                class_name,
                method_name,
                args,
                ..
            } => {
                if let Some(choice_ty) = self.typed_ast.choices.get(class_name).cloned() {
                    let Some((index, variant)) = choice_ty
                        .variants
                        .iter()
                        .enumerate()
                        .find(|(_, variant)| variant.name == *method_name)
                    else {
                        return Err(AtlasError::CodegenError {
                            message: format!("unknown choice variant '{}.{}'", class_name, method_name),
                        });
                    };
                    let (payload_value, payload_ty) = match (&variant.payload, args.as_slice()) {
                        (None, []) => (None, None),
                        (Some(expected_ty), [arg]) => {
                            let (value, _) = self.emit_expr_coerced(arg, expected_ty)?;
                            (Some(value), Some(expected_ty.clone()))
                        }
                        _ => {
                            return Err(AtlasError::CodegenError {
                                message: format!("wrong argument count for variant '{}.{}'", class_name, method_name),
                            });
                        }
                    };
                    let reg = self.emit_choice_constructor(
                        class_name,
                        index,
                        payload_value.as_deref(),
                        payload_ty.as_ref(),
                    )?;
                    return Ok((reg, AtlasType::Choice(class_name.clone())));
                }
                let method = self
                    .typed_ast
                    .classes
                    .get(class_name)
                    .and_then(|class_ty| class_ty.methods.get(method_name))
                    .cloned()
                    .ok_or_else(|| AtlasError::CodegenError {
                        message: format!("unknown static method '{}.{}'", class_name, method_name),
                    })?;
                let mut rendered_args = Vec::new();
                for (arg, (_, expected_ty)) in args.iter().zip(method.sig.params.iter()) {
                    let (value, _) = self.emit_expr_coerced(arg, expected_ty)?;
                    rendered_args.push(format!("{} {}", map_type(expected_ty)?, value));
                }
                if method.sig.ret_ty == AtlasType::Void {
                    self.output.push_str(&format!(
                        "    call void @{}.{}({})\n",
                        class_name, method_name, rendered_args.join(", ")
                    ));
                    Ok(("0".to_string(), AtlasType::Void))
                } else {
                    let reg = self.next_temp();
                    self.output.push_str(&format!(
                        "    {} = call {} @{}.{}({})\n",
                        reg,
                        map_type(&method.sig.ret_ty)?,
                        class_name,
                        method_name,
                        rendered_args.join(", ")
                    ));
                    Ok((reg, method.sig.ret_ty.clone()))
                }
            }
            Expr::StructInit {
                struct_name,
                fields,
                ..
            } => {
                let struct_ty = self
                    .typed_ast
                    .structs
                    .get(struct_name)
                    .cloned()
                    .ok_or_else(|| AtlasError::CodegenError {
                        message: format!("unknown struct '{}'", struct_name),
                    })?;
                let llvm_struct_ty = map_type(&AtlasType::Struct(struct_name.clone()))?;
                let mut value = "undef".to_string();
                for (index, (field_name, field_ty)) in struct_ty.fields.iter().enumerate() {
                    let (_, expr) = fields
                        .iter()
                        .find(|((candidate, _), _)| candidate == field_name)
                        .ok_or_else(|| AtlasError::CodegenError {
                            message: format!(
                                "missing field '{}' in struct initializer for '{}'",
                                field_name, struct_name
                            ),
                        })?;
                    let (field_value, actual_ty) = self.emit_expr(expr)?;
                    if &actual_ty != field_ty {
                        return Err(AtlasError::CodegenError {
                            message: format!(
                                "field '{}' type mismatch in struct initializer",
                                field_name
                            ),
                        });
                    }
                    let next_value = self.next_temp();
                    self.output.push_str(&format!(
                        "    {} = insertvalue {} {}, {} {}, {}\n",
                        next_value,
                        llvm_struct_ty,
                        value,
                        map_type(field_ty)?,
                        field_value,
                        index
                    ));
                    value = next_value;
                }
                Ok((value, AtlasType::Struct(struct_name.clone())))
            }
            Expr::Cast { target_ty, expr, .. } => {
                let target_ty = resolve_simple_type(&target_ty.0, &self.typed_ast.structs, &self.typed_ast.classes, &self.typed_ast.enums, &self.typed_ast.choices)?;
                let (value, source_ty) = self.emit_expr(expr)?;
                self.emit_cast_value(value, source_ty, target_ty)
            }
            Expr::SizeOf { ty, .. } => {
                let ty = resolve_simple_type(&ty.0, &self.typed_ast.structs, &self.typed_ast.classes, &self.typed_ast.enums, &self.typed_ast.choices)?;
                Ok((size_of_type(&ty, &self.typed_ast.structs, &self.typed_ast.classes, &self.typed_ast.choices)?.to_string(), AtlasType::Int))
            }
            Expr::Destroy { expr, type_arg, .. } => {
                let ty = resolve_simple_type(type_arg, &self.typed_ast.structs, &self.typed_ast.classes, &self.typed_ast.enums, &self.typed_ast.choices)?;
                if let Ok((ptr, _)) = self.emit_lvalue_address(expr) {
                    self.emit_destroy_for_ptr(&ptr, &ty)?;
                } else {
                    let _ = self.emit_expr(expr)?;
                }
                Ok(("0".to_string(), AtlasType::Void))
            }
            Expr::Match { .. } => Ok(("0".to_string(), AtlasType::Void)),
            _ => Err(AtlasError::CodegenError {
                message: "expression not yet supported by native codegen".to_string(),
            }),
        }
    }

    fn emit_choice_constructor(
        &mut self,
        choice_name: &str,
        variant_index: usize,
        payload_value: Option<&str>,
        payload_ty: Option<&AtlasType>,
    ) -> Result<String, AtlasError> {
        let choice_ty = AtlasType::Choice(choice_name.to_string());
        let llvm_choice_ty = map_type(&choice_ty)?;
        let choice_def = self
            .typed_ast
            .choices
            .get(choice_name)
            .ok_or_else(|| AtlasError::CodegenError {
                message: format!("unknown choice '{}'", choice_name),
            })?;
        let payload_size = self.choice_payload_size(choice_def)?;
        let payload_array_ty = format!("[{} x i8]", payload_size);
        let choice_ptr = self.next_temp();
        self.output
            .push_str(&format!("    {} = alloca {}\n", choice_ptr, llvm_choice_ty));
        let tag_ptr = self.next_temp();
        self.output.push_str(&format!(
            "    {} = getelementptr inbounds {}, {}* {}, i32 0, i32 0\n",
            tag_ptr, llvm_choice_ty, llvm_choice_ty, choice_ptr
        ));
        self.output
            .push_str(&format!("    store i32 {}, i32* {}\n", variant_index, tag_ptr));
        let payload_ptr = self.next_temp();
        self.output.push_str(&format!(
            "    {} = getelementptr inbounds {}, {}* {}, i32 0, i32 1\n",
            payload_ptr, llvm_choice_ty, llvm_choice_ty, choice_ptr
        ));
        self.output.push_str(&format!(
            "    store {} zeroinitializer, {}* {}\n",
            payload_array_ty,
            payload_array_ty,
            payload_ptr
        ));
        if let (Some(payload_value), Some(payload_ty)) = (payload_value, payload_ty) {
            let typed_payload_ptr = self.next_temp();
            self.output.push_str(&format!(
                "    {} = bitcast {}* {} to {}*\n",
                typed_payload_ptr,
                payload_array_ty,
                payload_ptr,
                map_type(payload_ty)?
            ));
            self.output.push_str(&format!(
                "    store {} {}, {}* {}\n",
                map_type(payload_ty)?,
                payload_value,
                map_type(payload_ty)?,
                typed_payload_ptr
            ));
        }
        let reg = self.next_temp();
        self.output.push_str(&format!(
            "    {} = load {}, {}* {}\n",
            reg, llvm_choice_ty, llvm_choice_ty, choice_ptr
        ));
        Ok(reg)
    }

    fn emit_match_stmt(
        &mut self,
        matched: &Expr,
        cases: &[crate::parser::MatchCase],
    ) -> Result<(), AtlasError> {
        let (value, ty) = self.emit_expr(matched)?;
        match ty {
            AtlasType::Enum(enum_name) => self.emit_enum_match_stmt(value, &enum_name, cases),
            AtlasType::Choice(choice_name) => self.emit_choice_match_stmt(value, &choice_name, cases),
            other => Err(AtlasError::CodegenError {
                message: format!("native match does not support '{:?}'", other),
            }),
        }
    }

    fn emit_enum_match_stmt(
        &mut self,
        value: String,
        enum_name: &str,
        cases: &[crate::parser::MatchCase],
    ) -> Result<(), AtlasError> {
        let end_label = self.next_label("match_end");
        let mut next_label: Option<String> = None;
        for (index, case) in cases.iter().enumerate() {
            let body_label = self.next_label("match_case_body");
            let fallthrough_label = if index + 1 == cases.len() {
                end_label.clone()
            } else {
                self.next_label("match_case_next")
            };
            let variant_index = self.pattern_variant_index(&AtlasType::Enum(enum_name.to_string()), &case.pattern)?;
            if let Some(label) = next_label.take() {
                self.emit_label(&label);
            }
            let cond = self.next_temp();
            self.output.push_str(&format!(
                "    {} = icmp eq i32 {}, {}\n",
                cond, value, variant_index
            ));
            self.output.push_str(&format!(
                "    br i1 {}, label %{}, label %{}\n",
                cond, body_label, fallthrough_label
            ));
            self.block_terminated = true;
            self.emit_label(&body_label);
            self.emit_pattern_block(None, &case.body)?;
            if !self.current_block_terminated() {
                self.output.push_str(&format!("    br label %{}\n", end_label));
                self.block_terminated = true;
            }
            if fallthrough_label != end_label {
                next_label = Some(fallthrough_label);
            }
        }
        if let Some(label) = next_label {
            self.emit_label(&label);
            self.output.push_str(&format!("    br label %{}\n", end_label));
            self.block_terminated = true;
        }
        self.emit_label(&end_label);
        Ok(())
    }

    fn emit_choice_match_stmt(
        &mut self,
        value: String,
        choice_name: &str,
        cases: &[crate::parser::MatchCase],
    ) -> Result<(), AtlasError> {
        let choice_ty = AtlasType::Choice(choice_name.to_string());
        let llvm_choice_ty = map_type(&choice_ty)?;
        let choice_ptr = self.next_temp();
        self.output
            .push_str(&format!("    {} = alloca {}\n", choice_ptr, llvm_choice_ty));
        self.output.push_str(&format!(
            "    store {} {}, {}* {}\n",
            llvm_choice_ty, value, llvm_choice_ty, choice_ptr
        ));
        let tag_ptr = self.next_temp();
        self.output.push_str(&format!(
            "    {} = getelementptr inbounds {}, {}* {}, i32 0, i32 0\n",
            tag_ptr, llvm_choice_ty, llvm_choice_ty, choice_ptr
        ));
        let tag = self.next_temp();
        self.output
            .push_str(&format!("    {} = load i32, i32* {}\n", tag, tag_ptr));

        let end_label = self.next_label("match_end");
        let mut next_label: Option<String> = None;
        for (index, case) in cases.iter().enumerate() {
            let body_label = self.next_label("match_case_body");
            let fallthrough_label = if index + 1 == cases.len() {
                end_label.clone()
            } else {
                self.next_label("match_case_next")
            };
            let variant_index = self.pattern_variant_index(&choice_ty, &case.pattern)?;
            if let Some(label) = next_label.take() {
                self.emit_label(&label);
            }
            let cond = self.next_temp();
            self.output.push_str(&format!(
                "    {} = icmp eq i32 {}, {}\n",
                cond, tag, variant_index
            ));
            self.output.push_str(&format!(
                "    br i1 {}, label %{}, label %{}\n",
                cond, body_label, fallthrough_label
            ));
            self.block_terminated = true;
            self.emit_label(&body_label);
            let payload_binding = self.pattern_payload_binding(&choice_ty, &case.pattern, &choice_ptr)?;
            self.emit_pattern_block(payload_binding.as_ref(), &case.body)?;
            if !self.current_block_terminated() {
                self.output.push_str(&format!("    br label %{}\n", end_label));
                self.block_terminated = true;
            }
            if fallthrough_label != end_label {
                next_label = Some(fallthrough_label);
            }
        }
        if let Some(label) = next_label {
            self.emit_label(&label);
            self.output.push_str(&format!("    br label %{}\n", end_label));
            self.block_terminated = true;
        }
        self.emit_label(&end_label);
        Ok(())
    }

    fn emit_pattern_block(
        &mut self,
        payload_binding: Option<&(String, AtlasType, String)>,
        block: &Block,
    ) -> Result<(), AtlasError> {
        self.scopes.push(HashMap::new());
        self.cleanup_scopes.push(Vec::new());
        if let Some((name, ty, value)) = payload_binding {
            let ptr = self.next_temp();
            let llvm_ty = map_type(ty)?;
            self.output.push_str(&format!("    {} = alloca {}\n", ptr, llvm_ty));
            self.output.push_str(&format!(
                "    store {} {}, {}* {}\n",
                llvm_ty, value, llvm_ty, ptr
            ));
            self.current_scope_mut().insert(name.clone(), (ptr, ty.clone()));
        }
        let result = self.emit_block(block);
        if result.is_ok() && !self.current_block_terminated() {
            self.emit_current_scope_cleanup()?;
        }
        self.scopes.pop();
        self.cleanup_scopes.pop();
        result
    }

    fn pattern_variant_index(&self, matched_ty: &AtlasType, pattern: &Pattern) -> Result<usize, AtlasError> {
        match (matched_ty, pattern) {
            (AtlasType::Enum(enum_name), Pattern::Variant { path, .. }) => {
                let enum_ty = self.typed_ast.enums.get(enum_name).ok_or_else(|| AtlasError::CodegenError {
                    message: format!("unknown enum '{}'", enum_name),
                })?;
                enum_ty.variants.iter().position(|variant| path.len() == 2 && path[0] == *enum_name && path[1] == *variant).ok_or_else(|| AtlasError::CodegenError {
                    message: format!("unknown enum variant pattern '{}::{:?}'", enum_name, path),
                })
            }
            (AtlasType::Choice(choice_name), Pattern::Variant { path, .. }) => {
                let choice_ty = self.typed_ast.choices.get(choice_name).ok_or_else(|| AtlasError::CodegenError {
                    message: format!("unknown choice '{}'", choice_name),
                })?;
                choice_ty.variants.iter().position(|variant| path.len() == 2 && path[0] == *choice_name && path[1] == variant.name).ok_or_else(|| AtlasError::CodegenError {
                    message: format!("unknown choice variant pattern '{}::{:?}'", choice_name, path),
                })
            }
            _ => Err(AtlasError::CodegenError {
                message: "unsupported native match pattern".to_string(),
            }),
        }
    }

    fn pattern_payload_binding(
        &mut self,
        matched_ty: &AtlasType,
        pattern: &Pattern,
        choice_ptr: &str,
    ) -> Result<Option<(String, AtlasType, String)>, AtlasError> {
        let (choice_name, bind_name, variant) = match (matched_ty, pattern) {
            (AtlasType::Choice(choice_name), Pattern::Variant { path, bind, .. }) => {
                let Some(bind_name) = bind.as_ref().map(|name| name.0.clone()) else {
                    return Ok(None);
                };
                let choice_ty = self.typed_ast.choices.get(choice_name).ok_or_else(|| AtlasError::CodegenError {
                    message: format!("unknown choice '{}'", choice_name),
                })?;
                let variant = choice_ty
                    .variants
                    .iter()
                    .find(|variant| path.len() == 2 && path[0] == *choice_name && path[1] == variant.name)
                    .ok_or_else(|| AtlasError::CodegenError {
                        message: format!("unknown choice variant pattern '{}::{:?}'", choice_name, path),
                    })?;
                (choice_name.clone(), bind_name, variant.clone())
            }
            _ => return Ok(None),
        };
        let Some(payload_ty) = variant.payload else {
            return Ok(None);
        };
        let llvm_choice_ty = map_type(&AtlasType::Choice(choice_name.clone()))?;
        let choice_def = self
            .typed_ast
            .choices
            .get(&choice_name)
            .ok_or_else(|| AtlasError::CodegenError {
                message: format!("unknown choice '{}'", choice_name),
            })?;
        let payload_size = self.choice_payload_size(choice_def)?;
        let payload_array_ty = format!("[{} x i8]", payload_size);
        let payload_ptr = self.next_temp();
        self.output.push_str(&format!(
            "    {} = getelementptr inbounds {}, {}* {}, i32 0, i32 1\n",
            payload_ptr, llvm_choice_ty, llvm_choice_ty, choice_ptr
        ));
        let typed_payload_ptr = self.next_temp();
        self.output.push_str(&format!(
            "    {} = bitcast {}* {} to {}*\n",
            typed_payload_ptr,
            payload_array_ty,
            payload_ptr,
            map_type(&payload_ty)?
        ));
        let value = self.next_temp();
        let llvm_payload_ty = map_type(&payload_ty)?;
        self.output.push_str(&format!(
            "    {} = load {}, {}* {}\n",
            value, llvm_payload_ty, llvm_payload_ty, typed_payload_ptr
        ));
        Ok(Some((bind_name, payload_ty, value)))
    }

    fn emit_lvalue_address(&mut self, expr: &Expr) -> Result<(String, AtlasType), AtlasError> {
        match expr {
            Expr::Group { inner, .. } => self.emit_lvalue_address(inner),
            Expr::Var { name, .. } => self.lookup_var(name).ok_or_else(|| AtlasError::CodegenError {
                message: format!("unknown variable '{}'", name),
            }),
            Expr::MemberAccess { object, member, .. } => {
                let (base_ptr, base_ty) = self.emit_lvalue_address(object)?;
                let (agg_prefix, agg_name, field_index, field_ty) = match base_ty {
                    AtlasType::Struct(struct_name) => {
                        let (field_index, field_ty) = self.struct_field(&struct_name, member)?;
                        ("struct", struct_name, field_index, field_ty)
                    }
                    AtlasType::Class(class_name) => {
                        let (field_index, field_ty) = self.class_field(&class_name, member)?;
                        ("class", class_name, field_index, field_ty)
                    }
                    _ => {
                        return Err(AtlasError::CodegenError {
                            message: "member access requires a struct or class lvalue".to_string(),
                        });
                    }
                };
                let field_ptr = self.next_temp();
                let struct_ty = format!("%{}.{}", agg_prefix, agg_name);
                self.output.push_str(&format!(
                    "    {} = getelementptr inbounds {}, {}* {}, i32 0, i32 {}\n",
                    field_ptr, struct_ty, struct_ty, base_ptr, field_index
                ));
                Ok((field_ptr, field_ty))
            }
            Expr::ArrayIndex { array, index, .. } => {
                let (index_value, index_ty) = self.emit_expr(index)?;
                let normalized_index = self.normalize_index(index_value, &index_ty)?;
                if let Ok((base_ptr, base_ty)) = self.emit_lvalue_address(array) {
                    if let AtlasType::Array { element, size } = base_ty {
                        let element_ty = *element;
                        let llvm_array_ty = map_type(&AtlasType::Array {
                            element: Box::new(element_ty.clone()),
                            size,
                        })?;
                        let field_ptr = self.next_temp();
                        self.output.push_str(&format!(
                            "    {} = getelementptr inbounds {}, {}* {}, i64 0, i64 {}\n",
                            field_ptr, llvm_array_ty, llvm_array_ty, base_ptr, normalized_index
                        ));
                        return Ok((field_ptr, element_ty));
                    }
                }

                let (base_value, base_ty) = self.emit_expr(array)?;
                if let AtlasType::Pointer { target, .. } = base_ty {
                    let field_ptr = self.next_temp();
                    let elem_ty = *target;
                    let llvm_elem_ty = map_type(&elem_ty)?;
                    self.output.push_str(&format!(
                        "    {} = getelementptr inbounds {}, {}* {}, i64 {}\n",
                        field_ptr, llvm_elem_ty, llvm_elem_ty, base_value, normalized_index
                    ));
                    return Ok((field_ptr, elem_ty));
                }

                let (slice_value, slice_ty) = self.emit_expr(array)?;
                let AtlasType::Slice(element) = slice_ty else {
                    return Err(AtlasError::CodegenError {
                        message: "array indexing requires an array, slice, or pointer value".to_string(),
                    });
                };
                let llvm_slice_ty = map_type(&AtlasType::Slice(element.clone()))?;
                let data_ptr = self.next_temp();
                self.output.push_str(&format!(
                    "    {} = extractvalue {} {}, 0\n",
                    data_ptr, llvm_slice_ty, slice_value
                ));
                let field_ptr = self.next_temp();
                let elem_ty = *element;
                let llvm_elem_ty = map_type(&elem_ty)?;
                self.output.push_str(&format!(
                    "    {} = getelementptr inbounds {}, {}* {}, i64 {}\n",
                    field_ptr, llvm_elem_ty, llvm_elem_ty, data_ptr, normalized_index
                ));
                Ok((field_ptr, elem_ty))
            }
            Expr::Unary {
                op: UnaryOp::Dereference,
                operand,
                ..
            } => {
                let (ptr_value, ptr_ty) = self.emit_expr(operand)?;
                let AtlasType::Pointer { target, .. } = ptr_ty else {
                    return Err(AtlasError::CodegenError {
                        message: "cannot dereference a non-pointer value".to_string(),
                    });
                };
                Ok((ptr_value, *target))
            }
            _ => Err(AtlasError::CodegenError {
                message: "expression is not assignable".to_string(),
            }),
        }
    }

    fn struct_field(
        &self,
        struct_name: &str,
        member: &str,
    ) -> Result<(usize, AtlasType), AtlasError> {
        let struct_ty = self
            .typed_ast
            .structs
            .get(struct_name)
            .ok_or_else(|| AtlasError::CodegenError {
                message: format!("unknown struct '{}'", struct_name),
            })?;
        struct_ty
            .fields
            .iter()
            .enumerate()
            .find(|(_, (field_name, _))| field_name == member)
            .map(|(index, (_, ty))| (index, ty.clone()))
            .ok_or_else(|| AtlasError::CodegenError {
                message: format!("struct '{}' has no field '{}'", struct_name, member),
            })
    }

    fn class_field(
        &self,
        class_name: &str,
        member: &str,
    ) -> Result<(usize, AtlasType), AtlasError> {
        let class_ty = self
            .typed_ast
            .classes
            .get(class_name)
            .ok_or_else(|| AtlasError::CodegenError {
                message: format!("unknown class '{}'", class_name),
            })?;
        class_ty
            .fields
            .iter()
            .enumerate()
            .find(|(_, field)| field.name == member)
            .map(|(index, field)| (index, field.ty.clone()))
            .ok_or_else(|| AtlasError::CodegenError {
                message: format!("class '{}' has no field '{}'", class_name, member),
            })
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

    fn maybe_register_cleanup(&mut self, ptr: String, ty: &AtlasType) {
        if matches!(ty, AtlasType::Class(_)) {
            self.cleanup_scopes
                .last_mut()
                .expect("cleanup scope stack is empty")
                .push((ptr, ty.clone()));
        }
    }

    fn emit_current_scope_cleanup(&mut self) -> Result<(), AtlasError> {
        let items = self
            .cleanup_scopes
            .last()
            .cloned()
            .unwrap_or_default();
        for (ptr, ty) in items.into_iter().rev() {
            self.emit_destroy_for_ptr(&ptr, &ty)?;
        }
        Ok(())
    }

    fn emit_all_scope_cleanups(&mut self) -> Result<(), AtlasError> {
        self.emit_all_scope_cleanups_except(None)
    }

    fn emit_all_scope_cleanups_except(
        &mut self,
        excluded_ptr: Option<&str>,
    ) -> Result<(), AtlasError> {
        let scopes = self.cleanup_scopes.clone();
        for scope in scopes.iter().rev() {
            for (ptr, ty) in scope.iter().rev() {
                if excluded_ptr == Some(ptr.as_str()) {
                    continue;
                }
                self.emit_destroy_for_ptr(ptr, ty)?;
            }
        }
        Ok(())
    }

    fn returned_cleanup_ptr(&self, expr: &Expr) -> Option<String> {
        match expr {
            Expr::Var { name, .. } => self.lookup_var(name).and_then(|(ptr, ty)| {
                if matches!(ty, AtlasType::Class(_)) {
                    Some(ptr)
                } else {
                    None
                }
            }),
            Expr::Group { inner, .. } => self.returned_cleanup_ptr(inner),
            _ => None,
        }
    }

    fn emit_destroy_for_ptr(&mut self, ptr: &str, ty: &AtlasType) -> Result<(), AtlasError> {
        if let AtlasType::Class(class_name) = ty {
            self.output.push_str(&format!(
                "    call void @{}.destroy({}* {})\n",
                class_name,
                map_type(ty)?,
                ptr
            ));
        }
        Ok(())
    }

    fn emit_method_receiver(&mut self, object: &Expr) -> Result<(String, String), AtlasError> {
        if let Ok((ptr, ty)) = self.emit_lvalue_address(object) {
            if let AtlasType::Class(class_name) = ty {
                return Ok((ptr, class_name));
            }
        }

        let (value, ty) = self.emit_expr(object)?;
        if let AtlasType::Pointer { target, .. } = ty {
            if let AtlasType::Class(class_name) = *target {
                return Ok((value, class_name));
            }
        }

        Err(AtlasError::CodegenError {
            message: "method receiver must be a class value or class pointer".to_string(),
        })
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

    fn emit_cast_value(
        &mut self,
        value: String,
        source_ty: AtlasType,
        target_ty: AtlasType,
    ) -> Result<(String, AtlasType), AtlasError> {
        if source_ty == target_ty {
            return Ok((value, target_ty));
        }

        let source_llvm = map_type(&source_ty)?;
        let target_llvm = map_type(&target_ty)?;
        let reg = self.next_temp();

        if is_integer(&source_ty) && is_integer(&target_ty) {
            let source_bits = integer_width(&source_ty)?;
            let target_bits = integer_width(&target_ty)?;
            if target_bits > source_bits {
                let op = if is_unsigned_like(&source_ty) { "zext" } else { "sext" };
                self.output.push_str(&format!(
                    "    {} = {} {} {} to {}\n",
                    reg, op, source_llvm, value, target_llvm
                ));
            } else {
                self.output.push_str(&format!(
                    "    {} = trunc {} {} to {}\n",
                    reg, source_llvm, value, target_llvm
                ));
            }
            return Ok((reg, target_ty));
        }

        if is_float(&source_ty) && is_float(&target_ty) {
            let op = if target_llvm == "double" { "fpext" } else { "fptrunc" };
            self.output.push_str(&format!(
                "    {} = {} {} {} to {}\n",
                reg, op, source_llvm, value, target_llvm
            ));
            return Ok((reg, target_ty));
        }

        if is_integer(&source_ty) && is_float(&target_ty) {
            let op = if is_unsigned_like(&source_ty) { "uitofp" } else { "sitofp" };
            self.output.push_str(&format!(
                "    {} = {} {} {} to {}\n",
                reg, op, source_llvm, value, target_llvm
            ));
            return Ok((reg, target_ty));
        }

        if is_float(&source_ty) && is_integer(&target_ty) {
            let op = if is_unsigned_like(&target_ty) { "fptoui" } else { "fptosi" };
            self.output.push_str(&format!(
                "    {} = {} {} {} to {}\n",
                reg, op, source_llvm, value, target_llvm
            ));
            return Ok((reg, target_ty));
        }

        match (&source_ty, &target_ty) {
            (AtlasType::Pointer { .. }, AtlasType::Pointer { .. }) => {
                self.output.push_str(&format!(
                    "    {} = bitcast {} {} to {}\n",
                    reg, source_llvm, value, target_llvm
                ));
                Ok((reg, target_ty))
            }
            (AtlasType::Pointer { .. }, _) if is_integer(&target_ty) => {
                self.output.push_str(&format!(
                    "    {} = ptrtoint {} {} to {}\n",
                    reg, source_llvm, value, target_llvm
                ));
                Ok((reg, target_ty))
            }
            (_, AtlasType::Pointer { .. }) if is_integer(&source_ty) => {
                self.output.push_str(&format!(
                    "    {} = inttoptr {} {} to {}\n",
                    reg, source_llvm, value, target_llvm
                ));
                Ok((reg, target_ty))
            }
            _ => Err(AtlasError::CodegenError {
                message: format!("unsupported cast from '{:?}' to '{:?}'", source_ty, target_ty),
            }),
        }
    }

    fn emit_string_literal_slice(&mut self, value: &str) -> Result<(String, AtlasType), AtlasError> {
        let global_name = format!("@.str.{}", self.str_counter);
        self.str_counter += 1;
        let bytes = value.as_bytes();
        let llvm_bytes = escape_llvm_c_string(bytes);
        let total_len = bytes.len() + 1;
        self.globals.push_str(&format!(
            "{} = private unnamed_addr constant [{} x i8] c\"{}\\00\"\n",
            global_name, total_len, llvm_bytes
        ));
        let ptr_reg = self.next_temp();
        self.output.push_str(&format!(
            "    {} = getelementptr inbounds [{} x i8], [{} x i8]* {}, i64 0, i64 0\n",
            ptr_reg, total_len, total_len, global_name
        ));
        let slice_ty = AtlasType::Slice(Box::new(AtlasType::Char));
        let llvm_slice_ty = map_type(&slice_ty)?;
        let with_ptr = self.next_temp();
        self.output.push_str(&format!(
            "    {} = insertvalue {} undef, i8* {}, 0\n",
            with_ptr, llvm_slice_ty, ptr_reg
        ));
        let with_len = self.next_temp();
        self.output.push_str(&format!(
            "    {} = insertvalue {} {}, i64 {}, 1\n",
            with_len,
            llvm_slice_ty,
            with_ptr,
            bytes.len()
        ));
        Ok((with_len, slice_ty))
    }

    fn emit_expr_coerced(
        &mut self,
        expr: &Expr,
        expected_ty: &AtlasType,
    ) -> Result<(String, AtlasType), AtlasError> {
        if let Expr::StringLit { value, .. } = expr {
            if matches!(expected_ty, AtlasType::Slice(element) if **element == AtlasType::Char) {
                return self.emit_string_literal_slice(value);
            }
            if let AtlasType::Class(class_name) = expected_ty {
                if let Some(method) = self
                    .typed_ast
                    .classes
                    .get(class_name)
                    .and_then(|class_ty| class_ty.methods.get("from"))
                    .cloned()
                {
                    if method.sig.params.len() == 1
                        && matches!(
                            (&method.sig.params[0].1, &method.sig.ret_ty),
                            (AtlasType::Slice(element), AtlasType::Class(ret_name))
                                if **element == AtlasType::Char && ret_name == class_name
                        )
                    {
                        let (slice_value, _) = self.emit_string_literal_slice(value)?;
                        let reg = self.next_temp();
                        self.output.push_str(&format!(
                            "    {} = call {} @{}.from({} {})\n",
                            reg,
                            map_type(expected_ty)?,
                            class_name,
                            map_type(&method.sig.params[0].1)?,
                            slice_value
                        ));
                        return Ok((reg, expected_ty.clone()));
                    }
                }
            }
        }

        if matches!(expr, Expr::Null { .. }) {
            if matches!(expected_ty, AtlasType::Pointer { nullable: true, .. }) {
                return Ok(("null".to_string(), expected_ty.clone()));
            }
        }

        let (value, actual_ty) = self.emit_expr(expr)?;
        if let (
            AtlasType::Slice(expected_elem),
            AtlasType::Array {
                element: actual_elem,
                size,
            },
        ) = (expected_ty, &actual_ty)
        {
            if expected_elem == actual_elem {
                let (array_ptr, _) = self.emit_lvalue_address(expr)?;
                let first_elem_ptr = self.next_temp();
                let llvm_array_ty = map_type(&actual_ty)?;
                let llvm_elem_ty = map_type(expected_elem)?;
                self.output.push_str(&format!(
                    "    {} = getelementptr inbounds {}, {}* {}, i64 0, i64 0\n",
                    first_elem_ptr, llvm_array_ty, llvm_array_ty, array_ptr
                ));
                let slice_ty = AtlasType::Slice(expected_elem.clone());
                let llvm_slice_ty = map_type(&slice_ty)?;
                let with_ptr = self.next_temp();
                self.output.push_str(&format!(
                    "    {} = insertvalue {} undef, {}* {}, 0\n",
                    with_ptr, llvm_slice_ty, llvm_elem_ty, first_elem_ptr
                ));
                let with_len = self.next_temp();
                self.output.push_str(&format!(
                    "    {} = insertvalue {} {}, i64 {}, 1\n",
                    with_len, llvm_slice_ty, with_ptr, size
                ));
                return Ok((with_len, slice_ty));
            }
        }
        Ok((value, actual_ty))
    }

    fn emit_binary_operands(
        &mut self,
        lhs: &Expr,
        rhs: &Expr,
    ) -> Result<(String, AtlasType, String, AtlasType), AtlasError> {
        let (lhs_val, lhs_ty) = self.emit_expr(lhs)?;
        let (rhs_val, rhs_ty) = self.emit_expr(rhs)?;

        if lhs_ty == rhs_ty {
            return Ok((lhs_val, lhs_ty, rhs_val, rhs_ty));
        }

        if let AtlasType::Pointer { nullable: true, .. } = &lhs_ty {
            if rhs_ty == AtlasType::Null {
                return Ok((lhs_val, lhs_ty.clone(), "null".to_string(), lhs_ty));
            }
        }

        if let AtlasType::Pointer { nullable: true, .. } = &rhs_ty {
            if lhs_ty == AtlasType::Null {
                return Ok(("null".to_string(), rhs_ty.clone(), rhs_val, rhs_ty));
            }
        }

        Ok((lhs_val, lhs_ty, rhs_val, rhs_ty))
    }

    fn normalize_index(&mut self, index_value: String, index_ty: &AtlasType) -> Result<String, AtlasError> {
        let llvm_ty = map_type(index_ty)?;
        if llvm_ty == "i64" {
            return Ok(index_value);
        }
        let widened = self.next_temp();
        self.output.push_str(&format!(
            "    {} = sext {} {} to i64\n",
            widened, llvm_ty, index_value
        ));
        Ok(widened)
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
        Add => output.push_str(&format!(
            "    {} = {} {} {}, {}\n",
            reg,
            if is_float_ty { "fadd" } else { "add" },
            llvm_ty,
            lhs,
            rhs
        )),
        Sub => output.push_str(&format!(
            "    {} = {} {} {}, {}\n",
            reg,
            if is_float_ty { "fsub" } else { "sub" },
            llvm_ty,
            lhs,
            rhs
        )),
        Mul => output.push_str(&format!(
            "    {} = {} {} {}, {}\n",
            reg,
            if is_float_ty { "fmul" } else { "mul" },
            llvm_ty,
            lhs,
            rhs
        )),
        Div => output.push_str(&format!(
            "    {} = {} {} {}, {}\n",
            reg,
            if is_float_ty { "fdiv" } else { "sdiv" },
            llvm_ty,
            lhs,
            rhs
        )),
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
            output.push_str(&format!(
                "    {} = {} {} {}, {}\n",
                reg, pred, llvm_ty, lhs, rhs
            ));
            return Ok((reg, AtlasType::Bool));
        }
        And => output.push_str(&format!("    {} = and i1 {}, {}\n", reg, lhs, rhs)),
        Or => output.push_str(&format!("    {} = or i1 {}, {}\n", reg, lhs, rhs)),
    }
    Ok((reg, ty))
}

fn map_type(ty: &AtlasType) -> Result<String, AtlasError> {
    match ty {
        AtlasType::Int | AtlasType::Int64 | AtlasType::Uint | AtlasType::Uint64 => {
            Ok("i64".to_string())
        }
        AtlasType::Int32 | AtlasType::Uint32 => Ok("i32".to_string()),
        AtlasType::Int16 | AtlasType::Uint16 => Ok("i16".to_string()),
        AtlasType::Int8 | AtlasType::Uint8 | AtlasType::Char => Ok("i8".to_string()),
        AtlasType::Float | AtlasType::Float64 => Ok("double".to_string()),
        AtlasType::Float32 => Ok("float".to_string()),
        AtlasType::Bool => Ok("i1".to_string()),
        AtlasType::Void => Ok("void".to_string()),
        AtlasType::Enum(_) => Ok("i32".to_string()),
        AtlasType::Struct(name) => Ok(format!("%struct.{}", name)),
        AtlasType::Class(name) => Ok(format!("%class.{}", name)),
        AtlasType::Choice(name) => Ok(format!("%choice.{}", name)),
        AtlasType::Pointer { target, .. } => Ok(format!("{}*", map_type(target)?)),
        AtlasType::Array { element, size } => Ok(format!("[{} x {}]", size, map_type(element)?)),
        AtlasType::Slice(element) => Ok(format!("{{ {}*, i64 }}", map_type(element)?)),
        _ => Err(AtlasError::CodegenError {
            message: format!("native codegen does not support type '{:?}'", ty),
        }),
    }
}

fn map_type_expr(
    ty: &crate::parser::TypeExpr,
    structs: &HashMap<String, StructType>,
    classes: &HashMap<String, ClassType>,
    enums: &HashMap<String, crate::typechecker::EnumType>,
    choices: &HashMap<String, ChoiceType>,
) -> Result<String, AtlasError> {
    map_type(&resolve_simple_type(ty, structs, classes, enums, choices)?)
}

fn resolve_simple_type(
    ty: &crate::parser::TypeExpr,
    structs: &HashMap<String, StructType>,
    classes: &HashMap<String, ClassType>,
    enums: &HashMap<String, crate::typechecker::EnumType>,
    choices: &HashMap<String, ChoiceType>,
) -> Result<AtlasType, AtlasError> {
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
            other => {
                if structs.contains_key(other) {
                    Ok(AtlasType::Struct(other.to_string()))
                } else if classes.contains_key(other) {
                    Ok(AtlasType::Class(other.to_string()))
                } else if enums.contains_key(other) {
                    Ok(AtlasType::Enum(other.to_string()))
                } else if choices.contains_key(other) {
                    Ok(AtlasType::Choice(other.to_string()))
                } else {
                    Err(AtlasError::CodegenError {
                        message: format!("native codegen does not support type '{}'", other),
                    })
                }
            }
        },
        crate::parser::TypeExpr::Pointer {
            target, nullable, ..
        } => Ok(AtlasType::Pointer {
            target: Box::new(resolve_simple_type(target, structs, classes, enums, choices)?),
            nullable: *nullable,
        }),
        crate::parser::TypeExpr::Array { element, size, .. } => Ok(AtlasType::Array {
            element: Box::new(resolve_simple_type(element, structs, classes, enums, choices)?),
            size: *size,
        }),
        crate::parser::TypeExpr::Slice { element, .. } => Ok(AtlasType::Slice(Box::new(
            resolve_simple_type(element, structs, classes, enums, choices)?,
        ))),
        crate::parser::TypeExpr::Generic { base, args, .. } => {
            let mut resolved_args = Vec::new();
            for arg in args {
                resolved_args.push(resolve_simple_type(arg, structs, classes, enums, choices)?);
            }
            let mangled = mangle_type_name(base, &resolved_args);
            if choices.contains_key(&mangled) {
                Ok(AtlasType::Choice(mangled))
            } else {
                Err(AtlasError::CodegenError {
                    message: format!("native codegen does not support generic type '{}'", base),
                })
            }
        }
    }
}

fn is_float(ty: &AtlasType) -> bool {
    matches!(ty, AtlasType::Float | AtlasType::Float32 | AtlasType::Float64)
}

fn is_assignable_to(expected: &AtlasType, actual: &AtlasType) -> bool {
    if expected == actual {
        return true;
    }

    if let (
        AtlasType::Pointer {
            target: expected_target,
            nullable: true,
        },
        AtlasType::Pointer {
            target: actual_target,
            nullable: false,
        },
    ) = (expected, actual)
    {
        if expected_target == actual_target {
            return true;
        }
    }

    if matches!((expected, actual), (AtlasType::Pointer { nullable: true, .. }, AtlasType::Null)) {
        return true;
    }

    matches!(
        (expected, actual),
        (
            AtlasType::Slice(expected_elem),
            AtlasType::Array {
                element: actual_elem,
                ..
            }
        ) if expected_elem == actual_elem
    )
}

fn is_integer(ty: &AtlasType) -> bool {
    matches!(
        ty,
        AtlasType::Int
            | AtlasType::Int8
            | AtlasType::Int16
            | AtlasType::Int32
            | AtlasType::Int64
            | AtlasType::Uint
            | AtlasType::Uint8
            | AtlasType::Uint16
            | AtlasType::Uint32
            | AtlasType::Uint64
            | AtlasType::Char
            | AtlasType::Bool
    )
}

fn is_unsigned_like(ty: &AtlasType) -> bool {
    matches!(
        ty,
        AtlasType::Uint
            | AtlasType::Uint8
            | AtlasType::Uint16
            | AtlasType::Uint32
            | AtlasType::Uint64
            | AtlasType::Char
            | AtlasType::Bool
    )
}

fn integer_width(ty: &AtlasType) -> Result<usize, AtlasError> {
    match ty {
        AtlasType::Bool => Ok(1),
        AtlasType::Int8 | AtlasType::Uint8 | AtlasType::Char => Ok(8),
        AtlasType::Int16 | AtlasType::Uint16 => Ok(16),
        AtlasType::Int32 | AtlasType::Uint32 => Ok(32),
        AtlasType::Int | AtlasType::Uint | AtlasType::Int64 | AtlasType::Uint64 => Ok(64),
        _ => Err(AtlasError::CodegenError {
            message: format!("type '{:?}' is not an integer type", ty),
        }),
    }
}

fn size_of_type(
    ty: &AtlasType,
    structs: &HashMap<String, StructType>,
    classes: &HashMap<String, ClassType>,
    choices: &HashMap<String, ChoiceType>,
) -> Result<usize, AtlasError> {
    match ty {
        AtlasType::Bool => Ok(1),
        AtlasType::Int8 | AtlasType::Uint8 | AtlasType::Char => Ok(1),
        AtlasType::Int16 | AtlasType::Uint16 => Ok(2),
        AtlasType::Int32 | AtlasType::Uint32 | AtlasType::Float32 => Ok(4),
        AtlasType::Int | AtlasType::Uint | AtlasType::Int64 | AtlasType::Uint64 | AtlasType::Float | AtlasType::Float64 => Ok(8),
        AtlasType::Enum(_) => Ok(4),
        AtlasType::Pointer { .. } => Ok(8),
        AtlasType::Slice(_) => Ok(16),
        AtlasType::Array { element, size } => Ok(size_of_type(element, structs, classes, choices)? * size),
        AtlasType::Struct(name) => {
            let struct_ty = structs.get(name).ok_or_else(|| AtlasError::CodegenError {
                message: format!("unknown struct '{}'", name),
            })?;
            let mut total = 0;
            for (_, field_ty) in &struct_ty.fields {
                total += size_of_type(field_ty, structs, classes, choices)?;
            }
            Ok(total)
        }
        AtlasType::Class(name) => {
            let class_ty = classes.get(name).ok_or_else(|| AtlasError::CodegenError {
                message: format!("unknown class '{}'", name),
            })?;
            let mut total = 0;
            for field in &class_ty.fields {
                total += size_of_type(&field.ty, structs, classes, choices)?;
            }
            Ok(total)
        }
        AtlasType::Choice(name) => {
            let choice_ty = choices.get(name).ok_or_else(|| AtlasError::CodegenError {
                message: format!("unknown choice '{}'", name),
            })?;
            let mut max_size = 0;
            for variant in &choice_ty.variants {
                if let Some(payload_ty) = &variant.payload {
                    max_size = max_size.max(size_of_type(payload_ty, structs, classes, choices)?);
                }
            }
            Ok(4 + max_size.max(1))
        }
        _ => Err(AtlasError::CodegenError {
            message: format!("native sizeof does not support type '{:?}'", ty),
        }),
    }
}

fn escape_llvm_c_string(bytes: &[u8]) -> String {
    let mut out = String::new();
    for &b in bytes {
        match b {
            b'\\' => out.push_str("\\5C"),
            b'"' => out.push_str("\\22"),
            32..=126 => out.push(char::from(b)),
            _ => out.push_str(&format!("\\{:02X}", b)),
        }
    }
    out
}

fn mangle_type_name(base: &str, args: &[AtlasType]) -> String {
    let mut name = base.to_string();
    for arg in args {
        name.push('_');
        name.push_str(&mangle_type_to_string(arg));
    }
    name
}

fn mangle_type_to_string(ty: &AtlasType) -> String {
    match ty {
        AtlasType::Int => "int".to_string(),
        AtlasType::Uint => "uint".to_string(),
        AtlasType::Int8 => "int8".to_string(),
        AtlasType::Int16 => "int16".to_string(),
        AtlasType::Int32 => "int32".to_string(),
        AtlasType::Int64 => "int64".to_string(),
        AtlasType::Uint8 => "uint8".to_string(),
        AtlasType::Uint16 => "uint16".to_string(),
        AtlasType::Uint32 => "uint32".to_string(),
        AtlasType::Uint64 => "uint64".to_string(),
        AtlasType::Float => "float".to_string(),
        AtlasType::Float32 => "float32".to_string(),
        AtlasType::Float64 => "float64".to_string(),
        AtlasType::Bool => "bool".to_string(),
        AtlasType::Char => "char".to_string(),
        AtlasType::Void => "void".to_string(),
        AtlasType::Struct(name) | AtlasType::Class(name) | AtlasType::Enum(name) | AtlasType::Choice(name) => {
            name.replace('<', "_").replace('>', "_").replace(',', "_").replace('@', "ptr_").replace(' ', "")
        }
        AtlasType::Pointer { target, nullable } => {
            if *nullable {
                format!("nullable_ptr_{}", mangle_type_to_string(target))
            } else {
                format!("ptr_{}", mangle_type_to_string(target))
            }
        }
        AtlasType::Array { element, size } => format!("arr{}_{}", size, mangle_type_to_string(element)),
        AtlasType::Slice(element) => format!("slice_{}", mangle_type_to_string(element)),
        AtlasType::Null => "null".to_string(),
        AtlasType::GenericPlaceholder(name) => name.clone(),
    }
}
