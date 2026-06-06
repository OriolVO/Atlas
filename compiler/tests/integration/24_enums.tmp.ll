; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @main.dir_to_code(i32 %d) {
entry:
    %tmp0 = alloca i32
    store i32 %d, i32* %tmp0
    %tmp1 = load i32, i32* %tmp0
    %tmp2 = icmp eq i32 %tmp1, 0
    br i1 %tmp2, label %match_case_body.1, label %match_case_next.2
match_case_body.1:
    ret i64 10
match_case_next.2:
    %tmp3 = icmp eq i32 %tmp1, 1
    br i1 %tmp3, label %match_case_body.3, label %match_case_next.4
match_case_body.3:
    ret i64 20
match_case_next.4:
    %tmp4 = icmp eq i32 %tmp1, 2
    br i1 %tmp4, label %match_case_body.5, label %match_case_next.6
match_case_body.5:
    ret i64 30
match_case_next.6:
    %tmp5 = icmp eq i32 %tmp1, 3
    br i1 %tmp5, label %match_case_body.7, label %match_end.0
match_case_body.7:
    ret i64 42
match_end.0:
    ret i64 0
}

define i32 @main() {
entry:
    %tmp6 = alloca i32
    store i32 3, i32* %tmp6
    %tmp7 = load i32, i32* %tmp6
    %tmp8 = call i64 @main.dir_to_code(i32 %tmp7)
    %tmp9 = trunc i64 %tmp8 to i32
    ret i32 %tmp9
}

