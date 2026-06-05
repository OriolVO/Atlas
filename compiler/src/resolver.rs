use std::collections::{HashMap, HashSet};
use std::fs;
use std::path::{Path, PathBuf};
use crate::error::{AtlasError, Span};
use crate::parser::{lower_intrinsics, SourceFile, Item, TypeExpr, Expr, Stmt, Pattern};
use crate::lexer::Lexer;
use crate::parser::Parser;

#[derive(Debug, Clone)]
pub struct ModuleInterface {
    pub name: String,
    pub structs: HashSet<String>,
    pub classes: HashSet<String>,
    pub enums: HashSet<String>,
    pub choices: HashSet<String>,
    pub functions: HashSet<String>,
    pub extern_fns: HashSet<String>,
    pub exports: HashSet<String>,
}

pub struct Project {
    pub modules: HashMap<String, SourceFile>,
    pub topological_order: Vec<String>,
    pub global_modules: HashMap<String, ModuleInterface>,
    pub sources: HashMap<String, (PathBuf, String)>,
}

impl Project {
    pub fn load_and_resolve(entry_path: &Path, stdlib_path: &Path) -> Result<Self, Vec<(String, String, AtlasError)>> {
        // 1. Load project modules transitively
        let mut files: HashMap<String, (PathBuf, SourceFile, Vec<String>)> = HashMap::new();
        let mut sources = HashMap::new();
        let mut queue = vec![("main".to_string(), entry_path.to_path_buf())];
        let prelude_modules = &["result"];
        for pm in prelude_modules {
            let pm_path = stdlib_path.join(format!("{}.atl", pm));
            if pm_path.exists() {
                queue.push((pm.to_string(), pm_path));
            }
        }

        while let Some((mod_name, path)) = queue.pop() {
            if files.contains_key(&mod_name) {
                continue;
            }

            let source = match fs::read_to_string(&path) {
                Ok(s) => s,
                Err(e) => {
                    return Err(vec![(
                        path.to_string_lossy().into_owned(),
                        String::new(),
                        AtlasError::TypeError {
                            span: Span::new(0, 0),
                            message: format!("could not read module '{}' at '{}': {}", mod_name, path.display(), e),
                            hint: None,
                        }
                    )]);
                }
            };

            let lexer = Lexer::new(&source);
            let (tokens, lex_errors) = lexer.tokenize();
            if !lex_errors.is_empty() {
                return Err(lex_errors.into_iter().map(|e| (path.to_string_lossy().into_owned(), source.clone(), e)).collect());
            }

            let parser = Parser::new(&tokens);
            let (mut ast, parse_errors) = parser.parse_file();
            if !parse_errors.is_empty() {
                return Err(parse_errors.into_iter().map(|e| (path.to_string_lossy().into_owned(), source.clone(), e)).collect());
            }
            lower_intrinsics(&mut ast);

            let mut imports = Vec::new();
            for item in &ast.items {
                if let Item::Import(imp) = item {
                    imports.push(imp.0.clone());
                }
            }

            sources.insert(mod_name.clone(), (path.clone(), source.clone()));
            files.insert(mod_name.clone(), (path.clone(), ast, imports.clone()));

            // Find and enqueue imports
            let parent_dir = path.parent().unwrap_or(&path);
            for imp in imports {
                if files.contains_key(&imp) || queue.iter().any(|(n, _)| n == &imp) {
                    continue;
                }

                let local_path = parent_dir.join(format!("{}.atl", imp));
                if local_path.exists() {
                    queue.push((imp, local_path));
                } else {
                    let std_path = stdlib_path.join(format!("{}.atl", imp));
                    if std_path.exists() {
                        queue.push((imp, std_path));
                    } else {
                        return Err(vec![(
                            path.to_string_lossy().into_owned(),
                            source.clone(),
                            AtlasError::TypeError {
                                span: Span::new(0, 0),
                                message: format!("imported module '{}' not found", imp),
                                hint: Some(format!("checked: '{}' and '{}'", local_path.display(), std_path.display())),
                            }
                        )]);
                    }
                }
            }
        }

        // 2. Topological sort
        let mut order = Vec::new();
        let mut visited = HashMap::new(); // name -> state: 1 = visiting, 2 = visited

        fn dfs(
            node: &str,
            files: &HashMap<String, (PathBuf, SourceFile, Vec<String>)>,
            visited: &mut HashMap<String, i32>,
            order: &mut Vec<String>,
            sources: &HashMap<String, (PathBuf, String)>,
        ) -> Result<(), Vec<(String, String, AtlasError)>> {
            let state = visited.get(node).cloned().unwrap_or(0);
            if state == 1 {
                let (path, source) = sources.get(node).unwrap();
                return Err(vec![(
                    path.to_string_lossy().into_owned(),
                    source.clone(),
                    AtlasError::TypeError {
                        span: Span::new(0, 0),
                        message: format!("circular dependency detected: module '{}' is imported in a cycle", node),
                        hint: None,
                    }
                )]);
            }
            if state == 2 {
                return Ok(());
            }

            visited.insert(node.to_string(), 1);

            if let Some((_, _, imports)) = files.get(node) {
                for imp in imports {
                    dfs(imp, files, visited, order, sources)?;
                }
            }

            visited.insert(node.to_string(), 2);
            order.push(node.to_string());
            Ok(())
        }

        for pm in prelude_modules {
            if files.contains_key(*pm) {
                dfs(pm, &files, &mut visited, &mut order, &sources)?;
            }
        }
        dfs("main", &files, &mut visited, &mut order, &sources)?;

        // 3. Build global modules registry
        let mut global_modules = HashMap::new();
        for (mod_name, (_, ast, _)) in &files {
            let mut structs = HashSet::new();
            let mut classes = HashSet::new();
            let mut enums = HashSet::new();
            let mut choices = HashSet::new();
            let mut functions = HashSet::new();
            let mut extern_fns = HashSet::new();
            let mut exports = HashSet::new();

            for item in &ast.items {
                match item {
                    Item::StructDecl(decl, is_exported) => {
                        structs.insert(decl.name.0.clone());
                        if *is_exported {
                            exports.insert(decl.name.0.clone());
                        }
                    }
                    Item::ClassDecl(decl, is_exported) => {
                        classes.insert(decl.name.0.clone());
                        if *is_exported {
                            exports.insert(decl.name.0.clone());
                        }
                        for nested in &decl.structs {
                            let mangled = format!("{}.{}", decl.name.0, nested.decl.name.0);
                            structs.insert(mangled.clone());
                            if *is_exported && nested.visibility == crate::parser::Visibility::Public {
                                exports.insert(mangled);
                            }
                        }
                    }
                    Item::EnumDecl(decl, is_exported) => {
                        enums.insert(decl.name.0.clone());
                        if *is_exported {
                            exports.insert(decl.name.0.clone());
                        }
                    }
                    Item::ChoiceDecl(decl, is_exported) => {
                        choices.insert(decl.name.0.clone());
                        if *is_exported {
                            exports.insert(decl.name.0.clone());
                        }
                    }
                    Item::FunctionDecl(decl, is_exported) => {
                        functions.insert(decl.name.0.clone());
                        if *is_exported {
                            exports.insert(decl.name.0.clone());
                        }
                    }
                    Item::ExternFnDecl(decl, is_exported) => {
                        extern_fns.insert(decl.name.0.clone());
                        if *is_exported {
                            exports.insert(decl.name.0.clone());
                        }
                    }
                    _ => {}
                }
            }

            global_modules.insert(mod_name.clone(), ModuleInterface {
                name: mod_name.clone(),
                structs,
                classes,
                enums,
                choices,
                functions,
                extern_fns,
                exports,
            });
        }

        // 4. Resolve namespaces in ASTs
        let mut modules = HashMap::new();
        let mut errors = Vec::new();

        for (mod_name, (_, mut ast, imports)) in files {
            let mut resolver = NameResolver {
                current_module: &mod_name,
                current_class: None,
                imports: &imports.into_iter().collect(),
                global_modules: &global_modules,
                errors: Vec::new(),
            };

            for item in &mut ast.items {
                resolver.resolve_item(item);
            }

            if !resolver.errors.is_empty() {
                let (path, source) = sources.get(&mod_name).unwrap();
                errors.extend(resolver.errors.into_iter().map(|e| (path.to_string_lossy().into_owned(), source.clone(), e)));
            }

            modules.insert(mod_name, ast);
        }

        if !errors.is_empty() {
            return Err(errors);
        }

        Ok(Self {
            modules,
            topological_order: order,
            global_modules,
            sources,
        })
    }
}

