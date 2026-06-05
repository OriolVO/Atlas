; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
    %tmp0 = alloca i64
    store i64 0, i64* %tmp0
    %tmp1 = load i64, i64* %tmp0
    %tmp2 = icmp sgt i64 %tmp1, 0
    br i1 %tmp2, label %if_then.0, label %if_else.1
if_then.0:
    %tmp3 = trunc i64 1 to i32
    ret i32 %tmp3
if_else.1:
    %tmp4 = load i64, i64* %tmp0
    %tmp5 = icmp eq i64 %tmp4, 0
    br i1 %tmp5, label %elseif_then.3, label %elseif_else.4
elseif_then.3:
    %tmp6 = trunc i64 2 to i32
    ret i32 %tmp6
elseif_else.4:
    %tmp7 = trunc i64 3 to i32
    ret i32 %tmp7
if_end.2:
    ret i32 0
}

