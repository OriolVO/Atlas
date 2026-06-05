use std::path::{Path, PathBuf};
use std::process::Command;

pub fn compile_to_ir(entry_path: &Path, project_mode: bool) -> Result<String, String> {
    let backend = backend_path()?;
    let mut command = Command::new(&backend);
    command.arg("build").arg(entry_path);
    if project_mode {
        command.arg("--project");
    }
    command.arg("--dump-ir");
    command.current_dir(repo_root());

    let output = command
        .output()
        .map_err(|err| format!("failed to execute legacy compiler backend '{}': {}", backend.display(), err))?;

    if !output.status.success() {
        let stdout = String::from_utf8_lossy(&output.stdout);
        let stderr = String::from_utf8_lossy(&output.stderr);
        let mut message = extract_relevant_diagnostics(&stderr)
            .or_else(|| extract_relevant_diagnostics(&stdout))
            .unwrap_or_else(|| {
                let mut combined = String::new();
                if !stderr.trim().is_empty() {
                    combined.push_str(stderr.trim());
                }
                if !stdout.trim().is_empty() {
                    if !combined.is_empty() {
                        combined.push('\n');
                    }
                    combined.push_str(stdout.trim());
                }
                combined
            });
        if message.is_empty() {
            message = format!("legacy compiler backend exited with status {:?}", output.status.code());
        }
        return Err(format!("{}\nlegacy backend: {}", message, backend.display()));
    }

    let stdout = String::from_utf8_lossy(&output.stdout);
    let ir = extract_ir(&stdout).ok_or_else(|| {
        format!(
            "legacy backend did not emit recognizable LLVM IR: {}",
            backend.display()
        )
    })?;

    Ok(normalize_ir_names(ir))
}

fn backend_path() -> Result<PathBuf, String> {
    let path = repo_root().join("compiler/.compat/atlas-legacy");
    if path.exists() {
        Ok(path)
    } else {
        Err(format!(
            "legacy backend not found at '{}'; rebuild or restore compiler/.compat/atlas-legacy",
            path.display()
        ))
    }
}

fn extract_relevant_diagnostics(stream: &str) -> Option<String> {
    let trimmed = stream.trim();
    if trimmed.is_empty() {
        return None;
    }

    if let Some(idx) = trimmed.find("atlas::") {
        return Some(trimmed[idx..].trim().to_string());
    }

    None
}

fn normalize_ir_names(ir: String) -> String {
    ir.replace("::", ".")
}

fn extract_ir(stdout: &str) -> Option<String> {
    stdout.find("; Atlas compiler").map(|idx| stdout[idx..].to_string())
}

fn repo_root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
        .parent()
        .unwrap_or_else(|| Path::new("."))
        .to_path_buf()
}
