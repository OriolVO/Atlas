use crate::error::{AtlasError, Span};
use logos::Logos;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize)]
pub enum IntSuffix {
    I8,
    I16,
    I32,
    I64,
    U8,
    U16,
    U32,
    U64,
}

#[derive(Logos, Debug, Clone, PartialEq, Serialize, Deserialize)]
#[logos(skip r"[ \t\n\r]+")]
#[logos(skip r"//[^\n]*")]
pub enum Token {
    #[regex("[0-9]+[a-zA-Z0-9]*", parse_int)]
    IntLiteral((i64, Option<IntSuffix>)),

    #[regex("[0-9]+\\.[0-9]+", |lex| lex.slice().parse::<f64>().ok())]
    FloatLiteral(f64),

    #[token("true", |_| true)]
    #[token("false", |_| false)]
    BoolLiteral(bool),

    #[regex("'([^'\\\\]|\\\\.)*'", parse_char)]
    CharLiteral(char),

    #[regex("\"([^\"\\n\\\\]|\\\\.)*\"", parse_string)]
    StringLiteral(String),

    // Keywords
    #[token("var")]
    Var,
    #[token("const")]
    Const,
    #[token("fn")]
    Fn,
    #[token("struct")]
    Struct,
    #[token("class")]
    Class,
    #[token("enum")]
    Enum,
    #[token("choice")]
    Choice,
    #[token("match")]
    Match,
    #[token("if")]
    If,
    #[token("else")]
    Else,
    #[token("while")]
    While,
    #[token("break")]
    Break,
    #[token("continue")]
    Continue,
    #[token("return")]
    Return,
    #[token("import")]
    Import,
    #[token("export")]
    Export,
    #[token("public")]
    Public,
    #[token("private")]
    Private,
    #[token("where")]
    Where,
    #[token("as")]
    As,
    #[token("and")]
    And,
    #[token("or")]
    Or,
    #[token("not")]
    Not,
    #[token("extern")]
    Extern,
    #[token("self")]
    SelfToken,
    #[token("null")]
    Null,

    // Primitive Type Keywords
    #[token("int")]
    Int,
    #[token("uint")]
    Uint,
    #[token("int8")]
    Int8,
    #[token("int16")]
    Int16,
    #[token("int32")]
    Int32,
    #[token("int64")]
    Int64,
    #[token("uint8")]
    Uint8,
    #[token("uint16")]
    Uint16,
    #[token("uint32")]
    Uint32,
    #[token("uint64")]
    Uint64,
    #[token("float")]
    Float,
    #[token("float32")]
    Float32,
    #[token("float64")]
    Float64,
    #[token("bool")]
    Bool,
    #[token("char")]
    Char,

    // Operators & Punctuation
    #[token("+")]
    Plus,
    #[token("-")]
    Minus,
    #[token("*")]
    Star,
    #[token("/")]
    Slash,
    #[token("%")]
    Percent,
    #[token("==")]
    Eq,
    #[token("!=")]
    NotEq,
    #[token("<=")]
    LtEq,
    #[token(">=")]
    GtEq,
    #[token("<")]
    Lt,
    #[token(">")]
    Gt,
    #[token("=")]
    Assign,
    #[token("!")]
    Bang,
    #[token("&&")]
    Ampersand,
    #[token("||")]
    Pipe,
    #[token("@")]
    At,
    #[token("?")]
    Question,
    #[token("::")]
    ColonColon,
    #[token(":")]
    Colon,
    #[token(";")]
    Semicolon,
    #[token(",")]
    Comma,
    #[token("...")]
    Ellipsis,
    #[token(".")]
    Dot,
    #[token("=>")]
    Arrow,
    #[token("(")]
    LParen,
    #[token(")")]
    RParen,
    #[token("{")]
    LBrace,
    #[token("}")]
    RBrace,
    #[token("[")]
    LBracket,
    #[token("]")]
    RBracket,

    #[regex("[a-zA-Z_][a-zA-Z0-9_]*", |lex| lex.slice().to_string())]
    Identifier(String),

    #[token("/*", block_comment)]
    UnterminatedBlockComment,

    Eof,
}

fn parse_int(lex: &mut logos::Lexer<Token>) -> Option<(i64, Option<IntSuffix>)> {
    let slice = lex.slice();
    let mut digits = String::new();
    let mut suffix = String::new();
    let mut in_suffix = false;
    for c in slice.chars() {
        if c.is_ascii_digit() && !in_suffix {
            digits.push(c);
        } else {
            in_suffix = true;
            suffix.push(c);
        }
    }
    
    let val = digits.parse::<i64>().ok()?;
    let suffix_opt = if suffix.is_empty() {
        None
    } else {
        match suffix.as_str() {
            "i8" | "int8" => Some(IntSuffix::I8),
            "i16" | "int16" => Some(IntSuffix::I16),
            "i32" | "int32" => Some(IntSuffix::I32),
            "i64" | "int64" => Some(IntSuffix::I64),
            "u8" | "uint8" => Some(IntSuffix::U8),
            "u16" | "uint16" => Some(IntSuffix::U16),
            "u32" | "uint32" => Some(IntSuffix::U32),
            "u64" | "uint64" => Some(IntSuffix::U64),
            _ => return None,
        }
    };
    Some((val, suffix_opt))
}

