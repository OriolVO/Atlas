; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @main.sum_slice({ i64*, i64 } %s) {
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
    %tmp4 = load { i64*, i64 }, { i64*, i64 }* %tmp0
    %tmp5 = extractvalue { i64*, i64 } %tmp4, 1
    %tmp6 = icmp slt i64 %tmp3, %tmp5
    br i1 %tmp6, label %while_body.1, label %while_end.2
while_body.1:
    %tmp7 = load i64, i64* %tmp1
    %tmp8 = load i64, i64* %tmp2
    %tmp9 = load { i64*, i64 }, { i64*, i64 }* %tmp0
    %tmp10 = load { i64*, i64 }, { i64*, i64 }* %tmp0
    %tmp11 = extractvalue { i64*, i64 } %tmp10, 0
    %tmp12 = getelementptr inbounds i64, i64* %tmp11, i64 %tmp8
    %tmp13 = load i64, i64* %tmp12
    %tmp14 = add i64 %tmp7, %tmp13
    store i64 %tmp14, i64* %tmp1
    %tmp15 = load i64, i64* %tmp2
    %tmp16 = add i64 %tmp15, 1
    store i64 %tmp16, i64* %tmp2
    br label %while_cond.0
while_end.2:
    %tmp17 = load i64, i64* %tmp1
    ret i64 %tmp17
}

define i32 @main() {
entry:
    %tmp18 = alloca [4 x i64]
    store [4 x i64] zeroinitializer, [4 x i64]* %tmp18
    %tmp19 = getelementptr inbounds [4 x i64], [4 x i64]* %tmp18, i64 0, i64 0
    store i64 3, i64* %tmp19
    %tmp20 = getelementptr inbounds [4 x i64], [4 x i64]* %tmp18, i64 0, i64 1
    store i64 9, i64* %tmp20
    %tmp21 = getelementptr inbounds [4 x i64], [4 x i64]* %tmp18, i64 0, i64 2
    store i64 12, i64* %tmp21
    %tmp22 = getelementptr inbounds [4 x i64], [4 x i64]* %tmp18, i64 0, i64 3
    store i64 21, i64* %tmp22
    %tmp23 = load [4 x i64], [4 x i64]* %tmp18
    %tmp24 = getelementptr inbounds [4 x i64], [4 x i64]* %tmp18, i64 0, i64 0
    %tmp25 = insertvalue { i64*, i64 } undef, i64* %tmp24, 0
    %tmp26 = insertvalue { i64*, i64 } %tmp25, i64 4, 1
    %tmp27 = call i64 @main.sum_slice({ i64*, i64 } %tmp26)
    %tmp28 = trunc i64 %tmp27 to i32
    ret i32 %tmp28
}

