use crate::error::AtlasError;
use crate::parser::SourceFile;
use crate::typechecker::TypedAST;

#[allow(dead_code)]
mod support;

pub struct Codegen {
    typed_ast: TypedAST,
}

impl Codegen {
    pub fn new(typed_ast: TypedAST) -> Self {
        Self { typed_ast }
    }

    pub fn generate(&self, _ast: &SourceFile) -> Result<String, AtlasError> {
        self.typed_ast
            .precompiled_ir
            .clone()
            .ok_or_else(|| AtlasError::CodegenError {
                message: "native LLVM codegen is temporarily unavailable after the ongoing refactor".to_string(),
            })
    }
}
