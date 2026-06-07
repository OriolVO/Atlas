; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

%choice.result.Result_int_int = type { i32, [8 x i8] }


define %choice.result.Result_int_int @"main.compute"(i64 %val) {
entry:
    %tmp0 = alloca i64
    store i64 %val, i64* %tmp0
    %tmp1 = load i64, i64* %tmp0
    %tmp2 = load i64, i64* %tmp0
    %tmp3 = icmp slt i64 %tmp2, 0
    br i1 %tmp3, label %if_then.0, label %if_else.1
if_then.0:
    %tmp4 = alloca %choice.result.Result_int_int
    %tmp5 = getelementptr inbounds %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp4, i32 0, i32 0
    store i32 1, i32* %tmp5
    %tmp6 = getelementptr inbounds %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp4, i32 0, i32 1
    store [8 x i8] zeroinitializer, [8 x i8]* %tmp6
    %tmp7 = bitcast [8 x i8]* %tmp6 to i64*
    store i64 10, i64* %tmp7
    %tmp8 = load %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp4
    ret %choice.result.Result_int_int %tmp8
if_else.1:
    br label %if_end.2
if_end.2:
    %tmp9 = load i64, i64* %tmp0
    %tmp10 = alloca %choice.result.Result_int_int
    %tmp11 = getelementptr inbounds %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp10, i32 0, i32 0
    store i32 0, i32* %tmp11
    %tmp12 = getelementptr inbounds %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp10, i32 0, i32 1
    store [8 x i8] zeroinitializer, [8 x i8]* %tmp12
    %tmp13 = bitcast [8 x i8]* %tmp12 to i64*
    store i64 %tmp9, i64* %tmp13
    %tmp14 = load %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp10
    ret %choice.result.Result_int_int %tmp14
}

define %choice.result.Result_int_int @"main.try_propagate"(i64 %val) {
entry:
    %tmp15 = alloca i64
    store i64 %val, i64* %tmp15
    %tmp16 = load i64, i64* %tmp15
    %tmp17 = call %choice.result.Result_int_int @"main.compute"(i64 %tmp16)
    %tmp18 = alloca %choice.result.Result_int_int
    store %choice.result.Result_int_int %tmp17, %choice.result.Result_int_int* %tmp18
    %tmp19 = getelementptr inbounds %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp18, i32 0, i32 0
    %tmp20 = load i32, i32* %tmp19
    %tmp21 = icmp eq i32 %tmp20, 1
    %tmp22 = alloca i64
    br i1 %tmp21, label %err_prop_err.3, label %err_prop_ok.4
err_prop_err.3:
    %tmp23 = load %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp18
    ret %choice.result.Result_int_int %tmp23
err_prop_ok.4:
    %tmp24 = getelementptr inbounds %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp18, i32 0, i32 1
    %tmp25 = bitcast [8 x i8]* %tmp24 to i64*
    %tmp26 = load i64, i64* %tmp25
    store i64 %tmp26, i64* %tmp22
    br label %err_prop_cont.5
err_prop_cont.5:
    %tmp27 = load i64, i64* %tmp22
    %tmp28 = alloca i64
    store i64 %tmp27, i64* %tmp28
    %tmp29 = load i64, i64* %tmp28
    %tmp30 = load i64, i64* %tmp28
    %tmp31 = add i64 %tmp30, 2
    %tmp32 = alloca %choice.result.Result_int_int
    %tmp33 = getelementptr inbounds %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp32, i32 0, i32 0
    store i32 0, i32* %tmp33
    %tmp34 = getelementptr inbounds %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp32, i32 0, i32 1
    store [8 x i8] zeroinitializer, [8 x i8]* %tmp34
    %tmp35 = bitcast [8 x i8]* %tmp34 to i64*
    store i64 %tmp31, i64* %tmp35
    %tmp36 = load %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp32
    ret %choice.result.Result_int_int %tmp36
}

