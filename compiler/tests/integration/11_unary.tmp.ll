; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
    %tmp0 = sub i64 0, 5
    %tmp1 = alloca i64
    store i64 %tmp0, i64* %tmp1
    %tmp2 = xor i1 0, true
    %tmp3 = alloca i1
    store i1 %tmp2, i1* %tmp3
    %tmp4 = load i1, i1* %tmp3
    br i1 %tmp4, label %if_then.0, label %if_else.1
if_then.0:
    %tmp5 = load i64, i64* %tmp1
    %tmp6 = sub i64 0, %tmp5
    %tmp7 = trunc i64 %tmp6 to i32
    ret i32 %tmp7
if_else.1:
    br label %if_end.2
if_end.2:
    %tmp8 = trunc i64 0 to i32
    ret i32 %tmp8
}

