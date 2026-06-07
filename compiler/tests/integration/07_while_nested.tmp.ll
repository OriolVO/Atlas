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
    store i64 0, i64* %tmp1
    br label %while_cond.0
while_cond.0:
    %tmp2 = load i64, i64* %tmp1
    %tmp3 = load i64, i64* %tmp1
    %tmp4 = icmp slt i64 %tmp3, 10
    br i1 %tmp4, label %while_body.1, label %while_end.2
while_body.1:
    %tmp5 = alloca i64
    store i64 0, i64* %tmp5
    br label %while_cond.3
while_cond.3:
    %tmp6 = load i64, i64* %tmp5
    %tmp7 = load i64, i64* %tmp5
    %tmp8 = icmp slt i64 %tmp7, 10
    br i1 %tmp8, label %while_body.4, label %while_end.5
while_body.4:
    %tmp9 = load i64, i64* %tmp0
    %tmp10 = load i64, i64* %tmp0
    %tmp11 = add i64 %tmp10, 1
    store i64 %tmp11, i64* %tmp0
    %tmp12 = load i64, i64* %tmp5
    %tmp13 = load i64, i64* %tmp5
    %tmp14 = add i64 %tmp13, 1
    store i64 %tmp14, i64* %tmp5
    br label %while_cond.3
while_end.5:
    %tmp15 = load i64, i64* %tmp1
    %tmp16 = load i64, i64* %tmp1
    %tmp17 = add i64 %tmp16, 1
    store i64 %tmp17, i64* %tmp1
    br label %while_cond.0
while_end.2:
    %tmp18 = load i64, i64* %tmp0
    %tmp19 = trunc i64 %tmp18 to i32
    ret i32 %tmp19
}