struct NameResolver<'a> {
    current_module: &'a str,
    current_class: Option<String>,
    imports: &'a HashSet<String>,
    global_modules: &'a HashMap<String, ModuleInterface>,
    errors: Vec<AtlasError>,
}

impl<'a> NameResolver<'a> {
    fn resolve_type(&mut self, ty: &mut TypeExpr, span: Span) {
        match ty {
            TypeExpr::Named(ref mut name) => {
                match name.as_str() {
                    "int" | "int64" | "uint" | "uint64" | "int8" | "int16" | "int32"
                    | "uint8" | "uint16" | "uint32" | "float" | "float64" | "float32"
                    | "bool" | "char" | "string" | "void" | "self" => {
                        // Primitive/special types, do not qualify
                    }
                    other => {
                        if let Some(qualified) = self.resolve_qualified_name(other) {
                            *name = qualified;
                        }
                    }
                }
            }
            TypeExpr::Pointer { target, .. } => {
                self.resolve_type(target, span);
            }
            TypeExpr::Array { element, .. } => {
                self.resolve_type(element, span);
            }
            TypeExpr::Slice { element, .. } => {
                self.resolve_type(element, span);
            }
            TypeExpr::Generic { base, args, .. } => {
                if let Some(qualified) = self.resolve_qualified_name(base) {
                    *base = qualified;
                }
                for arg in args {
                    self.resolve_type(arg, span);
                }
            }
        }
    }