fn parse_char(lex: &mut logos::Lexer<Token>) -> Option<char> {
    let s = lex.slice();
    if s.len() < 3 {
        return None;
    }
    let inner = &s[1..s.len()-1];
    if let Some(stripped) = inner.strip_prefix('\\') {
        if stripped.len() != 1 {
            return None;
        }
        match stripped {
            "n" => Some('\n'),
            "t" => Some('\t'),
            "r" => Some('\r'),
            "0" => Some('\0'),
            "\\" => Some('\\'),
            "'" => Some('\''),
            _ => None,
        }
    } else {
        if inner.chars().count() != 1 {
            return None;
        }
        inner.chars().next()
    }
}

fn parse_string(lex: &mut logos::Lexer<Token>) -> Option<String> {
    let s = lex.slice();
    let inner = &s[1..s.len()-1];
    let mut result = String::new();
    let mut chars = inner.chars().peekable();
    while let Some(c) = chars.next() {
        if c == '\\' {
            match chars.next() {
                Some('n') => result.push('\n'),
                Some('t') => result.push('\t'),
                Some('r') => result.push('\r'),
                Some('0') => result.push('\0'),
                Some('\\') => result.push('\\'),
                Some('"') => result.push('"'),
                _ => return None,
            }
        } else {
            result.push(c);
        }
    }
    Some(result)
}

fn block_comment(lex: &mut logos::Lexer<Token>) -> logos::Filter<Token> {
    let mut depth = 1;
    let remainder = lex.remainder();
    let mut bytes = remainder.bytes().enumerate();
    let mut end_idx = 0;
    while let Some((i, b)) = bytes.next() {
        if b == b'/' {
            if let Some((_, next_b)) = bytes.clone().next() {
                if next_b == b'*' {
                    bytes.next();
                    depth += 1;
                }
            }
        } else if b == b'*' {
            if let Some((_, next_b)) = bytes.clone().next() {
                if next_b == b'/' {
                    bytes.next();
                    depth -= 1;
                    if depth == 0 {
                        end_idx = i + 2;
                        break;
                    }
                }
            }
        }
    }
    if depth == 0 {
        lex.bump(end_idx);
        logos::Filter::Skip
    } else {
        lex.bump(remainder.len());
        logos::Filter::Emit(Token::UnterminatedBlockComment)
    }
}

fn handle_lex_error(source: &str, span: std::ops::Range<usize>) -> AtlasError {
    let slice = &source[span.clone()];
    let first_char = slice.chars().next();
    
    let message = if let Some(c) = first_char {
        if c.is_ascii_digit() {
            format!("invalid numeric literal or suffix in '{}'", slice)
        } else if c == '\'' {
            format!("invalid character literal '{}'", slice)
        } else if c == '"' {
            "invalid or unterminated string literal".to_string()
        } else {
            format!("unexpected character '{}'", c)
        }
    } else {
        "unexpected end of input".to_string()
    };
    
    AtlasError::LexError {
        span: Span::new(span.start, span.end),
        message,
    }
}

pub type Spanned<T> = (T, Span);

pub struct Lexer<'src> {
    source: &'src str,
    inner: logos::Lexer<'src, Token>,
}

impl<'src> Lexer<'src> {
    pub fn new(source: &'src str) -> Self {
        Self {
            source,
            inner: Token::lexer(source),
        }
    }

    pub fn tokenize(mut self) -> (Vec<Spanned<Token>>, Vec<AtlasError>) {
        let mut tokens = Vec::new();
        let mut errors = Vec::new();

        // Add rules for skipping whitespace and line comments
        // logos parses these implicitly using macros/attributes, but let's iterate next()
        while let Some(res) = self.inner.next() {
            let span = Span::from(self.inner.span());
            match res {
                Ok(token) => {
                    if token == Token::UnterminatedBlockComment {
                        errors.push(AtlasError::LexError {
                            span,
                            message: "unterminated block comment".to_string(),
                        });
                    } else {
                        tokens.push((token, span));
                    }
                }
                Err(_) => {
                    let range = self.inner.span();
                    let err = handle_lex_error(self.source, range);
                    errors.push(err);
                }
            }
        }

        let eof_span = Span::new(self.source.len(), self.source.len());
        tokens.push((Token::Eof, eof_span));

        (tokens, errors)
    }
}

// Add Logos rules for skipped elements at the Token enum level
// logos doesn't compile unless skip rules are defined on the Token enum or at module level.
// Let's make sure we have skip rules. In logos, skip rules are simple regexes with logos::skip callbacks.
// Since logos macros check all attributes, we already have logos::skip on some things, but wait!
// Did we define them in the Token enum? Ah, we can define them as attributes on the Token enum!
// Let's do that to ensure it compiles correctly.
impl Token {
    // Helper to check if a token is a keyword or type keyword etc. if needed
}
