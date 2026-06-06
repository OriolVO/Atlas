; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
    %tmp0 = alloca [5 x i64]
    store [5 x i64] zeroinitializer, [5 x i64]* %tmp0
    %tmp1 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 0
    store i64 5, i64* %tmp1
    %tmp2 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 1
    store i64 10, i64* %tmp2
    %tmp3 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 2
    store i64 15, i64* %tmp3
    %tmp4 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 3
    store i64 20, i64* %tmp4
    %tmp5 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 4
    store i64 25, i64* %tmp5
    %tmp6 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 0
    %tmp7 = load i64, i64* %tmp6
    %tmp8 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 1
    %tmp9 = load i64, i64* %tmp8
    %tmp10 = add i64 %tmp7, %tmp9
    %tmp11 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 2
    %tmp12 = load i64, i64* %tmp11
    %tmp13 = add i64 %tmp10, %tmp12
    %tmp14 = alloca i64
    store i64 %tmp13, i64* %tmp14
    %tmp15 = load i64, i64* %tmp14
    %tmp16 = trunc i64 %tmp15 to i32
    ret i32 %tmp16
}

