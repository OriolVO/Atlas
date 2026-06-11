use crate::error::{AtlasError, Span};
use crate::lexer::{Token, Spanned};
use super::ast::*;

pub struct Parser<'src> {
    tokens: &'src [Spanned<Token>],
    cursor: usize,
    errors: Vec<AtlasError>,
}

impl<'src> Parser<'src> {
    pub fn new(tokens: &'src [Spanned<Token>]) -> Self {
        Self {
            tokens,
            cursor: 0,
            errors: Vec::new(),
        }
    }

    pub fn errors(&self) -> &[AtlasError] {
        &self.errors
    }

    pub fn parse_file(mut self) -> (SourceFile, Vec<AtlasError>) {
        let mut items = Vec::new();
        while self.peek() != &Token::Eof {
            if let Some(item) = self.parse_item() {
                items.push(item);
            } else {
                let start_cursor = self.cursor;
                self.synchronize();
                if self.cursor == start_cursor {
                    self.advance();
                }
            }
        }
        (SourceFile { items }, self.errors)
    }

    fn parse_item(&mut self) -> Option<Item> {
        let is_exported = if self.peek() == &Token::Export {
            self.advance();
            true
        } else {
            false
        };
        match self.peek() {
            Token::Import => {
                let decl = self.parse_import()?;
                Some(Item::Import(decl))
            }
            Token::Class => {
                let decl = self.parse_class_decl()?;
                Some(Item::ClassDecl(decl, is_exported))
            }
            Token::Fn => {
                let decl = self.parse_fn_decl()?;
                Some(Item::FunctionDecl(decl, is_exported))
            }
            Token::Extern => {
                let decl = self.parse_extern_fn()?;
                Some(Item::ExternFnDecl(decl, is_exported))
            }
            Token::Struct => {
                let decl = self.parse_struct_decl()?;
                Some(Item::StructDecl(decl, is_exported))
            }
            Token::Enum => {
                let decl = self.parse_enum_decl()?;
                Some(Item::EnumDecl(decl, is_exported))
            }
            Token::Choice => {
                let decl = self.parse_choice_decl()?;
                Some(Item::ChoiceDecl(decl, is_exported))
            }
            token => {
                let span = self.peek_span();
                self.errors.push(AtlasError::ParseError {
                    span,
                    message: format!("expected top-level item (e.g. fn, struct, class, import, extern), found '{:?}'", token),
                    hint: Some("Functions, structs, classes, imports, and extern declarations are valid top-level items".to_string()),
                });
                None
            }
        }
    }

    fn parse_extern_fn(&mut self) -> Option<ExternFnDecl> {
        let start_span = self.expect(&Token::Extern)?;
        let (abi_tok, _) = self.advance()?;
        let abi = match abi_tok {
            Token::StringLiteral(s) => s,
            t => {
                let span = self.peek_span();
                self.errors.push(AtlasError::ParseError {
                    span,
                    message: format!("expected ABI string (e.g. \"C\"), found '{:?}'", t),
                    hint: None,
                });
                return None;
            }
        };
        if abi != "C" {
            let span = self.peek_span();
            self.errors.push(AtlasError::ParseError {
                span,
                message: format!("only 'C' ABI is supported, found '{}'", abi),
                hint: None,
            });
            return None;
        }

        self.expect(&Token::Fn)?;
        let name = self.expect_identifier()?;
        self.expect(&Token::LParen)?;
        let (params, is_variadic) = self.parse_extern_param_list()?;
        self.expect(&Token::RParen)?;

        let ret_ty = if self.peek() == &Token::Colon {
            self.advance();
            let ty = self.parse_type_expr()?;
            Some(ty)
        } else {
            None
        };

        let semi_span = self.expect(&Token::Semicolon)?;
        Some(ExternFnDecl {
            abi,
            name,
            params,
            is_variadic,
            ret_ty,
            span: Span::new(start_span.start, semi_span.end),
        })
    }

    fn parse_extern_param_list(&mut self) -> Option<(Vec<Param>, bool)> {
        let mut params = Vec::new();
        let mut is_variadic = false;

        if self.peek() == &Token::RParen {
            return Some((params, false));
        }

        if self.peek() == &Token::Ellipsis {
            self.advance();
            return Some((params, true));
        }

        loop {
            params.push(self.parse_param()?);

            if self.peek() != &Token::Comma {
                break;
            }
            self.advance();

            if self.peek() == &Token::Ellipsis {
                self.advance();
                is_variadic = true;
                break;
            }
        }

        Some((params, is_variadic))
    }

    fn parse_struct_decl(&mut self) -> Option<StructDecl> {
        let start_span = self.expect(&Token::Struct)?;
        let name = self.expect_identifier()?;
        self.expect(&Token::LBrace)?;
        let mut fields = Vec::new();
        while self.peek() != &Token::RBrace && self.peek() != &Token::Eof {
            let field_name = self.expect_identifier()?;
            self.expect(&Token::Colon)?;
            let field_ty = self.parse_type_expr()?;
            self.expect(&Token::Semicolon)?;
            fields.push(FieldDecl { name: field_name, ty: field_ty });
        }
        let end_span = self.expect(&Token::RBrace)?;
        Some(StructDecl {
            name,
            fields,
            span: Span::new(start_span.start, end_span.end),
        })
    }

