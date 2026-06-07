use std::collections::{HashMap, HashSet};

use crate::error::{AtlasError, Span};
use crate::parser::{FunctionDecl, TypeExpr};
use crate::typechecker::{atlas_type_to_type_expr, substitute_fn_decl, AtlasType};
use crate::typechecker::helpers::mangle_type_name;

pub struct MonomorphizedFunctionPlan {
    pub mangled_name: String,
    pub bindings: HashMap<String, AtlasType>,
    pub instantiated_decl: FunctionDecl,
}

pub fn plan_generic_function_instantiation(
    template: &FunctionDecl,
    arg_types: &[(Span, AtlasType)],
    call_span: Span,
) -> Result<MonomorphizedFunctionPlan, AtlasError> {
    if template.params.len() != arg_types.len() {
        return Err(AtlasError::TypeError {
            span: call_span,
            message: format!("wrong argument count for '{}'", template.name.0),
            hint: None,
        });
    }

    let generic_names: HashSet<String> = template.generic_params.iter().map(|param| param.0.clone()).collect();
    let mut bindings: HashMap<String, AtlasType> = HashMap::new();
    for (param, (arg_span, actual_ty)) in template.params.iter().zip(arg_types.iter()) {
        if !infer_type_bindings(&param.ty.0, actual_ty, &generic_names, &mut bindings) {
            return Err(AtlasError::TypeError {
                span: *arg_span,
                message: format!("could not infer generic arguments for '{}'", template.name.0),
                hint: None,
            });
        }
    }

    for generic_name in &generic_names {
        if !bindings.contains_key(generic_name) {
            return Err(AtlasError::TypeError {
                span: call_span,
                message: format!(
                    "generic argument '{}' could not be inferred for '{}'",
                    generic_name, template.name.0
                ),
                hint: None,
            });
        }
    }

    let ordered_args: Vec<AtlasType> = template
        .generic_params
        .iter()
        .map(|param| bindings.get(&param.0).cloned().expect("generic binding missing"))
        .collect();
    let mangled_name = mangle_type_name(&template.name.0, &ordered_args);

    let substitutions: HashMap<String, TypeExpr> = bindings
        .iter()
        .map(|(name, ty)| (name.clone(), atlas_type_to_type_expr(ty)))
        .collect();
    let instantiated_decl = substitute_fn_decl(template, &mangled_name, &substitutions);

    Ok(MonomorphizedFunctionPlan {
        mangled_name,
        bindings,
        instantiated_decl,
    })
}

fn infer_type_bindings(
    expected: &TypeExpr,
    actual: &AtlasType,
    generic_names: &HashSet<String>,
    bindings: &mut HashMap<String, AtlasType>,
) -> bool {
    match expected {
        TypeExpr::Named(name) if generic_names.contains(name) => match bindings.get(name) {
            Some(bound) => bound == actual,
            None => {
                bindings.insert(name.clone(), actual.clone());
                true
            }
        },
        TypeExpr::Named(_) => true,
        TypeExpr::Pointer { target, nullable, .. } => {
            if let AtlasType::Pointer { target: actual_target, nullable: actual_nullable } = actual {
                *nullable == *actual_nullable && infer_type_bindings(target, actual_target, generic_names, bindings)
            } else {
                false
            }
        }
        TypeExpr::Array { element, size, .. } => {
            if let AtlasType::Array { element: actual_element, size: actual_size } = actual {
                *size == *actual_size && infer_type_bindings(element, actual_element, generic_names, bindings)
            } else {
                false
            }
        }
        TypeExpr::Slice { element, .. } => {
            if let AtlasType::Slice(actual_element) = actual {
                infer_type_bindings(element, actual_element, generic_names, bindings)
            } else {
                false
            }
        }
        TypeExpr::Generic { .. } => true,
    }
}
