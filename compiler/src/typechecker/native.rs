use std::collections::{HashMap, HashSet};

use crate::error::{AtlasError, Span};
use crate::lexer::IntSuffix;
use crate::parser::{BinOp, Expr, Item, SourceFile, Stmt, TypeExpr, UnaryOp};
use crate::resolver::Project;

use super::{
    helpers::{atlas_type_to_type_expr, mangle_type_name, substitute_class_decl, substitute_constraint_signature, substitute_fn_decl},
    AtlasType, ChoiceType, ChoiceVariantType, ClassFieldType,
    ClassMethodType, ClassType, EnumType, FnSignature, StructType, TypedAST,
};

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
        let Some(main_ast) = project.modules.get("main") else {
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

        let mut checker = Checker::new();
        for mod_name in &project.topological_order {
            if let Some(ast) = project.modules.get(mod_name) {
                checker.collect_structs_from_ast(ast);
                checker.collect_classes_from_ast(ast);
                checker.collect_enums_from_ast(ast);
                checker.collect_choices_from_ast(ast);
            }
        }
        for mod_name in &project.topological_order {
            if let Some(ast) = project.modules.get(mod_name) {
                checker.build_signatures_from_ast(ast, true);
            }
        }

        let mut reachable_classes = collect_referenced_classes_from_file(main_ast, &checker.classes);
        if let Err(err) = checker.check_reachable_project_classes(project, &mut reachable_classes) {
            return match err {
                NativeCheckError::Unsupported => NativeProjectCheck::Unsupported,
                NativeCheckError::Errors(errors) => {
                    let (path, source) = project
                        .sources
                        .get("main")
                        .map(|(path, source)| (path.to_string_lossy().into_owned(), source.clone()))
                        .unwrap_or_else(|| ("<main>".to_string(), String::new()));
                    NativeProjectCheck::Errors(vec![(path, source, errors)])
                }
            };
        }

        match checker.finish_check(main_ast) {
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
    structs: HashMap<String, StructType>,
    classes: HashMap<String, ClassType>,
    enums: HashMap<String, EnumType>,
    choices: HashMap<String, ChoiceType>,
    choice_templates: HashMap<String, GenericChoiceTemplate>,
    generic_class_templates: HashMap<String, crate::parser::ClassDecl>,
    generated_classes: Vec<crate::parser::ClassDecl>,
    generic_fn_templates: HashMap<String, crate::parser::FunctionDecl>,
    generated_functions: Vec<crate::parser::FunctionDecl>,
    mangled_calls: HashMap<Span, String>,
    current_return_ty: Option<AtlasType>,
    current_function_name: Option<String>,
    current_class_name: Option<String>,
    errors: Vec<AtlasError>,
}

#[derive(Clone)]
struct GenericChoiceTemplate {
    generic_params: Vec<String>,
    variants: Vec<(String, Option<TypeExpr>)>,
}

impl Checker {
    fn new() -> Self {
        Self {
            fn_sigs: HashMap::new(),
            structs: HashMap::new(),
            classes: HashMap::new(),
            enums: HashMap::new(),
            choices: HashMap::new(),
            choice_templates: HashMap::new(),
            generic_class_templates: HashMap::new(),
            generated_classes: Vec::new(),
            generic_fn_templates: HashMap::new(),
            generated_functions: Vec::new(),
            mangled_calls: HashMap::new(),
            current_return_ty: None,
            current_function_name: None,
            current_class_name: None,
            errors: Vec::new(),
        }
    }

    fn collect_structs_from_ast(&mut self, ast: &SourceFile) {
        for item in &ast.items {
            match item {
                Item::StructDecl(decl, _) => {
                    self.register_struct_decl(decl);
                }
                Item::ClassDecl(decl, _) => {
                    for nested in &decl.structs {
                        self.register_struct_decl(&nested.decl);
                    }
                }
                _ => {}
            }
        }
    }

    fn register_struct_decl(&mut self, decl: &crate::parser::StructDecl) {
        let mut fields = Vec::new();
        for field in &decl.fields {
            let Some(ty) = self.resolve_type_expr(&field.ty.0) else {
                return;
            };
            fields.push((field.name.0.clone(), ty));
        }
        self.structs.insert(
            decl.name.0.clone(),
            StructType {
                name: decl.name.0.clone(),
                fields,
            },
        );
    }

    fn build_signatures(&mut self, ast: &SourceFile) -> Result<(), NativeCheckError> {
        self.collect_structs_from_ast(ast);
        self.collect_classes_from_ast(ast);
        self.collect_enums_from_ast(ast);
        self.collect_choices_from_ast(ast);
        self.build_signatures_from_ast(ast, false);
        if self.errors.is_empty() {
            Ok(())
        } else {
            Err(NativeCheckError::Errors(std::mem::take(&mut self.errors)))
        }
    }

    fn resolve_type_expr(&mut self, ty: &TypeExpr) -> Option<AtlasType> {
        match ty {
            TypeExpr::Named(name) => match name.as_str() {
                "int" => Some(AtlasType::Int),
                "int64" => Some(AtlasType::Int64),
                "int32" => Some(AtlasType::Int32),
                "int16" => Some(AtlasType::Int16),
                "int8" => Some(AtlasType::Int8),
                "uint" => Some(AtlasType::Uint),
                "uint64" => Some(AtlasType::Uint64),
                "uint32" => Some(AtlasType::Uint32),
                "uint16" => Some(AtlasType::Uint16),
                "uint8" => Some(AtlasType::Uint8),
                "float" => Some(AtlasType::Float),
                "float64" => Some(AtlasType::Float64),
                "float32" => Some(AtlasType::Float32),
                "bool" => Some(AtlasType::Bool),
                "char" => Some(AtlasType::Char),
                "void" => Some(AtlasType::Void),
                other => {
                    if self.structs.contains_key(other) {
                        Some(AtlasType::Struct(other.to_string()))
                    } else if self.classes.contains_key(other) {
                        Some(AtlasType::Class(other.to_string()))
                    } else if self.enums.contains_key(other) {
                        Some(AtlasType::Enum(other.to_string()))
                    } else if self.choices.contains_key(other) {
                        Some(AtlasType::Choice(other.to_string()))
                    } else {
                        None
                    }
                }
            },
            TypeExpr::Pointer { target, nullable, .. } => Some(AtlasType::Pointer {
                target: Box::new(self.resolve_type_expr(target)?),
                nullable: *nullable,
            }),
            TypeExpr::Array { element, size, .. } => Some(AtlasType::Array {
                element: Box::new(self.resolve_type_expr(element)?),
                size: *size,
            }),
            TypeExpr::Slice { element, .. } => Some(AtlasType::Slice(Box::new(self.resolve_type_expr(element)?))),
            TypeExpr::Generic { base, args, .. } => {
                let mut resolved_args = Vec::new();
                for arg in args {
                    resolved_args.push(self.resolve_type_expr(arg)?);
                }
                let mangled = mangle_type_name(base, &resolved_args);
                if self.choices.contains_key(&mangled) {
                    return Some(AtlasType::Choice(mangled));
                }
                if self.classes.contains_key(&mangled) {
                    return Some(AtlasType::Class(mangled));
                }
                if let Some(template) = self.generic_class_templates.get(base).cloned() {
                    if template.generic_params.len() != resolved_args.len() {
                        return None;
                    }
                    let substitutions: HashMap<String, TypeExpr> = template
                        .generic_params
                        .iter()
                        .zip(resolved_args.iter())
                        .map(|(name, ty)| (name.0.clone(), atlas_type_to_type_expr(ty)))
                        .collect();
                    let mut instantiated = substitute_class_decl(&template, &mangled, &substitutions);
                    self.rewrite_generic_class_calls_in_class(&mut instantiated, &substitutions);
                    self.register_class_decl(&instantiated);
                    self.register_class_methods(&instantiated);
                    self.generated_classes.push(instantiated.clone());
                    for method in &instantiated.methods {
                        let qualified = format!("{}.{}", instantiated.name.0, method.decl.name.0);
                        if self.fn_sigs.contains_key(&qualified) {
                            let _ = self.check_qualified_function(&qualified, &method.decl);
                        }
                    }
                    return Some(AtlasType::Class(mangled));
                }
                if let Some(template) = self.choice_templates.get(base).cloned() {
                    if template.generic_params.len() != resolved_args.len() {
                        return None;
                    }
                    let bindings: HashMap<String, AtlasType> = template
                        .generic_params
                        .into_iter()
                        .zip(resolved_args.into_iter())
                        .collect();
                    let mut variants = Vec::new();
                    for (variant_name, payload_ty) in template.variants {
                        let payload = match payload_ty {
                            Some(payload_ty) => {
                                let substituted = substitute_type_expr(&payload_ty, &bindings);
                                Some(self.resolve_type_expr(&substituted)?)
                            }
                            None => None,
                        };
                        variants.push(ChoiceVariantType {
                            name: variant_name,
                            payload,
                        });
                    }
                    self.choices.insert(
                        mangled.clone(),
                        ChoiceType {
                            name: mangled.clone(),
                            variants,
                        },
                    );
                    Some(AtlasType::Choice(mangled))
                } else {
                    None
                }
            }
        }
    }

    fn resolve_type_expr_or_error(
        &mut self,
        ty: &TypeExpr,
        span: Span,
        context: &str,
    ) -> AtlasType {
        match self.resolve_type_expr(ty) {
            Some(resolved) => resolved,
            None => {
                self.errors.push(AtlasError::TypeError {
                    span,
                    message: format!("unknown type '{:?}' in {}", ty, context),
                    hint: None,
                });
                AtlasType::Void
            }
        }
    }

    fn register_class_methods(&mut self, decl: &crate::parser::ClassDecl) {
        let class_name = decl.name.0.clone();
        if !self.classes.contains_key(&class_name) {
            return;
        }
        for method in &decl.methods {
            if !method.decl.generic_params.is_empty() || !method.decl.where_clauses.is_empty() {
                continue;
            }
            let mut params = Vec::new();
            let mut supported = true;
            for param in &method.decl.params {
                let Some(ty) = self.resolve_method_type_expr(&class_name, &param.ty.0) else {
                    supported = false;
                    break;
                };
                params.push((param.name.0.clone(), ty));
            }
            let ret_ty = method
                .decl
                .ret_ty
                .as_ref()
                .map(|ret| self.resolve_type_expr(&ret.0))
                .unwrap_or(Some(AtlasType::Void));
            if supported {
                if let Some(ret_ty) = ret_ty {
                    let sig = FnSignature { params: params.clone(), ret_ty: ret_ty.clone(), is_variadic: false };
                    self.fn_sigs.insert(
                        format!("{}.{}", class_name, method.decl.name.0),
                        sig.clone(),
                    );
                    if let Some(class_ty) = self.classes.get_mut(&class_name) {
                        class_ty.methods.insert(
                            method.decl.name.0.clone(),
                            ClassMethodType {
                                name: method.decl.name.0.clone(),
                                sig,
                                visibility: method.visibility,
                            },
                        );
                    }
                }
            }
        }
        let class_ty = self.classes.get_mut(&class_name).expect("class missing");
        class_ty.methods.entry("init".to_string()).or_insert_with(|| default_class_method(&class_name, "init", AtlasType::Void));
        class_ty.methods.entry("destroy".to_string()).or_insert_with(|| default_class_method(&class_name, "destroy", AtlasType::Void));
        class_ty.methods.entry("clone".to_string()).or_insert_with(|| default_class_method(&class_name, "clone", AtlasType::Class(class_name.clone())));
    }

    fn collect_classes_from_ast(&mut self, ast: &SourceFile) {
        for item in &ast.items {
            if let Item::ClassDecl(decl, _) = item {
                if !decl.generic_params.is_empty() || !decl.where_clauses.is_empty() {
                    self.generic_class_templates.insert(decl.name.0.clone(), decl.clone());
                    continue;
                }
                self.register_class_decl(decl);
            }
        }

        let class_names: Vec<String> = self.classes.keys().cloned().collect();
        for class_name in class_names {
            let class_ty = self.classes.get_mut(&class_name).expect("class missing");
            class_ty.methods.entry("init".to_string()).or_insert_with(|| default_class_method(&class_name, "init", AtlasType::Void));
            class_ty.methods.entry("destroy".to_string()).or_insert_with(|| default_class_method(&class_name, "destroy", AtlasType::Void));
            class_ty.methods.entry("clone".to_string()).or_insert_with(|| default_class_method(&class_name, "clone", AtlasType::Class(class_name.clone())));
        }
    }

    fn register_class_decl(&mut self, decl: &crate::parser::ClassDecl) {
        let mut fields = Vec::new();
        for field in &decl.fields {
            let Some(ty) = self.resolve_type_expr(&field.ty.0) else {
                return;
            };
            fields.push(ClassFieldType {
                name: field.name.0.clone(),
                ty,
                visibility: field.visibility,
                is_const: field.is_const,
            });
        }
        self.classes.insert(
            decl.name.0.clone(),
            ClassType {
                name: decl.name.0.clone(),
                fields,
                methods: HashMap::new(),
            },
        );
    }

    fn collect_enums_from_ast(&mut self, ast: &SourceFile) {
        for item in &ast.items {
            if let Item::EnumDecl(decl, _) = item {
                self.enums.insert(
                    decl.name.0.clone(),
                    EnumType {
                        name: decl.name.0.clone(),
                        variants: decl.variants.iter().map(|variant| variant.0.clone()).collect(),
                    },
                );
            }
        }
    }

    fn collect_choices_from_ast(&mut self, ast: &SourceFile) {
        for item in &ast.items {
            if let Item::ChoiceDecl(decl, _) = item {
                if !decl.generic_params.is_empty() {
                    self.choice_templates.insert(
                        decl.name.0.clone(),
                        GenericChoiceTemplate {
                            generic_params: decl.generic_params.iter().map(|param| param.0.clone()).collect(),
                            variants: decl
                                .variants
                                .iter()
                                .map(|variant| (variant.name.0.clone(), variant.payload.as_ref().map(|payload| payload.0.clone())))
                                .collect(),
                        },
                    );
                    continue;
                }
                let mut variants = Vec::new();
                for variant in &decl.variants {
                    let payload = variant.payload.as_ref().map(|payload| self.resolve_type_expr(&payload.0));
                    let payload = match payload {
                        Some(Some(ty)) => Some(ty),
                        Some(None) => return,
                        None => None,
                    };
                    variants.push(ChoiceVariantType {
                        name: variant.name.0.clone(),
                        payload,
                    });
                }
                self.choices.insert(
                    decl.name.0.clone(),
                    ChoiceType {
                        name: decl.name.0.clone(),
                        variants,
                    },
                );
            }
        }
    }

    fn build_signatures_from_ast(&mut self, ast: &SourceFile, skip_unsupported: bool) {
        for item in &ast.items {
            match item {
                Item::FunctionDecl(decl, _) => {
                    if !decl.generic_params.is_empty() || !decl.where_clauses.is_empty() {
                        self.generic_fn_templates.insert(decl.name.0.clone(), decl.clone());
                        continue;
                    }
                    let mut params = Vec::new();
                    let mut supported = true;
                    for param in &decl.params {
                        let Some(ty) = self.resolve_type_expr(&param.ty.0) else {
                            supported = false;
                            break;
                        };
                        params.push((param.name.0.clone(), ty));
                    }
                    let ret_ty = decl
                        .ret_ty
                        .as_ref()
                        .map(|ret| self.resolve_type_expr(&ret.0))
                        .unwrap_or(Some(AtlasType::Void));
                    if supported {
                        if let Some(ret_ty) = ret_ty {
                            self.fn_sigs.insert(decl.name.0.clone(), FnSignature { params, ret_ty, is_variadic: false });
                        } else if !skip_unsupported {
                            self.errors.push(AtlasError::TypeError {
                                span: decl.body.span,
                                message: format!("unsupported return type in '{}'", decl.name.0),
                                hint: None,
                            });
                        }
                    } else if !skip_unsupported {
                        self.errors.push(AtlasError::TypeError {
                            span: decl.body.span,
                            message: format!("unsupported parameter types in '{}'", decl.name.0),
                            hint: None,
                        });
                    }
                }
                Item::ExternFnDecl(decl, _) => {
                    let mut params = Vec::new();
                    let mut supported = true;
                    for param in &decl.params {
                        let Some(ty) = self.resolve_type_expr(&param.ty.0) else {
                            supported = false;
                            break;
                        };
                        params.push((param.name.0.clone(), ty));
                    }
                    let ret_ty = decl
                        .ret_ty
                        .as_ref()
                        .map(|ret| self.resolve_type_expr(&ret.0))
                        .unwrap_or(Some(AtlasType::Void));
                    if supported {
                        if let Some(ret_ty) = ret_ty {
                            self.fn_sigs.insert(
                                decl.name.0.clone(),
                                FnSignature { params, ret_ty, is_variadic: decl.is_variadic },
                            );
                        }
                    }
                }
                Item::ClassDecl(decl, _) => {
                    let class_name = decl.name.0.clone();
                    if !self.classes.contains_key(&class_name) {
                        continue;
                    }
                    for method in &decl.methods {
                        if !method.decl.generic_params.is_empty() || !method.decl.where_clauses.is_empty() {
                            continue;
                        }
                        let mut params = Vec::new();
                        let mut supported = true;
                        for param in &method.decl.params {
                            let Some(ty) = self.resolve_method_type_expr(&class_name, &param.ty.0) else {
                                supported = false;
                                break;
                            };
                            params.push((param.name.0.clone(), ty));
                        }
                        let ret_ty = method
                            .decl
                            .ret_ty
                            .as_ref()
                            .map(|ret| self.resolve_type_expr(&ret.0))
                            .unwrap_or(Some(AtlasType::Void));
                        if supported {
                            if let Some(ret_ty) = ret_ty {
                                let sig = FnSignature { params: params.clone(), ret_ty: ret_ty.clone(), is_variadic: false };
                                self.fn_sigs.insert(
                                    format!("{}.{}", class_name, method.decl.name.0),
                                    sig.clone(),
                                );
                                if let Some(class_ty) = self.classes.get_mut(&class_name) {
                                    class_ty.methods.insert(
                                        method.decl.name.0.clone(),
                                        ClassMethodType {
                                            name: method.decl.name.0.clone(),
                                            sig,
                                            visibility: method.visibility,
                                        },
                                    );
                                }
                            }
                        }
                    }
                }
                Item::Import(_) | Item::StructDecl(_, _) | Item::EnumDecl(_, _) | Item::ChoiceDecl(_, _) => {}
            }
        }
    }

    fn check_file(mut self, ast: &SourceFile) -> Result<TypedAST, NativeCheckError> {
        self.build_signatures(ast)?;

        self.finish_check(ast)
    }

    fn check_reachable_project_classes(
        &mut self,
        project: &Project,
        reachable_classes: &mut HashSet<String>,
    ) -> Result<(), NativeCheckError> {
        let class_decls = collect_project_class_decls(project);
        let mut checked = HashSet::new();
        let mut queue: Vec<String> = reachable_classes.iter().cloned().collect();

        while let Some(class_name) = queue.pop() {
            if !checked.insert(class_name.clone()) {
                continue;
            }

            let Some(decl) = class_decls.get(&class_name).copied() else {
                return Err(NativeCheckError::Unsupported);
            };

            for method in &decl.methods {
                let qualified = format!("{}.{}", class_name, method.decl.name.0);
                if !self.fn_sigs.contains_key(&qualified) {
                    continue;
                }
                self.check_qualified_function(&qualified, &method.decl)?;
                let nested = collect_referenced_classes_from_block(&method.decl.body, &self.classes);
                for nested_class in nested {
                    if reachable_classes.insert(nested_class.clone()) {
                        queue.push(nested_class);
                    }
                }
            }
        }

        Ok(())
    }

    fn finish_check(&mut self, ast: &SourceFile) -> Result<TypedAST, NativeCheckError> {
        for item in &ast.items {
            match item {
                Item::FunctionDecl(decl, _) => {
                    if !decl.generic_params.is_empty() || !decl.where_clauses.is_empty() {
                        continue;
                    }
                    if !self.fn_sigs.contains_key(&decl.name.0) {
                        return Err(NativeCheckError::Unsupported);
                    }
                    self.check_function(decl)?;
                }
                Item::ClassDecl(decl, _) => {
                    for method in &decl.methods {
                        let qualified = format!("{}.{}", decl.name.0, method.decl.name.0);
                        if !self.fn_sigs.contains_key(&qualified) {
                            continue;
                        }
                        self.check_qualified_function(&qualified, &method.decl)?;
                    }
                }
                _ => {}
            }
        }

        if self.errors.is_empty() {
            Ok(TypedAST {
                fn_sigs: std::mem::take(&mut self.fn_sigs),
                expr_types: HashMap::new(),
                structs: std::mem::take(&mut self.structs),
                classes: std::mem::take(&mut self.classes),
                enums: std::mem::take(&mut self.enums),
                choices: std::mem::take(&mut self.choices),
                generated_classes: std::mem::take(&mut self.generated_classes),
                generated_functions: std::mem::take(&mut self.generated_functions),
                mangled_calls: std::mem::take(&mut self.mangled_calls),
                overloaded_operators: HashMap::new(),
            })
        } else {
            Err(NativeCheckError::Errors(std::mem::take(&mut self.errors)))
        }
    }

    fn check_function(&mut self, decl: &crate::parser::FunctionDecl) -> Result<(), NativeCheckError> {
        let sig = self
            .fn_sigs
            .get(&decl.name.0)
            .cloned()
            .ok_or(NativeCheckError::Unsupported)?;
        let previous_ret = self.current_return_ty.clone();
        let previous_fn = self.current_function_name.clone();
        let previous_class = self.current_class_name.clone();
        self.current_return_ty = Some(sig.ret_ty.clone());
        self.current_function_name = Some(decl.name.0.clone());
        self.current_class_name = None;
        let mut locals: HashMap<String, AtlasType> = sig.params.into_iter().collect();
        let result = self.check_block(&decl.body, &mut locals, &sig.ret_ty);
        self.current_return_ty = previous_ret;
        self.current_function_name = previous_fn;
        self.current_class_name = previous_class;
        result
    }

    fn check_qualified_function(
        &mut self,
        qualified_name: &str,
        decl: &crate::parser::FunctionDecl,
    ) -> Result<(), NativeCheckError> {
        let sig = self
            .fn_sigs
            .get(qualified_name)
            .cloned()
            .ok_or(NativeCheckError::Unsupported)?;
        let previous_ret = self.current_return_ty.clone();
        let previous_fn = self.current_function_name.clone();
        let previous_class = self.current_class_name.clone();
        self.current_return_ty = Some(sig.ret_ty.clone());
        self.current_function_name = Some(qualified_name.to_string());
        self.current_class_name = qualified_name.rsplit_once('.').map(|(class_name, _)| class_name.to_string());
        let mut locals: HashMap<String, AtlasType> = sig.params.into_iter().collect();
        let result = self.check_block(&decl.body, &mut locals, &sig.ret_ty);
        self.current_return_ty = previous_ret;
        self.current_function_name = previous_fn;
        self.current_class_name = previous_class;
        result
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
                let var_ty = if let Some(init) = &decl.init {
                    if let Some(hint) = &decl.ty_hint {
                        let hint_ty = self.resolve_type_expr_or_error(&hint.0, decl.span, "variable declaration");
                        let init_ty = self.check_expr_with_expected(init, &hint_ty, locals)?;
                        if !is_assignable_to(&hint_ty, &init_ty) {
                            self.errors.push(AtlasError::TypeError {
                                span: decl.span,
                                message: format!(
                                    "mismatched initializer type: expected '{:?}', found '{:?}'",
                                    hint_ty, init_ty
                                ),
                                hint: None,
                            });
                        }
                        hint_ty
                    } else {
                        let init_ty = self.check_expr(init, locals)?;
                        init_ty
                    }
                } else if let Some(hint) = &decl.ty_hint {
                    let hint_ty = self.resolve_type_expr_or_error(&hint.0, decl.span, "variable declaration");
                    hint_ty
                } else {
                    self.errors.push(AtlasError::TypeError {
                        span: decl.span,
                        message: "uninitialized local variables require a type annotation".to_string(),
                        hint: Some("Add an explicit type, for example 'var x: int;'".to_string()),
                    });
                    AtlasType::Void
                };
                locals.insert(decl.name.0.clone(), var_ty);
            }
            Stmt::ConstDecl(decl) => {
                let init_ty = if let Some(hint) = &decl.ty_hint {
                    let hint_ty = self.resolve_type_expr_or_error(&hint.0, decl.span, "constant declaration");
                    self.check_expr_with_expected(&decl.init, &hint_ty, locals)?
                } else {
                    self.check_expr(&decl.init, locals)?
                };
                if let Some(hint) = &decl.ty_hint {
                    let hint_ty = self.resolve_type_expr_or_error(&hint.0, decl.span, "constant declaration");
                    if !is_assignable_to(&hint_ty, &init_ty) {
                        self.errors.push(AtlasError::TypeError {
                            span: decl.span,
                            message: format!(
                                "mismatched initializer type: expected '{:?}', found '{:?}'",
                                hint_ty, init_ty
                            ),
                            hint: None,
                        });
                    }
                }
                locals.insert(decl.name.0.clone(), init_ty);
            }
            Stmt::Assign(assign) => {
                if let Expr::ArrayIndex { array, index, span } = &assign.target {
                    if let Some((class_name, method)) =
                        self.resolve_index_assign_method(array, index, locals, *span)?
                    {
                        let actual = self.check_expr_with_expected(&assign.value, &method.sig.params[2].1, locals)?;
                        let expected_ty = &method.sig.params[2].1;
                        if !is_assignable_to(expected_ty, &actual) {
                            self.errors.push(AtlasError::TypeError {
                                span: assign.value.span(),
                                message: format!(
                                    "index assignment type mismatch for '{}.operator[]=': expected '{:?}', found '{:?}'",
                                    class_name, expected_ty, actual
                                ),
                                hint: None,
                            });
                        }
                        return Ok(());
                    }
                }
                let target_ty = self.check_lvalue(&assign.target, locals)?;
                let value_ty = self.check_expr_with_expected(&assign.value, &target_ty, locals)?;
                if !is_assignable_to(&target_ty, &value_ty) {
                    self.errors.push(AtlasError::TypeError {
                        span: assign.span,
                        message: format!("cannot assign '{:?}' to '{:?}'", value_ty, target_ty),
                        hint: None,
                    });
                }
            }
            Stmt::ExprStmt(expr) => {
                if let Expr::Match { expr: matched, cases, span } = expr {
                    self.check_match(matched, cases, locals, expected_ret, *span)?;
                } else {
                    self.check_expr(expr, locals)?;
                }
            }
            Stmt::Return(expr, span) => {
                let actual = if let Some(expr) = expr {
                    self.check_expr_with_expected(expr, expected_ret, locals)?
                } else {
                    AtlasType::Void
                };
                if !is_assignable_to(expected_ret, &actual) {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: format!(
                            "return type mismatch: expected '{:?}', found '{:?}'",
                            expected_ret, actual
                        ),
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
            Stmt::StructDecl(decl) => {
                self.register_struct_decl(decl);
            }
        }
        Ok(())
    }

    fn check_lvalue(
        &mut self,
        expr: &Expr,
        locals: &HashMap<String, AtlasType>,
    ) -> Result<AtlasType, NativeCheckError> {
        match expr {
            Expr::Var { name, span } => {
                if let Some(ty) = locals.get(name) {
                    Ok(ty.clone())
                } else {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: format!("unknown variable '{}'", name),
                        hint: None,
                    });
                    Ok(AtlasType::Void)
                }
            }
            Expr::MemberAccess { object, member, span } => {
                let object_ty = self.check_expr(object, locals)?;
                self.resolve_member_type(&object_ty, member, *span)
            }
            Expr::ArrayIndex { array, index, span } => {
                let array_ty = self.check_expr(array, locals)?;
                match array_ty {
                    AtlasType::Class(class_name) => {
                        let index_ty = self.check_expr(index, locals)?;
                        self.resolve_index_read_method(&class_name, &index_ty, *span)
                            .map(|method| method.sig.ret_ty.clone())
                    }
                    AtlasType::Array { element, .. } | AtlasType::Slice(element) => {
                        let index_ty = self.check_expr(index, locals)?;
                        if !is_integer(&index_ty) {
                            self.errors.push(AtlasError::TypeError {
                                span: index.span(),
                                message: format!("array index must be integer, found '{:?}'", index_ty),
                                hint: None,
                            });
                        }
                        Ok(*element)
                    }
                    AtlasType::Pointer { target, .. } => match *target {
                        other => {
                            let index_ty = self.check_expr(index, locals)?;
                            if !is_integer(&index_ty) {
                                self.errors.push(AtlasError::TypeError {
                                    span: index.span(),
                                    message: format!("array index must be integer, found '{:?}'", index_ty),
                                    hint: None,
                                });
                            }
                            Ok(other)
                        }
                    },
                    other => {
                        self.errors.push(AtlasError::TypeError {
                            span: *span,
                            message: format!("cannot index into '{:?}'", other),
                            hint: None,
                        });
                        Ok(AtlasType::Void)
                    }
                }
            }
            Expr::Unary {
                op: UnaryOp::Dereference,
                operand,
                span,
            } => {
                let ty = self.check_expr(operand, locals)?;
                match ty {
                    AtlasType::Pointer { target, .. } => Ok(*target),
                    other => {
                        self.errors.push(AtlasError::TypeError {
                            span: *span,
                            message: format!("cannot dereference '{:?}'", other),
                            hint: None,
                        });
                        Ok(AtlasType::Void)
                    }
                }
            }
            _ => {
                self.errors.push(AtlasError::TypeError {
                    span: expr.span(),
                    message: "invalid assignment target".to_string(),
                    hint: None,
                });
                Ok(AtlasType::Void)
            }
        }
    }

    fn resolve_member_type(
        &mut self,
        object_ty: &AtlasType,
        member: &str,
        span: Span,
    ) -> Result<AtlasType, NativeCheckError> {
        match object_ty {
            AtlasType::Struct(name) => {
                let Some(struct_ty) = self.structs.get(name) else {
                    return Err(NativeCheckError::Unsupported);
                };
                if let Some((_, field_ty)) = struct_ty.fields.iter().find(|(field, _)| field == member) {
                    Ok(field_ty.clone())
                } else {
                    self.errors.push(AtlasError::TypeError {
                        span,
                        message: format!("struct '{}' has no field '{}'", name, member),
                        hint: None,
                    });
                    Ok(AtlasType::Void)
                }
            }
            AtlasType::Class(name) => {
                let Some(class_ty) = self.classes.get(name) else {
                    return Err(NativeCheckError::Unsupported);
                };
                if let Some(field_ty) = class_ty.fields.iter().find(|field| field.name == member) {
                    Ok(field_ty.ty.clone())
                } else {
                    self.errors.push(AtlasError::TypeError {
                        span,
                        message: format!("class '{}' has no field '{}'", name, member),
                        hint: None,
                    });
                    Ok(AtlasType::Void)
                }
            }
            _ => {
                self.errors.push(AtlasError::TypeError {
                    span,
                    message: format!("type '{:?}' has no member '{}'", object_ty, member),
                    hint: None,
                });
                Ok(AtlasType::Void)
            }
        }
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
                Some(IntSuffix::I64) => AtlasType::Int64,
                None => AtlasType::Int,
                Some(IntSuffix::U8) => AtlasType::Uint8,
                Some(IntSuffix::U16) => AtlasType::Uint16,
                Some(IntSuffix::U32) => AtlasType::Uint32,
                Some(IntSuffix::U64) => AtlasType::Uint64,
            }),
            Expr::FloatLit { .. } => Ok(AtlasType::Float),
            Expr::BoolLit { .. } => Ok(AtlasType::Bool),
            Expr::CharLit { .. } => Ok(AtlasType::Char),
            Expr::StringLit { .. } => Ok(AtlasType::Slice(Box::new(AtlasType::Char))),
            Expr::Null { .. } => Ok(AtlasType::Null),
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
                    UnaryOp::AddressOf => Ok(AtlasType::Pointer {
                        target: Box::new(self.check_lvalue(operand, locals)?),
                        nullable: false,
                    }),
                    UnaryOp::Dereference => match ty {
                        AtlasType::Pointer { target, .. } => Ok(*target),
                        other => {
                            self.errors.push(AtlasError::TypeError {
                                span: *span,
                                message: format!("cannot dereference '{:?}'", other),
                                hint: None,
                            });
                            Ok(AtlasType::Void)
                        }
                    },
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
                if let AtlasType::Class(class_name) = &lhs_ty {
                    if let Some(method_name) = binary_operator_method_name(op) {
                        let Some(method) = self
                            .classes
                            .get(class_name)
                            .and_then(|class_ty| class_ty.methods.get(method_name))
                            .cloned()
                        else {
                            self.errors.push(AtlasError::TypeError {
                                span: *span,
                                message: format!("type '{class_name}' does not support operator '{:?}'", op),
                                hint: None,
                            });
                            return Ok(AtlasType::Void);
                        };
                        if method.sig.params.len() != 2 {
                            self.errors.push(AtlasError::TypeError {
                                span: *span,
                                message: format!(
                                    "operator method '{}.{}' must take exactly one explicit argument",
                                    class_name, method_name
                                ),
                                hint: None,
                            });
                            return Ok(method.sig.ret_ty.clone());
                        }
                        let expected_rhs_ty = &method.sig.params[1].1;
                        if !is_assignable_to(expected_rhs_ty, &rhs_ty) {
                            self.errors.push(AtlasError::TypeError {
                                span: rhs.span(),
                                message: format!(
                                    "operator argument type mismatch: expected '{:?}', found '{:?}'",
                                    expected_rhs_ty, rhs_ty
                                ),
                                hint: None,
                            });
                        }
                        return Ok(method.sig.ret_ty.clone());
                    }
                }
                check_binary(op, lhs_ty, rhs_ty, *span, &mut self.errors)
            }
            Expr::Call { callee, args, span } => {
                if let Some(struct_ty) = self.structs.get(callee).cloned() {
                    if struct_ty.fields.len() != args.len() {
                        self.errors.push(AtlasError::TypeError {
                            span: *span,
                            message: format!("wrong argument count for struct constructor '{}'", callee),
                            hint: None,
                        });
                        return Ok(AtlasType::Struct(callee.clone()));
                    }
                    for (arg, (_, expected_ty)) in args.iter().zip(struct_ty.fields.iter()) {
                        let actual = self.check_expr_with_expected(arg, expected_ty, locals)?;
                        if !is_assignable_to(expected_ty, &actual) {
                            self.errors.push(AtlasError::TypeError {
                                span: arg.span(),
                                message: format!(
                                    "struct constructor argument type mismatch: expected '{:?}', found '{:?}'",
                                    expected_ty, actual
                                ),
                                hint: None,
                            });
                        }
                    }
                    return Ok(AtlasType::Struct(callee.clone()));
                }
                if let Some(class_ty) = self.classes.get(callee).cloned() {
                    let Some(init_sig) = class_ty.methods.get("init").map(|method| method.sig.clone()) else {
                        self.errors.push(AtlasError::TypeError {
                            span: *span,
                            message: format!("class '{}' has no constructor 'init'", callee),
                            hint: None,
                        });
                        return Ok(AtlasType::Class(callee.clone()));
                    };
                    let expected_args = init_sig.params.iter().skip(1).collect::<Vec<_>>();
                    if expected_args.len() != args.len() {
                        self.errors.push(AtlasError::TypeError {
                            span: *span,
                            message: format!("wrong argument count for constructor '{}'", callee),
                            hint: None,
                        });
                        return Ok(AtlasType::Class(callee.clone()));
                    }
                    for (arg, (_, expected_ty)) in args.iter().zip(expected_args.iter()) {
                        let actual = self.check_expr_with_expected(arg, expected_ty, locals)?;
                        if !is_assignable_to(expected_ty, &actual) {
                            self.errors.push(AtlasError::TypeError {
                                span: arg.span(),
                                message: format!(
                                    "constructor argument type mismatch: expected '{:?}', found '{:?}'",
                                    expected_ty, actual
                                ),
                                hint: None,
                            });
                        }
                    }
                    return Ok(AtlasType::Class(callee.clone()));
                }
                if let Some(template) = self.generic_fn_templates.get(callee).cloned() {
                    let instantiated_sig = self.instantiate_generic_function(&template, args, locals, *span)?;
                    return Ok(instantiated_sig.ret_ty);
                }
                let Some(sig) = self.fn_sigs.get(callee).cloned() else {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: format!("unknown function '{}'", callee),
                        hint: None,
                    });
                    return Ok(AtlasType::Void);
                };
                if args.len() < sig.params.len() || (!sig.is_variadic && sig.params.len() != args.len()) {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: format!("wrong argument count for '{}'", callee),
                        hint: None,
                    });
                    return Ok(sig.ret_ty);
                }
                for (arg, (_, expected_ty)) in args.iter().zip(sig.params.iter()) {
                    let actual = self.check_expr_with_expected(arg, expected_ty, locals)?;
                    if !is_assignable_to(expected_ty, &actual) {
                        self.errors.push(AtlasError::TypeError {
                            span: arg.span(),
                            message: format!(
                                "argument type mismatch: expected '{:?}', found '{:?}'",
                                expected_ty, actual
                            ),
                            hint: None,
                        });
                    }
                }
                if sig.is_variadic {
                    for arg in args.iter().skip(sig.params.len()) {
                        let _ = self.check_expr(arg, locals)?;
                    }
                }
                Ok(sig.ret_ty)
            }
            Expr::StaticMember {
                class_name,
                member_name,
                span,
            } => {
                if let Some(enum_ty) = self.enums.get(class_name) {
                    if enum_ty.variants.iter().any(|variant| variant == member_name) {
                        return Ok(AtlasType::Enum(class_name.clone()));
                    }
                }
                if let Some(choice_ty) = self.choices.get(class_name) {
                    if let Some(variant) = choice_ty.variants.iter().find(|variant| variant.name == *member_name) {
                        if variant.payload.is_none() {
                            return Ok(AtlasType::Choice(class_name.clone()));
                        }
                    }
                }
                self.errors.push(AtlasError::TypeError {
                    span: *span,
                    message: format!("unknown static member '{}.{}'", class_name, member_name),
                    hint: None,
                });
                Ok(AtlasType::Void)
            }
            Expr::MethodCall {
                object,
                method_name,
                args,
                span,
            } => {
                let object_ty = self.check_expr(object, locals)?;
                if let Some(ret_ty) =
                    self.resolve_primitive_method_call(&object_ty, method_name, args, locals, *span)?
                {
                    return Ok(ret_ty);
                }
                if method_name == "destroy" && is_class_receiver(&object_ty) {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: "manual '.destroy()' calls on class instances are forbidden; destruction is automatic".to_string(),
                        hint: Some("Remove the explicit destroy call and let the compiler manage object teardown.".to_string()),
                    });
                    return Ok(AtlasType::Void);
                }
                let (class_name, is_instance) = match &object_ty {
                    AtlasType::Class(name) => (name.clone(), true),
                    AtlasType::Pointer { target, .. } => match target.as_ref() {
                        AtlasType::Class(name) => (name.clone(), true),
                        _ => {
                            self.errors.push(AtlasError::TypeError {
                                span: *span,
                                message: format!("type '{:?}' has no method '{}'", object_ty, method_name),
                                hint: None,
                            });
                            return Ok(AtlasType::Void);
                        }
                    },
                    _ => {
                        self.errors.push(AtlasError::TypeError {
                            span: *span,
                            message: format!("type '{:?}' has no method '{}'", object_ty, method_name),
                            hint: None,
                        });
                        return Ok(AtlasType::Void);
                    }
                };
                let method = self
                    .classes
                    .get(&class_name)
                    .and_then(|class_ty| class_ty.methods.get(method_name))
                    .cloned();
                let Some(method) = method else {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: format!("class '{}' has no method '{}'", class_name, method_name),
                        hint: None,
                    });
                    return Ok(AtlasType::Void);
                };
                let params = if is_instance {
                    method.sig.params.iter().skip(1).collect::<Vec<_>>()
                } else {
                    method.sig.params.iter().collect::<Vec<_>>()
                };
                if params.len() != args.len() {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: format!("wrong argument count for method '{}'", method_name),
                        hint: None,
                    });
                    return Ok(method.sig.ret_ty.clone());
                }
                for (arg, (_, expected_ty)) in args.iter().zip(params.iter()) {
                    let actual = self.check_expr_with_expected(arg, expected_ty, locals)?;
                    if !is_assignable_to(expected_ty, &actual) {
                        self.errors.push(AtlasError::TypeError {
                            span: arg.span(),
                            message: format!(
                                "method argument type mismatch: expected '{:?}', found '{:?}'",
                                expected_ty, actual
                            ),
                            hint: None,
                        });
                    }
                }
                Ok(method.sig.ret_ty.clone())
            }
            Expr::StaticCall {
                class_name,
                method_name,
                args,
                span,
            } => {
                let inferred_choice_name = self.infer_choice_constructor_target(class_name);
                if let Some(choice_name) = inferred_choice_name.or_else(|| self.choices.get(class_name).map(|_| class_name.clone())) {
                    let Some(choice_ty) = self.choices.get(&choice_name).cloned() else {
                        return Err(NativeCheckError::Unsupported);
                    };
                    let Some(variant) = choice_ty
                        .variants
                        .iter()
                        .find(|variant| variant.name == *method_name)
                        .cloned()
                    else {
                        self.errors.push(AtlasError::TypeError {
                            span: *span,
                            message: format!("choice '{}' has no variant '{}'", class_name, method_name),
                            hint: None,
                        });
                        return Ok(AtlasType::Choice(choice_name.clone()));
                    };
                    match (&variant.payload, args.as_slice()) {
                        (None, []) => return Ok(AtlasType::Choice(choice_name.clone())),
                        (Some(expected_ty), [arg]) => {
                            let actual = self.check_expr_with_expected(arg, expected_ty, locals)?;
                            if !is_assignable_to(expected_ty, &actual) {
                                self.errors.push(AtlasError::TypeError {
                                    span: arg.span(),
                                    message: format!(
                                        "choice payload type mismatch: expected '{:?}', found '{:?}'",
                                        expected_ty, actual
                                    ),
                                    hint: None,
                                });
                            }
                            return Ok(AtlasType::Choice(choice_name.clone()));
                        }
                        _ => {
                            self.errors.push(AtlasError::TypeError {
                                span: *span,
                                message: format!(
                                    "wrong argument count for variant '{}.{}'",
                                    class_name, method_name
                                ),
                                hint: None,
                            });
                            return Ok(AtlasType::Choice(choice_name.clone()));
                        }
                    }
                }
                let method = self
                    .classes
                    .get(class_name)
                    .and_then(|class_ty| class_ty.methods.get(method_name))
                    .cloned();
                let Some(method) = method else {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: format!("class '{}' has no static method '{}'", class_name, method_name),
                        hint: None,
                    });
                    return Ok(AtlasType::Void);
                };
                if method.sig.params.len() != args.len() {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: format!("wrong argument count for static method '{}'", method_name),
                        hint: None,
                    });
                    return Ok(method.sig.ret_ty.clone());
                }
                for (arg, (_, expected_ty)) in args.iter().zip(method.sig.params.iter()) {
                    let actual = self.check_expr_with_expected(arg, expected_ty, locals)?;
                    if !is_assignable_to(expected_ty, &actual) {
                        self.errors.push(AtlasError::TypeError {
                            span: arg.span(),
                            message: format!(
                                "static method argument type mismatch: expected '{:?}', found '{:?}'",
                                expected_ty, actual
                            ),
                            hint: None,
                        });
                    }
                }
                Ok(method.sig.ret_ty.clone())
            }
            Expr::StructInit {
                struct_name,
                fields,
                span,
            } => {
                let Some(struct_ty) = self.structs.get(struct_name).cloned() else {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: format!("unknown struct '{}'", struct_name),
                        hint: None,
                    });
                    return Ok(AtlasType::Void);
                };
                if struct_ty.fields.len() != fields.len() {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: format!(
                            "struct '{}' initializer has wrong field count",
                            struct_name
                        ),
                        hint: None,
                    });
                }
                for ((field_name, field_span), expr) in fields {
                    let Some((_, expected_ty)) = struct_ty
                        .fields
                        .iter()
                        .find(|(defined_name, _)| defined_name == field_name)
                    else {
                        self.errors.push(AtlasError::TypeError {
                            span: *field_span,
                            message: format!(
                                "struct '{}' has no field '{}'",
                                struct_name, field_name
                            ),
                            hint: None,
                        });
                        continue;
                    };
                    let actual_ty = self.check_expr(expr, locals)?;
                    if !is_assignable_to(expected_ty, &actual_ty) {
                        self.errors.push(AtlasError::TypeError {
                            span: expr.span(),
                            message: format!(
                                "field '{}' type mismatch: expected '{:?}', found '{:?}'",
                                field_name, expected_ty, actual_ty
                            ),
                            hint: None,
                        });
                    }
                }
                Ok(AtlasType::Struct(struct_name.clone()))
            }
            Expr::MemberAccess {
                object,
                member,
                span,
            } => {
                let object_ty = self.check_expr(object, locals)?;
                match &object_ty {
                    AtlasType::Slice(_) if member == "len" => Ok(AtlasType::Int),
                    _ => self.resolve_member_type(&object_ty, member, *span),
                }
            }
            Expr::ArrayIndex { array, index, span } => {
                let array_ty = self.check_expr(array, locals)?;
                match array_ty {
                    AtlasType::Class(class_name) => {
                        let index_ty = self.check_expr(index, locals)?;
                        self.resolve_index_read_method(&class_name, &index_ty, *span)
                            .map(|method| method.sig.ret_ty.clone())
                    }
                    AtlasType::Array { element, .. } | AtlasType::Slice(element) => {
                        let index_ty = self.check_expr(index, locals)?;
                        if !is_integer(&index_ty) {
                            self.errors.push(AtlasError::TypeError {
                                span: index.span(),
                                message: format!("array index must be integer, found '{:?}'", index_ty),
                                hint: None,
                            });
                        }
                        Ok(*element)
                    }
                    AtlasType::Pointer { target, .. } => match *target {
                        other => {
                            let index_ty = self.check_expr(index, locals)?;
                            if !is_integer(&index_ty) {
                                self.errors.push(AtlasError::TypeError {
                                    span: index.span(),
                                    message: format!("array index must be integer, found '{:?}'", index_ty),
                                    hint: None,
                                });
                            }
                            Ok(other)
                        }
                    },
                    other => {
                        self.errors.push(AtlasError::TypeError {
                            span: *span,
                            message: format!("cannot index into '{:?}'", other),
                            hint: None,
                        });
                        Ok(AtlasType::Void)
                    }
                }
            }
            Expr::Cast { target_ty, expr, span } => {
                let source_ty = self.check_expr(expr, locals)?;
                let target_ty = self.resolve_type_expr_or_error(&target_ty.0, *span, "cast");
                if !is_cast_supported(&source_ty, &target_ty) {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: format!("cannot cast '{:?}' to '{:?}'", source_ty, target_ty),
                        hint: None,
                    });
                }
                Ok(target_ty)
            }
            Expr::SizeOf { ty, .. } => {
                let _ = self.resolve_type_expr_or_error(&ty.0, expr.span(), "sizeof");
                Ok(AtlasType::Int)
            }
            Expr::Destroy { type_arg, expr, span } => {
                let target_ty = self.resolve_type_expr_or_error(type_arg, *span, "memory::destroy");
                let value_ty = self.check_expr(expr, locals)?;
                if matches!(target_ty, AtlasType::Class(_)) && !self.allow_internal_class_destroy() {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: "manual 'memory::destroy<T>' is forbidden for class values; destruction is automatic".to_string(),
                        hint: Some("Remove the explicit destroy call and let scope exit or the owning container release the class.".to_string()),
                    });
                    return Ok(AtlasType::Void);
                }
                if !is_assignable_to(&target_ty, &value_ty) {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: format!(
                            "destroy type mismatch: expected '{:?}', found '{:?}'",
                            target_ty, value_ty
                        ),
                        hint: None,
                    });
                }
                Ok(AtlasType::Void)
            }
            Expr::ErrorPropagate { expr, span } => {
                let inner_ty = self.check_expr(expr, locals)?;
                let AtlasType::Choice(choice_name) = inner_ty else {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: "error propagation requires a Result-like choice value".to_string(),
                        hint: None,
                    });
                    return Ok(AtlasType::Void);
                };
                let Some(AtlasType::Choice(current_return_choice)) = self.current_return_ty.clone() else {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: "error propagation requires the enclosing function to return a Result-like choice".to_string(),
                        hint: None,
                    });
                    return Ok(AtlasType::Void);
                };
                if current_return_choice != choice_name {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: "error propagation requires the enclosing function to return the same Result-like choice".to_string(),
                        hint: None,
                    });
                    return Ok(AtlasType::Void);
                }
                let Some(choice_ty) = self.choices.get(&choice_name) else {
                    return Err(NativeCheckError::Unsupported);
                };
                let Some(ok_variant) = choice_ty.variants.iter().find(|variant| variant.name == "Ok") else {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: "error propagation currently requires a choice with an 'Ok' variant".to_string(),
                        hint: None,
                    });
                    return Ok(AtlasType::Void);
                };
                let Some(ok_payload_ty) = ok_variant.payload.clone() else {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: "error propagation requires the 'Ok' variant to carry a value".to_string(),
                        hint: None,
                    });
                    return Ok(AtlasType::Void);
                };
                Ok(ok_payload_ty)
            }
            Expr::Match { .. } => Ok(AtlasType::Void),
            _ => Err(NativeCheckError::Unsupported),
        }
    }

    fn check_match(
        &mut self,
        expr: &Expr,
        cases: &[crate::parser::MatchCase],
        locals: &HashMap<String, AtlasType>,
        expected_ret: &AtlasType,
        span: Span,
    ) -> Result<(), NativeCheckError> {
        let matched_ty = self.check_expr(expr, locals)?;
        for case in cases {
            let mut case_locals = locals.clone();
            self.bind_pattern(&matched_ty, &case.pattern, &mut case_locals)?;
            self.check_block(&case.body, &mut case_locals, expected_ret)?;
        }
        match matched_ty {
            AtlasType::Enum(_) | AtlasType::Choice(_) => Ok(()),
            ty if supports_literal_match(&ty) => Ok(()),
            _ => {
                self.errors.push(AtlasError::TypeError {
                    span,
                    message: format!("match is not supported for '{:?}' in native backend", matched_ty),
                    hint: None,
                });
                Ok(())
            }
        }
    }

    fn bind_pattern(
        &mut self,
        matched_ty: &AtlasType,
        pattern: &crate::parser::Pattern,
        locals: &mut HashMap<String, AtlasType>,
    ) -> Result<(), NativeCheckError> {
        match pattern {
            crate::parser::Pattern::Variant { path, bind, span } => {
                if path.len() != 2 {
                    return Err(NativeCheckError::Unsupported);
                }
                match matched_ty {
                    AtlasType::Enum(enum_name) => {
                        let Some(enum_ty) = self.enums.get(enum_name) else {
                            return Err(NativeCheckError::Unsupported);
                        };
                        if path[0] != *enum_name || !enum_ty.variants.iter().any(|variant| variant == &path[1]) {
                            self.errors.push(AtlasError::TypeError {
                                span: *span,
                                message: format!("pattern '{}::{}' does not match enum '{}'", path[0], path[1], enum_name),
                                hint: None,
                            });
                        }
                        if bind.is_some() {
                            self.errors.push(AtlasError::TypeError {
                                span: *span,
                                message: "enum patterns cannot bind payloads".to_string(),
                                hint: None,
                            });
                        }
                    }
                    AtlasType::Choice(choice_name) => {
                        let Some(choice_ty) = self.choices.get(choice_name) else {
                            return Err(NativeCheckError::Unsupported);
                        };
                        let Some(variant) = choice_ty
                            .variants
                            .iter()
                            .find(|variant| self.choice_name_matches_pattern(choice_name, &path[0]) && variant.name == path[1])
                        else {
                            self.errors.push(AtlasError::TypeError {
                                span: *span,
                                message: format!("pattern '{}::{}' does not match choice '{}'", path[0], path[1], choice_name),
                                hint: None,
                            });
                            return Ok(());
                        };
                        match (&variant.payload, bind) {
                            (Some(payload_ty), Some(name)) => {
                                locals.insert(name.0.clone(), payload_ty.clone());
                            }
                            (None, None) => {}
                            (Some(_), None) | (None, Some(_)) => {
                                self.errors.push(AtlasError::TypeError {
                                    span: *span,
                                    message: format!("pattern '{}::{}' has the wrong binding shape", path[0], path[1]),
                                    hint: None,
                                });
                            }
                        }
                    }
                    _ => {
                        self.errors.push(AtlasError::TypeError {
                            span: *span,
                            message: format!("variant patterns cannot match values of type '{:?}'", matched_ty),
                            hint: None,
                        });
                    }
                }
                Ok(())
            }
            crate::parser::Pattern::Discard(_) => Ok(()),
            crate::parser::Pattern::Literal(lit, span) => {
                let literal_ty = self.check_expr(lit, locals)?;
                if !same_runtime_type(matched_ty, &literal_ty) {
                    self.errors.push(AtlasError::TypeError {
                        span: *span,
                        message: format!(
                            "literal pattern type mismatch: matched '{:?}', pattern '{:?}'",
                            matched_ty, literal_ty
                        ),
                        hint: None,
                    });
                }
                Ok(())
            }
        }
    }

    fn infer_choice_constructor_target(&self, base_name: &str) -> Option<String> {
        if self.choices.contains_key(base_name) {
            return Some(base_name.to_string());
        }
        match self.current_return_ty.as_ref() {
            Some(AtlasType::Choice(choice_name)) if self.choice_name_matches_pattern(choice_name, base_name) => {
                Some(choice_name.clone())
            }
            _ => None,
        }
    }

    fn choice_name_matches_pattern(&self, choice_name: &str, pattern_base: &str) -> bool {
        choice_name == pattern_base || choice_name.starts_with(&format!("{}_", pattern_base))
    }

    fn resolve_index_read_method(
        &mut self,
        class_name: &str,
        index_ty: &AtlasType,
        span: Span,
    ) -> Result<ClassMethodType, NativeCheckError> {
        let Some(method) = self
            .classes
            .get(class_name)
            .and_then(|class_ty| class_ty.methods.get("operator_index"))
            .cloned()
        else {
            self.errors.push(AtlasError::TypeError {
                span,
                message: format!("class '{}' does not support indexing", class_name),
                hint: None,
            });
            return Ok(ClassMethodType {
                name: "operator_index".to_string(),
                sig: FnSignature {
                    params: vec![
                        (
                            "self".to_string(),
                            AtlasType::Pointer {
                                target: Box::new(AtlasType::Class(class_name.to_string())),
                                nullable: false,
                            },
                        ),
                        ("index".to_string(), AtlasType::Void),
                    ],
                    ret_ty: AtlasType::Void,
                    is_variadic: false,
                },
                visibility: crate::parser::Visibility::Public,
            });
        };
        if method.sig.params.len() != 2 {
            self.errors.push(AtlasError::TypeError {
                span,
                message: format!(
                    "index operator '{}.operator[]' must take exactly one explicit index argument",
                    class_name
                ),
                hint: None,
            });
            return Ok(method);
        }
        let expected_index_ty = &method.sig.params[1].1;
        if !is_assignable_to(expected_index_ty, index_ty) {
            self.errors.push(AtlasError::TypeError {
                span,
                message: format!(
                    "index type mismatch for '{}.operator[]': expected '{:?}', found '{:?}'",
                    class_name, expected_index_ty, index_ty
                ),
                hint: None,
            });
        }
        Ok(method)
    }

    fn resolve_index_assign_method(
        &mut self,
        array: &Expr,
        index: &Expr,
        locals: &HashMap<String, AtlasType>,
        span: Span,
    ) -> Result<Option<(String, ClassMethodType)>, NativeCheckError> {
        let array_ty = self.check_expr(array, locals)?;
        let index_ty = self.check_expr(index, locals)?;
        let class_name = match array_ty {
            AtlasType::Class(class_name) => class_name,
            _ => return Ok(None),
        };
        let Some(method) = self
            .classes
            .get(&class_name)
            .and_then(|class_ty| class_ty.methods.get("operator_index_set"))
            .cloned()
        else {
            self.errors.push(AtlasError::TypeError {
                span,
                message: format!("class '{}' does not support indexed assignment", class_name),
                hint: None,
            });
            let recovery_class_name = class_name.clone();
            return Ok(Some((
                class_name,
                ClassMethodType {
                    name: "operator_index_set".to_string(),
                    sig: FnSignature {
                        params: vec![
                            (
                                "self".to_string(),
                                AtlasType::Pointer {
                                    target: Box::new(AtlasType::Class(recovery_class_name)),
                                    nullable: false,
                                },
                            ),
                            ("index".to_string(), AtlasType::Void),
                            ("value".to_string(), AtlasType::Void),
                        ],
                        ret_ty: AtlasType::Void,
                        is_variadic: false,
                    },
                    visibility: crate::parser::Visibility::Public,
                },
            )));
        };
        if method.sig.params.len() != 3 {
            self.errors.push(AtlasError::TypeError {
                span,
                message: format!(
                    "index assignment operator '{}.operator[]=' must take index and value arguments",
                    class_name
                ),
                hint: None,
            });
            return Ok(Some((class_name, method)));
        }
        let expected_index_ty = &method.sig.params[1].1;
        if !is_assignable_to(expected_index_ty, &index_ty) {
            self.errors.push(AtlasError::TypeError {
                span,
                message: format!(
                    "index type mismatch for '{}.operator[]=': expected '{:?}', found '{:?}'",
                    class_name, expected_index_ty, index_ty
                ),
                hint: None,
            });
        }
        Ok(Some((class_name, method)))
    }

    fn resolve_primitive_method_call(
        &mut self,
        object_ty: &AtlasType,
        method_name: &str,
        args: &[Expr],
        locals: &HashMap<String, AtlasType>,
        span: Span,
    ) -> Result<Option<AtlasType>, NativeCheckError> {
        let is_supported = supports_primitive_methods(object_ty);
        if !is_supported {
            return Ok(None);
        }

        match method_name {
            "format" => {
                if !args.is_empty() {
                    self.errors.push(AtlasError::TypeError {
                        span,
                        message: format!("wrong argument count for primitive method '{}'", method_name),
                        hint: None,
                    });
                }
                Ok(Some(AtlasType::Class("string.String".to_string())))
            }
            "hash" => {
                if !args.is_empty() {
                    self.errors.push(AtlasError::TypeError {
                        span,
                        message: format!("wrong argument count for primitive method '{}'", method_name),
                        hint: None,
                    });
                }
                Ok(Some(AtlasType::Int))
            }
            "equals" => {
                if args.len() != 1 {
                    self.errors.push(AtlasError::TypeError {
                        span,
                        message: format!("wrong argument count for primitive method '{}'", method_name),
                        hint: None,
                    });
                    return Ok(Some(AtlasType::Bool));
                }
                let actual = self.check_expr_with_expected(&args[0], object_ty, locals)?;
                if !same_runtime_type(&actual, object_ty) {
                    self.errors.push(AtlasError::TypeError {
                        span: args[0].span(),
                        message: format!(
                            "primitive equals type mismatch: expected '{:?}', found '{:?}'",
                            object_ty, actual
                        ),
                        hint: None,
                    });
                }
                Ok(Some(AtlasType::Bool))
            }
            _ => Ok(None),
        }
    }

    fn instantiate_generic_function(
        &mut self,
        template: &crate::parser::FunctionDecl,
        args: &[Expr],
        locals: &HashMap<String, AtlasType>,
        call_span: Span,
    ) -> Result<FnSignature, NativeCheckError> {
        if template.params.len() != args.len() {
            self.errors.push(AtlasError::TypeError {
                span: call_span,
                message: format!("wrong argument count for '{}'", template.name.0),
                hint: None,
            });
            return Ok(FnSignature { params: Vec::new(), ret_ty: AtlasType::Void, is_variadic: false });
        }

        let generic_names: HashSet<String> = template.generic_params.iter().map(|param| param.0.clone()).collect();
        let mut bindings: HashMap<String, AtlasType> = HashMap::new();
        for (param, arg) in template.params.iter().zip(args.iter()) {
            let actual_ty = self.check_expr(arg, locals)?;
            if !infer_type_bindings(&param.ty.0, &actual_ty, &generic_names, &mut bindings) {
                self.errors.push(AtlasError::TypeError {
                    span: arg.span(),
                    message: format!("could not infer generic arguments for '{}'", template.name.0),
                    hint: None,
                });
                return Ok(FnSignature { params: Vec::new(), ret_ty: AtlasType::Void, is_variadic: false });
            }
        }

        for generic_name in &generic_names {
            if !bindings.contains_key(generic_name) {
                self.errors.push(AtlasError::TypeError {
                    span: call_span,
                    message: format!("generic argument '{}' could not be inferred for '{}'", generic_name, template.name.0),
                    hint: None,
                });
                return Ok(FnSignature { params: Vec::new(), ret_ty: AtlasType::Void, is_variadic: false });
            }
        }

        if !self.check_where_clauses(template, &bindings, call_span)? {
            return Ok(FnSignature { params: Vec::new(), ret_ty: AtlasType::Void, is_variadic: false });
        }

        let ordered_args: Vec<AtlasType> = template
            .generic_params
            .iter()
            .map(|param| bindings.get(&param.0).cloned().expect("generic binding missing"))
            .collect();
        let mangled_name = mangle_type_name(&template.name.0, &ordered_args);
        self.mangled_calls.insert(call_span, mangled_name.clone());

        if let Some(sig) = self.fn_sigs.get(&mangled_name).cloned() {
            return Ok(sig);
        }

        let substitutions: HashMap<String, TypeExpr> = bindings
            .iter()
            .map(|(name, ty)| (name.clone(), atlas_type_to_type_expr(ty)))
            .collect();
        let mut instantiated_decl = substitute_fn_decl(template, &mangled_name, &substitutions);
        self.rewrite_generic_class_calls_in_block(&mut instantiated_decl.body, &substitutions);
        let sig = self.build_fn_signature(&instantiated_decl).ok_or(NativeCheckError::Unsupported)?;
        self.fn_sigs.insert(mangled_name.clone(), sig.clone());
        self.generated_functions.push(instantiated_decl.clone());
        self.check_function(&instantiated_decl)?;
        Ok(sig)
    }

    fn build_fn_signature(&mut self, decl: &crate::parser::FunctionDecl) -> Option<FnSignature> {
        let mut params = Vec::new();
        for param in &decl.params {
            params.push((param.name.0.clone(), self.resolve_type_expr(&param.ty.0)?));
        }
        let ret_ty = decl
            .ret_ty
            .as_ref()
            .map(|ret| self.resolve_type_expr(&ret.0))
            .unwrap_or(Some(AtlasType::Void))?;
        Some(FnSignature { params, ret_ty, is_variadic: false })
    }

    fn resolve_method_type_expr(&mut self, class_name: &str, ty: &TypeExpr) -> Option<AtlasType> {
        if matches!(ty, TypeExpr::Named(name) if name == "self") {
            return Some(AtlasType::Pointer {
                target: Box::new(AtlasType::Class(class_name.to_string())),
                nullable: false,
            });
        }
        self.resolve_type_expr(ty)
    }

    fn resolve_type_expr_shallow(&self, ty: &TypeExpr) -> Option<AtlasType> {
        match ty {
            TypeExpr::Named(name) => match name.as_str() {
                "int" => Some(AtlasType::Int),
                "int64" => Some(AtlasType::Int64),
                "int32" => Some(AtlasType::Int32),
                "int16" => Some(AtlasType::Int16),
                "int8" => Some(AtlasType::Int8),
                "uint" => Some(AtlasType::Uint),
                "uint64" => Some(AtlasType::Uint64),
                "uint32" => Some(AtlasType::Uint32),
                "uint16" => Some(AtlasType::Uint16),
                "uint8" => Some(AtlasType::Uint8),
                "float" => Some(AtlasType::Float),
                "float64" => Some(AtlasType::Float64),
                "float32" => Some(AtlasType::Float32),
                "bool" => Some(AtlasType::Bool),
                "char" => Some(AtlasType::Char),
                "void" => Some(AtlasType::Void),
                other => {
                    if self.structs.contains_key(other) {
                        Some(AtlasType::Struct(other.to_string()))
                    } else if self.classes.contains_key(other) {
                        Some(AtlasType::Class(other.to_string()))
                    } else if self.enums.contains_key(other) {
                        Some(AtlasType::Enum(other.to_string()))
                    } else if self.choices.contains_key(other) {
                        Some(AtlasType::Choice(other.to_string()))
                    } else {
                        None
                    }
                }
            },
            TypeExpr::Pointer { target, nullable, .. } => Some(AtlasType::Pointer {
                target: Box::new(self.resolve_type_expr_shallow(target)?),
                nullable: *nullable,
            }),
            TypeExpr::Array { element, size, .. } => Some(AtlasType::Array {
                element: Box::new(self.resolve_type_expr_shallow(element)?),
                size: *size,
            }),
            TypeExpr::Slice { element, .. } => Some(AtlasType::Slice(Box::new(self.resolve_type_expr_shallow(element)?))),
            TypeExpr::Generic { base, args, .. } => {
                let resolved_args: Vec<AtlasType> = args
                    .iter()
                    .map(|arg| self.resolve_type_expr_shallow(arg))
                    .collect::<Option<_>>()?;
                let mangled = mangle_type_name(base, &resolved_args);
                if self.choices.contains_key(&mangled) {
                    Some(AtlasType::Choice(mangled))
                } else if self.classes.contains_key(&mangled) {
                    Some(AtlasType::Class(mangled))
                } else {
                    None
                }
            }
        }
    }

    fn check_where_clauses(
        &mut self,
        template: &crate::parser::FunctionDecl,
        bindings: &HashMap<String, AtlasType>,
        span: Span,
    ) -> Result<bool, NativeCheckError> {
        let substitutions: HashMap<String, TypeExpr> = bindings
            .iter()
            .map(|(name, ty)| (name.clone(), atlas_type_to_type_expr(ty)))
            .collect();
        for where_clause in &template.where_clauses {
            let Some(actual_ty) = bindings.get(&where_clause.target.0) else {
                return Err(NativeCheckError::Unsupported);
            };
            for constraint in &where_clause.constraints {
                let substituted = substitute_constraint_signature(constraint, &substitutions);
                if !self.satisfies_constraint(actual_ty, &substituted) {
                    self.errors.push(AtlasError::TypeError {
                        span,
                        message: format!(
                            "type '{:?}' does not satisfy constraint '{}'",
                            actual_ty, constraint.name.0
                        ),
                        hint: None,
                    });
                    return Ok(false);
                }
            }
        }
        Ok(true)
    }

    fn satisfies_constraint(
        &self,
        actual_ty: &AtlasType,
        constraint: &crate::parser::ConstraintSignature,
    ) -> bool {
        if self.satisfies_primitive_constraint(actual_ty, constraint) {
            return true;
        }
        let AtlasType::Class(class_name) = actual_ty else {
            return false;
        };
        let Some(class_ty) = self.classes.get(class_name) else {
            return false;
        };
        let Some(method) = class_ty.methods.get(&constraint.name.0) else {
            return false;
        };
        let expected_params: Vec<&crate::parser::Param> = constraint
            .params
            .iter()
            .filter(|param| param.name.0 != "self")
            .collect();
        let actual_params = if method.sig.params.first().map(|(name, _)| name == "self").unwrap_or(false) {
            &method.sig.params[1..]
        } else {
            &method.sig.params[..]
        };
        if actual_params.len() != expected_params.len() {
            return false;
        }
        for ((_, actual_param_ty), expected_param) in actual_params.iter().zip(expected_params.iter()) {
            let Some(expected_param_ty) = self.resolve_type_expr_shallow(&expected_param.ty.0) else {
                return false;
            };
            if actual_param_ty != &expected_param_ty {
                return false;
            }
        }
        match (&constraint.ret_ty, &method.sig.ret_ty) {
            (Some((ret_ty, _)), actual_ret) => self
                .resolve_type_expr_shallow(ret_ty)
                .map(|expected_ret| expected_ret == *actual_ret)
                .unwrap_or(false),
            (None, AtlasType::Void) => true,
            (None, _) => false,
        }
    }

    fn satisfies_primitive_constraint(
        &self,
        actual_ty: &AtlasType,
        constraint: &crate::parser::ConstraintSignature,
    ) -> bool {
        if !supports_primitive_methods(actual_ty) {
            return false;
        }

        match constraint.name.0.as_str() {
            "format" => {
                if constraint.params.len() != 1 || constraint.params[0].name.0 != "self" {
                    return false;
                }
                match constraint.ret_ty.as_ref() {
                    Some((TypeExpr::Named(name), _)) if name == "String" || name == "string.String" => true,
                    Some((ret_ty, _)) => matches!(
                        self.resolve_type_expr_shallow(ret_ty),
                        Some(AtlasType::Class(ref name)) if name == "string.String"
                    ),
                    None => false,
                }
            }
            "hash" => {
                if constraint.params.len() != 1 || constraint.params[0].name.0 != "self" {
                    return false;
                }
                matches!(
                    constraint.ret_ty.as_ref().and_then(|(ret_ty, _)| self.resolve_type_expr_shallow(ret_ty)),
                    Some(AtlasType::Int)
                )
            }
            "equals" => {
                if constraint.params.len() != 2 || constraint.params[0].name.0 != "self" {
                    return false;
                }
                let expected_param = self.resolve_type_expr_shallow(&constraint.params[1].ty.0);
                let expected_ret = constraint
                    .ret_ty
                    .as_ref()
                    .and_then(|(ret_ty, _)| self.resolve_type_expr_shallow(ret_ty));
                expected_param.as_ref() == Some(actual_ty) && expected_ret == Some(AtlasType::Bool)
            }
            _ => false,
        }
    }

    fn rewrite_generic_class_calls_in_block(
        &self,
        block: &mut crate::parser::Block,
        substitutions: &HashMap<String, TypeExpr>,
    ) {
        for stmt in &mut block.stmts {
            self.rewrite_generic_class_calls_in_stmt(stmt, substitutions);
        }
    }

    fn rewrite_generic_class_calls_in_class(
        &self,
        class_decl: &mut crate::parser::ClassDecl,
        substitutions: &HashMap<String, TypeExpr>,
    ) {
        for method in &mut class_decl.methods {
            self.rewrite_generic_class_calls_in_block(&mut method.decl.body, substitutions);
        }
    }

    fn check_expr_with_expected(
        &mut self,
        expr: &Expr,
        expected_ty: &AtlasType,
        locals: &HashMap<String, AtlasType>,
    ) -> Result<AtlasType, NativeCheckError> {
        if let Expr::Call { callee, args, span } = expr {
            if let Some(constructed) =
                self.check_constructor_call_with_expected(callee, args, expected_ty, locals, *span)?
            {
                return Ok(constructed);
            }
        }
        let actual = self.check_expr(expr, locals)?;
        if can_construct_from_char_slice(expected_ty, &actual, &self.classes) {
            return Ok(expected_ty.clone());
        }
        Ok(actual)
    }

    fn check_constructor_call_with_expected(
        &mut self,
        callee: &str,
        args: &[Expr],
        expected_ty: &AtlasType,
        locals: &HashMap<String, AtlasType>,
        span: Span,
    ) -> Result<Option<AtlasType>, NativeCheckError> {
        let AtlasType::Class(expected_class) = expected_ty else {
            return Ok(None);
        };
        if expected_class != callee && !expected_class.starts_with(&format!("{}_", callee)) {
            return Ok(None);
        }
        let Some(class_ty) = self.classes.get(expected_class).cloned() else {
            return Ok(None);
        };
        let Some(init_sig) = class_ty.methods.get("init").map(|method| method.sig.clone()) else {
            self.errors.push(AtlasError::TypeError {
                span,
                message: format!("class '{}' has no constructor 'init'", expected_class),
                hint: None,
            });
            return Ok(Some(AtlasType::Class(expected_class.clone())));
        };
        let expected_args = init_sig.params.iter().skip(1).collect::<Vec<_>>();
        if expected_args.len() != args.len() {
            self.errors.push(AtlasError::TypeError {
                span,
                message: format!("wrong argument count for constructor '{}'", callee),
                hint: None,
            });
            return Ok(Some(AtlasType::Class(expected_class.clone())));
        }
        for (arg, (_, expected_arg_ty)) in args.iter().zip(expected_args.iter()) {
            let actual = self.check_expr_with_expected(arg, expected_arg_ty, locals)?;
            if !is_assignable_to(expected_arg_ty, &actual) {
                self.errors.push(AtlasError::TypeError {
                    span: arg.span(),
                    message: format!(
                        "constructor argument type mismatch: expected '{:?}', found '{:?}'",
                        expected_arg_ty, actual
                    ),
                    hint: None,
                });
            }
        }
        Ok(Some(AtlasType::Class(expected_class.clone())))
    }

    fn rewrite_generic_class_calls_in_stmt(
        &self,
        stmt: &mut Stmt,
        substitutions: &HashMap<String, TypeExpr>,
    ) {
        match stmt {
            Stmt::VarDecl(decl) => {
                if let Some(init) = &mut decl.init {
                    self.rewrite_generic_class_calls_in_expr(init, substitutions);
                }
            }
            Stmt::ConstDecl(decl) => self.rewrite_generic_class_calls_in_expr(&mut decl.init, substitutions),
            Stmt::Assign(assign) => {
                self.rewrite_generic_class_calls_in_expr(&mut assign.target, substitutions);
                self.rewrite_generic_class_calls_in_expr(&mut assign.value, substitutions);
            }
            Stmt::ExprStmt(expr) => self.rewrite_generic_class_calls_in_expr(expr, substitutions),
            Stmt::Return(Some(expr), _) => self.rewrite_generic_class_calls_in_expr(expr, substitutions),
            Stmt::If(if_stmt) => {
                self.rewrite_generic_class_calls_in_expr(&mut if_stmt.condition, substitutions);
                self.rewrite_generic_class_calls_in_block(&mut if_stmt.then_block, substitutions);
                for (cond, block) in &mut if_stmt.else_if_clauses {
                    self.rewrite_generic_class_calls_in_expr(cond, substitutions);
                    self.rewrite_generic_class_calls_in_block(block, substitutions);
                }
                if let Some(block) = &mut if_stmt.else_block {
                    self.rewrite_generic_class_calls_in_block(block, substitutions);
                }
            }
            Stmt::While(while_stmt) => {
                self.rewrite_generic_class_calls_in_expr(&mut while_stmt.condition, substitutions);
                self.rewrite_generic_class_calls_in_block(&mut while_stmt.body, substitutions);
            }
            Stmt::Block(block) => self.rewrite_generic_class_calls_in_block(block, substitutions),
            Stmt::StructDecl(_) | Stmt::Return(None, _) => {}
        }
    }

    fn rewrite_generic_class_calls_in_expr(
        &self,
        expr: &mut Expr,
        substitutions: &HashMap<String, TypeExpr>,
    ) {
        match expr {
            Expr::Call { callee, args, .. } => {
                if let Some(template) = self.generic_class_templates.get(callee) {
                    let resolved_args: Vec<AtlasType> = template
                        .generic_params
                        .iter()
                        .filter_map(|param| substitutions.get(&param.0))
                        .filter_map(|ty| self.resolve_type_expr_shallow(ty))
                        .collect();
                    if resolved_args.len() == template.generic_params.len() {
                        *callee = mangle_type_name(callee, &resolved_args);
                    }
                }
                for arg in args {
                    self.rewrite_generic_class_calls_in_expr(arg, substitutions);
                }
            }
            Expr::Binary { lhs, rhs, .. } => {
                self.rewrite_generic_class_calls_in_expr(lhs, substitutions);
                self.rewrite_generic_class_calls_in_expr(rhs, substitutions);
            }
            Expr::Unary { operand, .. } => self.rewrite_generic_class_calls_in_expr(operand, substitutions),
            Expr::Group { inner, .. } => self.rewrite_generic_class_calls_in_expr(inner, substitutions),
            Expr::StructInit { fields, .. } => {
                for (_, value) in fields {
                    self.rewrite_generic_class_calls_in_expr(value, substitutions);
                }
            }
            Expr::MemberAccess { object, .. } => self.rewrite_generic_class_calls_in_expr(object, substitutions),
            Expr::MethodCall { object, args, .. } => {
                self.rewrite_generic_class_calls_in_expr(object, substitutions);
                for arg in args {
                    self.rewrite_generic_class_calls_in_expr(arg, substitutions);
                }
            }
            Expr::StaticCall { args, .. } => {
                for arg in args {
                    self.rewrite_generic_class_calls_in_expr(arg, substitutions);
                }
            }
            Expr::ArrayLit { elements, .. } => {
                for element in elements {
                    self.rewrite_generic_class_calls_in_expr(element, substitutions);
                }
            }
            Expr::ArrayIndex { array, index, .. } => {
                self.rewrite_generic_class_calls_in_expr(array, substitutions);
                self.rewrite_generic_class_calls_in_expr(index, substitutions);
            }
            Expr::Match { expr, cases, .. } => {
                self.rewrite_generic_class_calls_in_expr(expr, substitutions);
                for case in cases {
                    self.rewrite_generic_class_calls_in_block(&mut case.body, substitutions);
                }
            }
            Expr::ErrorPropagate { expr, .. } => self.rewrite_generic_class_calls_in_expr(expr, substitutions),
            Expr::Cast { expr, .. } => self.rewrite_generic_class_calls_in_expr(expr, substitutions),
            Expr::Destroy { expr, .. } => self.rewrite_generic_class_calls_in_expr(expr, substitutions),
            Expr::GenericCall { args, .. } | Expr::GenericStaticCall { args, .. } => {
                for arg in args {
                    self.rewrite_generic_class_calls_in_expr(arg, substitutions);
                }
            }
            Expr::IntLit { .. }
            | Expr::FloatLit { .. }
            | Expr::BoolLit { .. }
            | Expr::CharLit { .. }
            | Expr::StringLit { .. }
            | Expr::Var { .. }
            | Expr::Null { .. }
            | Expr::StaticMember { .. }
            | Expr::SizeOf { .. } => {}
        }
    }

    fn allow_internal_class_destroy(&self) -> bool {
        let Some(class_name) = self.current_class_name.as_deref() else {
            return false;
        };
        class_name == "array.Array"
            || class_name.starts_with("array.Array_")
            || class_name == "memory.Box"
            || class_name.starts_with("memory.Box_")
            || class_name == "hashmap.HashMapEntry"
            || class_name.starts_with("hashmap.HashMapEntry_")
            || class_name == "hashmap.HashMap"
            || class_name.starts_with("hashmap.HashMap_")
    }
}

