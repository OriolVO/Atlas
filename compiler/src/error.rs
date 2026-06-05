use miette::{Diagnostic, SourceSpan};
use serde::{Deserialize, Serialize};
use thiserror::Error;

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize)]
pub struct Span {
    pub start: usize,
    pub end: usize,
}

impl Span {
    pub fn new(start: usize, end: usize) -> Self {
        Self { start, end }
    }

    pub fn to_source_span(&self) -> SourceSpan {
        SourceSpan::new(self.start.into(), self.end - self.start)
    }
}

impl From<Span> for SourceSpan {
    fn from(span: Span) -> Self {
        span.to_source_span()
    }
}

impl From<std::ops::Range<usize>> for Span {
    fn from(range: std::ops::Range<usize>) -> Self {
        Self::new(range.start, range.end)
    }
}

#[derive(Debug, Error, Diagnostic, Clone, PartialEq, Eq, Serialize, Deserialize)]
pub enum AtlasError {
    #[error("lexer error: {message}")]
    #[diagnostic(code(atlas::lex_error))]
    LexError {
        #[label("here")]
        span: Span,
        message: String,
    },

    #[error("parser error: {message}")]
    #[diagnostic(code(atlas::parse_error))]
    ParseError {
        #[label("here")]
        span: Span,
        message: String,
        #[help]
        hint: Option<String>,
    },

    #[error("type error: {message}")]
    #[diagnostic(code(atlas::type_error))]
    TypeError {
        #[label("here")]
        span: Span,
        message: String,
        #[help]
        hint: Option<String>,
    },

    #[error("codegen error: {message}")]
    #[diagnostic(code(atlas::codegen_error))]
    CodegenError {
        message: String,
    },
}

pub type AtlasResult<T> = Result<T, AtlasError>;
