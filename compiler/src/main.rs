use clap::{Parser as ClapParser, Subcommand};
use miette::{NamedSource, Report};
use std::fs;
use std::path::PathBuf;
use std::process;

use atlas::lexer::Lexer;
use atlas::parser::Parser;
use atlas::resolver::Project;
use atlas::typechecker::TypeChecker;
use atlas::llvm_codegen::Codegen;

#[derive(ClapParser)]
#[command(name = "atlas")]
#[command(about = "Atlas Compiler", long_about = None)]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    /// Build an Atlas source file or multi-file project
    Build {
        /// The source file to compile (single-file mode)
        file: PathBuf,

        /// Compile as a multi-file project rooted at this entry point.
        /// The compiler will resolve all transitive imports automatically.
        #[arg(long)]
        project: bool,

        /// Path to the Atlas standard library directory
        #[arg(long, default_value = "stdlib")]
        stdlib: PathBuf,

        /// Print the token stream and exit (single-file mode only)
        #[arg(long)]
        dump_tokens: bool,

        /// Print the AST and exit
        #[arg(long)]
        dump_ast: bool,

        /// Dump the generated LLVM IR to stdout and exit
        #[arg(long)]
        dump_ir: bool,

        /// Keep the generated .ll file next to the binary
        #[arg(long)]
        emit_ir: bool,

        /// Output path for the compiled binary
        #[arg(short, long)]
        output: Option<PathBuf>,
    },
}

fn main() {
    let cli = Cli::parse();

    match cli.command {
        Commands::Build {
            file,
            project,
            stdlib,
            dump_tokens,
            dump_ast,
            dump_ir,
            emit_ir,
            output,
        } => {
            if project {
                build_project(file, stdlib, dump_ast, dump_ir, emit_ir, output);
            } else {
                build_single(file, dump_tokens, dump_ast, dump_ir, emit_ir, output);
            }
        }
    }
}

// ─── Single-file compilation ──────────────────────────────────────────────────

fn build_single(
    file: PathBuf,
    dump_tokens: bool,
    dump_ast: bool,
    dump_ir: bool,
    emit_ir: bool,
    output: Option<PathBuf>,
) {
    // Validate .atl extension
    if file.extension().and_then(|e| e.to_str()) != Some("atl") {
        eprintln!(
            "error: Atlas source files must use the '.atl' extension (got '{}')",
            file.display()
        );
        process::exit(1);
    }

    // Read source file
    let source = match fs::read_to_string(&file) {
        Ok(content) => content,
        Err(err) => {
            eprintln!("error reading file '{}': {}", file.display(), err);
            process::exit(1);
        }
    };

    let file_name = file.to_string_lossy().into_owned();

    // Lex
    let lexer = Lexer::new(&source);
    let (tokens, lex_errors) = lexer.tokenize();

    if !lex_errors.is_empty() {
        for err in lex_errors {
            let report = Report::new(err).with_source_code(NamedSource::new(&file_name, source.clone()));
            eprintln!("{:?}", report);
        }
        process::exit(1);
    }

    if dump_tokens {
        for (tok, span) in &tokens {
            println!("{:?} @ {:?}", tok, span);
        }
        return;
    }

    // Parse
    let parser = Parser::new(&tokens);
    let (ast, parse_errors) = parser.parse_file();

    if !parse_errors.is_empty() {
        for err in parse_errors {
            let report = Report::new(err).with_source_code(NamedSource::new(&file_name, source.clone()));
            eprintln!("{:?}", report);
        }
        process::exit(1);
    }

    if dump_ast {
        println!("{:#?}", ast);
        return;
    }

    // Typecheck
    let typechecker = TypeChecker::new();
    let mut ast = ast;
    let typed_ast = match typechecker.check(&mut ast) {
        Ok(t) => t,
        Err(type_errors) => {
            for err in type_errors {
                let report = Report::new(err).with_source_code(NamedSource::new(&file_name, source.clone()));
                eprintln!("{:?}", report);
            }
            process::exit(1);
        }
    };

    // Codegen + link
    emit_binary(typed_ast, &ast, &file_name, &source, dump_ir, emit_ir, output.unwrap_or_else(|| file.with_extension("")));
}