    fn resolve_qualified_name(&mut self, name: &str) -> Option<String> {
        if name.contains("::") {
            let parts: Vec<&str> = name.split("::").collect();
            if parts.len() >= 2 {
                let mod_name = parts[0];
                let item_name = parts[1..].join("::");
                if mod_name == self.current_module {
                    if let Some(mi) = self.global_modules.get(self.current_module) {
                        if mi.extern_fns.contains(&item_name) {
                            return Some(item_name);
                        }
                    }
                    return Some(format!("{}.{}", self.current_module, item_name));
                }
                if !self.imports.contains(mod_name) {
                    self.errors.push(AtlasError::TypeError {
                        span: Span::new(0, 0),
                        message: format!("module '{}' is not imported in this file", mod_name),
                        hint: Some(format!("Add 'import {};' at the top of the file", mod_name)),
                    });
                    return None;
                }
                if let Some(module_interface) = self.global_modules.get(mod_name) {
                    if module_interface.exports.contains(&item_name) {
                        if module_interface.extern_fns.contains(&item_name) {
                            return Some(item_name);
                        }
                        return Some(format!("{}.{}", mod_name, item_name));
                    } else {
                        self.errors.push(AtlasError::TypeError {
                            span: Span::new(0, 0),
                            message: format!("item '{}' is not exported by module '{}'", item_name, mod_name),
                            hint: Some(format!("Add 'export' keyword before the definition of '{}' in '{}.atl'", item_name, mod_name)),
                        });
                        return None;
                    }
                }
            }
            None
        } else {
            if let Some(mi) = self.global_modules.get(self.current_module) {
                if let Some(ref cls) = self.current_class {
                    let nested_name = format!("{}.{}", cls, name);
                    if mi.structs.contains(&nested_name) {
                        return Some(format!("{}.{}", self.current_module, nested_name));
                    }
                }
                if mi.structs.contains(name)
                    || mi.classes.contains(name)
                    || mi.enums.contains(name)
                    || mi.choices.contains(name)
                    || mi.functions.contains(name)
                {
                    return Some(format!("{}.{}", self.current_module, name));
                }
                if mi.extern_fns.contains(name) {
                    return Some(name.to_string());
                }
            }
            // Check prelude modules (like 'result')
            for prelude_mod in &["result"] {
                if let Some(mi) = self.global_modules.get(*prelude_mod) {
                    if mi.exports.contains(name) {
                        if mi.extern_fns.contains(name) {
                            return Some(name.to_string());
                        }
                        return Some(format!("{}.{}", prelude_mod, name));
                    }
                }
            }
            None
        }
    }

