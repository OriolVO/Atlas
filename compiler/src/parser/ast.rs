use crate::error::Span;
use crate::lexer::{IntSuffix, Spanned};
use serde::{Deserialize, Serialize};

// ==========================================
// AST Definitions
// ==========================================

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct SourceFile {
    pub items: Vec<Item>,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize)]
pub struct ExprId(pub u64);

impl ExprId {
    pub fn from_span(span: Span) -> Self {
        Self(((span.start as u64) << 32) | (span.end as u64))
    }
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub enum Item {
    FunctionDecl(FunctionDecl, bool),
    ExternFnDecl(ExternFnDecl, bool),
    StructDecl(StructDecl, bool),
    ClassDecl(ClassDecl, bool),
    EnumDecl(EnumDecl, bool),
    ChoiceDecl(ChoiceDecl, bool),
    Import(Spanned<String>),
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct EnumDecl {
    pub name: Spanned<String>,
    pub variants: Vec<Spanned<String>>,
    pub span: Span,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct ChoiceVariant {
    pub name: Spanned<String>,
    pub payload: Option<Spanned<TypeExpr>>,
    pub span: Span,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct ChoiceDecl {
    pub name: Spanned<String>,
    pub generic_params: Vec<Spanned<String>>,
    pub variants: Vec<ChoiceVariant>,
    pub span: Span,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
pub enum Visibility {
    Public,
    Private,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct WhereClause {
    pub target: Spanned<String>,
    pub constraints: Vec<ConstraintSignature>,
    pub span: Span,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct ConstraintSignature {
    pub name: Spanned<String>,
    pub params: Vec<Param>,
    pub ret_ty: Option<Spanned<TypeExpr>>,
    pub span: Span,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct ClassDecl {
    pub name: Spanned<String>,
    pub generic_params: Vec<Spanned<String>>,
    pub where_clauses: Vec<WhereClause>,
    pub fields: Vec<ClassField>,
    pub methods: Vec<ClassMethod>,
    pub structs: Vec<ClassStruct>,
    pub span: Span,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct ClassField {
    pub visibility: Visibility,
    pub is_const: bool,
    pub name: Spanned<String>,
    pub ty: Spanned<TypeExpr>,
    pub span: Span,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct ClassMethod {
    pub visibility: Visibility,
    pub decl: FunctionDecl,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct ClassStruct {
    pub visibility: Visibility,
    pub decl: StructDecl,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct StructDecl {
    pub name: Spanned<String>,
    pub fields: Vec<FieldDecl>,
    pub span: Span,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct FieldDecl {
    pub name: Spanned<String>,
    pub ty: Spanned<TypeExpr>,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct FunctionDecl {
    pub name: Spanned<String>,
    pub generic_params: Vec<Spanned<String>>,
    pub params: Vec<Param>,
    pub ret_ty: Option<Spanned<TypeExpr>>,
    pub where_clauses: Vec<WhereClause>,
    pub body: Block,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Param {
    pub name: Spanned<String>,
    pub ty: Spanned<TypeExpr>,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Block {
    pub stmts: Vec<Stmt>,
    pub span: Span,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub enum Stmt {
    VarDecl(VarDecl),
    ConstDecl(ConstDecl),
    Assign(Assign),
    ExprStmt(Expr),
    Return(Option<Expr>, Span),
    If(IfStmt),
    While(WhileStmt),
    Block(Block),
    StructDecl(StructDecl),
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct VarDecl {
    pub name: Spanned<String>,
    pub ty_hint: Option<Spanned<TypeExpr>>,
    pub init: Option<Expr>,
    pub span: Span,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct ConstDecl {
    pub name: Spanned<String>,
    pub ty_hint: Option<Spanned<TypeExpr>>,
    pub init: Expr,
    pub span: Span,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub enum Expr {
    IntLit {
        value: i64,
        suffix: Option<IntSuffix>,
        span: Span,
    },
    FloatLit {
        value: f64,
        span: Span,
    },
    BoolLit {
        value: bool,
        span: Span,
    },
    CharLit {
        value: char,
        span: Span,
    },
    StringLit {
        value: String,
        span: Span,
    },
    Var {
        name: String,
        span: Span,
    },
    Binary {
        op: BinOp,
        lhs: Box<Expr>,
        rhs: Box<Expr>,
        span: Span,
    },
    Unary {
        op: UnaryOp,
        operand: Box<Expr>,
        span: Span,
    },
    Group {
        inner: Box<Expr>,
        span: Span,
    },
    Call {
        callee: String,
        args: Vec<Expr>,
        span: Span,
    },
    GenericCall {
        callee: String,
        type_args: Vec<Spanned<TypeExpr>>,
        args: Vec<Expr>,
        span: Span,
    },
    StructInit {
        struct_name: String,
        fields: Vec<(Spanned<String>, Expr)>,
        span: Span,
    },
    MemberAccess {
        object: Box<Expr>,
        member: String,
        span: Span,
    },
    MethodCall {
        object: Box<Expr>,
        method_name: String,
        args: Vec<Expr>,
        span: Span,
    },
    StaticCall {
        class_name: String,
        method_name: String,
        args: Vec<Expr>,
        span: Span,
    },
    GenericStaticCall {
        class_name: String,
        method_name: String,
        type_args: Vec<Spanned<TypeExpr>>,
        args: Vec<Expr>,
        span: Span,
    },
    SizeOf {
        ty: Spanned<TypeExpr>,
        span: Span,
    },
    Cast {
        target_ty: Spanned<TypeExpr>,
        expr: Box<Expr>,
        span: Span,
    },
    Destroy {
        type_arg: Box<TypeExpr>,
        expr: Box<Expr>,
        span: Span,
    },
    ArrayLit {
        elements: Vec<Expr>,
        span: Span,
    },
    ArrayIndex {
        array: Box<Expr>,
        index: Box<Expr>,
        span: Span,
    },
    Null {
        span: Span,
    },
    Match {
        expr: Box<Expr>,
        cases: Vec<MatchCase>,
        span: Span,
    },
    ErrorPropagate {
        expr: Box<Expr>,
        span: Span,
    },
    StaticMember {
        class_name: String,
        member_name: String,
        span: Span,
    },
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct MatchCase {
    pub pattern: Pattern,
    pub body: Block,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub enum Pattern {
    Variant {
        path: Vec<String>,
        bind: Option<Spanned<String>>,
        span: Span,
    },
    Discard(Span),
    Literal(Expr, Span),
}

impl Pattern {
    pub fn span(&self) -> Span {
        match self {
            Pattern::Variant { span, .. } => *span,
            Pattern::Discard(span) => *span,
            Pattern::Literal(_, span) => *span,
        }
    }
}


#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
pub enum BinOp {
    Add, Sub, Mul, Div, Mod,
    Eq, NotEq, Lt, Gt, LtEq, GtEq,
    And, Or,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
pub enum UnaryOp {
    Neg,
    Not,
    AddressOf,
    Dereference,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub enum TypeExpr {
    Named(String),
    Pointer {
        target: Box<TypeExpr>,
        nullable: bool,
        span: Span,
    },
    Array {
        element: Box<TypeExpr>,
        size: usize,
        span: Span,
    },
    Slice {
        element: Box<TypeExpr>,
        span: Span,
    },
    Generic {
        base: String,
        args: Vec<TypeExpr>,
        span: Span,
    },
}


impl Expr {
    pub fn id(&self) -> ExprId {
        ExprId::from_span(self.span())
    }

    pub fn span(&self) -> Span {
        match self {
            Expr::IntLit { span, .. } => *span,
            Expr::FloatLit { span, .. } => *span,
            Expr::BoolLit { span, .. } => *span,
            Expr::CharLit { span, .. } => *span,
            Expr::StringLit { span, .. } => *span,
            Expr::Var { span, .. } => *span,
            Expr::Binary { span, .. } => *span,
            Expr::Unary { span, .. } => *span,
            Expr::Group { span, .. } => *span,
            Expr::Call { span, .. } => *span,
            Expr::GenericCall { span, .. } => *span,
            Expr::StructInit { span, .. } => *span,
            Expr::MemberAccess { span, .. } => *span,
            Expr::MethodCall { span, .. } => *span,
            Expr::StaticCall { span, .. } => *span,
            Expr::GenericStaticCall { span, .. } => *span,
            Expr::SizeOf { span, .. } => *span,
            Expr::Cast { span, .. } => *span,
            Expr::Destroy { span, .. } => *span,
            Expr::ArrayLit { span, .. } => *span,
            Expr::ArrayIndex { span, .. } => *span,
            Expr::Null { span, .. } => *span,
            Expr::Match { span, .. } => *span,
            Expr::ErrorPropagate { span, .. } => *span,
            Expr::StaticMember { span, .. } => *span,
        }
    }
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct ExternFnDecl {
    pub abi: String,
    pub name: Spanned<String>,
    pub params: Vec<Param>,
    pub is_variadic: bool,
    pub ret_ty: Option<Spanned<TypeExpr>>,
    pub span: Span,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Assign {
    pub target: Expr,
    pub value: Expr,
    pub span: Span,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct IfStmt {
    pub condition: Expr,
    pub then_block: Block,
    pub else_if_clauses: Vec<(Expr, Block)>,
    pub else_block: Option<Block>,
    pub span: Span,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct WhileStmt {
    pub condition: Expr,
    pub body: Block,
    pub span: Span,
}
