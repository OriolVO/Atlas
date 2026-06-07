; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

%class.io.File = type { i8*, i1 }
%class.string.String = type { i8*, i64 }

declare i8* @"malloc"(i64)
declare void @"free"(i8*)
declare i8* @"memcpy"(i8*, i8*, i64)
declare i32 @"putchar"(i32)
declare i32 @"puts"(i8*)
declare i8* @"fopen"(i8*, i8*)
declare i32 @"fclose"(i8*)
declare i32 @"fputs"(i8*, i8*)
declare i32 @"fgetc"(i8*)
declare void @"exit"(i32)

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

define void @"io.File.init"(%class.io.File* %self) {
entry:
    %tmp230 = alloca %class.io.File*
    store %class.io.File* %self, %class.io.File** %tmp230
    %tmp231 = load %class.io.File*, %class.io.File** %tmp230
    %tmp232 = getelementptr inbounds %class.io.File, %class.io.File* %tmp231, i32 0, i32 0
    store i8* null, i8** %tmp232
    %tmp233 = load %class.io.File*, %class.io.File** %tmp230
    %tmp234 = getelementptr inbounds %class.io.File, %class.io.File* %tmp233, i32 0, i32 1
    store i1 0, i1* %tmp234
    ret void
}

define void @"io.File.destroy"(%class.io.File* %self) {
entry:
    %tmp235 = alloca %class.io.File*
    store %class.io.File* %self, %class.io.File** %tmp235
    %tmp236 = load %class.io.File*, %class.io.File** %tmp235
    %tmp237 = load %class.io.File, %class.io.File* %tmp236
    %tmp238 = load %class.io.File*, %class.io.File** %tmp235
    %tmp239 = getelementptr inbounds %class.io.File, %class.io.File* %tmp238, i32 0, i32 1
    %tmp240 = load i1, i1* %tmp239
    br i1 %tmp240, label %if_then.15, label %if_else.16
if_then.15:
    %tmp241 = load %class.io.File*, %class.io.File** %tmp235
    %tmp242 = load %class.io.File*, %class.io.File** %tmp235
    call void @"io.File.close"(%class.io.File* %tmp242)
    br label %if_end.17
if_else.16:
    br label %if_end.17
if_end.17:
    ret void
}

define i1 @"io.File.open"(%class.io.File* %self, i8* %filename, i8* %mode) {
entry:
    %tmp243 = alloca %class.io.File*
    store %class.io.File* %self, %class.io.File** %tmp243
    %tmp244 = alloca i8*
    store i8* %filename, i8** %tmp244
    %tmp245 = alloca i8*
    store i8* %mode, i8** %tmp245
    %tmp246 = load %class.io.File*, %class.io.File** %tmp243
    %tmp247 = getelementptr inbounds %class.io.File, %class.io.File* %tmp246, i32 0, i32 0
    %tmp248 = load i8*, i8** %tmp244
    %tmp249 = load i8*, i8** %tmp245
    %tmp250 = call i8* @"fopen"(i8* %tmp248, i8* %tmp249)
    store i8* %tmp250, i8** %tmp247
    %tmp251 = load %class.io.File*, %class.io.File** %tmp243
    %tmp252 = getelementptr inbounds %class.io.File, %class.io.File* %tmp251, i32 0, i32 0
    %tmp253 = load %class.io.File*, %class.io.File** %tmp243
    %tmp254 = load %class.io.File, %class.io.File* %tmp253
    %tmp255 = load %class.io.File*, %class.io.File** %tmp243
    %tmp256 = getelementptr inbounds %class.io.File, %class.io.File* %tmp255, i32 0, i32 0
    %tmp257 = load i8*, i8** %tmp256
    %tmp258 = load %class.io.File*, %class.io.File** %tmp243
    %tmp259 = load %class.io.File, %class.io.File* %tmp258
    %tmp260 = load %class.io.File*, %class.io.File** %tmp243
    %tmp261 = getelementptr inbounds %class.io.File, %class.io.File* %tmp260, i32 0, i32 0
    %tmp262 = load i8*, i8** %tmp261
    %tmp263 = icmp ne i8* %tmp262, null
    br i1 %tmp263, label %if_then.18, label %if_else.19
if_then.18:
    %tmp264 = load %class.io.File*, %class.io.File** %tmp243
    %tmp265 = getelementptr inbounds %class.io.File, %class.io.File* %tmp264, i32 0, i32 1
    store i1 1, i1* %tmp265
    ret i1 1
if_else.19:
    br label %if_end.20
if_end.20:
    ret i1 0
}

