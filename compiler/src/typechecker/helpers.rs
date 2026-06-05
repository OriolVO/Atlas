#![allow(dead_code)]

use std::collections::HashMap;

use crate::error::Span;
use crate::parser::{
    Assign, BinOp, Block, ChoiceDecl, ChoiceVariant, ClassDecl, ClassField, ClassMethod,
    ConstDecl, Expr, FunctionDecl, IfStmt, MatchCase, Param, Stmt, TypeExpr, UnaryOp,
    VarDecl, WhileStmt, ConstraintSignature,
};

use super::{AtlasType, ClassType, StructType};

pub(crate) fn is_copy_prevented(ty: &AtlasType, structs: &HashMap<String, StructType>) -> bool {
    match ty {
        AtlasType::Class(_) => true,
        AtlasType::Struct(name) => {
            if let Some(st) = structs.get(name) {
                st.fields.iter().any(|(_, f_ty)| is_copy_prevented(f_ty, structs))
            } else {
                false
            }
        }
        AtlasType::Array { element, .. } => is_copy_prevented(element, structs),
        AtlasType::Slice(element) => is_copy_prevented(element, structs),
        _ => false,
    }
}

pub(crate) fn is_temporary(expr: &Expr, class_names: &std::collections::HashSet<String>, generic_classes: &std::collections::HashMap<String, (crate::parser::ClassDecl, bool)>) -> bool {
    match expr {
        Expr::Var { .. } | Expr::MemberAccess { .. } | Expr::Unary { op: UnaryOp::Dereference, .. } | Expr::ArrayIndex { .. } => false,
        Expr::Group { inner, .. } => is_temporary(inner, class_names, generic_classes),
        _ => true,
    }
}

pub(crate) fn extract_non_null_check(cond: &Expr) -> Option<String> {
    match cond {
        Expr::Binary { lhs, op: BinOp::NotEq, rhs, .. } => {
            if let (Expr::Var { name, .. }, Expr::Null { .. }) = (lhs.as_ref(), rhs.as_ref()) {
                Some(name.clone())
            } else if let (Expr::Null { .. }, Expr::Var { name, .. }) = (lhs.as_ref(), rhs.as_ref()) {
                Some(name.clone())
            } else {
                None
            }
        }
        Expr::Unary { op: UnaryOp::Not, operand, .. } => {
            if let Expr::Binary { lhs, op: BinOp::Eq, rhs, .. } = operand.as_ref() {
                if let (Expr::Var { name, .. }, Expr::Null { .. }) = (lhs.as_ref(), rhs.as_ref()) {
                    Some(name.clone())
                } else if let (Expr::Null { .. }, Expr::Var { name, .. }) = (lhs.as_ref(), rhs.as_ref()) {
                    Some(name.clone())
                } else {
                    None
                }
            } else {
                None
            }
        }
        _ => None
    }
}

// AST substitution and mangling helper functions for monomorphization

pub(crate) fn mangle_type_name(base: &str, args: &[AtlasType]) -> String {
    let mut name = base.to_string();
    for arg in args {
        name.push('_');
        name.push_str(&mangle_type_to_string(arg));
    }
    name
}

pub(crate) fn mangle_type_to_string(ty: &AtlasType) -> String {
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
        AtlasType::Struct(n) => n.replace("<", "_").replace(">", "_").replace(",", "_").replace("@", "ptr_").replace(" ", ""),
        AtlasType::Class(n) => n.replace("<", "_").replace(">", "_").replace(",", "_").replace("@", "ptr_").replace(" ", ""),
        AtlasType::Pointer { target, nullable } => {
            format!("ptr_{}{}", if *nullable { "opt_" } else { "" }, mangle_type_to_string(target))
        }
        AtlasType::Array { element, size } => {
            format!("arr_{}_{}", mangle_type_to_string(element), size)
        }
        AtlasType::Slice(element) => {
            format!("slice_{}", mangle_type_to_string(element))
        }
        AtlasType::Null => "null".to_string(),
        AtlasType::Enum(n) => n.clone(),
        AtlasType::Choice(n) => n.replace("<", "_").replace(">", "_").replace(",", "_").replace("@", "ptr_").replace(" ", ""),
        AtlasType::GenericPlaceholder(n) => n.clone(),
    }
}

