use atlas::typechecker::TypeChecker;
use atlas::llvm_codegen::Codegen;

fn run_integration_test(path: &std::path::Path) -> Result<(), String> {
    let source = std::fs::read_to_string(path).unwrap();
    
    let mut expected_exit_code = 0;
    let mut expected_output = String::new();
    for line in source.lines() {
        let trimmed = line.trim();
        if let Some(rest) = trimmed.strip_prefix("// Exit Code:") {
            expected_exit_code = rest.trim().parse::<i32>().unwrap();
        } else if let Some(rest) = trimmed.strip_prefix("// Expected Exit Code:") {
            expected_exit_code = rest.trim().parse::<i32>().unwrap();
        } else if let Some(rest) = trimmed.strip_prefix("// Output:") {
            expected_output = rest.trim().to_string();
        } else if let Some(rest) = trimmed.strip_prefix("// Expected Output:") {
            expected_output = rest.trim().to_string();
        }
    }

    let manifest_dir = std::env::var("CARGO_MANIFEST_DIR").unwrap_or_else(|_| ".".to_string());
    let stdlib_path = std::path::Path::new(&manifest_dir).parent().unwrap().join("stdlib");
    let mut project = match atlas::resolver::Project::load_and_resolve(path, &stdlib_path) {
        Ok(p) => p,
        Err(errors) => {
            return Err(format!(
                "Project load/resolve errors in {}: {:?}",
                path.display(),
                errors
            ));
        }
    };

    let typechecker = TypeChecker::new();
    let typed_ast = match typechecker.check_project(&mut project) {
        Ok(t) => t,
        Err(e) => {
            return Err(format!("Typecheck errors in {}: {:?}", path.display(), e));
        }
    };

    let mut merged = atlas::parser::SourceFile { items: Vec::new() };
    for mod_name in &project.topological_order {
        if let Some(module_ast) = project.modules.get_mut(mod_name) {
            let items = std::mem::take(&mut module_ast.items);
            for item in items {
                if !matches!(item, atlas::parser::Item::Import(_)) {
                    merged.items.push(item);
                }
            }
        }
    }

    let codegen = Codegen::new(typed_ast);
    let ir = codegen
        .generate(&merged)
        .map_err(|e| format!("Codegen failed for {}: {:?}", path.display(), e))?;

    let ir_path = path.with_extension("tmp.ll");
    std::fs::write(&ir_path, &ir).unwrap();

    let exe_path = path.with_extension("tmp.exe");
    let clang_status = std::process::Command::new("clang")
        .arg(&ir_path)
        .arg("-o")
        .arg(&exe_path)
        .arg("-lm")
        .output()
        .map_err(|e| format!("Failed to execute clang for {}: {}", path.display(), e))?;


    if !clang_status.status.success() {
        let stderr = String::from_utf8_lossy(&clang_status.stderr);
        let stdout = String::from_utf8_lossy(&clang_status.stdout);
        return Err(format!(
            "Clang compilation failed for {}:\n{}\n{}",
            path.display(),
            stdout,
            stderr
        ));
    }

    let run_output = std::process::Command::new(&exe_path)
        .output()
        .map_err(|e| format!("Failed to execute binary {}: {}", path.display(), e))?;

    let _ = std::fs::remove_file(&exe_path);

    let actual_exit_code = run_output.status.code().unwrap_or(-1);
    let actual_output = String::from_utf8_lossy(&run_output.stdout).trim().to_string();

    if actual_exit_code != expected_exit_code {
        return Err(format!(
            "Exit code mismatch for {}. Expected {}, got {}",
            path.display(),
            expected_exit_code,
            actual_exit_code
        ));
    }

    if !expected_output.is_empty() {
        if actual_output != expected_output {
            return Err(format!(
                "Output mismatch for {}. Expected '{}', got '{}'",
                path.display(),
                expected_output,
                actual_output
            ));
        }
    }

    Ok(())
}

#[test]
fn run_all_integration_tests() {
    let manifest_dir = std::env::var("CARGO_MANIFEST_DIR").unwrap();
    let dir = std::path::Path::new(&manifest_dir).join("tests").join("integration");
    
    if !dir.exists() {
        std::fs::create_dir_all(&dir).unwrap();
    }

    let mut entries = Vec::new();
    for entry in std::fs::read_dir(dir).unwrap() {
        let entry = entry.unwrap();
        let path = entry.path();
        if path.extension().and_then(|s| s.to_str()) == Some("atl") {
            entries.push(path);
        }
    }

    assert!(!entries.is_empty(), "No integration tests found");
    entries.sort();

    let mut failures = Vec::new();
    for path in entries {
        println!("Running test: {}", path.display());
        if let Err(err) = run_integration_test(&path) {
            failures.push(err);
        }
    }

    if !failures.is_empty() {
        panic!(
            "Integration failures ({}):\n\n{}",
            failures.len(),
            failures.join("\n\n")
        );
    }
}
