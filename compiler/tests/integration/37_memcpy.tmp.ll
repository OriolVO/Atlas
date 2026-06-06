; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i8* @malloc(i64)
declare void @free(i8*)
declare i8* @memcpy(i8*, i8*, i64)
define i32 @main() {
entry:
    %tmp0 = call i8* @malloc(i64 8)
    %tmp1 = bitcast i8* %tmp0 to i64*
    %tmp2 = alloca i64*
    store i64* %tmp1, i64** %tmp2
    %tmp3 = call i8* @malloc(i64 8)
    %tmp4 = bitcast i8* %tmp3 to i64*
    %tmp5 = alloca i64*
    store i64* %tmp4, i64** %tmp5
    %tmp6 = load i64*, i64** %tmp2
    %tmp7 = getelementptr inbounds i64, i64* %tmp6, i64 0
    store i64 42, i64* %tmp7
    %tmp8 = load i64*, i64** %tmp5
    %tmp9 = bitcast i64* %tmp8 to i8*
    %tmp10 = load i64*, i64** %tmp2
    %tmp11 = bitcast i64* %tmp10 to i8*
    %tmp12 = call i8* @memcpy(i8* %tmp9, i8* %tmp11, i64 4)
    %tmp13 = load i64*, i64** %tmp5
    %tmp14 = getelementptr inbounds i64, i64* %tmp13, i64 0
    %tmp15 = load i64, i64* %tmp14
    %tmp16 = alloca i64
    store i64 %tmp15, i64* %tmp16
    %tmp17 = load i64, i64* %tmp16
    %tmp18 = trunc i64 %tmp17 to i32
    ret i32 %tmp18
}

