; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

%class.string.String = type { i8*, i64 }

declare i8* @"malloc"(i64)
declare void @"free"(i8*)
declare i8* @"memcpy"(i8*, i8*, i64)
declare i32 @"printf"(i8*, ...)

define void @"string.String.init"(%class.string.String* %self) {
entry:
    %tmp0 = alloca %class.string.String*
    store %class.string.String* %self, %class.string.String** %tmp0
    %tmp1 = load %class.string.String*, %class.string.String** %tmp0
    %tmp2 = getelementptr inbounds %class.string.String, %class.string.String* %tmp1, i32 0, i32 0
    %tmp3 = call i8* @"malloc"(i64 1)
    store i8* %tmp3, i8** %tmp2
    %tmp4 = load %class.string.String*, %class.string.String** %tmp0
    %tmp5 = getelementptr inbounds %class.string.String, %class.string.String* %tmp4, i32 0, i32 0
    %tmp6 = load %class.string.String*, %class.string.String** %tmp0
    %tmp7 = load %class.string.String, %class.string.String* %tmp6
    %tmp8 = load %class.string.String*, %class.string.String** %tmp0
    %tmp9 = getelementptr inbounds %class.string.String, %class.string.String* %tmp8, i32 0, i32 0
    %tmp10 = load i8*, i8** %tmp9
    %tmp11 = load %class.string.String*, %class.string.String** %tmp0
    %tmp12 = getelementptr inbounds %class.string.String, %class.string.String* %tmp11, i32 0, i32 0
    %tmp13 = load %class.string.String*, %class.string.String** %tmp0
    %tmp14 = load %class.string.String, %class.string.String* %tmp13
    %tmp15 = load %class.string.String*, %class.string.String** %tmp0
    %tmp16 = getelementptr inbounds %class.string.String, %class.string.String* %tmp15, i32 0, i32 0
    %tmp17 = load i8*, i8** %tmp16
    %tmp18 = getelementptr inbounds i8, i8* %tmp17, i64 0
    store i8 0, i8* %tmp18
    %tmp19 = load %class.string.String*, %class.string.String** %tmp0
    %tmp20 = getelementptr inbounds %class.string.String, %class.string.String* %tmp19, i32 0, i32 1
    store i64 0, i64* %tmp20
    ret void
}

define void @"string.String.destroy"(%class.string.String* %self) {
entry:
    %tmp21 = alloca %class.string.String*
    store %class.string.String* %self, %class.string.String** %tmp21
    %tmp22 = load %class.string.String*, %class.string.String** %tmp21
    %tmp23 = getelementptr inbounds %class.string.String, %class.string.String* %tmp22, i32 0, i32 0
    %tmp24 = load %class.string.String*, %class.string.String** %tmp21
    %tmp25 = load %class.string.String, %class.string.String* %tmp24
    %tmp26 = load %class.string.String*, %class.string.String** %tmp21
    %tmp27 = getelementptr inbounds %class.string.String, %class.string.String* %tmp26, i32 0, i32 0
    %tmp28 = load i8*, i8** %tmp27
    call void @"free"(i8* %tmp28)
    ret void
}

define i64 @"string.String.length"(%class.string.String* %self) {
entry:
    %tmp29 = alloca %class.string.String*
    store %class.string.String* %self, %class.string.String** %tmp29
    %tmp30 = load %class.string.String*, %class.string.String** %tmp29
    %tmp31 = load %class.string.String, %class.string.String* %tmp30
    %tmp32 = load %class.string.String*, %class.string.String** %tmp29
    %tmp33 = getelementptr inbounds %class.string.String, %class.string.String* %tmp32, i32 0, i32 1
    %tmp34 = load i64, i64* %tmp33
    ret i64 %tmp34
}

