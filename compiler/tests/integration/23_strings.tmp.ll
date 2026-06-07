; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

%class.main.String = type { i8*, i64 }

declare i8* @"malloc"(i64)
declare void @"free"(i8*)

define void @"main.String.init"(%class.main.String* %self) {
entry:
    %tmp0 = alloca %class.main.String*
    store %class.main.String* %self, %class.main.String** %tmp0
    %tmp1 = load %class.main.String*, %class.main.String** %tmp0
    %tmp2 = getelementptr inbounds %class.main.String, %class.main.String* %tmp1, i32 0, i32 0
    %tmp3 = call i8* @"malloc"(i64 1)
    store i8* %tmp3, i8** %tmp2
    %tmp4 = load %class.main.String*, %class.main.String** %tmp0
    %tmp5 = getelementptr inbounds %class.main.String, %class.main.String* %tmp4, i32 0, i32 0
    %tmp6 = load %class.main.String*, %class.main.String** %tmp0
    %tmp7 = load %class.main.String, %class.main.String* %tmp6
    %tmp8 = load %class.main.String*, %class.main.String** %tmp0
    %tmp9 = getelementptr inbounds %class.main.String, %class.main.String* %tmp8, i32 0, i32 0
    %tmp10 = load i8*, i8** %tmp9
    %tmp11 = load %class.main.String*, %class.main.String** %tmp0
    %tmp12 = getelementptr inbounds %class.main.String, %class.main.String* %tmp11, i32 0, i32 0
    %tmp13 = load %class.main.String*, %class.main.String** %tmp0
    %tmp14 = load %class.main.String, %class.main.String* %tmp13
    %tmp15 = load %class.main.String*, %class.main.String** %tmp0
    %tmp16 = getelementptr inbounds %class.main.String, %class.main.String* %tmp15, i32 0, i32 0
    %tmp17 = load i8*, i8** %tmp16
    %tmp18 = getelementptr inbounds i8, i8* %tmp17, i64 0
    store i8 0, i8* %tmp18
    %tmp19 = load %class.main.String*, %class.main.String** %tmp0
    %tmp20 = getelementptr inbounds %class.main.String, %class.main.String* %tmp19, i32 0, i32 1
    store i64 0, i64* %tmp20
    ret void
}

define void @"main.String.destroy"(%class.main.String* %self) {
entry:
    %tmp21 = alloca %class.main.String*
    store %class.main.String* %self, %class.main.String** %tmp21
    %tmp22 = load %class.main.String*, %class.main.String** %tmp21
    %tmp23 = getelementptr inbounds %class.main.String, %class.main.String* %tmp22, i32 0, i32 0
    %tmp24 = load %class.main.String*, %class.main.String** %tmp21
    %tmp25 = load %class.main.String, %class.main.String* %tmp24
    %tmp26 = load %class.main.String*, %class.main.String** %tmp21
    %tmp27 = getelementptr inbounds %class.main.String, %class.main.String* %tmp26, i32 0, i32 0
    %tmp28 = load i8*, i8** %tmp27
    call void @"free"(i8* %tmp28)
    ret void
}

define i64 @"main.String.length"(%class.main.String* %self) {
entry:
    %tmp29 = alloca %class.main.String*
    store %class.main.String* %self, %class.main.String** %tmp29
    %tmp30 = load %class.main.String*, %class.main.String** %tmp29
    %tmp31 = load %class.main.String, %class.main.String* %tmp30
    %tmp32 = load %class.main.String*, %class.main.String** %tmp29
    %tmp33 = getelementptr inbounds %class.main.String, %class.main.String* %tmp32, i32 0, i32 1
    %tmp34 = load i64, i64* %tmp33
    ret i64 %tmp34
}

define i8* @"main.String.c_str"(%class.main.String* %self) {
entry:
    %tmp35 = alloca %class.main.String*
    store %class.main.String* %self, %class.main.String** %tmp35
    %tmp36 = load %class.main.String*, %class.main.String** %tmp35
    %tmp37 = getelementptr inbounds %class.main.String, %class.main.String* %tmp36, i32 0, i32 0
    %tmp38 = load %class.main.String*, %class.main.String** %tmp35
    %tmp39 = load %class.main.String, %class.main.String* %tmp38
    %tmp40 = load %class.main.String*, %class.main.String** %tmp35
    %tmp41 = getelementptr inbounds %class.main.String, %class.main.String* %tmp40, i32 0, i32 0
    %tmp42 = load i8*, i8** %tmp41
    ret i8* %tmp42
}

