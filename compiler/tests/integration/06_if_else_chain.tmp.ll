; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

define i32 @"main"() {
entry:
    %tmp0 = alloca i64
    store i64 0, i64* %tmp0
    %tmp1 = load i64, i64* %tmp0
    %tmp2 = load i64, i64* %tmp0
    %tmp3 = icmp sgt i64 %tmp2, 0
    br i1 %tmp3, label %if_then.0, label %if_else.1
if_then.0:
    %tmp4 = trunc i64 1 to i32
    ret i32 %tmp4
if_else.1:
    %tmp5 = load i64, i64* %tmp0
    %tmp6 = load i64, i64* %tmp0
    %tmp7 = icmp eq i64 %tmp6, 0
    br i1 %tmp7, label %elseif_then.3, label %elseif_else.4
elseif_then.3:
    %tmp8 = trunc i64 2 to i32
    ret i32 %tmp8
elseif_else.4:
    %tmp9 = trunc i64 3 to i32
    ret i32 %tmp9
if_end.2:
    ret i32 0
}