define void @"io.File.close"(%class.io.File* %self) {
entry:
    %tmp266 = alloca %class.io.File*
    store %class.io.File* %self, %class.io.File** %tmp266
    %tmp267 = load %class.io.File*, %class.io.File** %tmp266
    %tmp268 = load %class.io.File, %class.io.File* %tmp267
    %tmp269 = load %class.io.File*, %class.io.File** %tmp266
    %tmp270 = getelementptr inbounds %class.io.File, %class.io.File* %tmp269, i32 0, i32 1
    %tmp271 = load i1, i1* %tmp270
    br i1 %tmp271, label %if_then.21, label %if_else.22
if_then.21:
    %tmp272 = load %class.io.File*, %class.io.File** %tmp266
    %tmp273 = load %class.io.File, %class.io.File* %tmp272
    %tmp274 = load %class.io.File*, %class.io.File** %tmp266
    %tmp275 = getelementptr inbounds %class.io.File, %class.io.File* %tmp274, i32 0, i32 0
    %tmp276 = load i8*, i8** %tmp275
    %tmp277 = bitcast i8* %tmp276 to i8*
    %tmp278 = call i32 @"fclose"(i8* %tmp277)
    %tmp279 = load %class.io.File*, %class.io.File** %tmp266
    %tmp280 = getelementptr inbounds %class.io.File, %class.io.File* %tmp279, i32 0, i32 1
    store i1 0, i1* %tmp280
    %tmp281 = load %class.io.File*, %class.io.File** %tmp266
    %tmp282 = getelementptr inbounds %class.io.File, %class.io.File* %tmp281, i32 0, i32 0
    store i8* null, i8** %tmp282
    br label %if_end.23
if_else.22:
    br label %if_end.23
if_end.23:
    ret void
}

define i1 @"io.File.write_string"(%class.io.File* %self, i8* %s) {
entry:
    %tmp283 = alloca %class.io.File*
    store %class.io.File* %self, %class.io.File** %tmp283
    %tmp284 = alloca i8*
    store i8* %s, i8** %tmp284
    %tmp285 = load %class.io.File*, %class.io.File** %tmp283
    %tmp286 = load %class.io.File, %class.io.File* %tmp285
    %tmp287 = load %class.io.File*, %class.io.File** %tmp283
    %tmp288 = getelementptr inbounds %class.io.File, %class.io.File* %tmp287, i32 0, i32 1
    %tmp289 = load i1, i1* %tmp288
    br i1 %tmp289, label %if_then.24, label %if_else.25
if_then.24:
    %tmp290 = load i8*, i8** %tmp284
    %tmp291 = load %class.io.File*, %class.io.File** %tmp283
    %tmp292 = load %class.io.File, %class.io.File* %tmp291
    %tmp293 = load %class.io.File*, %class.io.File** %tmp283
    %tmp294 = getelementptr inbounds %class.io.File, %class.io.File* %tmp293, i32 0, i32 0
    %tmp295 = load i8*, i8** %tmp294
    %tmp296 = bitcast i8* %tmp295 to i8*
    %tmp297 = call i32 @"fputs"(i8* %tmp290, i8* %tmp296)
    %tmp298 = load i8*, i8** %tmp284
    %tmp299 = load %class.io.File*, %class.io.File** %tmp283
    %tmp300 = load %class.io.File, %class.io.File* %tmp299
    %tmp301 = load %class.io.File*, %class.io.File** %tmp283
    %tmp302 = getelementptr inbounds %class.io.File, %class.io.File* %tmp301, i32 0, i32 0
    %tmp303 = load i8*, i8** %tmp302
    %tmp304 = bitcast i8* %tmp303 to i8*
    %tmp305 = call i32 @"fputs"(i8* %tmp298, i8* %tmp304)
    %tmp306 = icmp sge i32 %tmp305, 0
    ret i1 %tmp306
if_else.25:
    br label %if_end.26
if_end.26:
    ret i1 0
}

