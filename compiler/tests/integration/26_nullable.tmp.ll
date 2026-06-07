; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

define i64 @"main.get_val_or_default"(i64* %p) {
entry:
    %tmp0 = alloca i64*
    store i64* %p, i64** %tmp0
    %tmp1 = load i64*, i64** %tmp0
    %tmp2 = load i64*, i64** %tmp0
    %tmp3 = icmp ne i64* %tmp2, null
    br i1 %tmp3, label %if_then.0, label %if_else.1
if_then.0:
    %tmp4 = load i64*, i64** %tmp0
    %tmp5 = load i64, i64* %tmp4
    ret i64 %tmp5
if_else.1:
    br label %if_end.2
if_end.2:
    ret i64 42
}

define i32 @"main"() {
entry:
    %tmp6 = alloca i64*
    store i64* null, i64** %tmp6
    %tmp7 = load i64*, i64** %tmp6
    %tmp8 = call i64 @"main.get_val_or_default"(i64* %tmp7)
    %tmp9 = trunc i64 %tmp8 to i32
    ret i32 %tmp9
}

