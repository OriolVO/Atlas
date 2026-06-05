use std::collections::HashMap;
use crate::resolver::Project;
use crate::error::{AtlasError, Span};
use crate::lexer::IntSuffix;
#[allow(unused_imports)]
use crate::parser::{
    SourceFile, Item, FunctionDecl, ExternFnDecl, Stmt, VarDecl, ConstDecl, Assign, IfStmt, WhileStmt, Block, Expr, BinOp, UnaryOp, TypeExpr, StructDecl, FieldDecl, Pattern, EnumDecl, ChoiceDecl, MatchCase,
    WhereClause, ConstraintSignature, ClassField, ClassMethod, Param, ChoiceVariant, ClassDecl
};
use super::helpers::mangle_type_name;

#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum AtlasType {
    Int,      // i64 (default int)
    Uint,     // u64 (default uint)
    Int8,
    Int16,
    Int32,
    Int64,
    Uint8,
    Uint16,
    Uint32,
    Uint64,
    Float,    // f64 (default float)
    Float32,
    Float64,
    Bool,
    Char,

    Void,
    Struct(String),
    Class(String),
    Pointer {
        target: Box<AtlasType>,
        nullable: bool,
    },
    Array {
        element: Box<AtlasType>,
        size: usize,
    },
    Slice(Box<AtlasType>),
    Null,
    Enum(String),
    Choice(String),
    GenericPlaceholder(String),
}

#[derive(Debug, Clone)]
pub struct EnumType {
    pub name: String,
    pub variants: Vec<String>,
}

#[derive(Debug, Clone)]
pub struct ChoiceVariantType {
    pub name: String,
    pub payload: Option<AtlasType>,
}

#[derive(Debug, Clone)]
pub struct ChoiceType {
    pub name: String,
    pub variants: Vec<ChoiceVariantType>,
}

#[derive(Debug, Clone)]
pub struct StructType {
    pub name: String,
    pub fields: Vec<(String, AtlasType)>,
}

#[derive(Debug, Clone)]
pub struct ClassType {
    pub name: String,
    pub fields: Vec<ClassFieldType>,
    pub methods: HashMap<String, ClassMethodType>,
}

#[derive(Debug, Clone)]
pub struct ClassFieldType {
    pub name: String,
    pub ty: AtlasType,
    pub visibility: crate::parser::Visibility,
    pub is_const: bool,
}

#[derive(Debug, Clone)]
pub struct ClassMethodType {
    pub name: String,
    pub sig: FnSignature,
    pub visibility: crate::parser::Visibility,
}

#[derive(Debug, Clone)]
pub struct FnSignature {
    pub params: Vec<(String, AtlasType)>,
    pub ret_ty: AtlasType,
}

pub struct TypedAST {
    pub fn_sigs: HashMap<String, FnSignature>,
    pub expr_types: HashMap<usize, AtlasType>,
    pub structs: HashMap<String, StructType>,
    pub classes: HashMap<String, ClassType>,
    pub enums: HashMap<String, EnumType>,
    pub choices: HashMap<String, ChoiceType>,
    pub mangled_calls: HashMap<Span, String>,
    pub overloaded_operators: HashMap<usize, String>,
}

