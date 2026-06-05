use std::collections::HashMap;
use crate::error::{AtlasError, Span};
use crate::legacy_backend;
use crate::parser::SourceFile;
use crate::resolver::Project;

mod helpers;
mod native;
mod types;

pub use self::native::NativeTypeChecker;
pub use self::types::*;
#[allow(unused_imports)]
use self::helpers::*;

pub struct TypeChecker;

impl TypeChecker {
    pub fn new() -> Self {
        Self
    }

    pub fn check(&self, _ast: &mut SourceFile) -> Result<TypedAST, Vec<AtlasError>> {
        match NativeTypeChecker::new().try_check(_ast) {
            native::NativeSingleCheck::Typed(typed) => Ok(typed),
            native::NativeSingleCheck::Unsupported => Err(vec![AtlasError::TypeError {
                span: Span::new(0, 0),
                message: "single-file typechecking is not supported natively for this program yet".to_string(),
                hint: Some("the single-file CLI currently falls back separately to the legacy backend".to_string()),
            }]),
            native::NativeSingleCheck::Errors(errors) => Err(errors),
        }
    }

    pub fn check_project(
        &self,
        project: &mut Project,
    ) -> Result<TypedAST, Vec<(String, String, Vec<AtlasError>)>> {
        if use_native_backend() {
            return match NativeTypeChecker::new().try_check_project(project) {
                native::NativeProjectCheck::Typed(typed) => Ok(typed),
                native::NativeProjectCheck::Unsupported => fallback_legacy_project(project),
                native::NativeProjectCheck::Errors(errors) => Err(errors),
            };
        }

        match NativeTypeChecker::new().try_check_project(project) {
            native::NativeProjectCheck::Typed(typed) => Ok(typed),
            native::NativeProjectCheck::Unsupported => fallback_legacy_project(project),
            native::NativeProjectCheck::Errors(errors) => Err(errors),
        }
    }
}

fn fallback_legacy_project(
    project: &mut Project,
) -> Result<TypedAST, Vec<(String, String, Vec<AtlasError>)>> {
    let (entry_path, source) = match project.sources.get("main") {
            Some((path, source)) => (path.clone(), source.clone()),
            None => {
                return Err(vec![(
                    "<internal>".to_string(),
                    String::new(),
                    vec![AtlasError::TypeError {
                        span: Span::new(0, 0),
                        message: "project is missing the 'main' module".to_string(),
                        hint: None,
                    }],
                )]);
            }
        };

    match legacy_backend::compile_to_ir(&entry_path, true) {
            Ok(ir) => Ok(TypedAST {
                fn_sigs: HashMap::new(),
                expr_types: HashMap::new(),
                structs: HashMap::new(),
                classes: HashMap::new(),
                enums: HashMap::new(),
                choices: HashMap::new(),
                mangled_calls: HashMap::new(),
                overloaded_operators: HashMap::new(),
                precompiled_ir: Some(ir),
            }),
            Err(message) => Err(vec![(
                entry_path.to_string_lossy().into_owned(),
                source,
                vec![AtlasError::TypeError {
                    span: Span::new(0, 0),
                    message,
                    hint: None,
                }],
            )]),
        }
}

fn use_native_backend() -> bool {
    std::env::var("ATLAS_USE_NATIVE_BACKEND")
        .map(|value| matches!(value.as_str(), "1" | "true" | "TRUE" | "yes" | "YES"))
        .unwrap_or(false)
}