    fn parse_enum_decl(&mut self) -> Option<EnumDecl> {
        let start_span = self.peek_span();
        self.expect(&Token::Enum)?;
        let name = self.expect_identifier()?;
        self.expect(&Token::LBrace)?;
        let mut variants = Vec::new();
        if self.peek() != &Token::RBrace {
            loop {
                let var_name = self.expect_identifier()?;
                variants.push(var_name);
                if self.peek() == &Token::Comma {
                    self.advance();
                } else {
                    break;
                }
            }
        }
        let end_span = self.expect(&Token::RBrace)?;
        let span = Span::new(start_span.start, end_span.end);
        Some(EnumDecl { name, variants, span })
    }

    fn parse_choice_decl(&mut self) -> Option<ChoiceDecl> {
        let start_span = self.peek_span();
        self.expect(&Token::Choice)?;
        let name = self.expect_identifier()?;
        let mut generic_params = Vec::new();
        if self.peek() == &Token::Lt {
            self.advance();
            loop {
                let param = self.expect_identifier()?;
                generic_params.push(param);
                if self.peek() == &Token::Comma {
                    self.advance();
                } else {
                    break;
                }
            }
            self.expect(&Token::Gt)?;
        }
        self.expect(&Token::LBrace)?;
        let mut variants = Vec::new();
        if self.peek() != &Token::RBrace {
            loop {
                let v_start_span = self.peek_span();
                let v_name = self.expect_identifier()?;
                let mut payload = None;
                if self.peek() == &Token::LParen {
                    self.advance(); // consume `(`
                    let ty = self.parse_type_expr()?;
                    self.expect(&Token::RParen)?;
                    payload = Some(ty);
                }
                let v_end_span = self.peek_span();
                variants.push(ChoiceVariant {
                    name: v_name,
                    payload,
                    span: Span::new(v_start_span.start, v_end_span.end),
                });
                if self.peek() == &Token::Comma {
                    self.advance();
                } else {
                    break;
                }
            }
        }
        let end_span = self.expect(&Token::RBrace)?;
        let span = Span::new(start_span.start, end_span.end);
        Some(ChoiceDecl {
            name,
            generic_params,
            variants,
            span,
        })
    }

    fn parse_import(&mut self) -> Option<Spanned<String>> {
        self.expect(&Token::Import)?;
        let first = self.expect_identifier()?;
        let mut name = first.0;
        let mut span = first.1;
        while self.peek() == &Token::Dot {
            self.advance();
            let next = self.expect_identifier()?;
            name.push('.');
            name.push_str(&next.0);
            span.end = next.1.end;
        }
        self.expect(&Token::Semicolon)?;
        Some((name, span))
    }

    fn parse_class_decl(&mut self) -> Option<ClassDecl> {
        let start_span = self.expect(&Token::Class)?;
        let name = self.expect_identifier()?;
        let mut generic_params = Vec::new();
        if self.peek() == &Token::Lt {
            self.advance();
            loop {
                let param = self.expect_identifier()?;
                generic_params.push(param);
                if self.peek() == &Token::Comma {
                    self.advance();
                } else {
                    break;
                }
            }
            self.expect(&Token::Gt)?;
        }

        let mut where_clauses = Vec::new();
        while self.peek() == &Token::Where {
            if let Some(clause) = self.parse_where_clause() {
                where_clauses.push(clause);
            } else {
                return None;
            }
        }

        self.expect(&Token::LBrace)?;
        
        let mut fields = Vec::new();
        let mut methods = Vec::new();
        let mut structs = Vec::new();
        
        while self.peek() != &Token::RBrace && self.peek() != &Token::Eof {
            let visibility = if self.peek() == &Token::Public {
                self.advance();
                Some(Visibility::Public)
            } else if self.peek() == &Token::Private {
                self.advance();
                Some(Visibility::Private)
            } else {
                None
            };
            
            if self.peek() == &Token::Fn {
                let decl = self.parse_fn_decl()?;
                let vis = visibility.unwrap_or(Visibility::Public); // Methods public by default
                methods.push(ClassMethod { visibility: vis, decl });
            } else if self.peek() == &Token::Struct {
                let decl = self.parse_struct_decl()?;
                let vis = visibility.unwrap_or(Visibility::Private); // Structs private by default
                structs.push(ClassStruct { visibility: vis, decl });
            } else {
                let is_const = if self.peek() == &Token::Const {
                    self.advance();
                    true
                } else {
                    false
                };
                let f_name = self.expect_identifier()?;
                self.expect(&Token::Colon)?;
                let ty = self.parse_type_expr()?;
                self.expect(&Token::Semicolon)?;
                let vis = visibility.unwrap_or(Visibility::Private); // Fields private by default
                let f_span = f_name.1;
                fields.push(ClassField {
                    visibility: vis,
                    is_const,
                    name: f_name,
                    ty,
                    span: f_span,
                });
            }
        }
        
        let end_span = self.expect(&Token::RBrace)?;
        Some(ClassDecl {
            name,
            generic_params,
            where_clauses,
            fields,
            methods,
            structs,
            span: Span::new(start_span.start, end_span.end),
        })
    }