    fn resolve_expr(&mut self, expr: &mut Expr) {
        match expr {
            Expr::Var { name, span: _ } => {
                if name.contains("::") {
                    if let Some(qualified) = self.resolve_qualified_name(name) {
                        *name = qualified;
                    }
                }
            }
            Expr::Call { callee, args, span: _ } => {
                if callee.contains("::") {
                    if let Some(qualified) = self.resolve_qualified_name(callee) {
                        *callee = qualified;
                    }
                } else {
                    if let Some(qualified) = self.resolve_qualified_name(callee) {
                        *callee = qualified;
                    }
                }
                for arg in args {
                    self.resolve_expr(arg);
                }
            }
            Expr::GenericCall { callee, type_args, args, .. } => {
                if callee.contains("::") {
                    if let Some(qualified) = self.resolve_qualified_name(callee) {
                        *callee = qualified;
                    }
                } else if let Some(qualified) = self.resolve_qualified_name(callee) {
                    *callee = qualified;
                }
                for type_arg in type_args {
                    self.resolve_type(&mut type_arg.0, type_arg.1);
                }
                for arg in args {
                    self.resolve_expr(arg);
                }
            }
            Expr::StaticCall { class_name, method_name, args, span } => {
                // Is `class_name` a known imported module (or the current one)?
                if self.imports.contains(class_name.as_str()) || class_name == self.current_module {
                    if let Some(mi) = self.global_modules.get(class_name.as_str()) {
                        let is_fn     = mi.functions.contains(method_name.as_str());
                        let is_extern = mi.extern_fns.contains(method_name.as_str());
                        let is_class  = mi.classes.contains(method_name.as_str());
                        let is_struct = mi.structs.contains(method_name.as_str());

                        if is_fn || is_extern || is_class || is_struct {
                            // Visibility check (own-module items are always visible)
                            if class_name != self.current_module && !mi.exports.contains(method_name.as_str()) {
                                self.errors.push(AtlasError::TypeError {
                                    span: Span::new(0, 0),
                                    message: format!(
                                        "item '{}' is not exported by module '{}'",
                                        method_name, class_name
                                    ),
                                    hint: Some(format!(
                                        "Add 'export' before the definition of '{}' in '{}.atl'",
                                        method_name, class_name
                                    )),
                                });
                                return;
                            }

                            // Extern fns keep their bare name; regular fns get qualified
                            let callee = if is_extern {
                                method_name.clone()
                            } else {
                                format!("{}.{}", class_name, method_name)
                            };

                            let mut resolved_args = std::mem::take(args);
                            for arg in &mut resolved_args {
                                self.resolve_expr(arg);
                            }
                            *expr = Expr::Call {
                                callee,
                                args: resolved_args,
                                span: *span,
                            };
                            return;
                        }
                    }
                }

                // Fall-through: not a module call — resolve class_name as a type and recurse
                let resolved_class = self.resolve_qualified_name(class_name).unwrap_or_else(|| class_name.clone());
                *class_name = resolved_class;
                for arg in args {
                    self.resolve_expr(arg);
                }
            }
            Expr::StaticMember { class_name, member_name, span } => {
                if self.imports.contains(class_name) || class_name == self.current_module {
                    if let Some(mi) = self.global_modules.get(class_name) {
                        if mi.enums.contains(member_name) || mi.choices.contains(member_name) {
                            let resolved = format!("{}.{}", class_name, member_name);
                            *expr = Expr::Var {
                                name: resolved,
                                span: *span,
                            };
                            return;
                        }
                    }
                }

                let resolved_class = self.resolve_qualified_name(class_name).unwrap_or_else(|| class_name.clone());
                *class_name = resolved_class;
            }
            Expr::GenericStaticCall { class_name, type_args, args, .. } => {
                let resolved_class = self.resolve_qualified_name(class_name).unwrap_or_else(|| class_name.clone());
                *class_name = resolved_class;
                for type_arg in type_args {
                    self.resolve_type(&mut type_arg.0, type_arg.1);
                }
                for arg in args {
                    self.resolve_expr(arg);
                }
            }
            Expr::IntLit { .. } | Expr::FloatLit { .. } | Expr::BoolLit { .. } | Expr::CharLit { .. } | Expr::StringLit { .. } | Expr::Null { .. } => {}
            Expr::Binary { lhs, rhs, .. } => {
                self.resolve_expr(lhs);
                self.resolve_expr(rhs);
            }
            Expr::Unary { operand, .. } => {
                self.resolve_expr(operand);
            }
            Expr::ArrayIndex { array, index, .. } => {
                self.resolve_expr(array);
                self.resolve_expr(index);
            }
            Expr::MemberAccess { object, .. } => {
                self.resolve_expr(object);
            }
            Expr::MethodCall { object, args, .. } => {
                self.resolve_expr(object);
                for arg in args {
                    self.resolve_expr(arg);
                }
            }
            Expr::Group { inner, .. } => {
                self.resolve_expr(inner);
            }
            Expr::SizeOf { ty, .. } => {
                let span = ty.1;
                self.resolve_type(&mut ty.0, span);
            }
            Expr::Cast { target_ty, expr, .. } => {
                let span = target_ty.1;
                self.resolve_type(&mut target_ty.0, span);
                self.resolve_expr(expr);
            }
            Expr::Destroy { type_arg, expr, .. } => {
                self.resolve_type(type_arg, expr.span());
                self.resolve_expr(expr);
            }
            Expr::Match { expr: m_expr, cases, .. } => {
                self.resolve_expr(m_expr);
                for case in cases {
                    match &mut case.pattern {
                        Pattern::Variant { path, bind: _, span: _pat_span } => {
                            if path.len() >= 2 {
                                let (enum_or_choice, variant) = if path.len() >= 3 {
                                    let variant = path.last().unwrap().clone();
                                    let enum_or_choice = path[0..path.len()-1].join("::");
                                    (enum_or_choice, variant)
                                } else {
                                    (path[0].clone(), path[1].clone())
                                };

                                let resolved = self.resolve_qualified_name(&enum_or_choice).unwrap_or(enum_or_choice);
                                *path = vec![resolved, variant];
                            }
                        }
                        _ => {}
                    }
                    for s in &mut case.body.stmts {
                        self.resolve_stmt(s);
                    }
                }
            }
            Expr::StructInit { struct_name, fields, span: _ } => {
                if let Some(qualified) = self.resolve_qualified_name(struct_name) {
                    *struct_name = qualified;
                }
                for (_, val_expr) in fields {
                    self.resolve_expr(val_expr);
                }
            }
            Expr::ErrorPropagate { expr: inner_expr, span: _ } => {
                self.resolve_expr(inner_expr);
            }
            Expr::ArrayLit { elements, span: _ } => {
                for elem in elements {
                    self.resolve_expr(elem);
                }
            }
        }
    }

