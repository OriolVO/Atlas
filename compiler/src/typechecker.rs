use crate::error::AtlasError;
use crate::parser::SourceFile;
use crate::resolver::Project;

pub(crate) mod helpers;
mod native;
mod types;

pub use self::native::NativeTypeChecker;
pub use self::types::*;
#[allow(unused_imports)]
use self::helpers::*;
pub(crate) use self::helpers::{atlas_type_to_type_expr, substitute_fn_decl};

pub struct TypeChecker;

impl TypeChecker {
    pub fn new() -> Self {
        Self
    }

    pub fn check(&self, _ast: &mut SourceFile) -> Result<TypedAST, Vec<AtlasError>> {
        match NativeTypeChecker::new().try_check(_ast) {
            native::NativeSingleCheck::Typed(typed) => Ok(typed),
            native::NativeSingleCheck::Errors(errors) => Err(errors),
        }
    }

    pub fn check_project(
        &self,
        project: &mut Project,
    ) -> Result<TypedAST, Vec<(String, String, Vec<AtlasError>)>> {
        match NativeTypeChecker::new().try_check_project(project) {
            native::NativeProjectCheck::Typed(typed) => Ok(typed),
            native::NativeProjectCheck::Errors(errors) => Err(errors),
        }
    }
}
