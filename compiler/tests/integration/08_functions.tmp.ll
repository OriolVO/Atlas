; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @main.square(i64 %x) {
entry:
    %tmp0 = alloca i64
    store i64 %x, i64* %tmp0
    %tmp1 = load i64, i64* %tmp0
    %tmp2 = load i64, i64* %tmp0
    %tmp3 = mul i64 %tmp1, %tmp2
    ret i64 %tmp3
}

define i64 @main.sum_of_squares(i64 %a, i64 %b) {
entry:
    %tmp4 = alloca i64
    store i64 %a, i64* %tmp4
    %tmp5 = alloca i64
    store i64 %b, i64* %tmp5
    %tmp6 = load i64, i64* %tmp4
    %tmp7 = call i64 @main.square(i64 %tmp6)
    %tmp8 = load i64, i64* %tmp5
    %tmp9 = call i64 @main.square(i64 %tmp8)
    %tmp10 = add i64 %tmp7, %tmp9
    ret i64 %tmp10
}

define i32 @main() {
entry:
    %tmp11 = call i64 @main.sum_of_squares(i64 5, i64 2)
    %tmp12 = trunc i64 %tmp11 to i32
    ret i32 %tmp12
}

