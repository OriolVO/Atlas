use atlas::lexer::Lexer;

macro_rules! assert_lexer_snapshot {
    ($name:ident, $input:expr) => {
        #[test]
        fn $name() {
            let lexer = Lexer::new($input);
            let (tokens, errors) = lexer.tokenize();
            if errors.is_empty() {
                insta::assert_ron_snapshot!(tokens);
            } else {
                insta::assert_ron_snapshot!(errors);
            }
        }
    };
}

assert_lexer_snapshot!(lex_integer_literal, "42");
assert_lexer_snapshot!(lex_float_literal, "3.14");
assert_lexer_snapshot!(lex_bool_literals, "true false");
assert_lexer_snapshot!(lex_char_literal, "'a'");
assert_lexer_snapshot!(lex_string_literal, "\"hello\"");
assert_lexer_snapshot!(lex_all_keywords, "var const fn struct class enum choice match if else while return import export public private where as and or not extern self null");
assert_lexer_snapshot!(lex_arithmetic_expr, "a + b * c");
assert_lexer_snapshot!(lex_comparison, "x >= 10");
assert_lexer_snapshot!(lex_bool_ops, "a and b or not c");
assert_lexer_snapshot!(lex_line_comment, "// comment\n42");
assert_lexer_snapshot!(lex_block_comment, "/* block */42");
assert_lexer_snapshot!(lex_var_decl, "var x: int32 = 10;");
assert_lexer_snapshot!(lex_fn_signature, "fn add(a: int, b: int): int {");
assert_lexer_snapshot!(lex_unknown_char, "$");
assert_lexer_snapshot!(lex_unterminated_string, "\"hello");