define i8* @"string.String.c_str"(%class.string.String* %self) {
entry:
    %tmp35 = alloca %class.string.String*
    store %class.string.String* %self, %class.string.String** %tmp35
    %tmp36 = load %class.string.String*, %class.string.String** %tmp35
    %tmp37 = getelementptr inbounds %class.string.String, %class.string.String* %tmp36, i32 0, i32 0
    %tmp38 = load %class.string.String*, %class.string.String** %tmp35
    %tmp39 = load %class.string.String, %class.string.String* %tmp38
    %tmp40 = load %class.string.String*, %class.string.String** %tmp35
    %tmp41 = getelementptr inbounds %class.string.String, %class.string.String* %tmp40, i32 0, i32 0
    %tmp42 = load i8*, i8** %tmp41
    ret i8* %tmp42
}

define %class.string.String @"string.String.from"({ i8*, i64 } %chars) {
entry:
    %tmp43 = alloca { i8*, i64 }
    store { i8*, i64 } %chars, { i8*, i64 }* %tmp43
    %tmp44 = alloca %class.string.String
    store %class.string.String zeroinitializer, %class.string.String* %tmp44
    call void @"string.String.init"(%class.string.String* %tmp44)
    %tmp45 = load %class.string.String, %class.string.String* %tmp44
    %tmp46 = alloca %class.string.String
    store %class.string.String %tmp45, %class.string.String* %tmp46
    %tmp47 = getelementptr inbounds %class.string.String, %class.string.String* %tmp46, i32 0, i32 0
    %tmp48 = load %class.string.String, %class.string.String* %tmp46
    %tmp49 = getelementptr inbounds %class.string.String, %class.string.String* %tmp46, i32 0, i32 0
    %tmp50 = load i8*, i8** %tmp49
    call void @"free"(i8* %tmp50)
    %tmp51 = load { i8*, i64 }, { i8*, i64 }* %tmp43
    %tmp52 = extractvalue { i8*, i64 } %tmp51, 1
    %tmp53 = alloca i64
    store i64 %tmp52, i64* %tmp53
    %tmp54 = getelementptr inbounds %class.string.String, %class.string.String* %tmp46, i32 0, i32 1
    %tmp55 = load i64, i64* %tmp53
    store i64 %tmp55, i64* %tmp54
    %tmp56 = getelementptr inbounds %class.string.String, %class.string.String* %tmp46, i32 0, i32 0
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
    %tmp66 = getelementptr inbounds %class.string.String, %class.string.String* %tmp46, i32 0, i32 0
    %tmp67 = load %class.string.String, %class.string.String* %tmp46
    %tmp68 = getelementptr inbounds %class.string.String, %class.string.String* %tmp46, i32 0, i32 0
    %tmp69 = load i8*, i8** %tmp68
    %tmp70 = load i64, i64* %tmp61
    %tmp71 = getelementptr inbounds %class.string.String, %class.string.String* %tmp46, i32 0, i32 0
    %tmp72 = load %class.string.String, %class.string.String* %tmp46
    %tmp73 = getelementptr inbounds %class.string.String, %class.string.String* %tmp46, i32 0, i32 0
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
    %tmp86 = getelementptr inbounds %class.string.String, %class.string.String* %tmp46, i32 0, i32 0
    %tmp87 = load %class.string.String, %class.string.String* %tmp46
    %tmp88 = getelementptr inbounds %class.string.String, %class.string.String* %tmp46, i32 0, i32 0
    %tmp89 = load i8*, i8** %tmp88
    %tmp90 = load i64, i64* %tmp53
    %tmp91 = getelementptr inbounds %class.string.String, %class.string.String* %tmp46, i32 0, i32 0
    %tmp92 = load %class.string.String, %class.string.String* %tmp46
    %tmp93 = getelementptr inbounds %class.string.String, %class.string.String* %tmp46, i32 0, i32 0
    %tmp94 = load i8*, i8** %tmp93
    %tmp95 = getelementptr inbounds i8, i8* %tmp94, i64 %tmp90
    store i8 0, i8* %tmp95
    %tmp96 = load %class.string.String, %class.string.String* %tmp46
    ret %class.string.String %tmp96
}