    fn resolve_stmt(&mut self, stmt: &mut Stmt) {
        match stmt {
            Stmt::ExprStmt(expr) => self.resolve_expr(expr),
            Stmt::VarDecl(decl) => {
                if let Some(ref mut t) = decl.ty_hint {
                    self.resolve_type(&mut t.0, decl.span);
                }
                if let Some(ref mut v) = decl.init {
                    self.resolve_expr(v);
                }
            }
            Stmt::ConstDecl(decl) => {
                if let Some(ref mut t) = decl.ty_hint {
                    self.resolve_type(&mut t.0, decl.span);
                }
                self.resolve_expr(&mut decl.init);
            }
            Stmt::StructDecl(decl) => {
                for field in &mut decl.fields {
                    self.resolve_type(&mut field.ty.0, field.ty.1);
                }
            }
            Stmt::Assign(assign) => {
                self.resolve_expr(&mut assign.target);
                self.resolve_expr(&mut assign.value);
            }
            Stmt::If(stmt) => {
                self.resolve_expr(&mut stmt.condition);
                for s in &mut stmt.then_block.stmts {
                    self.resolve_stmt(s);
                }
                for clause in &mut stmt.else_if_clauses {
                    self.resolve_expr(&mut clause.0);
                    for s in &mut clause.1.stmts {
                        self.resolve_stmt(s);
                    }
                }
                if let Some(ref mut eb) = stmt.else_block {
                    for s in &mut eb.stmts {
                        self.resolve_stmt(s);
                    }
                }
            }
            Stmt::While(stmt) => {
                self.resolve_expr(&mut stmt.condition);
                for s in &mut stmt.body.stmts {
                    self.resolve_stmt(s);
                }
            }
            Stmt::Block(block) => {
                for s in &mut block.stmts {
                    self.resolve_stmt(s);
                }
            }
            Stmt::Return(val, _) => {
                if let Some(ref mut v) = val {
                    self.resolve_expr(v);
                }
            }
        }
    }

