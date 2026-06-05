#![allow(dead_code, unused_imports)]

use std::collections::HashMap;
use crate::error::{AtlasError, Span};
use crate::typechecker::{AtlasType, FnSignature, TypedAST, StructType, ClassType, EnumType, ChoiceType, resolve_type};
use crate::parser::{
    SourceFile, Item, ExternFnDecl, Stmt, Block, Expr, ExprId, BinOp, UnaryOp, IfStmt, WhileStmt, Pattern, TypeExpr
};

#[allow(dead_code)]
fn mangle_type(ty: &AtlasType) -> String {
    match ty {
        AtlasType::Int => "int".to_string(),
        AtlasType::Uint => "uint".to_string(),
        AtlasType::Int64 => "int64".to_string(),
        AtlasType::Uint64 => "uint64".to_string(),
        AtlasType::Int32 => "int32".to_string(),
        AtlasType::Uint32 => "uint32".to_string(),
        AtlasType::Int16 => "int16".to_string(),
        AtlasType::Uint16 => "uint16".to_string(),
        AtlasType::Int8 => "int8".to_string(),
        AtlasType::Uint8 => "uint8".to_string(),
        AtlasType::Char => "char".to_string(),
        AtlasType::Float => "float".to_string(),
        AtlasType::Float64 => "float64".to_string(),
        AtlasType::Float32 => "float32".to_string(),
        AtlasType::Bool => "bool".to_string(),
        AtlasType::Void => "void".to_string(),

        AtlasType::Struct(n) => format!("struct_{}", n),
        AtlasType::Class(n) => format!("class_{}", n),
        AtlasType::Pointer { target, .. } => format!("ptr_{}", mangle_type(target)),
        AtlasType::Array { element, size } => format!("arr_{}_{}", size, mangle_type(element)),
        AtlasType::Slice(element) => format!("slice_{}", mangle_type(element)),
        AtlasType::Enum(n) => format!("enum_{}", n),
        AtlasType::Choice(n) => format!("choice_{}", n),
        AtlasType::Null => "null".to_string(),
        AtlasType::GenericPlaceholder(n) => format!("gp_{}", n),
    }
}

fn map_type(ty: &AtlasType) -> String {
    match ty {
        AtlasType::Int | AtlasType::Uint | AtlasType::Int64 | AtlasType::Uint64 => "i64".to_string(),
        AtlasType::Int32 | AtlasType::Uint32 => "i32".to_string(),
        AtlasType::Int16 | AtlasType::Uint16 => "i16".to_string(),
        AtlasType::Int8 | AtlasType::Uint8 | AtlasType::Char => "i8".to_string(),
        AtlasType::Float | AtlasType::Float64 => "double".to_string(),
        AtlasType::Float32 => "float".to_string(),
        AtlasType::Bool => "i1".to_string(),
        AtlasType::Void => "void".to_string(),

        AtlasType::Struct(name) => format!("%struct.{}", name),
        AtlasType::Class(name) => format!("%class.{}", name),
        AtlasType::Pointer { target, .. } => {
            let target_str = map_type(target);
            format!("{}*", target_str)
        }
        AtlasType::Array { element, size } => {
            let elem_str = map_type(element);
            format!("[{} x {}]", size, elem_str)
        }
        AtlasType::Slice(element) => {
            let elem_str = map_type(element);
            format!("{{ {}*, i64 }}", elem_str)
        }
        AtlasType::Enum(_) => "i32".to_string(),
        AtlasType::Choice(name) => format!("%choice.{}", name),
        AtlasType::Null => "i8*".to_string(),
        AtlasType::GenericPlaceholder(_) => "i8*".to_string(),
    }
}

#[derive(Clone)]
struct ScopeVar {
    name: String,
    reg: String,
    ty: AtlasType,
}

#[derive(Clone)]
struct Scope {
    map: HashMap<String, (String, String)>,
    ordered_vars: Vec<ScopeVar>,
}

impl Scope {
    fn new() -> Self {
        Self {
            map: HashMap::new(),
            ordered_vars: Vec::new(),
        }
    }

    fn insert(&mut self, name: String, reg: String, llvm_ty: String, ty: AtlasType) {
        self.map.insert(name.clone(), (reg.clone(), llvm_ty));
        self.ordered_vars.push(ScopeVar { name, reg, ty });
    }

    fn get(&self, name: &str) -> Option<&(String, String)> {
        self.map.get(name)
    }
}

pub struct Codegen {
    output: String,
    alloca_buf: String,
    temp_counter: usize,
    label_counter: usize,
    str_counter: usize,
    var_counter: usize,
    globals: String,
    scopes: Vec<Scope>,
    fn_sigs: HashMap<String, FnSignature>,
    expr_types: HashMap<ExprId, AtlasType>,
    structs: HashMap<String, StructType>,
    classes: HashMap<String, ClassType>,
    has_terminator: bool,
    current_ret_ty: Option<AtlasType>,
    enums: HashMap<String, EnumType>,
    choices: HashMap<String, ChoiceType>,
    mangled_calls: HashMap<Span, String>,
    overloaded_operators: HashMap<ExprId, String>,
}
