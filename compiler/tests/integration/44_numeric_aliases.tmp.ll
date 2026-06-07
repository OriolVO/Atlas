; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

define i64 @"main.add_i64"(i64 %x) {
entry:
    %tmp0 = alloca i64
    store i64 %x, i64* %tmp0
    %tmp1 = load i64, i64* %tmp0
    %tmp2 = load i64, i64* %tmp0
    %tmp3 = add i64 %tmp2, 1
    ret i64 %tmp3
}

define i64 @"main.add_u64"(i64 %x) {
entry:
    %tmp4 = alloca i64
    store i64 %x, i64* %tmp4
    %tmp5 = load i64, i64* %tmp4
    %tmp6 = load i64, i64* %tmp4
    %tmp7 = add i64 %tmp6, 1
    ret i64 %tmp7
}

define i32 @"main"() {
entry:
    %tmp8 = alloca i64
    store i64 40, i64* %tmp8
    %tmp9 = load i64, i64* %tmp8
    %tmp10 = alloca i64
    store i64 %tmp9, i64* %tmp10
    %tmp11 = load i64, i64* %tmp10
    %tmp12 = load i64, i64* %tmp10
    %tmp13 = icmp ne i64 %tmp12, 40
    br i1 %tmp13, label %if_then.0, label %if_else.1
if_then.0:
    %tmp14 = trunc i64 1 to i32
    ret i32 %tmp14
if_else.1:
    br label %if_end.2
if_end.2:
    %tmp15 = load i64, i64* %tmp8
    %tmp16 = call i64 @"main.add_i64"(i64 %tmp15)
    %tmp17 = alloca i64
    store i64 %tmp16, i64* %tmp17
    %tmp18 = load i64, i64* %tmp17
    %tmp19 = load i64, i64* %tmp17
    %tmp20 = icmp ne i64 %tmp19, 41
    br i1 %tmp20, label %if_then.3, label %if_else.4
if_then.3:
    %tmp21 = trunc i64 2 to i32
    ret i32 %tmp21
if_else.4:
    br label %if_end.5
if_end.5:
    %tmp22 = alloca i64
    store i64 9, i64* %tmp22
    %tmp23 = load i64, i64* %tmp22
    %tmp24 = alloca i64
    store i64 %tmp23, i64* %tmp24
    %tmp25 = load i64, i64* %tmp24
    %tmp26 = load i64, i64* %tmp24
    %tmp27 = icmp ne i64 %tmp26, 9
    br i1 %tmp27, label %if_then.6, label %if_else.7
if_then.6:
    %tmp28 = trunc i64 3 to i32
    ret i32 %tmp28
if_else.7:
    br label %if_end.8
if_end.8:
    %tmp29 = load i64, i64* %tmp22
    %tmp30 = call i64 @"main.add_u64"(i64 %tmp29)
    %tmp31 = alloca i64
    store i64 %tmp30, i64* %tmp31
    %tmp32 = load i64, i64* %tmp31
    %tmp33 = load i64, i64* %tmp31
    %tmp34 = icmp ne i64 %tmp33, 10
    br i1 %tmp34, label %if_then.9, label %if_else.10
if_then.9:
    %tmp35 = trunc i64 4 to i32
    ret i32 %tmp35
if_else.10:
    br label %if_end.11
if_end.11:
    %tmp36 = alloca double
    store double 1.5, double* %tmp36
    %tmp37 = load double, double* %tmp36
    %tmp38 = alloca double
    store double %tmp37, double* %tmp38
    %tmp39 = load double, double* %tmp38
    %tmp40 = load double, double* %tmp38
    %tmp41 = fcmp olt double %tmp40, 1.49
    %tmp42 = load double, double* %tmp38
    %tmp43 = load double, double* %tmp38
    %tmp44 = fcmp ogt double %tmp43, 1.51
    %tmp45 = or i1 %tmp41, %tmp44
    br i1 %tmp45, label %if_then.12, label %if_else.13
if_then.12:
    %tmp46 = trunc i64 5 to i32
    ret i32 %tmp46
if_else.13:
    br label %if_end.14
if_end.14:
    %tmp47 = trunc i64 0 to i32
    ret i32 %tmp47
}