    fn parse_where_clause(&mut self) -> Option<WhereClause> {
        let start_span = self.peek_span();
        self.expect(&Token::Where)?;
        let target = self.expect_identifier()?;
        self.expect(&Token::LParen)?;
        let mut constraints = Vec::new();
        while self.peek() != &Token::RParen && self.peek() != &Token::Eof {
            if let Some(sig) = self.parse_constraint_signature() {
                constraints.push(sig);
            } else {
                return None;
            }
        }
        let end_span = self.expect(&Token::RParen)?;
        Some(WhereClause {
            target,
            constraints,
            span: Span::new(start_span.start, end_span.end),
        })
    }

    fn parse_constraint_signature(&mut self) -> Option<ConstraintSignature> {
        let start_span = self.peek_span();
        self.expect(&Token::Fn)?;
        let name = self.expect_identifier()?;
        self.expect(&Token::LParen)?;
        let params = self.parse_param_list();
        self.expect(&Token::RParen)?;
        let ret_ty = if self.peek() == &Token::Colon {
            self.advance();
            let ty = self.parse_type_expr()?;
            Some(ty)
        } else {
            None
        };
        let end_span = self.expect(&Token::Semicolon)?;
        Some(ConstraintSignature {
            name,
            params,
            ret_ty,
            span: Span::new(start_span.start, end_span.end),
        })
    }

    fn parse_fn_decl(&mut self) -> Option<FunctionDecl> {
        self.expect(&Token::Fn)?;
        let mut name_spanned = self.expect_identifier()?;
        
        if name_spanned.0 == "operator" {
            let next_tok = self.peek().clone();
            match next_tok {
                Token::Plus | Token::Minus | Token::Star | Token::Slash | Token::Percent |
                Token::Eq | Token::NotEq | Token::Lt | Token::Gt | Token::LtEq | Token::GtEq => {
                    let end = self.peek_span().end;
                    self.advance();
                    let op_name = match next_tok {
                        Token::Plus => "operator_add",
                        Token::Minus => "operator_sub",
                        Token::Star => "operator_mul",
                        Token::Slash => "operator_div",
                        Token::Percent => "operator_rem",
                        Token::Eq => "operator_eq",
                        Token::NotEq => "operator_neq",
                        Token::Lt => "operator_lt",
                        Token::Gt => "operator_gt",
                        Token::LtEq => "operator_lte",
                        Token::GtEq => "operator_gte",
                        _ => unreachable!(),
                    };
                    name_spanned.0 = op_name.to_string();
                    name_spanned.1 = Span::new(name_spanned.1.start, end);
                }
                Token::LBracket => {
                    self.advance(); // consume [
                    if self.peek() == &Token::RBracket {
                        let mut end = self.peek_span().end;
                        self.advance(); // consume ]
                        if self.peek() == &Token::Assign {
                            end = self.peek_span().end;
                            self.advance(); // consume =
                            name_spanned.0 = "operator_index_set".to_string();
                        } else {
                            name_spanned.0 = "operator_index".to_string();
                        }
                        name_spanned.1 = Span::new(name_spanned.1.start, end);
                    } else {
                        self.errors.push(crate::error::AtlasError::ParseError {
                            span: self.peek_span(),
                            message: "expected ']' after 'operator['".to_string(),
                            hint: None,
                        });
                        return None;
                    }
                }
                _ => {} // Not an operator overload
            }
        }
        let mut generic_params = Vec::new();
        if self.peek() == &Token::Lt {
            self.advance();
            loop {
                let param = self.expect_identifier()?;
                generic_params.push(param);
                if self.peek() == &Token::Comma {
                    self.advance();
                } else {
                    break;
                }
            }
            self.expect(&Token::Gt)?;
        }
        self.expect(&Token::LParen)?;
        let params = self.parse_param_list();
        self.expect(&Token::RParen)?;
        
        let ret_ty = if self.peek() == &Token::Colon {
            self.advance();
            let ty = self.parse_type_expr()?;
            Some(ty)
        } else {
            None
        };

        let mut where_clauses = Vec::new();
        while self.peek() == &Token::Where {
            if let Some(clause) = self.parse_where_clause() {
                where_clauses.push(clause);
            } else {
                return None;
            }
        }

        let body = self.parse_block()?;
        Some(FunctionDecl {
            name: name_spanned,
            generic_params,
            params,
            ret_ty,
            where_clauses,
            body,
        })
    }

    fn parse_param_list(&mut self) -> Vec<Param> {
        let mut params = Vec::new();
        if self.peek() == &Token::RParen {
            return params;
        }
        while let Some(param) = self.parse_param() {
            params.push(param);
            if self.peek() == &Token::Comma {
                self.advance();
            } else {
                break;
            }
        }
        params
    }

    fn parse_param(&mut self) -> Option<Param> {
        let name = if self.peek() == &Token::SelfToken {
            let (_, span) = self.advance().unwrap();
            ("self".to_string(), span)
        } else {
            self.expect_identifier()?
        };
        
        if name.0 == "self" && self.peek() != &Token::Colon {
            return Some(Param {
                name: name.clone(),
                ty: (TypeExpr::Named("self".to_string()), name.1),
            });
        }
        self.expect(&Token::Colon)?;
        let ty = self.parse_type_expr()?;
        Some(Param { name, ty })
    }

