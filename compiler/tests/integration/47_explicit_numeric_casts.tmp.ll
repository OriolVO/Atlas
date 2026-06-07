; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

define i32 @"main"() {
entry:
    %tmp0 = alloca i32
    store i32 7, i32* %tmp0
    %tmp1 = load i32, i32* %tmp0
    %tmp2 = sext i32 %tmp1 to i64
    %tmp3 = alloca i64
    store i64 %tmp2, i64* %tmp3
    %tmp4 = load i64, i64* %tmp3
    %tmp5 = load i64, i64* %tmp3
    %tmp6 = icmp ne i64 %tmp5, 7
    br i1 %tmp6, label %if_then.0, label %if_else.1
if_then.0:
    %tmp7 = trunc i64 1 to i32
    ret i32 %tmp7
if_else.1:
    br label %if_end.2
if_end.2:
    %tmp8 = alloca i64
    store i64 9, i64* %tmp8
    %tmp9 = load i64, i64* %tmp8
    %tmp11 = alloca i64
    store i64 %tmp9, i64* %tmp11
    %tmp12 = load i64, i64* %tmp11
    %tmp13 = load i64, i64* %tmp11
    %tmp14 = icmp ne i64 %tmp13, 9
    br i1 %tmp14, label %if_then.3, label %if_else.4
if_then.3:
    %tmp15 = trunc i64 2 to i32
    ret i32 %tmp15
if_else.4:
    br label %if_end.5
if_end.5:
    %tmp16 = fptrunc double 1.5 to float
    %tmp17 = alloca float
    store float %tmp16, float* %tmp17
    %tmp18 = load float, float* %tmp17
    %tmp19 = fpext float %tmp18 to double
    %tmp20 = alloca double
    store double %tmp19, double* %tmp20
    %tmp21 = load double, double* %tmp20
    %tmp22 = load double, double* %tmp20
    %tmp23 = fcmp olt double %tmp22, 1.49
    %tmp24 = load double, double* %tmp20
    %tmp25 = load double, double* %tmp20
    %tmp26 = fcmp ogt double %tmp25, 1.51
    %tmp27 = or i1 %tmp23, %tmp26
    br i1 %tmp27, label %if_then.6, label %if_else.7
if_then.6:
    %tmp28 = trunc i64 3 to i32
    ret i32 %tmp28
if_else.7:
    br label %if_end.8
if_end.8:
    %tmp29 = trunc i64 0 to i32
    ret i32 %tmp29
}

