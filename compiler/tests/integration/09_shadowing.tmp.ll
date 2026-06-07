; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

define i32 @"main"() {
entry:
    %tmp0 = alloca i64
    store i64 10, i64* %tmp0
    %tmp1 = alloca i64
    store i64 30, i64* %tmp1
    %tmp2 = load i64, i64* %tmp1
    %tmp3 = load i64, i64* %tmp1
    %tmp4 = icmp eq i64 %tmp3, 30
    br i1 %tmp4, label %if_then.0, label %if_else.1
if_then.0:
    %tmp5 = alloca i64
    store i64 40, i64* %tmp5
    %tmp6 = load i64, i64* %tmp5
    %tmp7 = trunc i64 %tmp6 to i32
    ret i32 %tmp7
if_else.1:
    br label %if_end.2
if_end.2:
    %tmp8 = load i64, i64* %tmp0
    %tmp9 = trunc i64 %tmp8 to i32
    ret i32 %tmp9
}

