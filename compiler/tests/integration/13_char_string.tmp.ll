; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.string.String = type { i8*, i64 }

declare i8* @malloc(i64)
declare void @free(i8*)
declare i8* @memcpy(i8*, i8*, i64)
declare i64 @puts(i8*)

define void @string.String.init(%class.string.String* %self) {
entry:
    %tmp0 = alloca %class.string.String*
    store %class.string.String* %self, %class.string.String** %tmp0
    %tmp1 = load %class.string.String*, %class.string.String** %tmp0
    %tmp2 = getelementptr inbounds %class.string.String, %class.string.String* %tmp1, i32 0, i32 0
    %tmp3 = call i8* @malloc(i64 1)
    store i8* %tmp3, i8** %tmp2
    %tmp4 = load %class.string.String*, %class.string.String** %tmp0
    %tmp5 = getelementptr inbounds %class.string.String, %class.string.String* %tmp4, i32 0, i32 0
    %tmp6 = load %class.string.String*, %class.string.String** %tmp0
    %tmp7 = load %class.string.String, %class.string.String* %tmp6
    %tmp8 = load %class.string.String*, %class.string.String** %tmp0
    %tmp9 = getelementptr inbounds %class.string.String, %class.string.String* %tmp8, i32 0, i32 0
    %tmp10 = load i8*, i8** %tmp9
    %tmp11 = getelementptr inbounds i8, i8* %tmp10, i64 0
    store i8 0, i8* %tmp11
    %tmp12 = load %class.string.String*, %class.string.String** %tmp0
    %tmp13 = getelementptr inbounds %class.string.String, %class.string.String* %tmp12, i32 0, i32 1
    store i64 0, i64* %tmp13
    ret void
}

define void @string.String.destroy(%class.string.String* %self) {
entry:
    %tmp14 = alloca %class.string.String*
    store %class.string.String* %self, %class.string.String** %tmp14
    %tmp15 = load %class.string.String*, %class.string.String** %tmp14
    %tmp16 = load %class.string.String, %class.string.String* %tmp15
    %tmp17 = load %class.string.String*, %class.string.String** %tmp14
    %tmp18 = getelementptr inbounds %class.string.String, %class.string.String* %tmp17, i32 0, i32 0
    %tmp19 = load i8*, i8** %tmp18
    call void @free(i8* %tmp19)
    ret void
}

define i64 @string.String.length(%class.string.String* %self) {
entry:
    %tmp20 = alloca %class.string.String*
    store %class.string.String* %self, %class.string.String** %tmp20
    %tmp21 = load %class.string.String*, %class.string.String** %tmp20
    %tmp22 = load %class.string.String, %class.string.String* %tmp21
    %tmp23 = load %class.string.String*, %class.string.String** %tmp20
    %tmp24 = getelementptr inbounds %class.string.String, %class.string.String* %tmp23, i32 0, i32 1
    %tmp25 = load i64, i64* %tmp24
    ret i64 %tmp25
}

define i8* @string.String.c_str(%class.string.String* %self) {
entry:
    %tmp26 = alloca %class.string.String*
    store %class.string.String* %self, %class.string.String** %tmp26
    %tmp27 = load %class.string.String*, %class.string.String** %tmp26
    %tmp28 = load %class.string.String, %class.string.String* %tmp27
    %tmp29 = load %class.string.String*, %class.string.String** %tmp26
    %tmp30 = getelementptr inbounds %class.string.String, %class.string.String* %tmp29, i32 0, i32 0
    %tmp31 = load i8*, i8** %tmp30
    ret i8* %tmp31
}

