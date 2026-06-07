; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

define i32 @"main"() {
entry:
    %tmp0 = alloca [5 x i64]
    store [5 x i64] zeroinitializer, [5 x i64]* %tmp0
    %tmp1 = load [5 x i64], [5 x i64]* %tmp0
    %tmp2 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 0
    store i64 5, i64* %tmp2
    %tmp3 = load [5 x i64], [5 x i64]* %tmp0
    %tmp4 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 1
    store i64 10, i64* %tmp4
    %tmp5 = load [5 x i64], [5 x i64]* %tmp0
    %tmp6 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 2
    store i64 15, i64* %tmp6
    %tmp7 = load [5 x i64], [5 x i64]* %tmp0
    %tmp8 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 3
    store i64 20, i64* %tmp8
    %tmp9 = load [5 x i64], [5 x i64]* %tmp0
    %tmp10 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 4
    store i64 25, i64* %tmp10
    %tmp11 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 0
    %tmp12 = load [5 x i64], [5 x i64]* %tmp0
    %tmp13 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 0
    %tmp14 = load i64, i64* %tmp13
    %tmp15 = load [5 x i64], [5 x i64]* %tmp0
    %tmp16 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 0
    %tmp17 = load i64, i64* %tmp16
    %tmp18 = load [5 x i64], [5 x i64]* %tmp0
    %tmp19 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 1
    %tmp20 = load i64, i64* %tmp19
    %tmp21 = add i64 %tmp17, %tmp20
    %tmp22 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 0
    %tmp23 = load [5 x i64], [5 x i64]* %tmp0
    %tmp24 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 0
    %tmp25 = load i64, i64* %tmp24
    %tmp26 = load [5 x i64], [5 x i64]* %tmp0
    %tmp27 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 0
    %tmp28 = load i64, i64* %tmp27
    %tmp29 = load [5 x i64], [5 x i64]* %tmp0
    %tmp30 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 1
    %tmp31 = load i64, i64* %tmp30
    %tmp32 = add i64 %tmp28, %tmp31
    %tmp33 = load [5 x i64], [5 x i64]* %tmp0
    %tmp34 = getelementptr inbounds [5 x i64], [5 x i64]* %tmp0, i64 0, i64 2
    %tmp35 = load i64, i64* %tmp34
    %tmp36 = add i64 %tmp32, %tmp35
    %tmp37 = alloca i64
    store i64 %tmp36, i64* %tmp37
    %tmp38 = load i64, i64* %tmp37
    %tmp39 = trunc i64 %tmp38 to i32
    ret i32 %tmp39
}

