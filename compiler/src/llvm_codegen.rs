use crate::error::AtlasError;
use crate::parser::SourceFile;
use crate::typechecker::TypedAST;

mod native;
#[allow(dead_code)]
mod support;

pub use self::native::NativeCodegen;

pub struct Codegen {
    typed_ast: TypedAST,
}

impl Codegen {
    pub fn new(typed_ast: TypedAST) -> Self {
        Self { typed_ast }
    }

    pub fn generate(&self, ast: &SourceFile) -> Result<String, AtlasError> {
        if let Some(ir) = self.typed_ast.precompiled_ir.clone() {
            return Ok(ir);
        }

        NativeCodegen::new(self.typed_ast.clone()).generate(ast)
    }
}