fn check_file(ast: &SourceFile) -> Result<TypedAST, NativeCheckError> {
    Checker::new().check_file(ast)
}

fn collect_project_class_decls<'a>(project: &'a Project) -> HashMap<String, &'a crate::parser::ClassDecl> {
    let mut classes = HashMap::new();
    for module in project.modules.values() {
        for item in &module.items {
            if let Item::ClassDecl(decl, _) = item {
                classes.insert(decl.name.0.clone(), decl);
            }
        }
    }
    classes
}

fn collect_referenced_classes_from_file(
    ast: &SourceFile,
    classes: &HashMap<String, ClassType>,
) -> HashSet<String> {
    let mut referenced = HashSet::new();
    for item in &ast.items {
        match item {
            Item::FunctionDecl(decl, _) => {
                collect_referenced_classes_from_function(decl, classes, &mut referenced);
            }
            Item::ClassDecl(decl, _) => {
                for method in &decl.methods {
                    collect_referenced_classes_from_function(&method.decl, classes, &mut referenced);
                }
            }
            _ => {}
        }
    }
    referenced
}

fn collect_referenced_classes_from_function(
    decl: &crate::parser::FunctionDecl,
    classes: &HashMap<String, ClassType>,
    referenced: &mut HashSet<String>,
) {
    for param in &decl.params {
        collect_referenced_classes_from_type(&param.ty.0, classes, referenced);
    }
    if let Some(ret_ty) = &decl.ret_ty {
        collect_referenced_classes_from_type(&ret_ty.0, classes, referenced);
    }
    collect_referenced_classes_from_block_into(&decl.body, classes, referenced);
}