define i64 @"io.File.read_char"(%class.io.File* %self) {
entry:
    %tmp307 = alloca %class.io.File*
    store %class.io.File* %self, %class.io.File** %tmp307
    %tmp308 = load %class.io.File*, %class.io.File** %tmp307
    %tmp309 = load %class.io.File, %class.io.File* %tmp308
    %tmp310 = load %class.io.File*, %class.io.File** %tmp307
    %tmp311 = getelementptr inbounds %class.io.File, %class.io.File* %tmp310, i32 0, i32 1
    %tmp312 = load i1, i1* %tmp311
    br i1 %tmp312, label %if_then.27, label %if_else.28
if_then.27:
    %tmp313 = load %class.io.File*, %class.io.File** %tmp307
    %tmp314 = load %class.io.File, %class.io.File* %tmp313
    %tmp315 = load %class.io.File*, %class.io.File** %tmp307
    %tmp316 = getelementptr inbounds %class.io.File, %class.io.File* %tmp315, i32 0, i32 0
    %tmp317 = load i8*, i8** %tmp316
    %tmp318 = bitcast i8* %tmp317 to i8*
    %tmp319 = call i32 @"fgetc"(i8* %tmp318)
    %tmp320 = sext i32 %tmp319 to i64
    ret i64 %tmp320
if_else.28:
    br label %if_end.29
if_end.29:
    %tmp321 = sub i64 0, 1
    ret i64 %tmp321
}

define %class.io.File @"io.File.clone"(%class.io.File* %self) {
entry:
    %tmp0 = load %class.io.File, %class.io.File* %self
    ret %class.io.File %tmp0
}

define void @"io.print_char"(i8 %c) {
entry:
    %tmp322 = alloca i8
    store i8 %c, i8* %tmp322
    %tmp323 = load i8, i8* %tmp322
    %tmp324 = zext i8 %tmp323 to i32
    %tmp325 = call i32 @"putchar"(i32 %tmp324)
    ret void
}

define void @"io.print_str"(i8* %s) {
entry:
    %tmp326 = alloca i8*
    store i8* %s, i8** %tmp326
    %tmp327 = alloca i64
    store i64 0, i64* %tmp327
    br label %while_cond.30
while_cond.30:
    %tmp328 = load i64, i64* %tmp327
    %tmp329 = load i8*, i8** %tmp326
    %tmp330 = getelementptr inbounds i8, i8* %tmp329, i64 %tmp328
    %tmp331 = load i8*, i8** %tmp326
    %tmp332 = load i64, i64* %tmp327
    %tmp333 = load i8*, i8** %tmp326
    %tmp334 = getelementptr inbounds i8, i8* %tmp333, i64 %tmp332
    %tmp335 = load i8, i8* %tmp334
    %tmp336 = load i8*, i8** %tmp326
    %tmp337 = load i64, i64* %tmp327
    %tmp338 = load i8*, i8** %tmp326
    %tmp339 = getelementptr inbounds i8, i8* %tmp338, i64 %tmp337
    %tmp340 = load i8, i8* %tmp339
    %tmp341 = icmp ne i8 %tmp340, 0
    br i1 %tmp341, label %while_body.31, label %while_end.32
while_body.31:
    %tmp342 = load i8*, i8** %tmp326
    %tmp343 = load i64, i64* %tmp327
    %tmp344 = load i8*, i8** %tmp326
    %tmp345 = getelementptr inbounds i8, i8* %tmp344, i64 %tmp343
    %tmp346 = load i8, i8* %tmp345
    %tmp347 = zext i8 %tmp346 to i32
    %tmp348 = call i32 @"putchar"(i32 %tmp347)
    %tmp349 = load i64, i64* %tmp327
    %tmp350 = load i64, i64* %tmp327
    %tmp351 = add i64 %tmp350, 1
    store i64 %tmp351, i64* %tmp327
    br label %while_cond.30
while_end.32:
    ret void
}

define void @"io.println_str"(i8* %s) {
entry:
    %tmp352 = alloca i8*
    store i8* %s, i8** %tmp352
    %tmp353 = load i8*, i8** %tmp352
    %tmp354 = call i32 @"puts"(i8* %tmp353)
    ret void
}

