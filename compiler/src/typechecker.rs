use crate::error::{AtlasError, Span};
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
                hint: None,
            }]),
            native::NativeSingleCheck::Errors(errors) => Err(errors),
        }
    }

    pub fn check_project(
        &self,
        project: &mut Project,
    ) -> Result<TypedAST, Vec<(String, String, Vec<AtlasError>)>> {
        match NativeTypeChecker::new().try_check_project(project) {
            native::NativeProjectCheck::Typed(typed) => Ok(typed),
            native::NativeProjectCheck::Unsupported => Err(vec![(
                "<native>".to_string(),
                String::new(),
                vec![AtlasError::TypeError {
                    span: Span::new(0, 0),
                    message: "project typechecking is not supported natively for this program yet".to_string(),
                    hint: None,
                }],
            )]),
            native::NativeProjectCheck::Errors(errors) => Err(errors),
        }
    }
}