fn collect_referenced_classes_from_block(
    block: &crate::parser::Block,
    classes: &HashMap<String, ClassType>,
) -> HashSet<String> {
    let mut referenced = HashSet::new();
    collect_referenced_classes_from_block_into(block, classes, &mut referenced);
    referenced
}

fn collect_referenced_classes_from_block_into(
    block: &crate::parser::Block,
    classes: &HashMap<String, ClassType>,
    referenced: &mut HashSet<String>,
) {
    for stmt in &block.stmts {
        collect_referenced_classes_from_stmt(stmt, classes, referenced);
    }
}

fn collect_referenced_classes_from_stmt(
    stmt: &Stmt,
    classes: &HashMap<String, ClassType>,
    referenced: &mut HashSet<String>,
) {
    match stmt {
        Stmt::VarDecl(decl) => {
            if let Some(ty_hint) = &decl.ty_hint {
                collect_referenced_classes_from_type(&ty_hint.0, classes, referenced);
            }
            if let Some(init) = &decl.init {
                collect_referenced_classes_from_expr(init, classes, referenced);
            }
        }
        Stmt::ConstDecl(decl) => {
            if let Some(ty_hint) = &decl.ty_hint {
                collect_referenced_classes_from_type(&ty_hint.0, classes, referenced);
            }
            collect_referenced_classes_from_expr(&decl.init, classes, referenced);
        }
        Stmt::Assign(assign) => {
            collect_referenced_classes_from_expr(&assign.target, classes, referenced);
            collect_referenced_classes_from_expr(&assign.value, classes, referenced);
        }
        Stmt::ExprStmt(expr) => collect_referenced_classes_from_expr(expr, classes, referenced),
        Stmt::Return(expr, _) => {
            if let Some(expr) = expr {
                collect_referenced_classes_from_expr(expr, classes, referenced);
            }
        }
        Stmt::If(if_stmt) => {
            collect_referenced_classes_from_expr(&if_stmt.condition, classes, referenced);
            collect_referenced_classes_from_block_into(&if_stmt.then_block, classes, referenced);
            for (cond, block) in &if_stmt.else_if_clauses {
                collect_referenced_classes_from_expr(cond, classes, referenced);
                collect_referenced_classes_from_block_into(block, classes, referenced);
            }
            if let Some(block) = &if_stmt.else_block {
                collect_referenced_classes_from_block_into(block, classes, referenced);
            }
        }
        Stmt::While(while_stmt) => {
            collect_referenced_classes_from_expr(&while_stmt.condition, classes, referenced);
            collect_referenced_classes_from_block_into(&while_stmt.body, classes, referenced);
        }
        Stmt::Block(block) => collect_referenced_classes_from_block_into(block, classes, referenced),
        Stmt::StructDecl(_) => {}
    }
}