    fn parse_type_expr(&mut self) -> Option<Spanned<TypeExpr>> {
        let start_span = self.peek_span();
        
        // Slice Type: []T
        if self.peek() == &Token::LBracket && self.peek_nth(1) == &Token::RBracket {
            self.advance(); // consume `[`
            self.advance(); // consume `]`
            let element = self.parse_type_expr()?;
            let span = Span::new(start_span.start, element.1.end);
            return Some((
                TypeExpr::Slice {
                    element: Box::new(element.0),
                    span,
                },
                span,
            ));
        }

        let mut base = if self.peek() == &Token::At {
            self.advance();
            let target = self.parse_type_expr()?;
            let mut end_span = target.1;
            let mut nullable = false;
            if self.peek() == &Token::Question {
                let (_, q_span) = self.advance().unwrap();
                nullable = true;
                end_span = q_span;
            }
            let span = Span::new(start_span.start, end_span.end);
            (
                TypeExpr::Pointer {
                    target: Box::new(target.0),
                    nullable,
                    span,
                },
                span,
            )
        } else {
            let next = self.peek();
            let is_type = matches!(next, 
                Token::Int | Token::Uint |
                Token::Int8 | Token::Int16 | Token::Int32 | Token::Int64 |
                Token::Uint8 | Token::Uint16 | Token::Uint32 | Token::Uint64 |
                Token::Float | Token::Float32 | Token::Float64 |
                Token::Bool | Token::Char |
                Token::Identifier(_)
            );
            if is_type {
                let (tok, span) = self.advance().unwrap();
                let mut name = match tok {
                    Token::Identifier(s) => s.clone(),
                    t => format!("{:?}", t).to_lowercase(),
                };
                while self.peek() == &Token::ColonColon {
                    self.advance(); // consume "::"
                    let (next_id, _) = self.expect_identifier()?;
                    name.push_str("::");
                    name.push_str(&next_id);
                }
                if self.peek() == &Token::Lt {
                    self.advance(); // consume `<`
                    let mut args = Vec::new();
                    loop {
                        let arg = self.parse_type_expr()?;
                        args.push(arg.0);
                        if self.peek() == &Token::Comma {
                            self.advance();
                        } else {
                            break;
                        }
                    }
                    let end_span = self.expect(&Token::Gt)?;
                    let full_span = Span::new(span.start, end_span.end);
                    (
                        TypeExpr::Generic {
                            base: name,
                            args,
                            span: full_span,
                        },
                        full_span,
                    )
                } else {
                    (TypeExpr::Named(name), span)
                }
            } else {
                let span = self.peek_span();
                self.errors.push(AtlasError::ParseError {
                    span,
                    message: format!("expected type name, found '{:?}'", next),
                    hint: None,
                });
                return None;
            }
        };

        // Parse array subscripts (e.g. T[10])
        while self.peek() == &Token::LBracket {
            self.advance(); // consume `[`
            let size_token = self.advance()?;
            let size = match size_token.0 {
                Token::IntLiteral((val, _)) if val >= 0 => val as usize,
                other => {
                    self.errors.push(AtlasError::ParseError {
                        span: size_token.1,
                        message: format!("expected positive integer array size, found '{:?}'", other),
                        hint: None,
                    });
                    return None;
                }
            };
            let end_bracket_span = self.expect(&Token::RBracket)?;
            let span = Span::new(base.1.start, end_bracket_span.end);
            base = (
                TypeExpr::Array {
                    element: Box::new(base.0),
                    size,
                    span,
                },
                span,
            );
        }

        Some(base)
    }

    fn parse_block(&mut self) -> Option<Block> {
        let start_span = self.expect(&Token::LBrace)?;
        let mut stmts = Vec::new();
        while self.peek() != &Token::RBrace && self.peek() != &Token::Eof {
            if let Some(stmt) = self.parse_stmt() {
                stmts.push(stmt);
            } else {
                self.synchronize();
            }
        }
        let end_span = self.expect(&Token::RBrace)?;
        Some(Block {
            stmts,
            span: Span::new(start_span.start, end_span.end),
        })
    }

    fn parse_pattern(&mut self) -> Option<Pattern> {
        let start_span = self.peek_span();
        if let Token::Identifier(ref name) = self.peek() {
            if name == "_" {
                let (_, span) = self.advance().unwrap();
                return Some(Pattern::Discard(span));
            }
        }
        
        if matches!(self.peek(), Token::IntLiteral(_) | Token::FloatLiteral(_) | Token::BoolLiteral(_) | Token::CharLiteral(_) | Token::StringLiteral(_)) {
            let lit = self.parse_expr(0)?;
            let span = lit.span();
            return Some(Pattern::Literal(lit, span));
        }
        
        let first = self.expect_identifier()?;
        let mut path = vec![first.0];
        let mut end_span = first.1;
        while self.peek() == &Token::ColonColon {
            self.advance();
            let next = self.expect_identifier()?;
            path.push(next.0);
            end_span = next.1;
        }
        
        let mut bind = None;
        if self.peek() == &Token::LParen {
            self.advance();
            let b_name = self.expect_identifier()?;
            bind = Some(b_name);
            let r_paren_span = self.expect(&Token::RParen)?;
            end_span = r_paren_span;
        }
        
        let span = Span::new(start_span.start, end_span.end);
        Some(Pattern::Variant { path, bind, span })
    }

