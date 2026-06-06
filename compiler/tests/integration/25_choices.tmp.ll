; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%choice.main.OptionInt = type { i32, [8 x i8] }


define i64 @main.get_val(%choice.main.OptionInt %o) {
entry:
    %tmp0 = alloca %choice.main.OptionInt
    store %choice.main.OptionInt %o, %choice.main.OptionInt* %tmp0
    %tmp1 = load %choice.main.OptionInt, %choice.main.OptionInt* %tmp0
    %tmp2 = alloca %choice.main.OptionInt
    store %choice.main.OptionInt %tmp1, %choice.main.OptionInt* %tmp2
    %tmp3 = getelementptr inbounds %choice.main.OptionInt, %choice.main.OptionInt* %tmp2, i32 0, i32 0
    %tmp4 = load i32, i32* %tmp3
    %tmp5 = icmp eq i32 %tmp4, 0
    br i1 %tmp5, label %match_case_body.1, label %match_case_next.2
match_case_body.1:
    %tmp6 = getelementptr inbounds %choice.main.OptionInt, %choice.main.OptionInt* %tmp2, i32 0, i32 1
    %tmp7 = bitcast [8 x i8]* %tmp6 to i64*
    %tmp8 = load i64, i64* %tmp7
    %tmp9 = alloca i64
    store i64 %tmp8, i64* %tmp9
    %tmp10 = load i64, i64* %tmp9
    ret i64 %tmp10
match_case_next.2:
    %tmp11 = icmp eq i32 %tmp4, 1
    br i1 %tmp11, label %match_case_body.3, label %match_end.0
match_case_body.3:
    ret i64 0
match_end.0:
    ret i64 0
}

define i32 @main() {
entry:
    %tmp12 = alloca %choice.main.OptionInt
    %tmp13 = getelementptr inbounds %choice.main.OptionInt, %choice.main.OptionInt* %tmp12, i32 0, i32 0
    store i32 0, i32* %tmp13
    %tmp14 = getelementptr inbounds %choice.main.OptionInt, %choice.main.OptionInt* %tmp12, i32 0, i32 1
    store [8 x i8] zeroinitializer, [8 x i8]* %tmp14
    %tmp15 = bitcast [8 x i8]* %tmp14 to i64*
    store i64 42, i64* %tmp15
    %tmp16 = load %choice.main.OptionInt, %choice.main.OptionInt* %tmp12
    %tmp17 = alloca %choice.main.OptionInt
    store %choice.main.OptionInt %tmp16, %choice.main.OptionInt* %tmp17
    %tmp18 = load %choice.main.OptionInt, %choice.main.OptionInt* %tmp17
    %tmp19 = call i64 @main.get_val(%choice.main.OptionInt %tmp18)
    %tmp20 = trunc i64 %tmp19 to i32
    ret i32 %tmp20
}