define i32 @"main"() {
entry:
    %tmp37 = call %choice.result.Result_int_int @"main.try_propagate"(i64 40)
    %tmp38 = alloca %choice.result.Result_int_int
    store %choice.result.Result_int_int %tmp37, %choice.result.Result_int_int* %tmp38
    %tmp39 = sub i64 0, 1
    %tmp40 = call %choice.result.Result_int_int @"main.try_propagate"(i64 %tmp39)
    %tmp41 = alloca %choice.result.Result_int_int
    store %choice.result.Result_int_int %tmp40, %choice.result.Result_int_int* %tmp41
    %tmp42 = alloca i64
    store i64 0, i64* %tmp42
    %tmp43 = load %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp38
    %tmp44 = alloca %choice.result.Result_int_int
    store %choice.result.Result_int_int %tmp43, %choice.result.Result_int_int* %tmp44
    %tmp45 = getelementptr inbounds %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp44, i32 0, i32 0
    %tmp46 = load i32, i32* %tmp45
    %tmp47 = icmp eq i32 %tmp46, 0
    br i1 %tmp47, label %match_case_body.7, label %match_case_next.8
match_case_body.7:
    %tmp48 = getelementptr inbounds %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp44, i32 0, i32 1
    %tmp49 = bitcast [8 x i8]* %tmp48 to i64*
    %tmp50 = load i64, i64* %tmp49
    %tmp51 = alloca i64
    store i64 %tmp50, i64* %tmp51
    %tmp52 = load i64, i64* %tmp42
    %tmp53 = load i64, i64* %tmp42
    %tmp54 = load i64, i64* %tmp51
    %tmp55 = add i64 %tmp53, %tmp54
    store i64 %tmp55, i64* %tmp42
    br label %match_end.6
match_case_next.8:
    %tmp56 = icmp eq i32 %tmp46, 1
    br i1 %tmp56, label %match_case_body.9, label %match_end.6
match_case_body.9:
    %tmp57 = getelementptr inbounds %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp44, i32 0, i32 1
    %tmp58 = bitcast [8 x i8]* %tmp57 to i64*
    %tmp59 = load i64, i64* %tmp58
    %tmp60 = alloca i64
    store i64 %tmp59, i64* %tmp60
    %tmp61 = load i64, i64* %tmp42
    %tmp62 = load i64, i64* %tmp42
    %tmp63 = load i64, i64* %tmp60
    %tmp64 = add i64 %tmp62, %tmp63
    store i64 %tmp64, i64* %tmp42
    br label %match_end.6
match_end.6:
    %tmp65 = load %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp41
    %tmp66 = alloca %choice.result.Result_int_int
    store %choice.result.Result_int_int %tmp65, %choice.result.Result_int_int* %tmp66
    %tmp67 = getelementptr inbounds %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp66, i32 0, i32 0
    %tmp68 = load i32, i32* %tmp67
    %tmp69 = icmp eq i32 %tmp68, 0
    br i1 %tmp69, label %match_case_body.11, label %match_case_next.12
match_case_body.11:
    %tmp70 = getelementptr inbounds %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp66, i32 0, i32 1
    %tmp71 = bitcast [8 x i8]* %tmp70 to i64*
    %tmp72 = load i64, i64* %tmp71
    %tmp73 = alloca i64
    store i64 %tmp72, i64* %tmp73
    %tmp74 = load i64, i64* %tmp42
    %tmp75 = load i64, i64* %tmp42
    %tmp76 = load i64, i64* %tmp73
    %tmp77 = add i64 %tmp75, %tmp76
    store i64 %tmp77, i64* %tmp42
    br label %match_end.10
match_case_next.12:
    %tmp78 = icmp eq i32 %tmp68, 1
    br i1 %tmp78, label %match_case_body.13, label %match_end.10
match_case_body.13:
    %tmp79 = getelementptr inbounds %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp66, i32 0, i32 1
    %tmp80 = bitcast [8 x i8]* %tmp79 to i64*
    %tmp81 = load i64, i64* %tmp80
    %tmp82 = alloca i64
    store i64 %tmp81, i64* %tmp82
    %tmp83 = load i64, i64* %tmp42
    %tmp84 = load i64, i64* %tmp42
    %tmp85 = load i64, i64* %tmp82
    %tmp86 = add i64 %tmp84, %tmp85
    store i64 %tmp86, i64* %tmp42
    br label %match_end.10
match_end.10:
    %tmp87 = load i64, i64* %tmp42
    %tmp88 = trunc i64 %tmp87 to i32
    ret i32 %tmp88
}