    pub fn parse_stmt(&mut self) -> Option<Stmt> {
        match self.peek() {
            Token::Var => self.parse_var_decl().map(Stmt::VarDecl),
            Token::Const => self.parse_const_decl().map(Stmt::ConstDecl),
            Token::Return => self.parse_return_stmt(),
            Token::If => self.parse_if_stmt().map(Stmt::If),
            Token::While => self.parse_while_stmt().map(Stmt::While),
            Token::Break => self.parse_break_stmt(),
            Token::Continue => self.parse_continue_stmt(),
            Token::LBrace => self.parse_block().map(Stmt::Block),
            Token::Struct => self.parse_struct_decl().map(Stmt::StructDecl),
            _ => {
                let expr = self.parse_expr(0)?;
                if self.peek() == &Token::Assign {
                    self.advance();
                    let value = self.parse_expr(0)?;
                    let semi_span = self.expect(&Token::Semicolon)?;
                    return Some(Stmt::Assign(Assign {
                        target: expr.clone(),
                        value,
                        span: Span::new(expr.span().start, semi_span.end),
                    }));
                }
                self.expect(&Token::Semicolon)?;
                Some(Stmt::ExprStmt(expr))
            }
        }
    }

    fn parse_if_stmt(&mut self) -> Option<IfStmt> {
        let start_span = self.expect(&Token::If)?;
        let condition = self.parse_expr(0)?;
        let then_block = self.parse_block()?;
        
        let mut else_if_clauses = Vec::new();
        let mut else_block = None;

        while self.peek() == &Token::Else {
            self.advance();
            if self.peek() == &Token::If {
                self.advance();
                let elif_cond = self.parse_expr(0)?;
                let elif_block = self.parse_block()?;
                else_if_clauses.push((elif_cond, elif_block));
            } else {
                else_block = Some(self.parse_block()?);
                break;
            }
        }

        let end_span = else_block.as_ref()
            .map(|b| b.span)
            .or_else(|| else_if_clauses.last().map(|(_, b)| b.span))
            .unwrap_or(then_block.span);

        Some(IfStmt {
            condition,
            then_block,
            else_if_clauses,
            else_block,
            span: Span::new(start_span.start, end_span.end),
        })
    }

    fn parse_while_stmt(&mut self) -> Option<WhileStmt> {
        let start_span = self.expect(&Token::While)?;
        let condition = self.parse_expr(0)?;
        let body = self.parse_block()?;
        let body_span = body.span;
        Some(WhileStmt {
            condition,
            body,
            span: Span::new(start_span.start, body_span.end),
        })
    }

    fn parse_var_decl(&mut self) -> Option<VarDecl> {
        let var_span = self.expect(&Token::Var)?;
        let name = self.expect_identifier()?;
        
        let ty_hint = if self.peek() == &Token::Colon {
            self.advance();
            let ty = self.parse_type_expr()?;
            Some(ty)
        } else {
            None
        };

        let init = if self.peek() == &Token::Assign {
            self.advance();
            let expr = self.parse_expr(0)?;
            Some(expr)
        } else {
            None
        };

        let semi_span = self.expect(&Token::Semicolon)?;
        Some(VarDecl {
            name,
            ty_hint,
            init,
            span: Span::new(var_span.start, semi_span.end),
        })
    }

    fn parse_const_decl(&mut self) -> Option<ConstDecl> {
        let const_span = self.expect(&Token::Const)?;
        let name = self.expect_identifier()?;
        
        let ty_hint = if self.peek() == &Token::Colon {
            self.advance();
            let ty = self.parse_type_expr()?;
            Some(ty)
        } else {
            None
        };

        self.expect(&Token::Assign)?;
        let init = self.parse_expr(0)?;
        let semi_span = self.expect(&Token::Semicolon)?;
        
        Some(ConstDecl {
            name,
            ty_hint,
            init,
            span: Span::new(const_span.start, semi_span.end),
        })
    }

    fn parse_return_stmt(&mut self) -> Option<Stmt> {
        let ret_span = self.expect(&Token::Return)?;
        if self.peek() == &Token::Semicolon {
            let semi_span = self.advance().unwrap().1;
            Some(Stmt::Return(None, Span::new(ret_span.start, semi_span.end)))
        } else {
            let expr = self.parse_expr(0)?;
            let semi_span = self.expect(&Token::Semicolon)?;
            Some(Stmt::Return(Some(expr), Span::new(ret_span.start, semi_span.end)))
        }
    }

    fn parse_break_stmt(&mut self) -> Option<Stmt> {
        let break_span = self.expect(&Token::Break)?;
        let semi_span = self.expect(&Token::Semicolon)?;
        Some(Stmt::Break(Span::new(break_span.start, semi_span.end)))
    }

    fn parse_continue_stmt(&mut self) -> Option<Stmt> {
        let continue_span = self.expect(&Token::Continue)?;
        let semi_span = self.expect(&Token::Semicolon)?;
        Some(Stmt::Continue(Span::new(continue_span.start, semi_span.end)))
    }