pub fn resolve_type(
    type_expr: &TypeExpr,
    structs: &HashMap<String, StructType>,
    classes: &std::collections::HashSet<String>,
    enums: &std::collections::HashSet<String>,
    choices: &std::collections::HashSet<String>,
    local_generics: &std::collections::HashSet<String>,
) -> Option<AtlasType> {
    match type_expr {
        TypeExpr::Named(name) => match name.as_str() {
            "int" | "int64" => Some(AtlasType::Int),
            "uint" | "uint64" => Some(AtlasType::Uint),
            "int8" => Some(AtlasType::Int8),
            "int16" => Some(AtlasType::Int16),
            "int32" => Some(AtlasType::Int32),
            "uint8" => Some(AtlasType::Uint8),
            "uint16" => Some(AtlasType::Uint16),
            "uint32" => Some(AtlasType::Uint32),
            "float" | "float64" => Some(AtlasType::Float),
            "float32" => Some(AtlasType::Float32),
            "bool" => Some(AtlasType::Bool),
            "char" => Some(AtlasType::Char),

            "void" => Some(AtlasType::Void),
            other => {
                if local_generics.contains(other) {
                    Some(AtlasType::GenericPlaceholder(other.to_string()))
                } else if structs.contains_key(other) {
                    Some(AtlasType::Struct(other.to_string()))
                } else if classes.contains(other) {
                    Some(AtlasType::Class(other.to_string()))
                } else if enums.contains(other) {
                    Some(AtlasType::Enum(other.to_string()))
                } else if choices.contains(other) {
                    Some(AtlasType::Choice(other.to_string()))
                } else {
                    None
                }
            }
        },
        TypeExpr::Pointer { target, nullable, .. } => {
            let target_ty = resolve_type(target, structs, classes, enums, choices, local_generics)?;
            Some(AtlasType::Pointer {
                target: Box::new(target_ty),
                nullable: *nullable,
            })
        }
        TypeExpr::Array { element, size, .. } => {
            let elem_ty = resolve_type(element, structs, classes, enums, choices, local_generics)?;
            Some(AtlasType::Array {
                element: Box::new(elem_ty),
                size: *size,
            })
        }
        TypeExpr::Slice { element, .. } => {
            let elem_ty = resolve_type(element, structs, classes, enums, choices, local_generics)?;
            Some(AtlasType::Slice(Box::new(elem_ty)))
        }
        TypeExpr::Generic { base, args, .. } => {
            let mut resolved_args = Vec::new();
            for arg in args {
                resolved_args.push(resolve_type(arg, structs, classes, enums, choices, local_generics)?);
            }
            let mangled = mangle_type_name(base, &resolved_args);
            if classes.contains(&mangled) {
                Some(AtlasType::Class(mangled))
            } else if choices.contains(&mangled) {
                Some(AtlasType::Choice(mangled))
            } else {
                None
            }
        }
    }
}

pub fn type_expr_to_string(te: &TypeExpr) -> String {
    match te {
        TypeExpr::Named(s) => s.clone(),
        TypeExpr::Pointer { .. } => "pointer".to_string(),
        TypeExpr::Array { .. } => "array".to_string(),
        TypeExpr::Slice { .. } => "slice".to_string(),
        TypeExpr::Generic { base, .. } => format!("{}<...>", base),
    }
}

fn map_suffix(suffix: IntSuffix) -> AtlasType {
    match suffix {
        IntSuffix::I8 => AtlasType::Int8,
        IntSuffix::I16 => AtlasType::Int16,
        IntSuffix::I32 => AtlasType::Int32,
        IntSuffix::I64 => AtlasType::Int,
        IntSuffix::U8 => AtlasType::Uint8,
        IntSuffix::U16 => AtlasType::Uint16,
        IntSuffix::U32 => AtlasType::Uint32,
        IntSuffix::U64 => AtlasType::Uint,
    }
}

pub fn generate_zero_expr(ty: &AtlasType, span: Span, structs: &HashMap<String, StructType>) -> Expr {
    match ty {
        AtlasType::Int | AtlasType::Int64 | AtlasType::Int32 | AtlasType::Int16 | AtlasType::Int8 |
        AtlasType::Uint | AtlasType::Uint64 | AtlasType::Uint32 | AtlasType::Uint16 | AtlasType::Uint8 => Expr::IntLit { value: 0, suffix: None, span },
        AtlasType::Float | AtlasType::Float64 | AtlasType::Float32 => Expr::FloatLit { value: 0.0, span },
        AtlasType::Bool => Expr::BoolLit { value: false, span },
        AtlasType::Char => Expr::CharLit { value: '\0', span },
        AtlasType::Pointer { .. } => Expr::Null { span },
        AtlasType::Class(name) => Expr::Call { callee: name.clone(), args: vec![], span },
        AtlasType::Struct(name) => {
            let mut fields = vec![];
            if let Some(st) = structs.get(name) {
                for (f_name, f_ty) in &st.fields {
                    fields.push(( (f_name.clone(), span), generate_zero_expr(f_ty, span, structs) ));
                }
            }
            Expr::StructInit { struct_name: name.clone(), fields, span }
        }
        AtlasType::Array { element, size } => {
            let mut elements = vec![];
            for _ in 0..*size {
                elements.push(generate_zero_expr(element, span, structs));
            }
            Expr::ArrayLit { elements, span }
        }
        // Slice is fundamentally a struct { ptr, len }, but we can initialize as empty array lit conceptually, 
        // though slices without ptrs are kinda tricky. Just returning Null for choice/enum fallback.
        _ => Expr::Null { span },
    }
}