fn collect_referenced_classes_from_expr(
    expr: &Expr,
    classes: &HashMap<String, ClassType>,
    referenced: &mut HashSet<String>,
) {
    match expr {
        Expr::Call { callee, args, .. } => {
            if classes.contains_key(callee) {
                referenced.insert(callee.clone());
            }
            for arg in args {
                collect_referenced_classes_from_expr(arg, classes, referenced);
            }
        }
        Expr::MethodCall { object, args, .. } => {
            collect_referenced_classes_from_expr(object, classes, referenced);
            for arg in args {
                collect_referenced_classes_from_expr(arg, classes, referenced);
            }
        }
        Expr::StaticCall {
            class_name, args, ..
        } => {
            if classes.contains_key(class_name) {
                referenced.insert(class_name.clone());
            }
            for arg in args {
                collect_referenced_classes_from_expr(arg, classes, referenced);
            }
        }
        Expr::StructInit { fields, .. } => {
            for (_, value) in fields {
                collect_referenced_classes_from_expr(value, classes, referenced);
            }
        }
        Expr::MemberAccess { object, .. } => collect_referenced_classes_from_expr(object, classes, referenced),
        Expr::ArrayIndex { array, index, .. } => {
            collect_referenced_classes_from_expr(array, classes, referenced);
            collect_referenced_classes_from_expr(index, classes, referenced);
        }
        Expr::Unary { operand, .. } => collect_referenced_classes_from_expr(operand, classes, referenced),
        Expr::Binary { lhs, rhs, .. } => {
            collect_referenced_classes_from_expr(lhs, classes, referenced);
            collect_referenced_classes_from_expr(rhs, classes, referenced);
        }
        Expr::Cast { target_ty, expr, .. } => {
            collect_referenced_classes_from_type(&target_ty.0, classes, referenced);
            collect_referenced_classes_from_expr(expr, classes, referenced);
        }
        Expr::SizeOf { ty, .. } => collect_referenced_classes_from_type(&ty.0, classes, referenced),
        Expr::Destroy { type_arg, expr, .. } => {
            collect_referenced_classes_from_type(type_arg, classes, referenced);
            collect_referenced_classes_from_expr(expr, classes, referenced);
        }
        Expr::Group { inner, .. } => collect_referenced_classes_from_expr(inner, classes, referenced),
        Expr::IntLit { .. }
        | Expr::FloatLit { .. }
        | Expr::BoolLit { .. }
        | Expr::CharLit { .. }
        | Expr::StringLit { .. }
        | Expr::Var { .. }
        | Expr::Null { .. }
        | Expr::GenericCall { .. }
        | Expr::GenericStaticCall { .. }
        | Expr::ArrayLit { .. }
        | Expr::Match { .. }
        | Expr::StaticMember { .. }
        | Expr::ErrorPropagate { .. } => {}
    }
}