    pub fn parse_expr(&mut self, min_bp: u8) -> Option<Expr> {
        let (token, span) = self.advance()?;
        let mut lhs = match token {
            Token::Null => Expr::Null { span },
            Token::Match => {
                let target = self.parse_expr(0)?;
                self.expect(&Token::LBrace)?;
                let mut cases = Vec::new();
                while self.peek() != &Token::RBrace && self.peek() != &Token::Eof {
                    let pattern = self.parse_pattern()?;
                    self.expect(&Token::Arrow)?;
                    let body = self.parse_block()?;
                    cases.push(MatchCase { pattern, body });
                    if self.peek() == &Token::Comma {
                        self.advance();
                    }
                }
                let end_span = self.expect(&Token::RBrace)?;
                Expr::Match {
                    expr: Box::new(target),
                    cases,
                    span: Span::new(span.start, end_span.end),
                }
            }
            Token::IntLiteral((val, suffix)) => Expr::IntLit {
                value: val,
                suffix,
                span,
            },
            Token::SelfToken => Expr::Var {
                name: "self".to_string(),
                span,
            },
            Token::FloatLiteral(val) => Expr::FloatLit {
                value: val,
                span,
            },
            Token::BoolLiteral(val) => Expr::BoolLit {
                value: val,
                span,
            },
            Token::CharLiteral(val) => Expr::CharLit {
                value: val,
                span,
            },
            Token::StringLiteral(val) => Expr::StringLit {
                value: val,
                span,
            },
            Token::Identifier(name) => {
                if self.peek() == &Token::ColonColon || self.peek() == &Token::Dot {
                    let mut has_coloncolon = false;
                    let mut lookahead = 0;
                    while self.cursor + lookahead < self.tokens.len() {
                        let tok = &self.tokens[self.cursor + lookahead].0;
                        if *tok == Token::ColonColon {
                            has_coloncolon = true;
                            break;
                        }
                        if *tok != Token::Dot && !matches!(tok, Token::Identifier(_)) {
                            break;
                        }
                        lookahead = lookahead + 1;
                    }
                    if has_coloncolon {
                        let mut path = vec![name];
                        let mut end_span = span;
                        while self.peek() == &Token::Dot {
                            self.advance();
                            let (next_id, next_span) = self.expect_identifier()?;
                            path.push(next_id);
                            end_span = next_span;
                        }
                        while self.peek() == &Token::ColonColon {
                            self.advance();
                            let (next_id, next_span) = self.expect_identifier()?;
                            path.push(next_id);
                            end_span = next_span;
                        }
                        let type_args = if self.peek() == &Token::Lt {
                            self.try_parse_generic_call_type_args()
                        } else {
                            None
                        };
                        if path.len() >= 2 {
                            let member = path.pop().unwrap();
                            let class_name = path.join("::");
                            if self.peek() == &Token::LParen {
                                let (args, r_span) = self.parse_call_args()?;
                                if let Some(type_args) = type_args {
                                    Expr::GenericStaticCall {
                                        class_name,
                                        method_name: member,
                                        type_args,
                                        args,
                                        span: Span::new(span.start, r_span.end),
                                    }
                                } else {
                                    Expr::StaticCall {
                                        class_name,
                                        method_name: member,
                                        args,
                                        span: Span::new(span.start, r_span.end),
                                    }
                                }
                            } else if self.peek() == &Token::LBrace
                                && (self.peek_nth(1) == &Token::RBrace
                                    || (matches!(self.peek_nth(1), Token::Identifier(_)) && self.peek_nth(2) == &Token::Colon))
                            {
                                self.advance();
                                let mut fields = Vec::new();
                                if self.peek() != &Token::RBrace {
                                    loop {
                                        let field_name = self.expect_identifier()?;
                                        self.expect(&Token::Colon)?;
                                        let value = self.parse_expr(0)?;
                                        fields.push((field_name, value));
                                        if self.peek() == &Token::Comma {
                                            self.advance();
                                            if self.peek() == &Token::RBrace {
                                                break;
                                            }
                                        } else {
                                            break;
                                        }
                                    }
                                }
                                let r_span = self.expect(&Token::RBrace)?;
                                path.push(member);
                                Expr::StructInit { struct_name: path.join("::"), fields, span: Span::new(span.start, r_span.end) }
                            } else {
                                Expr::StaticMember {
                                    class_name,
                                    member_name: member,
                                    span: Span::new(span.start, end_span.end),
                                }
                            }
                        } else {
                            Expr::Var { name: path[0].clone(), span }
                        }
                    } else {
                        Expr::Var { name, span }
                    }
                } else if self.peek() == &Token::Lt {
                    if let Some(type_args) = self.try_parse_generic_call_type_args() {
                        let (args, end_span) = self.parse_call_args()?;
                        Expr::GenericCall {
                            callee: name,
                            type_args,
                            args,
                            span: Span::new(span.start, end_span.end),
                        }
                    } else {
                        Expr::Var {
                            name,
                            span,
                        }
                    }
                } else if self.peek() == &Token::LParen {
                    let (args, end_span) = self.parse_call_args()?;
                    Expr::Call {
                        callee: name,
                        args,
                        span: Span::new(span.start, end_span.end),
                    }
                } else if self.peek() == &Token::LBrace
                    && (self.peek_nth(1) == &Token::RBrace
                        || (matches!(self.peek_nth(1), Token::Identifier(_)) && self.peek_nth(2) == &Token::Colon))
                {
                    self.advance();
                    let mut fields = Vec::new();
                    if self.peek() != &Token::RBrace {
                        loop {
                            let field_name = self.expect_identifier()?;
                            self.expect(&Token::Colon)?;
                            let value = self.parse_expr(0)?;
                            fields.push((field_name, value));
                            if self.peek() == &Token::Comma {
                                self.advance();
                                if self.peek() == &Token::RBrace {
                                    break;
                                }
                            } else {
                                break;
                            }
                        }
                    }
                    let end_span = self.expect(&Token::RBrace)?;
                    Expr::StructInit {
                        struct_name: name,
                        fields,
                        span: Span::new(span.start, end_span.end),
                    }
                } else {
                    Expr::Var {
                        name,
                        span,
                    }
                }
            },
            Token::LParen => {
                let start_span = span;
                let expr = self.parse_expr(0)?;
                let end_span = self.expect(&Token::RParen)?;
                Expr::Group {
                    inner: Box::new(expr),
                    span: Span::new(start_span.start, end_span.end),
                }
            }
            Token::LBracket => {
                let start_span = span;
                let mut elements = Vec::new();
                if self.peek() != &Token::RBracket {
                    loop {
                        let elem = self.parse_expr(0)?;
                        elements.push(elem);
                        if self.peek() == &Token::Comma {
                            self.advance();
                            if self.peek() == &Token::RBracket {
                                break;
                            }
                        } else {
                            break;
                        }
                    }
                }
                let end_span = self.expect(&Token::RBracket)?;
                Expr::ArrayLit {
                    elements,
                    span: Span::new(start_span.start, end_span.end),
                }
            }
            op => {
                if let Some(((), r_bp)) = prefix_bp(&op) {
                    let operand = self.parse_expr(r_bp)?;
                    let op_span = span;
                    let operand_span = operand.span();
                    let unary_op = match op {
                        Token::Minus => UnaryOp::Neg,
                        Token::Bang | Token::Not => UnaryOp::Not,
                        Token::At => UnaryOp::AddressOf,
                        Token::Star => UnaryOp::Dereference,
                        _ => unreachable!(),
                    };
                    Expr::Unary {
                        op: unary_op,
                        operand: Box::new(operand),
                        span: Span::new(op_span.start, operand_span.end),
                    }
                } else {
                    self.errors.push(AtlasError::ParseError {
                        span,
                        message: format!("expected expression, found '{:?}'", op),
                        hint: None,
                    });
                    return None;
                }
            }
        };

        loop {
            let next_op = self.peek();
            if next_op == &Token::Eof {
                break;
            }
            if let Some((l_bp, ())) = postfix_bp(next_op) {
                if l_bp < min_bp {
                    break;
                }
                let (op_token, op_span) = self.advance().unwrap();
                if op_token == Token::Question {
                    let lhs_span = lhs.span();
                    lhs = Expr::ErrorPropagate {
                        expr: Box::new(lhs),
                        span: Span::new(lhs_span.start, op_span.end),
                    };
                }
                continue;
            }
            if let Some((l_bp, r_bp)) = infix_bp(next_op) {
                if l_bp < min_bp {
                    break;
                }
                let (op_token, _) = self.advance().unwrap();
                if op_token == Token::Dot {
                    let member = self.expect_identifier()?;
                    let lhs_span = lhs.span();
                    let member_span = member.1;
                    if self.peek() == &Token::LParen {
                        self.advance();
                        let mut args = Vec::new();
                        if self.peek() != &Token::RParen {
                            loop {
                                let arg = self.parse_expr(0)?;
                                args.push(arg);
                                if self.peek() == &Token::Comma {
                                    self.advance();
                                } else {
                                    break;
                                }
                            }
                        }
                        let end_span = self.expect(&Token::RParen)?;
                        lhs = Expr::MethodCall {
                            object: Box::new(lhs),
                            method_name: member.0,
                            args,
                            span: Span::new(lhs_span.start, end_span.end),
                        };
                    } else {
                        lhs = Expr::MemberAccess {
                            object: Box::new(lhs),
                            member: member.0,
                            span: Span::new(lhs_span.start, member_span.end),
                        };
                    }
                } else if op_token == Token::LBracket {
                    let index = self.parse_expr(0)?;
                    let end_bracket_span = self.expect(&Token::RBracket)?;
                    let lhs_span = lhs.span();
                    lhs = Expr::ArrayIndex {
                        array: Box::new(lhs),
                        index: Box::new(index),
                        span: Span::new(lhs_span.start, end_bracket_span.end),
                    };
                } else {
                    let rhs = self.parse_expr(r_bp)?;
                    let rhs_span = rhs.span();
                    let bin_op = match op_token {
                        Token::Plus => BinOp::Add,
                        Token::Minus => BinOp::Sub,
                        Token::Star => BinOp::Mul,
                        Token::Slash => BinOp::Div,
                        Token::Percent => BinOp::Mod,
                        Token::Eq => BinOp::Eq,
                        Token::NotEq => BinOp::NotEq,
                        Token::Lt => BinOp::Lt,
                        Token::Gt => BinOp::Gt,
                        Token::LtEq => BinOp::LtEq,
                        Token::GtEq => BinOp::GtEq,
                        Token::And | Token::Ampersand => BinOp::And,
                        Token::Or | Token::Pipe => BinOp::Or,
                        _ => unreachable!(),
                    };
                    let lhs_span = lhs.span();
                    lhs = Expr::Binary {
                        op: bin_op,
                        lhs: Box::new(lhs),
                        rhs: Box::new(rhs),
                        span: Span::new(lhs_span.start, rhs_span.end),
                    };
                }
            } else {
                break;
            }
        }

        Some(lhs)
    }