define %class.string.String @string.String.from({ i8*, i64 } %chars) {
entry:
    %tmp32 = alloca { i8*, i64 }
    store { i8*, i64 } %chars, { i8*, i64 }* %tmp32
    %tmp33 = alloca %class.string.String
    call void @string.String.init(%class.string.String* %tmp33)
    %tmp34 = load %class.string.String, %class.string.String* %tmp33
    %tmp35 = alloca %class.string.String
    store %class.string.String %tmp34, %class.string.String* %tmp35
    %tmp36 = load %class.string.String, %class.string.String* %tmp35
    %tmp37 = getelementptr inbounds %class.string.String, %class.string.String* %tmp35, i32 0, i32 0
    %tmp38 = load i8*, i8** %tmp37
    call void @free(i8* %tmp38)
    %tmp39 = load { i8*, i64 }, { i8*, i64 }* %tmp32
    %tmp40 = extractvalue { i8*, i64 } %tmp39, 1
    %tmp41 = alloca i64
    store i64 %tmp40, i64* %tmp41
    %tmp42 = getelementptr inbounds %class.string.String, %class.string.String* %tmp35, i32 0, i32 1
    %tmp43 = load i64, i64* %tmp41
    store i64 %tmp43, i64* %tmp42
    %tmp44 = getelementptr inbounds %class.string.String, %class.string.String* %tmp35, i32 0, i32 0
    %tmp45 = load i64, i64* %tmp41
    %tmp46 = add i64 %tmp45, 1
    %tmp47 = call i8* @malloc(i64 %tmp46)
    store i8* %tmp47, i8** %tmp44
    %tmp48 = alloca i64
    store i64 0, i64* %tmp48
    br label %while_cond.0
while_cond.0:
    %tmp49 = load i64, i64* %tmp48
    %tmp50 = load i64, i64* %tmp41
    %tmp51 = icmp slt i64 %tmp49, %tmp50
    br i1 %tmp51, label %while_body.1, label %while_end.2
while_body.1:
    %tmp52 = load i64, i64* %tmp48
    %tmp53 = getelementptr inbounds %class.string.String, %class.string.String* %tmp35, i32 0, i32 0
    %tmp54 = load %class.string.String, %class.string.String* %tmp35
    %tmp55 = getelementptr inbounds %class.string.String, %class.string.String* %tmp35, i32 0, i32 0
    %tmp56 = load i8*, i8** %tmp55
    %tmp57 = getelementptr inbounds i8, i8* %tmp56, i64 %tmp52
    %tmp58 = load i64, i64* %tmp48
    %tmp59 = load { i8*, i64 }, { i8*, i64 }* %tmp32
    %tmp60 = load { i8*, i64 }, { i8*, i64 }* %tmp32
    %tmp61 = extractvalue { i8*, i64 } %tmp60, 0
    %tmp62 = getelementptr inbounds i8, i8* %tmp61, i64 %tmp58
    %tmp63 = load i8, i8* %tmp62
    store i8 %tmp63, i8* %tmp57
    %tmp64 = load i64, i64* %tmp48
    %tmp65 = add i64 %tmp64, 1
    store i64 %tmp65, i64* %tmp48
    br label %while_cond.0
while_end.2:
    %tmp66 = load i64, i64* %tmp41
    %tmp67 = getelementptr inbounds %class.string.String, %class.string.String* %tmp35, i32 0, i32 0
    %tmp68 = load %class.string.String, %class.string.String* %tmp35
    %tmp69 = getelementptr inbounds %class.string.String, %class.string.String* %tmp35, i32 0, i32 0
    %tmp70 = load i8*, i8** %tmp69
    %tmp71 = getelementptr inbounds i8, i8* %tmp70, i64 %tmp66
    store i8 0, i8* %tmp71
    %tmp72 = load %class.string.String, %class.string.String* %tmp35
    ret %class.string.String %tmp72
}

define i64 @string.String.hash(%class.string.String* %self) {
entry:
    %tmp73 = alloca %class.string.String*
    store %class.string.String* %self, %class.string.String** %tmp73
    %tmp74 = alloca i64
    store i64 0, i64* %tmp74
    %tmp75 = alloca i64
    store i64 0, i64* %tmp75
    br label %while_cond.3
while_cond.3:
    %tmp76 = load i64, i64* %tmp75
    %tmp77 = load %class.string.String*, %class.string.String** %tmp73
    %tmp78 = load %class.string.String, %class.string.String* %tmp77
    %tmp79 = load %class.string.String*, %class.string.String** %tmp73
    %tmp80 = getelementptr inbounds %class.string.String, %class.string.String* %tmp79, i32 0, i32 1
    %tmp81 = load i64, i64* %tmp80
    %tmp82 = icmp slt i64 %tmp76, %tmp81
    br i1 %tmp82, label %while_body.4, label %while_end.5
while_body.4:
    %tmp83 = load i64, i64* %tmp74
    %tmp84 = mul i64 %tmp83, 31
    %tmp85 = load i64, i64* %tmp75
    %tmp86 = load %class.string.String*, %class.string.String** %tmp73
    %tmp87 = getelementptr inbounds %class.string.String, %class.string.String* %tmp86, i32 0, i32 0
    %tmp88 = load %class.string.String*, %class.string.String** %tmp73
    %tmp89 = load %class.string.String, %class.string.String* %tmp88
    %tmp90 = load %class.string.String*, %class.string.String** %tmp73
    %tmp91 = getelementptr inbounds %class.string.String, %class.string.String* %tmp90, i32 0, i32 0
    %tmp92 = load i8*, i8** %tmp91
    %tmp93 = getelementptr inbounds i8, i8* %tmp92, i64 %tmp85
    %tmp94 = load i8, i8* %tmp93
    %tmp95 = zext i8 %tmp94 to i64
    %tmp96 = add i64 %tmp84, %tmp95
    store i64 %tmp96, i64* %tmp74
    %tmp97 = load i64, i64* %tmp75
    %tmp98 = add i64 %tmp97, 1
    store i64 %tmp98, i64* %tmp75
    br label %while_cond.3
while_end.5:
    %tmp99 = load i64, i64* %tmp74
    ret i64 %tmp99
}