// ─── Multi-file project compilation ──────────────────────────────────────────

fn build_project(
    entry: PathBuf,
    stdlib: PathBuf,
    dump_ast: bool,
    dump_ir: bool,
    emit_ir: bool,
    output: Option<PathBuf>,
) {
    // Validate extension
    if entry.extension().and_then(|e| e.to_str()) != Some("atl") {
        eprintln!(
            "error: project entry point must use the '.atl' extension (got '{}')",
            entry.display()
        );
        process::exit(1);
    }

    // Resolve & load all modules
    let mut project = match Project::load_and_resolve(&entry, &stdlib) {
        Ok(p) => p,
        Err(errors) => {
            for (path, source, err) in errors {
                let report = Report::new(err).with_source_code(NamedSource::new(&path, source));
                eprintln!("{:?}", report);
            }
            process::exit(1);
        }
    };

    if dump_ast {
        for mod_name in &project.topological_order {
            println!("=== module: {} ===", mod_name);
            println!("{:#?}", project.modules[mod_name]);
        }
        return;
    }

    // Typecheck all modules
    let typechecker = TypeChecker::new();
    let typed_ast = match typechecker.check_project(&mut project) {
        Ok(t) => t,
        Err(errors) => {
            for (path, source, errs) in errors {
                for err in errs {
                    let report = Report::new(err).with_source_code(NamedSource::new(&path, source.clone()));
                    eprintln!("{:?}", report);
                }
            }
            process::exit(1);
        }
    };

    // Merge all module ASTs into a single synthetic SourceFile for codegen
    let mut merged = atlas::parser::SourceFile { items: Vec::new() };
    for mod_name in &project.topological_order {
        if let Some(module_ast) = project.modules.get_mut(mod_name) {
            let items = std::mem::take(&mut module_ast.items);
            for item in items {
                // Skip import declarations — they are already resolved
                if !matches!(item, atlas::parser::Item::Import(_)) {
                    merged.items.push(item);
                }
            }
        }
    }

    let entry_name = entry.to_string_lossy().into_owned();
    let entry_source = project.sources.get("main").map(|(_, s)| s.clone()).unwrap_or_default();
    let binary_out = output.unwrap_or_else(|| entry.with_extension(""));

    emit_binary(typed_ast, &merged, &entry_name, &entry_source, dump_ir, emit_ir, binary_out);
}

// ─── Shared codegen + link step ───────────────────────────────────────────────

fn emit_binary(
    typed_ast: atlas::typechecker::TypedAST,
    ast: &atlas::parser::SourceFile,
    file_name: &str,
    source: &str,
    dump_ir: bool,
    emit_ir: bool,
    binary_out: PathBuf,
) {
    let codegen = Codegen::new(typed_ast);
    let ir = match codegen.generate(ast) {
        Ok(i) => i,
        Err(codegen_err) => {
            let report = Report::new(codegen_err).with_source_code(NamedSource::new(file_name, source.to_owned()));
            eprintln!("{:?}", report);
            process::exit(1);
        }
    };

    if dump_ir {
        println!("{}", ir);
        return;
    }

    let ll_out = if emit_ir {
        binary_out.with_extension("ll")
    } else {
        binary_out.with_extension("tmp.ll")
    };

    if let Err(err) = fs::write(&ll_out, &ir) {
        eprintln!("error writing LLVM IR to '{}': {}", ll_out.display(), err);
        process::exit(1);
    }

    let clang_status = process::Command::new("clang")
        .arg(&ll_out)
        .arg("-o")
        .arg(&binary_out)
        .arg("-lm")
        .status();

    if !emit_ir {
        let _ = fs::remove_file(&ll_out);
    }

    match clang_status {
        Ok(status) => {
            if !status.success() {
                eprintln!("clang compilation failed with exit code: {:?}", status.code());
                process::exit(1);
            }
        }
        Err(err) => {
            eprintln!("failed to execute clang: {}", err);
            process::exit(1);
        }
    }

    println!("Compilation successful: {}", binary_out.display());
}