    fn peek(&self) -> &Token {
        if self.cursor < self.tokens.len() {
            &self.tokens[self.cursor].0
        } else {
            &Token::Eof
        }
    }

    fn peek_nth(&self, n: usize) -> &Token {
        if self.cursor + n < self.tokens.len() {
            &self.tokens[self.cursor + n].0
        } else {
            &Token::Eof
        }
    }

    fn peek_span(&self) -> Span {
        if self.cursor < self.tokens.len() {
            self.tokens[self.cursor].1
        } else if !self.tokens.is_empty() {
            self.tokens.last().unwrap().1
        } else {
            Span::new(0, 0)
        }
    }

    fn advance(&mut self) -> Option<(Token, Span)> {
        if self.cursor < self.tokens.len() {
            let (tok, span) = &self.tokens[self.cursor];
            self.cursor += 1;
            Some((tok.clone(), *span))
        } else {
            None
        }
    }

    fn expect(&mut self, expected: &Token) -> Option<Span> {
        let actual = self.peek();
        if actual == expected {
            let (_, span) = self.advance().unwrap();
            Some(span)
        } else {
            let span = self.peek_span();
            self.errors.push(AtlasError::ParseError {
                span,
                message: format!("expected '{:?}', found '{:?}'", expected, actual),
                hint: None,
            });
            None
        }
    }