define i32 @"main"() {
entry:
    %tmp355 = alloca [32 x i8]
    %tmp356 = getelementptr inbounds [32 x i8], [32 x i8]* %tmp355, i64 0, i64 0
    %tmp357 = getelementptr inbounds [5 x i8], [5 x i8]* @.fmt.0, i64 0, i64 0
    %tmp358 = call i32 @"snprintf"(i8* %tmp356, i64 32, i8* %tmp357, i64 42)
    %tmp359 = sext i32 %tmp358 to i64
    %tmp360 = add i64 %tmp359, 1
    %tmp361 = call i8* @"malloc"(i64 %tmp360)
    call i32 @"snprintf"(i8* %tmp361, i64 %tmp360, i8* %tmp357, i64 42)
    %tmp363 = insertvalue %class.string.String zeroinitializer, i8* %tmp361, 0
    %tmp364 = insertvalue %class.string.String %tmp363, i64 %tmp359, 1
    %tmp365 = alloca %class.string.String
    store %class.string.String %tmp364, %class.string.String* %tmp365
    %tmp366 = call i8* @"malloc"(i64 5)
    %tmp367 = getelementptr inbounds [5 x i8], [5 x i8]* @.strlit.1, i64 0, i64 0
    call i8* @"memcpy"(i8* %tmp366, i8* %tmp367, i64 5)
    %tmp368 = insertvalue %class.string.String zeroinitializer, i8* %tmp366, 0
    %tmp369 = insertvalue %class.string.String %tmp368, i64 4, 1
    %tmp370 = call i8* @"malloc"(i64 6)
    %tmp371 = getelementptr inbounds [6 x i8], [6 x i8]* @.strlit.2, i64 0, i64 0
    call i8* @"memcpy"(i8* %tmp370, i8* %tmp371, i64 6)
    %tmp372 = insertvalue %class.string.String zeroinitializer, i8* %tmp370, 0
    %tmp373 = insertvalue %class.string.String %tmp372, i64 5, 1
    %tmp374 = select i1 1, %class.string.String %tmp369, %class.string.String %tmp373
    %tmp375 = alloca %class.string.String
    store %class.string.String %tmp374, %class.string.String* %tmp375
    %tmp376 = call i8* @"malloc"(i64 2)
    %tmp377 = getelementptr inbounds i8, i8* %tmp376, i64 0
    store i8 65, i8* %tmp377
    %tmp378 = getelementptr inbounds i8, i8* %tmp376, i64 1
    store i8 0, i8* %tmp378
    %tmp379 = insertvalue %class.string.String zeroinitializer, i8* %tmp376, 0
    %tmp380 = insertvalue %class.string.String %tmp379, i64 1, 1
    %tmp381 = alloca %class.string.String
    store %class.string.String %tmp380, %class.string.String* %tmp381
    call void @"io.println_int"(i64 42)
    call void @"io.println_bool"(i1 0)
    call void @"io.println_char"(i8 90)
    %tmp382 = icmp eq i64 42, 42
    %tmp383 = xor i1 %tmp382, true
    br i1 %tmp383, label %if_then.33, label %if_else.34
if_then.33:
    %tmp384 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp384)
    br label %if_end.35
if_else.34:
    br label %if_end.35
if_end.35:
    %tmp385 = icmp eq i1 1, 0
    br i1 %tmp385, label %if_then.36, label %if_else.37
if_then.36:
    %tmp386 = trunc i64 2 to i32
    call void @"exit"(i32 %tmp386)
    br label %if_end.38
if_else.37:
    br label %if_end.38
if_end.38:
    %tmp387 = icmp eq i8 88, 88
    %tmp388 = xor i1 %tmp387, true
    br i1 %tmp388, label %if_then.39, label %if_else.40
if_then.39:
    %tmp389 = trunc i64 3 to i32
    call void @"exit"(i32 %tmp389)
    br label %if_end.41
if_else.40:
    br label %if_end.41
if_end.41:
    %tmp390 = alloca i64
    store i64 100, i64* %tmp390
    %tmp391 = load i64, i64* %tmp390
    %tmp392 = load i64, i64* %tmp390
    %tmp393 = icmp ne i64 %tmp392, 100
    br i1 %tmp393, label %if_then.42, label %if_else.43
if_then.42:
    %tmp394 = trunc i64 4 to i32
    call void @"exit"(i32 %tmp394)
    br label %if_end.44
if_else.43:
    br label %if_end.44
if_end.44:
    %tmp395 = trunc i64 0 to i32
    call void @"string.String.destroy"(%class.string.String* %tmp381)
    call void @"string.String.destroy"(%class.string.String* %tmp375)
    call void @"string.String.destroy"(%class.string.String* %tmp365)
    ret i32 %tmp395
}