define %class.main.String @"main.String.from"({ i8*, i64 } %chars) {
entry:
    %tmp43 = alloca { i8*, i64 }
    store { i8*, i64 } %chars, { i8*, i64 }* %tmp43
    %tmp44 = alloca %class.main.String
    store %class.main.String zeroinitializer, %class.main.String* %tmp44
    call void @"main.String.init"(%class.main.String* %tmp44)
    %tmp45 = load %class.main.String, %class.main.String* %tmp44
    %tmp46 = alloca %class.main.String
    store %class.main.String %tmp45, %class.main.String* %tmp46
    %tmp47 = getelementptr inbounds %class.main.String, %class.main.String* %tmp46, i32 0, i32 0
    %tmp48 = load %class.main.String, %class.main.String* %tmp46
    %tmp49 = getelementptr inbounds %class.main.String, %class.main.String* %tmp46, i32 0, i32 0
    %tmp50 = load i8*, i8** %tmp49
    call void @"free"(i8* %tmp50)
    %tmp51 = load { i8*, i64 }, { i8*, i64 }* %tmp43
    %tmp52 = extractvalue { i8*, i64 } %tmp51, 1
    %tmp53 = alloca i64
    store i64 %tmp52, i64* %tmp53
    %tmp54 = getelementptr inbounds %class.main.String, %class.main.String* %tmp46, i32 0, i32 1
    %tmp55 = load i64, i64* %tmp53
    store i64 %tmp55, i64* %tmp54
    %tmp56 = getelementptr inbounds %class.main.String, %class.main.String* %tmp46, i32 0, i32 0
    %tmp57 = load i64, i64* %tmp53
    %tmp58 = load i64, i64* %tmp53
    %tmp59 = add i64 %tmp58, 1
    %tmp60 = call i8* @"malloc"(i64 %tmp59)
    store i8* %tmp60, i8** %tmp56
    %tmp61 = alloca i64
    store i64 0, i64* %tmp61
    br label %while_cond.0
while_cond.0:
    %tmp62 = load i64, i64* %tmp61
    %tmp63 = load i64, i64* %tmp61
    %tmp64 = load i64, i64* %tmp53
    %tmp65 = icmp slt i64 %tmp63, %tmp64
    br i1 %tmp65, label %while_body.1, label %while_end.2
while_body.1:
    %tmp66 = getelementptr inbounds %class.main.String, %class.main.String* %tmp46, i32 0, i32 0
    %tmp67 = load %class.main.String, %class.main.String* %tmp46
    %tmp68 = getelementptr inbounds %class.main.String, %class.main.String* %tmp46, i32 0, i32 0
    %tmp69 = load i8*, i8** %tmp68
    %tmp70 = load i64, i64* %tmp61
    %tmp71 = getelementptr inbounds %class.main.String, %class.main.String* %tmp46, i32 0, i32 0
    %tmp72 = load %class.main.String, %class.main.String* %tmp46
    %tmp73 = getelementptr inbounds %class.main.String, %class.main.String* %tmp46, i32 0, i32 0
    %tmp74 = load i8*, i8** %tmp73
    %tmp75 = getelementptr inbounds i8, i8* %tmp74, i64 %tmp70
    %tmp76 = load { i8*, i64 }, { i8*, i64 }* %tmp43
    %tmp77 = load i64, i64* %tmp61
    %tmp78 = load { i8*, i64 }, { i8*, i64 }* %tmp43
    %tmp79 = load { i8*, i64 }, { i8*, i64 }* %tmp43
    %tmp80 = extractvalue { i8*, i64 } %tmp79, 0
    %tmp81 = getelementptr inbounds i8, i8* %tmp80, i64 %tmp77
    %tmp82 = load i8, i8* %tmp81
    store i8 %tmp82, i8* %tmp75
    %tmp83 = load i64, i64* %tmp61
    %tmp84 = load i64, i64* %tmp61
    %tmp85 = add i64 %tmp84, 1
    store i64 %tmp85, i64* %tmp61
    br label %while_cond.0
while_end.2:
    %tmp86 = getelementptr inbounds %class.main.String, %class.main.String* %tmp46, i32 0, i32 0
    %tmp87 = load %class.main.String, %class.main.String* %tmp46
    %tmp88 = getelementptr inbounds %class.main.String, %class.main.String* %tmp46, i32 0, i32 0
    %tmp89 = load i8*, i8** %tmp88
    %tmp90 = load i64, i64* %tmp53
    %tmp91 = getelementptr inbounds %class.main.String, %class.main.String* %tmp46, i32 0, i32 0
    %tmp92 = load %class.main.String, %class.main.String* %tmp46
    %tmp93 = getelementptr inbounds %class.main.String, %class.main.String* %tmp46, i32 0, i32 0
    %tmp94 = load i8*, i8** %tmp93
    %tmp95 = getelementptr inbounds i8, i8* %tmp94, i64 %tmp90
    store i8 0, i8* %tmp95
    %tmp96 = load %class.main.String, %class.main.String* %tmp46
    ret %class.main.String %tmp96
}

define %class.main.String @"main.String.clone"(%class.main.String* %self) {
entry:
    %tmp0 = load %class.main.String, %class.main.String* %self
    ret %class.main.String %tmp0
}

define i32 @"main"() {
entry:
    %tmp97 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i64 0, i64 0
    %tmp98 = insertvalue { i8*, i64 } undef, i8* %tmp97, 0
    %tmp99 = insertvalue { i8*, i64 } %tmp98, i64 5, 1
    %tmp100 = call %class.main.String @"main.String.from"({ i8*, i64 } %tmp99)
    %tmp101 = alloca %class.main.String
    store %class.main.String %tmp100, %class.main.String* %tmp101
    %tmp102 = load %class.main.String, %class.main.String* %tmp101
    %tmp103 = call i64 @"main.String.length"(%class.main.String* %tmp101)
    %tmp104 = load %class.main.String, %class.main.String* %tmp101
    %tmp105 = call i64 @"main.String.length"(%class.main.String* %tmp101)
    %tmp106 = add i64 %tmp105, 2
    %tmp107 = trunc i64 %tmp106 to i32
    call void @"main.String.destroy"(%class.main.String* %tmp101)
    ret i32 %tmp107
}


@.str.0 = private unnamed_addr constant [6 x i8] c"hello\00"