    fn resolve_item(&mut self, item: &mut Item) {
        match item {
            Item::FunctionDecl(decl, _) => {
                if decl.name.0 != "main" || self.current_module != "main" {
                    decl.name.0 = format!("{}.{}", self.current_module, decl.name.0);
                }
                for param in &mut decl.params {
                    let span = param.ty.1;
                    self.resolve_type(&mut param.ty.0, span);
                }
                if let Some(ref mut ret) = decl.ret_ty {
                    let span = ret.1;
                    self.resolve_type(&mut ret.0, span);
                }
                for clause in &mut decl.where_clauses {
                    for method in &mut clause.constraints {
                        for param in &mut method.params {
                            let span = param.ty.1;
                            self.resolve_type(&mut param.ty.0, span);
                        }
                        if let Some(ref mut ret) = method.ret_ty {
                            let span = ret.1;
                            self.resolve_type(&mut ret.0, span);
                        }
                    }
                }
                for stmt in &mut decl.body.stmts {
                    self.resolve_stmt(stmt);
                }
            }
            Item::ExternFnDecl(decl, _) => {
                for param in &mut decl.params {
                    let span = param.ty.1;
                    self.resolve_type(&mut param.ty.0, span);
                }
                if let Some(ref mut ret) = decl.ret_ty {
                    let span = ret.1;
                    self.resolve_type(&mut ret.0, span);
                }
            }
            Item::ClassDecl(decl, _) => {
                let unqalified_class = decl.name.0.clone();
                decl.name.0 = format!("{}.{}", self.current_module, decl.name.0);
                self.current_class = Some(unqalified_class);
                for field in &mut decl.fields {
                    let span = field.ty.1;
                    self.resolve_type(&mut field.ty.0, span);
                }
                for method in &mut decl.methods {
                    for param in &mut method.decl.params {
                        let span = param.ty.1;
                        self.resolve_type(&mut param.ty.0, span);
                    }
                    if let Some(ref mut ret) = method.decl.ret_ty {
                        let span = ret.1;
                        self.resolve_type(&mut ret.0, span);
                    }
                    for stmt in &mut method.decl.body.stmts {
                        self.resolve_stmt(stmt);
                    }
                }
                let class_name_str = decl.name.0.clone();
                for nested in &mut decl.structs {
                    nested.decl.name.0 = format!("{}.{}", class_name_str, nested.decl.name.0);
                    for field in &mut nested.decl.fields {
                        let span = field.ty.1;
                        self.resolve_type(&mut field.ty.0, span);
                    }
                }
                self.current_class = None;
            }
            Item::StructDecl(decl, _) => {
                decl.name.0 = format!("{}.{}", self.current_module, decl.name.0);
                for field in &mut decl.fields {
                    let span = field.ty.1;
                    self.resolve_type(&mut field.ty.0, span);
                }
            }
            Item::EnumDecl(decl, _) => {
                decl.name.0 = format!("{}.{}", self.current_module, decl.name.0);
            }
            Item::ChoiceDecl(decl, _) => {
                decl.name.0 = format!("{}.{}", self.current_module, decl.name.0);
                for variant in &mut decl.variants {
                    if let Some(ref mut payload) = variant.payload {
                        let span = payload.1;
                        self.resolve_type(&mut payload.0, span);
                    }
                }
            }
            Item::Import(_) => {}
        }
    }
}