fn collect_referenced_classes_from_type(
    ty: &TypeExpr,
    classes: &HashMap<String, ClassType>,
    referenced: &mut HashSet<String>,
) {
    match ty {
        TypeExpr::Named(name) => {
            if classes.contains_key(name) {
                referenced.insert(name.clone());
            }
        }
        TypeExpr::Pointer { target, .. }
        | TypeExpr::Array { element: target, .. }
        | TypeExpr::Slice { element: target, .. } => {
            collect_referenced_classes_from_type(target, classes, referenced);
        }
        TypeExpr::Generic { .. } => {}
    }
}

fn is_numeric(ty: &AtlasType) -> bool {
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
            | AtlasType::Float
            | AtlasType::Float32
            | AtlasType::Float64
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
    )
}

fn normalize_machine_alias(ty: &AtlasType) -> AtlasType {
    match ty {
        AtlasType::Int => AtlasType::Int64,
        AtlasType::Uint => AtlasType::Uint64,
        AtlasType::Float => AtlasType::Float64,
        other => other.clone(),
    }
}

fn same_runtime_type(lhs: &AtlasType, rhs: &AtlasType) -> bool {
    lhs == rhs || normalize_machine_alias(lhs) == normalize_machine_alias(rhs)
}

fn is_assignable_to(expected: &AtlasType, actual: &AtlasType) -> bool {
    if same_runtime_type(expected, actual) {
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

    if let (
        AtlasType::Pointer {
            target: expected_target,
            nullable: false,
        },
        AtlasType::Class(actual_class),
    ) = (expected, actual)
    {
        if expected_target.as_ref() == &AtlasType::Class(actual_class.clone()) {
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

fn is_class_receiver(ty: &AtlasType) -> bool {
    match ty {
        AtlasType::Class(_) => true,
        AtlasType::Pointer { target, .. } => matches!(target.as_ref(), AtlasType::Class(_)),
        _ => false,
    }
}

fn supports_primitive_methods(ty: &AtlasType) -> bool {
    is_integer(ty) || matches!(ty, AtlasType::Bool | AtlasType::Char)
}

fn supports_literal_match(ty: &AtlasType) -> bool {
    is_numeric(ty) || matches!(ty, AtlasType::Bool | AtlasType::Char)
}

fn is_cast_supported(source: &AtlasType, target: &AtlasType) -> bool {
    source == target
        || (is_numeric(source) && is_numeric(target))
        || matches!(
            (source, target),
            (AtlasType::Pointer { .. }, AtlasType::Pointer { .. })
                | (AtlasType::Pointer { .. }, AtlasType::Int)
                | (AtlasType::Pointer { .. }, AtlasType::Uint)
                | (AtlasType::Pointer { .. }, AtlasType::Int32)
                | (AtlasType::Pointer { .. }, AtlasType::Uint32)
                | (AtlasType::Int, AtlasType::Pointer { .. })
                | (AtlasType::Uint, AtlasType::Pointer { .. })
                | (AtlasType::Int32, AtlasType::Pointer { .. })
                | (AtlasType::Uint32, AtlasType::Pointer { .. })
                | (AtlasType::Char, AtlasType::Int)
                | (AtlasType::Int, AtlasType::Char)
                | (AtlasType::Char, AtlasType::Int32)
                | (AtlasType::Int32, AtlasType::Char)
        )
}

fn default_class_method(class_name: &str, method_name: &str, ret_ty: AtlasType) -> ClassMethodType {
    ClassMethodType {
        name: method_name.to_string(),
        sig: FnSignature {
            params: vec![(
                "self".to_string(),
                AtlasType::Pointer {
                    target: Box::new(AtlasType::Class(class_name.to_string())),
                    nullable: false,
                },
            )],
            ret_ty,
            is_variadic: false,
        },
        visibility: crate::parser::Visibility::Public,
    }
}

fn can_construct_from_char_slice(
    expected_ty: &AtlasType,
    actual_ty: &AtlasType,
    classes: &HashMap<String, ClassType>,
) -> bool {
    let AtlasType::Class(class_name) = expected_ty else {
        return false;
    };
    classes
        .get(class_name)
        .and_then(|class_ty| class_ty.methods.get("from"))
        .map(|method| {
            method.sig.params.len() == 1
                && matches!(
                    (&method.sig.params[0].1, actual_ty, &method.sig.ret_ty),
                    (AtlasType::Slice(expected_element), AtlasType::Slice(actual_element), AtlasType::Class(ret_name))
                        if **expected_element == AtlasType::Char
                            && **actual_element == AtlasType::Char
                            && ret_name == class_name
                )
        })
        .unwrap_or(false)
}

fn substitute_type_expr(ty: &TypeExpr, bindings: &HashMap<String, AtlasType>) -> TypeExpr {
    match ty {
        TypeExpr::Named(name) => bindings
            .get(name)
            .map(type_to_type_expr)
            .unwrap_or_else(|| TypeExpr::Named(name.clone())),
        TypeExpr::Pointer { target, nullable, span } => TypeExpr::Pointer {
            target: Box::new(substitute_type_expr(target, bindings)),
            nullable: *nullable,
            span: *span,
        },
        TypeExpr::Array { element, size, span } => TypeExpr::Array {
            element: Box::new(substitute_type_expr(element, bindings)),
            size: *size,
            span: *span,
        },
        TypeExpr::Slice { element, span } => TypeExpr::Slice {
            element: Box::new(substitute_type_expr(element, bindings)),
            span: *span,
        },
        TypeExpr::Generic { base, args, span } => TypeExpr::Generic {
            base: base.clone(),
            args: args.iter().map(|arg| substitute_type_expr(arg, bindings)).collect(),
            span: *span,
        },
    }
}

fn type_to_type_expr(ty: &AtlasType) -> TypeExpr {
    match ty {
        AtlasType::Int => TypeExpr::Named("int".to_string()),
        AtlasType::Uint => TypeExpr::Named("uint".to_string()),
        AtlasType::Int8 => TypeExpr::Named("int8".to_string()),
        AtlasType::Int16 => TypeExpr::Named("int16".to_string()),
        AtlasType::Int32 => TypeExpr::Named("int32".to_string()),
        AtlasType::Int64 => TypeExpr::Named("int64".to_string()),
        AtlasType::Uint8 => TypeExpr::Named("uint8".to_string()),
        AtlasType::Uint16 => TypeExpr::Named("uint16".to_string()),
        AtlasType::Uint32 => TypeExpr::Named("uint32".to_string()),
        AtlasType::Uint64 => TypeExpr::Named("uint64".to_string()),
        AtlasType::Float => TypeExpr::Named("float".to_string()),
        AtlasType::Float32 => TypeExpr::Named("float32".to_string()),
        AtlasType::Float64 => TypeExpr::Named("float64".to_string()),
        AtlasType::Bool => TypeExpr::Named("bool".to_string()),
        AtlasType::Char => TypeExpr::Named("char".to_string()),
        AtlasType::Void => TypeExpr::Named("void".to_string()),
        AtlasType::Struct(name) | AtlasType::Class(name) | AtlasType::Enum(name) | AtlasType::Choice(name) => {
            TypeExpr::Named(name.clone())
        }
        AtlasType::Pointer { target, nullable } => TypeExpr::Pointer {
            target: Box::new(type_to_type_expr(target)),
            nullable: *nullable,
            span: Span::new(0, 0),
        },
        AtlasType::Array { element, size } => TypeExpr::Array {
            element: Box::new(type_to_type_expr(element)),
            size: *size,
            span: Span::new(0, 0),
        },
        AtlasType::Slice(element) => TypeExpr::Slice {
            element: Box::new(type_to_type_expr(element)),
            span: Span::new(0, 0),
        },
        AtlasType::Null | AtlasType::GenericPlaceholder(_) => TypeExpr::Named("void".to_string()),
    }
}

fn infer_type_bindings(
    expected: &TypeExpr,
    actual: &AtlasType,
    generic_names: &HashSet<String>,
    bindings: &mut HashMap<String, AtlasType>,
) -> bool {
    match expected {
        TypeExpr::Named(name) if generic_names.contains(name) => match bindings.get(name) {
            Some(bound) => bound == actual,
            None => {
                bindings.insert(name.clone(), actual.clone());
                true
            }
        },
        TypeExpr::Named(_) => true,
        TypeExpr::Pointer { target, nullable, .. } => {
            if let AtlasType::Pointer { target: actual_target, nullable: actual_nullable } = actual {
                *nullable == *actual_nullable && infer_type_bindings(target, actual_target, generic_names, bindings)
            } else {
                false
            }
        }
        TypeExpr::Array { element, size, .. } => {
            if let AtlasType::Array { element: actual_element, size: actual_size } = actual {
                *size == *actual_size && infer_type_bindings(element, actual_element, generic_names, bindings)
            } else {
                false
            }
        }
        TypeExpr::Slice { element, .. } => {
            if let AtlasType::Slice(actual_element) = actual {
                infer_type_bindings(element, actual_element, generic_names, bindings)
            } else {
                false
            }
        }
        TypeExpr::Generic { .. } => true,
    }
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
            if same_runtime_type(&lhs_ty, &rhs_ty) && is_numeric(&lhs_ty) && is_numeric(&rhs_ty) {
                Ok(lhs_ty)
            } else {
                errors.push(AtlasError::TypeError {
                    span,
                    message: format!(
                        "invalid arithmetic operands '{:?}' and '{:?}'",
                        lhs_ty, rhs_ty
                    ),
                    hint: None,
                });
                Ok(lhs_ty)
            }
        }
        Eq | NotEq | Lt | Gt | LtEq | GtEq => {
            if same_runtime_type(&lhs_ty, &rhs_ty)
                || matches!(
                    (&lhs_ty, &rhs_ty),
                    (AtlasType::Pointer { nullable: true, .. }, AtlasType::Null)
                        | (AtlasType::Null, AtlasType::Pointer { nullable: true, .. })
                )
            {
                Ok(AtlasType::Bool)
            } else {
                errors.push(AtlasError::TypeError {
                    span,
                    message: format!(
                        "invalid comparison operands '{:?}' and '{:?}'",
                        lhs_ty, rhs_ty
                    ),
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
                    message: format!(
                        "logical operands must be bool, found '{:?}' and '{:?}'",
                        lhs_ty, rhs_ty
                    ),
                    hint: None,
                });
                Ok(AtlasType::Bool)
            }
        }
    }
}

fn binary_operator_method_name(op: &BinOp) -> Option<&'static str> {
    match op {
        BinOp::Add => Some("operator_add"),
        BinOp::Sub => Some("operator_sub"),
        BinOp::Mul => Some("operator_mul"),
        BinOp::Div => Some("operator_div"),
        BinOp::Mod => Some("operator_rem"),
        BinOp::Eq => Some("operator_eq"),
        BinOp::NotEq => Some("operator_neq"),
        BinOp::Lt => Some("operator_lt"),
        BinOp::Gt => Some("operator_gt"),
        BinOp::LtEq => Some("operator_lte"),
        BinOp::GtEq => Some("operator_gte"),
        _ => None,
    }
}
