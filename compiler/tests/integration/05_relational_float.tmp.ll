; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
    %tmp0 = alloca double
    store double 3.14, double* %tmp0
    %tmp1 = alloca double
    store double 2.71, double* %tmp1
    %tmp2 = load double, double* %tmp0
    %tmp3 = load double, double* %tmp1
    %tmp4 = fcmp ogt double %tmp2, %tmp3
    br i1 %tmp4, label %if_then.0, label %if_else.1
if_then.0:
    %tmp5 = trunc i64 1 to i32
    ret i32 %tmp5
if_else.1:
    br label %if_end.2
if_end.2:
    %tmp6 = trunc i64 0 to i32
    ret i32 %tmp6
}

