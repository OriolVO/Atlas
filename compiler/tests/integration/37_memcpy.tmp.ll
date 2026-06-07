; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

declare i8* @"malloc"(i64)
declare void @"free"(i8*)
declare i8* @"memcpy"(i8*, i8*, i64)
define i32 @"main"() {
entry:
    %tmp0 = call i8* @"malloc"(i64 8)
    %tmp1 = bitcast i8* %tmp0 to i64*
    %tmp2 = alloca i64*
    store i64* %tmp1, i64** %tmp2
    %tmp3 = call i8* @"malloc"(i64 8)
    %tmp4 = bitcast i8* %tmp3 to i64*
    %tmp5 = alloca i64*
    store i64* %tmp4, i64** %tmp5
    %tmp6 = load i64*, i64** %tmp2
    %tmp7 = load i64*, i64** %tmp2
    %tmp8 = getelementptr inbounds i64, i64* %tmp7, i64 0
    store i64 42, i64* %tmp8
    %tmp9 = load i64*, i64** %tmp5
    %tmp10 = bitcast i64* %tmp9 to i8*
    %tmp11 = load i64*, i64** %tmp2
    %tmp12 = bitcast i64* %tmp11 to i8*
    %tmp13 = call i8* @"memcpy"(i8* %tmp10, i8* %tmp12, i64 4)
    %tmp14 = load i64*, i64** %tmp5
    %tmp15 = load i64*, i64** %tmp5
    %tmp16 = getelementptr inbounds i64, i64* %tmp15, i64 0
    %tmp17 = load i64, i64* %tmp16
    %tmp18 = alloca i64
    store i64 %tmp17, i64* %tmp18
    %tmp19 = load i64, i64* %tmp18
    %tmp20 = trunc i64 %tmp19 to i32
    ret i32 %tmp20
}

