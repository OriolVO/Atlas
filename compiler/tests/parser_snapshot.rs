use atlas::lexer::Lexer;
use atlas::parser::{Parser, Expr, Stmt, SourceFile};
use atlas::error::AtlasError;

fn parse_expr_helper(input: &str) -> Result<Expr, Vec<AtlasError>> {
    let (tokens, lex_errors) = Lexer::new(input).tokenize();
    assert!(lex_errors.is_empty(), "Lex errors in expr input: {:?}", lex_errors);
    let mut parser = Parser::new(&tokens);
    let expr = parser.parse_expr(0);
    let errors = parser.errors().to_vec();
    if errors.is_empty() {
        Ok(expr.expect("expected expression"))
    } else {
        Err(errors)
    }
}

fn parse_stmt_helper(input: &str) -> Result<Stmt, Vec<AtlasError>> {
    let (tokens, lex_errors) = Lexer::new(input).tokenize();
    assert!(lex_errors.is_empty(), "Lex errors in stmt input: {:?}", lex_errors);
    let mut parser = Parser::new(&tokens);
    let stmt = parser.parse_stmt();
    let errors = parser.errors().to_vec();
    if errors.is_empty() {
        Ok(stmt.expect("expected statement"))
    } else {
        Err(errors)
    }
}

fn parse_file_helper(input: &str) -> Result<SourceFile, Vec<AtlasError>> {
    let (tokens, lex_errors) = Lexer::new(input).tokenize();
    assert!(lex_errors.is_empty(), "Lex errors in file input: {:?}", lex_errors);
    let parser = Parser::new(&tokens);
    let (ast, errors) = parser.parse_file();
    if errors.is_empty() {
        Ok(ast)
    } else {
        Err(errors)
    }
}

#[test]
fn parse_int_literal() {
    let res = parse_expr_helper("42");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_binary_add() {
    let res = parse_expr_helper("1 + 2");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_precedence() {
    let res = parse_expr_helper("1 + 2 * 3");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_unary_neg() {
    let res = parse_expr_helper("-5");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_bool_and() {
    let res = parse_expr_helper("a and b");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_grouping() {
    let res = parse_expr_helper("(1 + 2) * 3");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_var_decl() {
    let res = parse_stmt_helper("var x = 10;");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_typed_var() {
    let res = parse_stmt_helper("var x: int32 = 10;");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_const_decl() {
    let res = parse_stmt_helper("const MAX = 100;");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_fn_decl() {
    let res = parse_file_helper("fn add(a: int, b: int): int { return a + b; }");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_fn_no_return() {
    let res = parse_file_helper("fn greet() { }");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_return_stmt() {
    let res = parse_stmt_helper("return x;");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_bare_return() {
    let res = parse_stmt_helper("return;");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_parse_error() {
    // This statement is invalid, parser will return parsing errors
    let res = parse_stmt_helper("var = 10;");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_if_stmt() {
    let res = parse_stmt_helper("if x > 0 { return 1; }");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_if_else() {
    let res = parse_stmt_helper("if x > 0 { return 1; } else { return 0; }");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_if_else_if() {
    let res = parse_stmt_helper("if x > 0 { return 1; } else if x == 0 { return 0; } else { return -1; }");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_while_stmt() {
    let res = parse_stmt_helper("while x < 10 { x = x + 1; }");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_fn_call() {
    let res = parse_expr_helper("foo(1, 2)");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_assign() {
    let res = parse_stmt_helper("x = 10;");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_extern_fn() {
    let res = parse_file_helper("extern \"C\" fn putchar(c: int32): int32;");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_variadic_extern_fn() {
    let res = parse_file_helper("extern \"C\" fn printf(format: @char, ...): int32;");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_ellipsis_outside_extern_is_error() {
    let res = parse_file_helper("fn bad(...): int { return 0; }");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_generic_class() {
    let res = parse_file_helper("class Array<T> { public data: @T; public len: int; }");
    insta::assert_ron_snapshot!(res);
}

#[test]
fn parse_generic_fn_with_where() {
    let res = parse_file_helper("fn print<T>(value: T) where T ( fn format(self): String; ) { }");
    insta::assert_ron_snapshot!(res);
}
