; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @putchar(i32)
define i32 @main() {
entry:
    %tmp0 = alloca i64
    store i64 0, i64* %tmp0
    %tmp1 = alloca i64
    store i64 0, i64* %tmp1
    br label %while_cond.0
while_cond.0:
    %tmp2 = load i64, i64* %tmp1
    %tmp3 = icmp slt i64 %tmp2, 5
    br i1 %tmp3, label %while_body.1, label %while_end.2
while_body.1:
    %tmp4 = load i64, i64* %tmp0
    %tmp5 = load i64, i64* %tmp1
    %tmp6 = add i64 %tmp4, %tmp5
    store i64 %tmp6, i64* %tmp0
    %tmp7 = load i64, i64* %tmp1
    %tmp8 = add i64 %tmp7, 1
    store i64 %tmp8, i64* %tmp1
    br label %while_cond.0
while_end.2:
    %tmp9 = load i64, i64* %tmp0
    %tmp10 = icmp eq i64 %tmp9, 10
    br i1 %tmp10, label %if_then.3, label %if_else.4
if_then.3:
    %tmp11 = call i32 @putchar(i32 42)
    %tmp12 = call i32 @putchar(i32 10)
    br label %if_end.5
if_else.4:
    br label %if_end.5
if_end.5:
    %tmp13 = trunc i64 0 to i32
    ret i32 %tmp13
}

