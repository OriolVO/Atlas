use std::collections::HashMap;
use crate::error::{AtlasError, Span};
use crate::typechecker::{AtlasType, FnSignature, TypedAST, StructType, ClassType, EnumType, ChoiceType, resolve_type};
use crate::parser::{
    SourceFile, Item, ExternFnDecl, Stmt, Block, Expr, BinOp, UnaryOp, IfStmt, WhileStmt, Pattern, TypeExpr
};

mod support;

use self::support::*;