pub(crate) fn atlas_type_to_type_expr(ty: &AtlasType) -> TypeExpr {
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
        AtlasType::Struct(n) => TypeExpr::Named(n.clone()),
        AtlasType::Class(n) => TypeExpr::Named(n.clone()),
        AtlasType::Pointer { target, nullable } => TypeExpr::Pointer {
            target: Box::new(atlas_type_to_type_expr(target)),
            nullable: *nullable,
            span: Span::new(0, 0),
        },
        AtlasType::Array { element, size } => TypeExpr::Array {
            element: Box::new(atlas_type_to_type_expr(element)),
            size: *size,
            span: Span::new(0, 0),
        },
        AtlasType::Slice(element) => TypeExpr::Slice {
            element: Box::new(atlas_type_to_type_expr(element)),
            span: Span::new(0, 0),
        },
        AtlasType::Null => TypeExpr::Named("null".to_string()),
        AtlasType::Enum(n) => TypeExpr::Named(n.clone()),
        AtlasType::Choice(n) => TypeExpr::Named(n.clone()),
        AtlasType::GenericPlaceholder(n) => TypeExpr::Named(n.clone()),
    }
}

pub(crate) fn substitute_type_expr(te: &TypeExpr, substitutions: &HashMap<String, TypeExpr>) -> TypeExpr {
    match te {
        TypeExpr::Named(name) => {
            if let Some(sub) = substitutions.get(name) {
                sub.clone()
            } else {
                TypeExpr::Named(name.clone())
            }
        }
        TypeExpr::Pointer { target, nullable, span } => {
            TypeExpr::Pointer {
                target: Box::new(substitute_type_expr(target, substitutions)),
                nullable: *nullable,
                span: *span,
            }
        }
        TypeExpr::Array { element, size, span } => {
            TypeExpr::Array {
                element: Box::new(substitute_type_expr(element, substitutions)),
                size: *size,
                span: *span,
            }
        }
        TypeExpr::Slice { element, span } => {
            TypeExpr::Slice {
                element: Box::new(substitute_type_expr(element, substitutions)),
                span: *span,
            }
        }
        TypeExpr::Generic { base, args, span } => {
            TypeExpr::Generic {
                base: base.clone(),
                args: args.iter().map(|arg| substitute_type_expr(arg, substitutions)).collect(),
                span: *span,
            }
        }
    }
}

pub(crate) fn substitute_expr(expr: &Expr, subs: &HashMap<String, TypeExpr>) -> Expr {
    match expr {
        Expr::Binary { op, lhs, rhs, span } => Expr::Binary {
            op: *op,
            lhs: Box::new(substitute_expr(lhs, subs)),
            rhs: Box::new(substitute_expr(rhs, subs)),
            span: *span,
        },
        Expr::Unary { op, operand, span } => Expr::Unary {
            op: *op,
            operand: Box::new(substitute_expr(operand, subs)),
            span: *span,
        },
        Expr::Group { inner, span } => Expr::Group {
            inner: Box::new(substitute_expr(inner, subs)),
            span: *span,
        },
        Expr::Call { callee, args, span } => Expr::Call {
            callee: callee.clone(),
            args: args.iter().map(|arg| substitute_expr(arg, subs)).collect(),
            span: *span,
        },
        Expr::StructInit { struct_name, fields, span } => Expr::StructInit {
            struct_name: struct_name.clone(),
            fields: fields.iter().map(|(n, e)| (n.clone(), substitute_expr(e, subs))).collect(),
            span: *span,
        },
        Expr::MemberAccess { object, member, span } => Expr::MemberAccess {
            object: Box::new(substitute_expr(object, subs)),
            member: member.clone(),
            span: *span,
        },
        Expr::MethodCall { object, method_name, args, span } => Expr::MethodCall {
            object: Box::new(substitute_expr(object, subs)),
            method_name: method_name.clone(),
            args: args.iter().map(|arg| substitute_expr(arg, subs)).collect(),
            span: *span,
        },
        Expr::StaticCall { class_name, method_name, args, span } => Expr::StaticCall {
            class_name: class_name.clone(),
            method_name: method_name.clone(),
            args: args.iter().map(|arg| substitute_expr(arg, subs)).collect(),
            span: *span,
        },
        Expr::ArrayLit { elements, span } => Expr::ArrayLit {
            elements: elements.iter().map(|e| substitute_expr(e, subs)).collect(),
            span: *span,
        },
        Expr::ArrayIndex { array, index, span } => Expr::ArrayIndex {
            array: Box::new(substitute_expr(array, subs)),
            index: Box::new(substitute_expr(index, subs)),
            span: *span,
        },
        Expr::Match { expr: m_expr, cases, span } => Expr::Match {
            expr: Box::new(substitute_expr(m_expr, subs)),
            cases: cases.iter().map(|case| MatchCase {
                pattern: case.pattern.clone(),
                body: substitute_block(&case.body, subs),
            }).collect(),
            span: *span,
        },
        Expr::ErrorPropagate { expr: ep_expr, span } => Expr::ErrorPropagate {
            expr: Box::new(substitute_expr(ep_expr, subs)),
            span: *span,
        },
        Expr::SizeOf { ty, span } => Expr::SizeOf {
            ty: (substitute_type_expr(&ty.0, subs), ty.1),
            span: *span,
        },
        Expr::Cast { target_ty, expr, span } => Expr::Cast {
            target_ty: (substitute_type_expr(&target_ty.0, subs), target_ty.1),
            expr: Box::new(substitute_expr(expr, subs)),
            span: *span,
        },
        Expr::Destroy { type_arg, expr, span } => Expr::Destroy {
            type_arg: Box::new(substitute_type_expr(type_arg, subs)),
            expr: Box::new(substitute_expr(expr, subs)),
            span: *span,
        },
        Expr::IntLit { .. } | Expr::FloatLit { .. } | Expr::BoolLit { .. } | Expr::CharLit { .. } | Expr::StringLit { .. } | Expr::Null { .. } => expr.clone(),
        other => other.clone(),
    }
}

