; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

define i64 @"main.fib"(i64 %n) {
entry:
    %tmp0 = alloca i64
    store i64 %n, i64* %tmp0
    %tmp1 = load i64, i64* %tmp0
    %tmp2 = load i64, i64* %tmp0
    %tmp3 = icmp sle i64 %tmp2, 1
    br i1 %tmp3, label %if_then.0, label %if_else.1
if_then.0:
    %tmp4 = load i64, i64* %tmp0
    ret i64 %tmp4
if_else.1:
    br label %if_end.2
if_end.2:
    %tmp5 = load i64, i64* %tmp0
    %tmp6 = load i64, i64* %tmp0
    %tmp7 = sub i64 %tmp6, 1
    %tmp8 = call i64 @"main.fib"(i64 %tmp7)
    %tmp9 = load i64, i64* %tmp0
    %tmp10 = load i64, i64* %tmp0
    %tmp11 = sub i64 %tmp10, 1
    %tmp12 = call i64 @"main.fib"(i64 %tmp11)
    %tmp13 = load i64, i64* %tmp0
    %tmp14 = load i64, i64* %tmp0
    %tmp15 = sub i64 %tmp14, 2
    %tmp16 = call i64 @"main.fib"(i64 %tmp15)
    %tmp17 = add i64 %tmp12, %tmp16
    ret i64 %tmp17
}

define i32 @"main"() {
entry:
    %tmp18 = call i64 @"main.fib"(i64 10)
    %tmp19 = trunc i64 %tmp18 to i32
    ret i32 %tmp19
}

