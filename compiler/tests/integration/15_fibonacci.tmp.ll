; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @main.fib(i64 %n) {
entry:
    %tmp0 = alloca i64
    store i64 %n, i64* %tmp0
    %tmp1 = load i64, i64* %tmp0
    %tmp2 = icmp sle i64 %tmp1, 1
    br i1 %tmp2, label %if_then.0, label %if_else.1
if_then.0:
    %tmp3 = load i64, i64* %tmp0
    ret i64 %tmp3
if_else.1:
    br label %if_end.2
if_end.2:
    %tmp4 = load i64, i64* %tmp0
    %tmp5 = sub i64 %tmp4, 1
    %tmp6 = call i64 @main.fib(i64 %tmp5)
    %tmp7 = load i64, i64* %tmp0
    %tmp8 = sub i64 %tmp7, 2
    %tmp9 = call i64 @main.fib(i64 %tmp8)
    %tmp10 = add i64 %tmp6, %tmp9
    ret i64 %tmp10
}

define i32 @main() {
entry:
    %tmp11 = call i64 @main.fib(i64 10)
    %tmp12 = trunc i64 %tmp11 to i32
    ret i32 %tmp12
}