pub(crate) fn substitute_stmt(stmt: &Stmt, subs: &HashMap<String, TypeExpr>) -> Stmt {
    match stmt {
        Stmt::VarDecl(decl) => Stmt::VarDecl(VarDecl {
            name: decl.name.clone(),
            ty_hint: decl.ty_hint.as_ref().map(|th| (substitute_type_expr(&th.0, subs), th.1)),
            init: decl.init.as_ref().map(|i| substitute_expr(i, subs)),
            span: decl.span,
        }),
        Stmt::ConstDecl(decl) => Stmt::ConstDecl(ConstDecl {
            name: decl.name.clone(),
            ty_hint: decl.ty_hint.as_ref().map(|th| (substitute_type_expr(&th.0, subs), th.1)),
            init: substitute_expr(&decl.init, subs),
            span: decl.span,
        }),
        Stmt::StructDecl(decl) => Stmt::StructDecl(decl.clone()),
        Stmt::Assign(assign) => Stmt::Assign(Assign {
            target: substitute_expr(&assign.target, subs),
            value: substitute_expr(&assign.value, subs),
            span: assign.span,
        }),
        Stmt::ExprStmt(expr) => Stmt::ExprStmt(substitute_expr(expr, subs)),
        Stmt::Return(expr_opt, span) => Stmt::Return(expr_opt.as_ref().map(|e| substitute_expr(e, subs)), *span),
        Stmt::If(if_stmt) => Stmt::If(IfStmt {
            condition: substitute_expr(&if_stmt.condition, subs),
            then_block: substitute_block(&if_stmt.then_block, subs),
            else_if_clauses: if_stmt.else_if_clauses.iter().map(|(cond, body)| {
                (substitute_expr(cond, subs), substitute_block(body, subs))
            }).collect(),
            else_block: if_stmt.else_block.as_ref().map(|eb| substitute_block(eb, subs)),
            span: if_stmt.span,
        }),
        Stmt::While(while_stmt) => Stmt::While(WhileStmt {
            condition: substitute_expr(&while_stmt.condition, subs),
            body: substitute_block(&while_stmt.body, subs),
            span: while_stmt.span,
        }),
        Stmt::Block(block) => Stmt::Block(substitute_block(block, subs)),
    }
}

pub(crate) fn substitute_block(block: &Block, subs: &HashMap<String, TypeExpr>) -> Block {
    Block {
        stmts: block.stmts.iter().map(|s| substitute_stmt(s, subs)).collect(),
        span: block.span,
    }
}

