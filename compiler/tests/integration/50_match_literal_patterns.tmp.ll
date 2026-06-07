; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

define i64 @"main.classify"(i64 %n) {
entry:
    %tmp0 = alloca i64
    store i64 %n, i64* %tmp0
    %tmp1 = load i64, i64* %tmp0
    %tmp2 = icmp eq i64 %tmp1, 0
    br i1 %tmp2, label %match_case_body.1, label %match_case_next.2
match_case_body.1:
    ret i64 10
match_case_next.2:
    %tmp3 = icmp eq i64 %tmp1, 1
    br i1 %tmp3, label %match_case_body.3, label %match_case_next.4
match_case_body.3:
    ret i64 20
match_case_next.4:
    ret i64 30
match_end.0:
    ret i64 99
}

define i32 @"main"() {
entry:
    %tmp4 = call i64 @"main.classify"(i64 0)
    %tmp5 = call i64 @"main.classify"(i64 0)
    %tmp6 = icmp ne i64 %tmp5, 10
    br i1 %tmp6, label %if_then.6, label %if_else.7
if_then.6:
    %tmp7 = trunc i64 1 to i32
    ret i32 %tmp7
if_else.7:
    br label %if_end.8
if_end.8:
    %tmp8 = call i64 @"main.classify"(i64 1)
    %tmp9 = call i64 @"main.classify"(i64 1)
    %tmp10 = icmp ne i64 %tmp9, 20
    br i1 %tmp10, label %if_then.9, label %if_else.10
if_then.9:
    %tmp11 = trunc i64 2 to i32
    ret i32 %tmp11
if_else.10:
    br label %if_end.11
if_end.11:
    %tmp12 = call i64 @"main.classify"(i64 7)
    %tmp13 = call i64 @"main.classify"(i64 7)
    %tmp14 = icmp ne i64 %tmp13, 30
    br i1 %tmp14, label %if_then.12, label %if_else.13
if_then.12:
    %tmp15 = trunc i64 3 to i32
    ret i32 %tmp15
if_else.13:
    br label %if_end.14
if_end.14:
    %tmp16 = trunc i64 0 to i32
    ret i32 %tmp16
}

