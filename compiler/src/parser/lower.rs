use crate::parser::{
    Block, ChoiceDecl, ClassDecl, Expr, FunctionDecl, Item, SourceFile, Stmt,
};

pub fn lower_intrinsics(file: &mut SourceFile) {
    for item in &mut file.items {
        lower_item(item);
    }
}

fn lower_item(item: &mut Item) {
    match item {
        Item::FunctionDecl(decl, _) => lower_function(decl),
        Item::ClassDecl(decl, _) => lower_class(decl),
        Item::ChoiceDecl(decl, _) => lower_choice(decl),
        _ => {}
    }
}

fn lower_function(decl: &mut FunctionDecl) {
    lower_block(&mut decl.body);
}

fn lower_class(decl: &mut ClassDecl) {
    for method in &mut decl.methods {
        lower_function(&mut method.decl);
    }
}

fn lower_choice(_decl: &mut ChoiceDecl) {}

fn lower_block(block: &mut Block) {
    for stmt in &mut block.stmts {
        lower_stmt(stmt);
    }
}

fn lower_stmt(stmt: &mut Stmt) {
    match stmt {
        Stmt::VarDecl(decl) => {
            if let Some(init) = &mut decl.init {
                lower_expr(init);
            }
        }
        Stmt::ConstDecl(decl) => lower_expr(&mut decl.init),
        Stmt::Assign(assign) => {
            lower_expr(&mut assign.target);
            lower_expr(&mut assign.value);
        }
        Stmt::ExprStmt(expr) => lower_expr(expr),
        Stmt::Return(Some(expr), _) => lower_expr(expr),
        Stmt::If(if_stmt) => {
            lower_expr(&mut if_stmt.condition);
            lower_block(&mut if_stmt.then_block);
            for (condition, block) in &mut if_stmt.else_if_clauses {
                lower_expr(condition);
                lower_block(block);
            }
            if let Some(block) = &mut if_stmt.else_block {
                lower_block(block);
            }
        }
        Stmt::While(while_stmt) => {
            lower_expr(&mut while_stmt.condition);
            lower_block(&mut while_stmt.body);
        }
        Stmt::Block(block) => lower_block(block),
        Stmt::StructDecl(_) | Stmt::Return(None, _) => {}
    }
}

fn lower_expr(expr: &mut Expr) {
    match expr {
        Expr::Binary { lhs, rhs, .. } => {
            lower_expr(lhs);
            lower_expr(rhs);
        }
        Expr::Unary { operand, .. } => lower_expr(operand),
        Expr::Call { args, .. } => {
            for arg in args {
                lower_expr(arg);
            }
        }
        Expr::GenericCall {
            callee,
            type_args,
            args,
            span,
        } => {
            for arg in args.iter_mut() {
                lower_expr(arg);
            }
            if callee == "cast" && type_args.len() == 1 && args.len() == 1 {
                let target_ty = type_args[0].clone();
                let inner = args.remove(0);
                *expr = Expr::Cast {
                    target_ty,
                    expr: Box::new(inner),
                    span: *span,
                };
            }
        }
        Expr::StructInit { fields, .. } => {
            for (_, value) in fields {
                lower_expr(value);
            }
        }
        Expr::MemberAccess { object, .. } => lower_expr(object),
        Expr::MethodCall { object, args, .. } => {
            lower_expr(object);
            for arg in args {
                lower_expr(arg);
            }
        }
        Expr::StaticCall { args, .. } => {
            for arg in args {
                lower_expr(arg);
            }
        }
        Expr::GenericStaticCall {
            class_name,
            method_name,
            type_args,
            args,
            span,
        } => {
            for arg in args.iter_mut() {
                lower_expr(arg);
            }
            if class_name == "memory" && method_name == "sizeof" && type_args.len() == 1 && args.is_empty() {
                let ty = type_args[0].clone();
                *expr = Expr::SizeOf { ty, span: *span };
            } else if class_name == "memory" && method_name == "destroy" && type_args.len() == 1 && args.len() == 1 {
                let ty = type_args[0].0.clone();
                let inner = args.remove(0);
                *expr = Expr::Destroy {
                    type_arg: Box::new(ty),
                    expr: Box::new(inner),
                    span: *span,
                };
            }
        }
        Expr::ArrayLit { elements, .. } => {
            for elem in elements {
                lower_expr(elem);
            }
        }
        Expr::ArrayIndex { array, index, .. } => {
            lower_expr(array);
            lower_expr(index);
        }
        Expr::Match { expr, cases, .. } => {
            lower_expr(expr);
            for case in cases {
                lower_block(&mut case.body);
            }
        }
        Expr::Group { inner, .. } => lower_expr(inner),
        Expr::ErrorPropagate { expr, .. } => lower_expr(expr),
        Expr::IntLit { .. }
        | Expr::FloatLit { .. }
        | Expr::BoolLit { .. }
        | Expr::CharLit { .. }
        | Expr::StringLit { .. }
        | Expr::Var { .. }
        | Expr::StaticMember { .. }
        | Expr::Null { .. }
        | Expr::SizeOf { .. }
        | Expr::Cast { .. }
        | Expr::Destroy { .. } => {}
    }
}