pub(crate) fn substitute_class_decl(decl: &ClassDecl, new_name: &str, subs: &HashMap<String, TypeExpr>) -> ClassDecl {
    ClassDecl {
        name: (new_name.to_string(), decl.name.1),
        generic_params: Vec::new(),
        fields: decl.fields.iter().map(|field| ClassField {
            visibility: field.visibility,
            is_const: field.is_const,
            name: field.name.clone(),
            ty: (substitute_type_expr(&field.ty.0, subs), field.ty.1),
            span: field.span,
        }).collect(),
        methods: decl.methods.iter().map(|method| {
            let sub_decl = substitute_fn_decl(&method.decl, &method.decl.name.0, subs);
            ClassMethod {
                visibility: method.visibility,
                decl: sub_decl,
            }
        }).collect(),
        structs: decl.structs.clone(),
        where_clauses: Vec::new(),
        span: decl.span,
    }
}

pub(crate) fn substitute_choice_decl(decl: &ChoiceDecl, new_name: &str, subs: &HashMap<String, TypeExpr>) -> ChoiceDecl {
    ChoiceDecl {
        name: (new_name.to_string(), decl.name.1),
        generic_params: Vec::new(),
        variants: decl.variants.iter().map(|variant| ChoiceVariant {
            name: variant.name.clone(),
            payload: variant.payload.as_ref().map(|pl| (substitute_type_expr(&pl.0, subs), pl.1)),
            span: variant.span,
        }).collect(),
        span: decl.span,
    }
}

pub(crate) fn substitute_fn_decl(decl: &FunctionDecl, new_name: &str, subs: &HashMap<String, TypeExpr>) -> FunctionDecl {
    FunctionDecl {
        name: (new_name.to_string(), decl.name.1),
        generic_params: Vec::new(),
        params: decl.params.iter().map(|param| Param {
            name: param.name.clone(),
            ty: (substitute_type_expr(&param.ty.0, subs), param.ty.1),
        }).collect(),
        ret_ty: decl.ret_ty.as_ref().map(|rt| (substitute_type_expr(&rt.0, subs), rt.1)),
        where_clauses: Vec::new(),
        body: substitute_block(&decl.body, subs),
    }
}

pub(crate) fn substitute_constraint_signature(
    sig: &ConstraintSignature,
    subs: &HashMap<String, TypeExpr>,
) -> ConstraintSignature {
    ConstraintSignature {
        name: sig.name.clone(),
        params: sig.params.iter().map(|p| Param {
            name: p.name.clone(),
            ty: (substitute_type_expr(&p.ty.0, subs), p.ty.1),
        }).collect(),
        ret_ty: sig.ret_ty.as_ref().map(|rt| (substitute_type_expr(&rt.0, subs), rt.1)),
        span: sig.span,
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum VisitState {
    Visiting,
    Visited,
}

pub(crate) fn check_type_cycle(
    name: &str,
    structs: &HashMap<String, StructType>,
    classes: &HashMap<String, ClassType>,
    visited: &mut HashMap<String, VisitState>,
) -> bool {
    match visited.get(name) {
        Some(VisitState::Visiting) => return true,
        Some(VisitState::Visited) => return false,
        None => {}
    }

    visited.insert(name.to_string(), VisitState::Visiting);

    if let Some(st) = structs.get(name) {
        for (_, ty) in &st.fields {
            if has_cycle_through_type(ty, structs, classes, visited) {
                return true;
            }
        }
    } else if let Some(cls) = classes.get(name) {
        for f in &cls.fields {
            if has_cycle_through_type(&f.ty, structs, classes, visited) {
                return true;
            }
        }
    }

    visited.insert(name.to_string(), VisitState::Visited);
    false
}

pub(crate) fn has_cycle_through_type(
    ty: &AtlasType,
    structs: &HashMap<String, StructType>,
    classes: &HashMap<String, ClassType>,
    visited: &mut HashMap<String, VisitState>,
) -> bool {
    match ty {
        AtlasType::Struct(ref_name) => {
            check_type_cycle(ref_name, structs, classes, visited)
        }
        AtlasType::Class(ref_name) => {
            check_type_cycle(ref_name, structs, classes, visited)
        }
        _ => false,
    }
}
