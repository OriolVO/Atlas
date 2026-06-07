; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

%struct.main.Pair = type { i64, i64 }


define i32 @"main"() {
entry:
    %tmp0 = alloca i64*
    store i64* zeroinitializer, i64** %tmp0
    %tmp1 = load i64*, i64** %tmp0
    %tmp2 = load i64*, i64** %tmp0
    %tmp3 = icmp ne i64* %tmp2, null
    br i1 %tmp3, label %if_then.0, label %if_else.1
if_then.0:
    %tmp4 = trunc i64 1 to i32
    ret i32 %tmp4
if_else.1:
    br label %if_end.2
if_end.2:
    %tmp5 = alloca i64
    store i64 zeroinitializer, i64* %tmp5
    %tmp6 = load i64, i64* %tmp5
    %tmp7 = load i64, i64* %tmp5
    %tmp8 = icmp ne i64 %tmp7, 0
    br i1 %tmp8, label %if_then.3, label %if_else.4
if_then.3:
    %tmp9 = trunc i64 2 to i32
    ret i32 %tmp9
if_else.4:
    br label %if_end.5
if_end.5:
    %tmp10 = alloca %struct.main.Pair
    store %struct.main.Pair zeroinitializer, %struct.main.Pair* %tmp10
    %tmp11 = getelementptr inbounds %struct.main.Pair, %struct.main.Pair* %tmp10, i32 0, i32 0
    %tmp12 = load %struct.main.Pair, %struct.main.Pair* %tmp10
    %tmp13 = getelementptr inbounds %struct.main.Pair, %struct.main.Pair* %tmp10, i32 0, i32 0
    %tmp14 = load i64, i64* %tmp13
    %tmp15 = load %struct.main.Pair, %struct.main.Pair* %tmp10
    %tmp16 = getelementptr inbounds %struct.main.Pair, %struct.main.Pair* %tmp10, i32 0, i32 0
    %tmp17 = load i64, i64* %tmp16
    %tmp18 = icmp ne i64 %tmp17, 0
    %tmp19 = getelementptr inbounds %struct.main.Pair, %struct.main.Pair* %tmp10, i32 0, i32 1
    %tmp20 = load %struct.main.Pair, %struct.main.Pair* %tmp10
    %tmp21 = getelementptr inbounds %struct.main.Pair, %struct.main.Pair* %tmp10, i32 0, i32 1
    %tmp22 = load i64, i64* %tmp21
    %tmp23 = load %struct.main.Pair, %struct.main.Pair* %tmp10
    %tmp24 = getelementptr inbounds %struct.main.Pair, %struct.main.Pair* %tmp10, i32 0, i32 1
    %tmp25 = load i64, i64* %tmp24
    %tmp26 = icmp ne i64 %tmp25, 0
    %tmp27 = or i1 %tmp18, %tmp26
    br i1 %tmp27, label %if_then.6, label %if_else.7
if_then.6:
    %tmp28 = trunc i64 3 to i32
    ret i32 %tmp28
if_else.7:
    br label %if_end.8
if_end.8:
    %tmp29 = trunc i64 0 to i32
    ret i32 %tmp29
}