define i64 @"string.String.hash"(%class.string.String* %self) {
entry:
    %tmp97 = alloca %class.string.String*
    store %class.string.String* %self, %class.string.String** %tmp97
    %tmp98 = alloca i64
    store i64 0, i64* %tmp98
    %tmp99 = alloca i64
    store i64 0, i64* %tmp99
    br label %while_cond.3
while_cond.3:
    %tmp100 = load i64, i64* %tmp99
    %tmp101 = load i64, i64* %tmp99
    %tmp102 = load %class.string.String*, %class.string.String** %tmp97
    %tmp103 = load %class.string.String, %class.string.String* %tmp102
    %tmp104 = load %class.string.String*, %class.string.String** %tmp97
    %tmp105 = getelementptr inbounds %class.string.String, %class.string.String* %tmp104, i32 0, i32 1
    %tmp106 = load i64, i64* %tmp105
    %tmp107 = icmp slt i64 %tmp101, %tmp106
    br i1 %tmp107, label %while_body.4, label %while_end.5
while_body.4:
    %tmp108 = load i64, i64* %tmp98
    %tmp109 = load i64, i64* %tmp98
    %tmp110 = mul i64 %tmp109, 31
    %tmp111 = load i64, i64* %tmp98
    %tmp112 = load i64, i64* %tmp98
    %tmp113 = mul i64 %tmp112, 31
    %tmp114 = load %class.string.String*, %class.string.String** %tmp97
    %tmp115 = getelementptr inbounds %class.string.String, %class.string.String* %tmp114, i32 0, i32 0
    %tmp116 = load %class.string.String*, %class.string.String** %tmp97
    %tmp117 = load %class.string.String, %class.string.String* %tmp116
    %tmp118 = load %class.string.String*, %class.string.String** %tmp97
    %tmp119 = getelementptr inbounds %class.string.String, %class.string.String* %tmp118, i32 0, i32 0
    %tmp120 = load i8*, i8** %tmp119
    %tmp121 = load i64, i64* %tmp99
    %tmp122 = load %class.string.String*, %class.string.String** %tmp97
    %tmp123 = getelementptr inbounds %class.string.String, %class.string.String* %tmp122, i32 0, i32 0
    %tmp124 = load %class.string.String*, %class.string.String** %tmp97
    %tmp125 = load %class.string.String, %class.string.String* %tmp124
    %tmp126 = load %class.string.String*, %class.string.String** %tmp97
    %tmp127 = getelementptr inbounds %class.string.String, %class.string.String* %tmp126, i32 0, i32 0
    %tmp128 = load i8*, i8** %tmp127
    %tmp129 = getelementptr inbounds i8, i8* %tmp128, i64 %tmp121
    %tmp130 = load i8, i8* %tmp129
    %tmp131 = zext i8 %tmp130 to i64
    %tmp132 = add i64 %tmp113, %tmp131
    store i64 %tmp132, i64* %tmp98
    %tmp133 = load i64, i64* %tmp99
    %tmp134 = load i64, i64* %tmp99
    %tmp135 = add i64 %tmp134, 1
    store i64 %tmp135, i64* %tmp99
    br label %while_cond.3
while_end.5:
    %tmp136 = load i64, i64* %tmp98
    ret i64 %tmp136
}

