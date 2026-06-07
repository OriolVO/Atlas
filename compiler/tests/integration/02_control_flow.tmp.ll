; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

define i32 @"main"() {
entry:
    %tmp0 = alloca i64
    store i64 0, i64* %tmp0
    %tmp1 = alloca i64
    store i64 1, i64* %tmp1
    br label %while_cond.0
while_cond.0:
    %tmp2 = load i64, i64* %tmp1
    %tmp3 = load i64, i64* %tmp1
    %tmp4 = icmp sle i64 %tmp3, 10
    br i1 %tmp4, label %while_body.1, label %while_end.2
while_body.1:
    %tmp5 = load i64, i64* %tmp0
    %tmp6 = load i64, i64* %tmp0
    %tmp7 = load i64, i64* %tmp1
    %tmp8 = add i64 %tmp6, %tmp7
    store i64 %tmp8, i64* %tmp0
    %tmp9 = load i64, i64* %tmp1
    %tmp10 = load i64, i64* %tmp1
    %tmp11 = add i64 %tmp10, 1
    store i64 %tmp11, i64* %tmp1
    br label %while_cond.0
while_end.2:
    %tmp12 = load i64, i64* %tmp0
    %tmp13 = trunc i64 %tmp12 to i32
    ret i32 %tmp13
}