    fn expect_identifier(&mut self) -> Option<Spanned<String>> {
        let actual = self.peek();
        if let Token::Identifier(name) = actual {
            let name = name.clone();
            let (_, span) = self.advance().unwrap();
            Some((name, span))
        } else {
            let span = self.peek_span();
            self.errors.push(AtlasError::ParseError {
                span,
                message: format!("expected identifier, found '{:?}'", actual),
                hint: None,
            });
            None
        }
    }

    fn parse_generic_call_type_args(&mut self) -> Option<Vec<Spanned<TypeExpr>>> {
        self.expect(&Token::Lt)?;
        let mut type_args = Vec::new();
        loop {
            type_args.push(self.parse_type_expr()?);
            if self.peek() == &Token::Comma {
                self.advance();
            } else {
                break;
            }
        }
        self.expect(&Token::Gt)?;
        Some(type_args)
    }

    fn try_parse_generic_call_type_args(&mut self) -> Option<Vec<Spanned<TypeExpr>>> {
        let saved_cursor = self.cursor;
        let saved_errors = self.errors.len();
        let parsed = self.parse_generic_call_type_args();
        if parsed.is_some() && self.peek() == &Token::LParen {
            return parsed;
        }
        self.cursor = saved_cursor;
        self.errors.truncate(saved_errors);
        None
    }

    fn parse_call_args(&mut self) -> Option<(Vec<Expr>, Span)> {
        self.expect(&Token::LParen)?;
        let mut args = Vec::new();
        if self.peek() != &Token::RParen {
            loop {
                let arg = self.parse_expr(0)?;
                args.push(arg);
                if self.peek() == &Token::Comma {
                    self.advance();
                } else {
                    break;
                }
            }
        }
        let end_span = self.expect(&Token::RParen)?;
        Some((args, end_span))
    }

    fn synchronize(&mut self) {
        while self.cursor < self.tokens.len() {
            let next = self.peek();
            if next == &Token::Semicolon {
                self.advance();
                break;
            }
            if next == &Token::RBrace || next == &Token::Fn {
                break;
            }
            self.advance();
        }
    }
}

// ==========================================
// Binding Power Helpers
// ==========================================

fn infix_bp(op: &Token) -> Option<(u8, u8)> {
    match op {
        Token::Or | Token::Pipe => Some((1, 2)),
        Token::And | Token::Ampersand => Some((3, 4)),
        Token::Eq | Token::NotEq => Some((5, 6)),
        Token::Lt | Token::Gt | Token::LtEq | Token::GtEq => Some((7, 8)),
        Token::Plus | Token::Minus => Some((9, 10)),
        Token::Star | Token::Slash | Token::Percent => Some((11, 12)),
        Token::Dot | Token::LBracket => Some((14, 15)),
        _ => None,
    }
}

fn prefix_bp(op: &Token) -> Option<((), u8)> {
    match op {
        Token::Minus | Token::Bang | Token::Not => Some(((), 13)),
        Token::At | Token::Star => Some(((), 13)),
        _ => None,
    }
}

fn postfix_bp(op: &Token) -> Option<(u8, ())> {
    match op {
        Token::Question => Some((21, ())),
        _ => None,
    }
}