define void @"io.println_int"(i64 %val) {
entry:
    %tmp396 = alloca i64
    store i64 %val, i64* %tmp396
    %tmp397 = load i64, i64* %tmp396
    %tmp398 = alloca [32 x i8]
    %tmp399 = getelementptr inbounds [32 x i8], [32 x i8]* %tmp398, i64 0, i64 0
    %tmp400 = getelementptr inbounds [5 x i8], [5 x i8]* @.fmt.3, i64 0, i64 0
    %tmp401 = call i32 @"snprintf"(i8* %tmp399, i64 32, i8* %tmp400, i64 %tmp397)
    %tmp402 = sext i32 %tmp401 to i64
    %tmp403 = add i64 %tmp402, 1
    %tmp404 = call i8* @"malloc"(i64 %tmp403)
    call i32 @"snprintf"(i8* %tmp404, i64 %tmp403, i8* %tmp400, i64 %tmp397)
    %tmp406 = insertvalue %class.string.String zeroinitializer, i8* %tmp404, 0
    %tmp407 = insertvalue %class.string.String %tmp406, i64 %tmp402, 1
    %tmp408 = alloca %class.string.String
    store %class.string.String %tmp407, %class.string.String* %tmp408
    %tmp409 = load %class.string.String, %class.string.String* %tmp408
    %tmp410 = call i8* @"string.String.c_str"(%class.string.String* %tmp408)
    call void @"io.println_str"(i8* %tmp410)
    call void @"string.String.destroy"(%class.string.String* %tmp408)
    ret void
}

define void @"io.println_bool"(i1 %val) {
entry:
    %tmp411 = alloca i1
    store i1 %val, i1* %tmp411
    %tmp412 = load i1, i1* %tmp411
    %tmp413 = call i8* @"malloc"(i64 5)
    %tmp414 = getelementptr inbounds [5 x i8], [5 x i8]* @.strlit.4, i64 0, i64 0
    call i8* @"memcpy"(i8* %tmp413, i8* %tmp414, i64 5)
    %tmp415 = insertvalue %class.string.String zeroinitializer, i8* %tmp413, 0
    %tmp416 = insertvalue %class.string.String %tmp415, i64 4, 1
    %tmp417 = call i8* @"malloc"(i64 6)
    %tmp418 = getelementptr inbounds [6 x i8], [6 x i8]* @.strlit.5, i64 0, i64 0
    call i8* @"memcpy"(i8* %tmp417, i8* %tmp418, i64 6)
    %tmp419 = insertvalue %class.string.String zeroinitializer, i8* %tmp417, 0
    %tmp420 = insertvalue %class.string.String %tmp419, i64 5, 1
    %tmp421 = select i1 %tmp412, %class.string.String %tmp416, %class.string.String %tmp420
    %tmp422 = alloca %class.string.String
    store %class.string.String %tmp421, %class.string.String* %tmp422
    %tmp423 = load %class.string.String, %class.string.String* %tmp422
    %tmp424 = call i8* @"string.String.c_str"(%class.string.String* %tmp422)
    call void @"io.println_str"(i8* %tmp424)
    call void @"string.String.destroy"(%class.string.String* %tmp422)
    ret void
}

define void @"io.println_char"(i8 %val) {
entry:
    %tmp425 = alloca i8
    store i8 %val, i8* %tmp425
    %tmp426 = load i8, i8* %tmp425
    %tmp427 = call i8* @"malloc"(i64 2)
    %tmp428 = getelementptr inbounds i8, i8* %tmp427, i64 0
    store i8 %tmp426, i8* %tmp428
    %tmp429 = getelementptr inbounds i8, i8* %tmp427, i64 1
    store i8 0, i8* %tmp429
    %tmp430 = insertvalue %class.string.String zeroinitializer, i8* %tmp427, 0
    %tmp431 = insertvalue %class.string.String %tmp430, i64 1, 1
    %tmp432 = alloca %class.string.String
    store %class.string.String %tmp431, %class.string.String* %tmp432
    %tmp433 = load %class.string.String, %class.string.String* %tmp432
    %tmp434 = call i8* @"string.String.c_str"(%class.string.String* %tmp432)
    call void @"io.println_str"(i8* %tmp434)
    call void @"string.String.destroy"(%class.string.String* %tmp432)
    ret void
}


@.fmt.0 = private unnamed_addr constant [5 x i8] c"%lld\00"
@.strlit.1 = private unnamed_addr constant [5 x i8] c"true\00"
@.strlit.2 = private unnamed_addr constant [6 x i8] c"false\00"
@.fmt.3 = private unnamed_addr constant [5 x i8] c"%lld\00"
@.strlit.4 = private unnamed_addr constant [5 x i8] c"true\00"
@.strlit.5 = private unnamed_addr constant [6 x i8] c"false\00"
