   Compiling atlas v0.1.0 (/home/oriolvo/Atlas/compiler)
warning: unreachable pattern
   --> compiler/src/resolver.rs:564:13
    |
514 |             Expr::Cast { target_ty, expr, .. } => {
    |             ---------------------------------- matches all the relevant values
...
564 |             Expr::Cast { target_ty, expr, span: _ } => {
    |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ no value can reach this
    |
    = note: `#[warn(unreachable_patterns)]` (part of `#[warn(unused)]`) on by default

warning: unreachable pattern
   --> compiler/src/resolver.rs:568:13
    |
510 |             Expr::SizeOf { ty, .. } => {
    |             ----------------------- matches all the relevant values
...
568 |             Expr::SizeOf { ty, span: _ } => {
    |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ no value can reach this

warning: unreachable pattern
   --> compiler/src/resolver.rs:571:13
    |
519 |             Expr::Destroy { type_arg, expr, .. } => {
    |             ------------------------------------ matches all the relevant values
...
571 |             Expr::Destroy { type_arg, expr, span } => {
    |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ no value can reach this

warning: unused variable: `index`
    --> compiler/src/typechecker.rs:1698:69
     |
1698 |                 let is_index_set = if let Expr::ArrayIndex { array, index, .. } = &assign.target {
     |                                                                     ^^^^^ help: try ignoring the field: `index: _`
     |
     = note: `#[warn(unused_variables)]` (part of `#[warn(unused)]`) on by default

warning: unused variable: `method`
    --> compiler/src/typechecker.rs:1714:41
     |
1714 | ...                   if let Some(method) = cls.methods.get("operator_index_set") {
     |                                   ^^^^^^ help: if this is intentional, prefix it with an underscore: `_method`

warning: unused variable: `is_ptr`
    --> compiler/src/typechecker.rs:1994:42
     |
1994 |                         let (class_name, is_ptr) = match &l {
     |                                          ^^^^^^ help: if this is intentional, prefix it with an underscore: `_is_ptr`

warning: unused variable: `is_ptr`
    --> compiler/src/typechecker.rs:3137:34
     |
3137 |                 let (class_name, is_ptr) = match &arr_ty {
     |                                  ^^^^^^ help: if this is intentional, prefix it with an underscore: `_is_ptr`

warning: unreachable pattern
    --> compiler/src/typechecker.rs:3783:9
     |
3711 |         Expr::SizeOf { ty, span } => Expr::SizeOf {
     |         ------------------------- matches all the relevant values
...
3783 |         Expr::SizeOf { ty, span } => Expr::SizeOf {
     |         ^^^^^^^^^^^^^^^^^^^^^^^^^ no value can reach this

warning: unreachable pattern
    --> compiler/src/typechecker.rs:3787:9
     |
3715 |         Expr::Cast { target_ty, expr, span } => Expr::Cast {
     |         ------------------------------------ matches all the relevant values
...
3787 |         Expr::Cast { target_ty, expr, span } => Expr::Cast {
     |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ no value can reach this

warning: unused variable: `r_llvm_ty`
    --> compiler/src/llvm_codegen.rs:1142:25
     |
1142 |                     let r_llvm_ty = map_type(&r_ty);
     |                         ^^^^^^^^^ help: if this is intentional, prefix it with an underscore: `_r_llvm_ty`

warning: unused variable: `is_ptr`
    --> compiler/src/llvm_codegen.rs:1147:26
     |
1147 |                     let (is_ptr, class_name) = match &op_ty {
     |                          ^^^^^^ help: if this is intentional, prefix it with an underscore: `_is_ptr`

warning: `atlas` (lib) generated 11 warnings (run `cargo fix --lib -p atlas` to apply 6 suggestions)
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.82s
     Running `target/debug/atlas build compiler/tests/integration/41_generic_print.atl --emit-ir`
atlas::type_error

  × type error: class 'io' has no static method named 'println'
    ╭─[compiler/tests/integration/41_generic_print.atl:14:5]
 13 │     // Wait, the user can just use IO to print them!
 14 │     io::println(42);
    ·     ───────┬───────
    ·            ╰── here
 15 │     io::println(false);
    ╰────

atlas::type_error

  × type error: class 'io' has no static method named 'println'
    ╭─[compiler/tests/integration/41_generic_print.atl:15:5]
 14 │     io::println(42);
 15 │     io::println(false);
    ·     ─────────┬────────
    ·              ╰── here
 16 │     io::println('Z');
    ╰────

atlas::type_error

  × type error: class 'io' has no static method named 'println'
    ╭─[compiler/tests/integration/41_generic_print.atl:16:5]
 15 │     io::println(false);
 16 │     io::println('Z');
    ·     ────────┬───────
    ·             ╰── here
 17 │     
    ╰────

atlas::type_error

  × type error: mismatched argument type: expected 'Int32', found 'Int'
    ╭─[compiler/tests/integration/41_generic_print.atl:18:30]
 17 │     
 18 │     if !42.equals(42) { exit(1); }
    ·                              ┬
    ·                              ╰── here
 19 │     if true.equals(false) { exit(2); }
    ╰────

atlas::type_error

  × type error: mismatched argument type: expected 'Int32', found 'Int'
    ╭─[compiler/tests/integration/41_generic_print.atl:19:34]
 18 │     if !42.equals(42) { exit(1); }
 19 │     if true.equals(false) { exit(2); }
    ·                                  ┬
    ·                                  ╰── here
 20 │     if !'X'.equals('X') { exit(3); }
    ╰────

atlas::type_error

  × type error: mismatched argument type: expected 'Int32', found 'Int'
    ╭─[compiler/tests/integration/41_generic_print.atl:20:32]
 19 │     if true.equals(false) { exit(2); }
 20 │     if !'X'.equals('X') { exit(3); }
    ·                                ┬
    ·                                ╰── here
 21 │     
    ╰────

atlas::type_error

  × type error: mismatched argument type: expected 'Int32', found 'Int'
    ╭─[compiler/tests/integration/41_generic_print.atl:23:25]
 22 │     var h1 = 100.hash();
 23 │     if h1 != 100 { exit(4); }
    ·                         ┬
    ·                         ╰── here
 24 │     
    ╰────

