; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

define i64 @"main.square"(i64 %x) {
entry:
    %tmp0 = alloca i64
    store i64 %x, i64* %tmp0
    %tmp1 = load i64, i64* %tmp0
    %tmp2 = load i64, i64* %tmp0
    %tmp3 = load i64, i64* %tmp0
    %tmp4 = mul i64 %tmp2, %tmp3
    ret i64 %tmp4
}

define i64 @"main.sum_of_squares"(i64 %a, i64 %b) {
entry:
    %tmp5 = alloca i64
    store i64 %a, i64* %tmp5
    %tmp6 = alloca i64
    store i64 %b, i64* %tmp6
    %tmp7 = load i64, i64* %tmp5
    %tmp8 = call i64 @"main.square"(i64 %tmp7)
    %tmp9 = load i64, i64* %tmp5
    %tmp10 = call i64 @"main.square"(i64 %tmp9)
    %tmp11 = load i64, i64* %tmp6
    %tmp12 = call i64 @"main.square"(i64 %tmp11)
    %tmp13 = add i64 %tmp10, %tmp12
    ret i64 %tmp13
}

define i32 @"main"() {
entry:
    %tmp14 = call i64 @"main.sum_of_squares"(i64 5, i64 2)
    %tmp15 = trunc i64 %tmp14 to i32
    ret i32 %tmp15
}

