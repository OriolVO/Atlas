; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

define i64 @"main.sum_slice"({ i64*, i64 } %s) {
entry:
    %tmp0 = alloca { i64*, i64 }
    store { i64*, i64 } %s, { i64*, i64 }* %tmp0
    %tmp1 = alloca i64
    store i64 0, i64* %tmp1
    %tmp2 = alloca i64
    store i64 0, i64* %tmp2
    br label %while_cond.0
while_cond.0:
    %tmp3 = load i64, i64* %tmp2
    %tmp4 = load i64, i64* %tmp2
    %tmp5 = load { i64*, i64 }, { i64*, i64 }* %tmp0
    %tmp6 = extractvalue { i64*, i64 } %tmp5, 1
    %tmp7 = icmp slt i64 %tmp4, %tmp6
    br i1 %tmp7, label %while_body.1, label %while_end.2
while_body.1:
    %tmp8 = load i64, i64* %tmp1
    %tmp9 = load i64, i64* %tmp1
    %tmp10 = load { i64*, i64 }, { i64*, i64 }* %tmp0
    %tmp11 = load i64, i64* %tmp2
    %tmp12 = load { i64*, i64 }, { i64*, i64 }* %tmp0
    %tmp13 = load { i64*, i64 }, { i64*, i64 }* %tmp0
    %tmp14 = extractvalue { i64*, i64 } %tmp13, 0
    %tmp15 = getelementptr inbounds i64, i64* %tmp14, i64 %tmp11
    %tmp16 = load i64, i64* %tmp15
    %tmp17 = add i64 %tmp9, %tmp16
    store i64 %tmp17, i64* %tmp1
    %tmp18 = load i64, i64* %tmp2
    %tmp19 = load i64, i64* %tmp2
    %tmp20 = add i64 %tmp19, 1
    store i64 %tmp20, i64* %tmp2
    br label %while_cond.0
while_end.2:
    %tmp21 = load i64, i64* %tmp1
    ret i64 %tmp21
}

define i32 @"main"() {
entry:
    %tmp22 = alloca [4 x i64]
    store [4 x i64] zeroinitializer, [4 x i64]* %tmp22
    %tmp23 = load [4 x i64], [4 x i64]* %tmp22
    %tmp24 = getelementptr inbounds [4 x i64], [4 x i64]* %tmp22, i64 0, i64 0
    store i64 3, i64* %tmp24
    %tmp25 = load [4 x i64], [4 x i64]* %tmp22
    %tmp26 = getelementptr inbounds [4 x i64], [4 x i64]* %tmp22, i64 0, i64 1
    store i64 9, i64* %tmp26
    %tmp27 = load [4 x i64], [4 x i64]* %tmp22
    %tmp28 = getelementptr inbounds [4 x i64], [4 x i64]* %tmp22, i64 0, i64 2
    store i64 12, i64* %tmp28
    %tmp29 = load [4 x i64], [4 x i64]* %tmp22
    %tmp30 = getelementptr inbounds [4 x i64], [4 x i64]* %tmp22, i64 0, i64 3
    store i64 21, i64* %tmp30
    %tmp31 = load [4 x i64], [4 x i64]* %tmp22
    %tmp32 = getelementptr inbounds [4 x i64], [4 x i64]* %tmp22, i64 0, i64 0
    %tmp33 = insertvalue { i64*, i64 } undef, i64* %tmp32, 0
    %tmp34 = insertvalue { i64*, i64 } %tmp33, i64 4, 1
    %tmp35 = call i64 @"main.sum_slice"({ i64*, i64 } %tmp34)
    %tmp36 = trunc i64 %tmp35 to i32
    ret i32 %tmp36
}