define i1 @string.String.equals(%class.string.String* %self, %class.string.String* %other) {
entry:
    %tmp100 = alloca %class.string.String*
    store %class.string.String* %self, %class.string.String** %tmp100
    %tmp101 = alloca %class.string.String*
    store %class.string.String* %other, %class.string.String** %tmp101
    %tmp102 = load %class.string.String*, %class.string.String** %tmp100
    %tmp103 = load %class.string.String, %class.string.String* %tmp102
    %tmp104 = load %class.string.String*, %class.string.String** %tmp100
    %tmp105 = getelementptr inbounds %class.string.String, %class.string.String* %tmp104, i32 0, i32 1
    %tmp106 = load i64, i64* %tmp105
    %tmp107 = load %class.string.String*, %class.string.String** %tmp101
    %tmp108 = load %class.string.String, %class.string.String* %tmp107
    %tmp109 = load %class.string.String*, %class.string.String** %tmp101
    %tmp110 = getelementptr inbounds %class.string.String, %class.string.String* %tmp109, i32 0, i32 1
    %tmp111 = load i64, i64* %tmp110
    %tmp112 = icmp ne i64 %tmp106, %tmp111
    br i1 %tmp112, label %if_then.6, label %if_else.7
if_then.6:
    ret i1 0
if_else.7:
    br label %if_end.8
if_end.8:
    %tmp113 = alloca i64
    store i64 0, i64* %tmp113
    br label %while_cond.9
while_cond.9:
    %tmp114 = load i64, i64* %tmp113
    %tmp115 = load %class.string.String*, %class.string.String** %tmp100
    %tmp116 = load %class.string.String, %class.string.String* %tmp115
    %tmp117 = load %class.string.String*, %class.string.String** %tmp100
    %tmp118 = getelementptr inbounds %class.string.String, %class.string.String* %tmp117, i32 0, i32 1
    %tmp119 = load i64, i64* %tmp118
    %tmp120 = icmp slt i64 %tmp114, %tmp119
    br i1 %tmp120, label %while_body.10, label %while_end.11
while_body.10:
    %tmp121 = load i64, i64* %tmp113
    %tmp122 = load %class.string.String*, %class.string.String** %tmp100
    %tmp123 = getelementptr inbounds %class.string.String, %class.string.String* %tmp122, i32 0, i32 0
    %tmp124 = load %class.string.String*, %class.string.String** %tmp100
    %tmp125 = load %class.string.String, %class.string.String* %tmp124
    %tmp126 = load %class.string.String*, %class.string.String** %tmp100
    %tmp127 = getelementptr inbounds %class.string.String, %class.string.String* %tmp126, i32 0, i32 0
    %tmp128 = load i8*, i8** %tmp127
    %tmp129 = getelementptr inbounds i8, i8* %tmp128, i64 %tmp121
    %tmp130 = load i8, i8* %tmp129
    %tmp131 = load i64, i64* %tmp113
    %tmp132 = load %class.string.String*, %class.string.String** %tmp101
    %tmp133 = getelementptr inbounds %class.string.String, %class.string.String* %tmp132, i32 0, i32 0
    %tmp134 = load %class.string.String*, %class.string.String** %tmp101
    %tmp135 = load %class.string.String, %class.string.String* %tmp134
    %tmp136 = load %class.string.String*, %class.string.String** %tmp101
    %tmp137 = getelementptr inbounds %class.string.String, %class.string.String* %tmp136, i32 0, i32 0
    %tmp138 = load i8*, i8** %tmp137
    %tmp139 = getelementptr inbounds i8, i8* %tmp138, i64 %tmp131
    %tmp140 = load i8, i8* %tmp139
    %tmp141 = icmp ne i8 %tmp130, %tmp140
    br i1 %tmp141, label %if_then.12, label %if_else.13
if_then.12:
    ret i1 0
if_else.13:
    br label %if_end.14
if_end.14:
    %tmp142 = load i64, i64* %tmp113
    %tmp143 = add i64 %tmp142, 1
    store i64 %tmp143, i64* %tmp113
    br label %while_cond.9
while_end.11:
    ret i1 1
}

define %class.string.String @string.String.clone(%class.string.String* %self) {
entry:
    %tmp0 = load %class.string.String, %class.string.String* %self
    ret %class.string.String %tmp0
}

define i32 @main() {
entry:
    %tmp144 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.0, i64 0, i64 0
    %tmp145 = insertvalue { i8*, i64 } undef, i8* %tmp144, 0
    %tmp146 = insertvalue { i8*, i64 } %tmp145, i64 11, 1
    %tmp147 = call %class.string.String @string.String.from({ i8*, i64 } %tmp146)
    %tmp148 = alloca %class.string.String
    store %class.string.String %tmp147, %class.string.String* %tmp148
    %tmp149 = call i8* @string.String.c_str(%class.string.String* %tmp148)
    %tmp150 = call i64 @puts(i8* %tmp149)
    %tmp151 = trunc i64 0 to i32
    call void @string.String.destroy(%class.string.String* %tmp148)
    ret i32 %tmp151
}


@.str.0 = private unnamed_addr constant [12 x i8] c"Hello World\00"