define i1 @"string.String.equals"(%class.string.String* %self, %class.string.String* %other) {
entry:
    %tmp137 = alloca %class.string.String*
    store %class.string.String* %self, %class.string.String** %tmp137
    %tmp138 = alloca %class.string.String*
    store %class.string.String* %other, %class.string.String** %tmp138
    %tmp139 = load %class.string.String*, %class.string.String** %tmp137
    %tmp140 = getelementptr inbounds %class.string.String, %class.string.String* %tmp139, i32 0, i32 1
    %tmp141 = load %class.string.String*, %class.string.String** %tmp137
    %tmp142 = load %class.string.String, %class.string.String* %tmp141
    %tmp143 = load %class.string.String*, %class.string.String** %tmp137
    %tmp144 = getelementptr inbounds %class.string.String, %class.string.String* %tmp143, i32 0, i32 1
    %tmp145 = load i64, i64* %tmp144
    %tmp146 = load %class.string.String*, %class.string.String** %tmp137
    %tmp147 = load %class.string.String, %class.string.String* %tmp146
    %tmp148 = load %class.string.String*, %class.string.String** %tmp137
    %tmp149 = getelementptr inbounds %class.string.String, %class.string.String* %tmp148, i32 0, i32 1
    %tmp150 = load i64, i64* %tmp149
    %tmp151 = load %class.string.String*, %class.string.String** %tmp138
    %tmp152 = load %class.string.String, %class.string.String* %tmp151
    %tmp153 = load %class.string.String*, %class.string.String** %tmp138
    %tmp154 = getelementptr inbounds %class.string.String, %class.string.String* %tmp153, i32 0, i32 1
    %tmp155 = load i64, i64* %tmp154
    %tmp156 = icmp ne i64 %tmp150, %tmp155
    br i1 %tmp156, label %if_then.6, label %if_else.7
if_then.6:
    ret i1 0
if_else.7:
    br label %if_end.8
if_end.8:
    %tmp157 = alloca i64
    store i64 0, i64* %tmp157
    br label %while_cond.9
while_cond.9:
    %tmp158 = load i64, i64* %tmp157
    %tmp159 = load i64, i64* %tmp157
    %tmp160 = load %class.string.String*, %class.string.String** %tmp137
    %tmp161 = load %class.string.String, %class.string.String* %tmp160
    %tmp162 = load %class.string.String*, %class.string.String** %tmp137
    %tmp163 = getelementptr inbounds %class.string.String, %class.string.String* %tmp162, i32 0, i32 1
    %tmp164 = load i64, i64* %tmp163
    %tmp165 = icmp slt i64 %tmp159, %tmp164
    br i1 %tmp165, label %while_body.10, label %while_end.11
while_body.10:
    %tmp166 = load i64, i64* %tmp157
    %tmp167 = load %class.string.String*, %class.string.String** %tmp137
    %tmp168 = getelementptr inbounds %class.string.String, %class.string.String* %tmp167, i32 0, i32 0
    %tmp169 = load %class.string.String*, %class.string.String** %tmp137
    %tmp170 = load %class.string.String, %class.string.String* %tmp169
    %tmp171 = load %class.string.String*, %class.string.String** %tmp137
    %tmp172 = getelementptr inbounds %class.string.String, %class.string.String* %tmp171, i32 0, i32 0
    %tmp173 = load i8*, i8** %tmp172
    %tmp174 = getelementptr inbounds i8, i8* %tmp173, i64 %tmp166
    %tmp175 = load %class.string.String*, %class.string.String** %tmp137
    %tmp176 = getelementptr inbounds %class.string.String, %class.string.String* %tmp175, i32 0, i32 0
    %tmp177 = load %class.string.String*, %class.string.String** %tmp137
    %tmp178 = load %class.string.String, %class.string.String* %tmp177
    %tmp179 = load %class.string.String*, %class.string.String** %tmp137
    %tmp180 = getelementptr inbounds %class.string.String, %class.string.String* %tmp179, i32 0, i32 0
    %tmp181 = load i8*, i8** %tmp180
    %tmp182 = load i64, i64* %tmp157
    %tmp183 = load %class.string.String*, %class.string.String** %tmp137
    %tmp184 = getelementptr inbounds %class.string.String, %class.string.String* %tmp183, i32 0, i32 0
    %tmp185 = load %class.string.String*, %class.string.String** %tmp137
    %tmp186 = load %class.string.String, %class.string.String* %tmp185
    %tmp187 = load %class.string.String*, %class.string.String** %tmp137
    %tmp188 = getelementptr inbounds %class.string.String, %class.string.String* %tmp187, i32 0, i32 0
    %tmp189 = load i8*, i8** %tmp188
    %tmp190 = getelementptr inbounds i8, i8* %tmp189, i64 %tmp182
    %tmp191 = load i8, i8* %tmp190
    %tmp192 = load %class.string.String*, %class.string.String** %tmp137
    %tmp193 = getelementptr inbounds %class.string.String, %class.string.String* %tmp192, i32 0, i32 0
    %tmp194 = load %class.string.String*, %class.string.String** %tmp137
    %tmp195 = load %class.string.String, %class.string.String* %tmp194
    %tmp196 = load %class.string.String*, %class.string.String** %tmp137
    %tmp197 = getelementptr inbounds %class.string.String, %class.string.String* %tmp196, i32 0, i32 0
    %tmp198 = load i8*, i8** %tmp197
    %tmp199 = load i64, i64* %tmp157
    %tmp200 = load %class.string.String*, %class.string.String** %tmp137
    %tmp201 = getelementptr inbounds %class.string.String, %class.string.String* %tmp200, i32 0, i32 0
    %tmp202 = load %class.string.String*, %class.string.String** %tmp137
    %tmp203 = load %class.string.String, %class.string.String* %tmp202
    %tmp204 = load %class.string.String*, %class.string.String** %tmp137
    %tmp205 = getelementptr inbounds %class.string.String, %class.string.String* %tmp204, i32 0, i32 0
    %tmp206 = load i8*, i8** %tmp205
    %tmp207 = getelementptr inbounds i8, i8* %tmp206, i64 %tmp199
    %tmp208 = load i8, i8* %tmp207
    %tmp209 = load %class.string.String*, %class.string.String** %tmp138
    %tmp210 = getelementptr inbounds %class.string.String, %class.string.String* %tmp209, i32 0, i32 0
    %tmp211 = load %class.string.String*, %class.string.String** %tmp138
    %tmp212 = load %class.string.String, %class.string.String* %tmp211
    %tmp213 = load %class.string.String*, %class.string.String** %tmp138
    %tmp214 = getelementptr inbounds %class.string.String, %class.string.String* %tmp213, i32 0, i32 0
    %tmp215 = load i8*, i8** %tmp214
    %tmp216 = load i64, i64* %tmp157
    %tmp217 = load %class.string.String*, %class.string.String** %tmp138
    %tmp218 = getelementptr inbounds %class.string.String, %class.string.String* %tmp217, i32 0, i32 0
    %tmp219 = load %class.string.String*, %class.string.String** %tmp138
    %tmp220 = load %class.string.String, %class.string.String* %tmp219
    %tmp221 = load %class.string.String*, %class.string.String** %tmp138
    %tmp222 = getelementptr inbounds %class.string.String, %class.string.String* %tmp221, i32 0, i32 0
    %tmp223 = load i8*, i8** %tmp222
    %tmp224 = getelementptr inbounds i8, i8* %tmp223, i64 %tmp216
    %tmp225 = load i8, i8* %tmp224
    %tmp226 = icmp ne i8 %tmp208, %tmp225
    br i1 %tmp226, label %if_then.12, label %if_else.13
if_then.12:
    ret i1 0
if_else.13:
    br label %if_end.14
if_end.14:
    %tmp227 = load i64, i64* %tmp157
    %tmp228 = load i64, i64* %tmp157
    %tmp229 = add i64 %tmp228, 1
    store i64 %tmp229, i64* %tmp157
    br label %while_cond.9
while_end.11:
    ret i1 1
}

define %class.string.String @"string.String.clone"(%class.string.String* %self) {
entry:
    %tmp0 = load %class.string.String, %class.string.String* %self
    ret %class.string.String %tmp0
}

define i32 @"main"() {
entry:
    %tmp230 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.0, i64 0, i64 0
    %tmp231 = insertvalue { i8*, i64 } undef, i8* %tmp230, 0
    %tmp232 = insertvalue { i8*, i64 } %tmp231, i64 7, 1
    %tmp233 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp232)
    %tmp234 = alloca %class.string.String
    store %class.string.String %tmp233, %class.string.String* %tmp234
    %tmp235 = load %class.string.String, %class.string.String* %tmp234
    %tmp236 = call i8* @"string.String.c_str"(%class.string.String* %tmp234)
    %tmp237 = call i32 @"printf"(i8* %tmp236, i64 7, i64 11)
    %tmp238 = trunc i64 0 to i32
    call void @"string.String.destroy"(%class.string.String* %tmp234)
    ret i32 %tmp238
}


@.str.0 = private unnamed_addr constant [8 x i8] c"%ld %ld\00"
