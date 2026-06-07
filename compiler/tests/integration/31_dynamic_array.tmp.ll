; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

%class.array.Array_char = type { i8*, i64, i64 }
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

define void @"array.Array_char.init"(%class.array.Array_char* %self) {
entry:
    %tmp322 = alloca %class.array.Array_char*
    store %class.array.Array_char* %self, %class.array.Array_char** %tmp322
    %tmp323 = load %class.array.Array_char*, %class.array.Array_char** %tmp322
    %tmp324 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp323, i32 0, i32 1
    store i64 0, i64* %tmp324
    %tmp325 = load %class.array.Array_char*, %class.array.Array_char** %tmp322
    %tmp326 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp325, i32 0, i32 2
    store i64 0, i64* %tmp326
    %tmp327 = load %class.array.Array_char*, %class.array.Array_char** %tmp322
    %tmp328 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp327, i32 0, i32 0
    store i8* null, i8** %tmp328
    ret void
}

define i64 @"array.Array_char.length"(%class.array.Array_char* %self) {
entry:
    %tmp329 = alloca %class.array.Array_char*
    store %class.array.Array_char* %self, %class.array.Array_char** %tmp329
    %tmp330 = load %class.array.Array_char*, %class.array.Array_char** %tmp329
    %tmp331 = load %class.array.Array_char, %class.array.Array_char* %tmp330
    %tmp332 = load %class.array.Array_char*, %class.array.Array_char** %tmp329
    %tmp333 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp332, i32 0, i32 1
    %tmp334 = load i64, i64* %tmp333
    ret i64 %tmp334
}

define i64 @"array.Array_char.capacity"(%class.array.Array_char* %self) {
entry:
    %tmp335 = alloca %class.array.Array_char*
    store %class.array.Array_char* %self, %class.array.Array_char** %tmp335
    %tmp336 = load %class.array.Array_char*, %class.array.Array_char** %tmp335
    %tmp337 = load %class.array.Array_char, %class.array.Array_char* %tmp336
    %tmp338 = load %class.array.Array_char*, %class.array.Array_char** %tmp335
    %tmp339 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp338, i32 0, i32 2
    %tmp340 = load i64, i64* %tmp339
    ret i64 %tmp340
}

define void @"array.Array_char.push"(%class.array.Array_char* %self, i8 %item) {
entry:
    %tmp341 = alloca %class.array.Array_char*
    store %class.array.Array_char* %self, %class.array.Array_char** %tmp341
    %tmp342 = alloca i8
    store i8 %item, i8* %tmp342
    %tmp343 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp344 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp343, i32 0, i32 1
    %tmp345 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp346 = load %class.array.Array_char, %class.array.Array_char* %tmp345
    %tmp347 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp348 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp347, i32 0, i32 1
    %tmp349 = load i64, i64* %tmp348
    %tmp350 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp351 = load %class.array.Array_char, %class.array.Array_char* %tmp350
    %tmp352 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp353 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp352, i32 0, i32 1
    %tmp354 = load i64, i64* %tmp353
    %tmp355 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp356 = load %class.array.Array_char, %class.array.Array_char* %tmp355
    %tmp357 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp358 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp357, i32 0, i32 2
    %tmp359 = load i64, i64* %tmp358
    %tmp360 = icmp eq i64 %tmp354, %tmp359
    br i1 %tmp360, label %if_then.30, label %if_else.31
if_then.30:
    %tmp361 = alloca i64
    store i64 4, i64* %tmp361
    %tmp362 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp363 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp362, i32 0, i32 2
    %tmp364 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp365 = load %class.array.Array_char, %class.array.Array_char* %tmp364
    %tmp366 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp367 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp366, i32 0, i32 2
    %tmp368 = load i64, i64* %tmp367
    %tmp369 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp370 = load %class.array.Array_char, %class.array.Array_char* %tmp369
    %tmp371 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp372 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp371, i32 0, i32 2
    %tmp373 = load i64, i64* %tmp372
    %tmp374 = icmp sgt i64 %tmp373, 0
    br i1 %tmp374, label %if_then.33, label %if_else.34
if_then.33:
    %tmp375 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp376 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp375, i32 0, i32 2
    %tmp377 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp378 = load %class.array.Array_char, %class.array.Array_char* %tmp377
    %tmp379 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp380 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp379, i32 0, i32 2
    %tmp381 = load i64, i64* %tmp380
    %tmp382 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp383 = load %class.array.Array_char, %class.array.Array_char* %tmp382
    %tmp384 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp385 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp384, i32 0, i32 2
    %tmp386 = load i64, i64* %tmp385
    %tmp387 = mul i64 %tmp386, 2
    store i64 %tmp387, i64* %tmp361
    br label %if_end.35
if_else.34:
    br label %if_end.35
if_end.35:
    %tmp388 = load i64, i64* %tmp361
    %tmp389 = load i64, i64* %tmp361
    %tmp390 = mul i64 %tmp389, 1
    %tmp391 = call i8* @"malloc"(i64 %tmp390)
    %tmp392 = alloca i8*
    store i8* %tmp391, i8** %tmp392
    %tmp393 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp394 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp393, i32 0, i32 0
    %tmp395 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp396 = load %class.array.Array_char, %class.array.Array_char* %tmp395
    %tmp397 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp398 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp397, i32 0, i32 0
    %tmp399 = load i8*, i8** %tmp398
    %tmp400 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp401 = load %class.array.Array_char, %class.array.Array_char* %tmp400
    %tmp402 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp403 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp402, i32 0, i32 0
    %tmp404 = load i8*, i8** %tmp403
    %tmp405 = icmp ne i8* %tmp404, null
    br i1 %tmp405, label %if_then.36, label %if_else.37
if_then.36:
    %tmp406 = load i8*, i8** %tmp392
    %tmp407 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp408 = load %class.array.Array_char, %class.array.Array_char* %tmp407
    %tmp409 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp410 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp409, i32 0, i32 0
    %tmp411 = load i8*, i8** %tmp410
    %tmp412 = bitcast i8* %tmp411 to i8*
    %tmp413 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp414 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp413, i32 0, i32 1
    %tmp415 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp416 = load %class.array.Array_char, %class.array.Array_char* %tmp415
    %tmp417 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp418 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp417, i32 0, i32 1
    %tmp419 = load i64, i64* %tmp418
    %tmp420 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp421 = load %class.array.Array_char, %class.array.Array_char* %tmp420
    %tmp422 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp423 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp422, i32 0, i32 1
    %tmp424 = load i64, i64* %tmp423
    %tmp425 = mul i64 %tmp424, 1
    %tmp426 = call i8* @"memcpy"(i8* %tmp406, i8* %tmp412, i64 %tmp425)
    %tmp427 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp428 = load %class.array.Array_char, %class.array.Array_char* %tmp427
    %tmp429 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp430 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp429, i32 0, i32 0
    %tmp431 = load i8*, i8** %tmp430
    %tmp432 = bitcast i8* %tmp431 to i8*
    call void @"free"(i8* %tmp432)
    br label %if_end.38
if_else.37:
    br label %if_end.38
if_end.38:
    %tmp433 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp434 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp433, i32 0, i32 2
    %tmp435 = load i64, i64* %tmp361
    store i64 %tmp435, i64* %tmp434
    %tmp436 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp437 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp436, i32 0, i32 0
    %tmp438 = load i8*, i8** %tmp392
    store i8* %tmp438, i8** %tmp437
    br label %if_end.32
if_else.31:
    br label %if_end.32
if_end.32:
    %tmp439 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp440 = load %class.array.Array_char, %class.array.Array_char* %tmp439
    %tmp441 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp442 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp441, i32 0, i32 1
    %tmp443 = load i64, i64* %tmp442
    %tmp444 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp445 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp444, i32 0, i32 0
    %tmp446 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp447 = load %class.array.Array_char, %class.array.Array_char* %tmp446
    %tmp448 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp449 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp448, i32 0, i32 0
    %tmp450 = load i8*, i8** %tmp449
    %tmp451 = getelementptr inbounds i8, i8* %tmp450, i64 %tmp443
    %tmp452 = call i8* @"memcpy"(i8* %tmp451, i8* %tmp342, i64 1)
    %tmp453 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp454 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp453, i32 0, i32 1
    %tmp455 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp456 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp455, i32 0, i32 1
    %tmp457 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp458 = load %class.array.Array_char, %class.array.Array_char* %tmp457
    %tmp459 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp460 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp459, i32 0, i32 1
    %tmp461 = load i64, i64* %tmp460
    %tmp462 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp463 = load %class.array.Array_char, %class.array.Array_char* %tmp462
    %tmp464 = load %class.array.Array_char*, %class.array.Array_char** %tmp341
    %tmp465 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp464, i32 0, i32 1
    %tmp466 = load i64, i64* %tmp465
    %tmp467 = add i64 %tmp466, 1
    store i64 %tmp467, i64* %tmp454
    ret void
}

define i8 @"array.Array_char.pop"(%class.array.Array_char* %self) {
entry:
    %tmp468 = alloca %class.array.Array_char*
    store %class.array.Array_char* %self, %class.array.Array_char** %tmp468
    %tmp469 = load %class.array.Array_char*, %class.array.Array_char** %tmp468
    %tmp470 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp469, i32 0, i32 1
    %tmp471 = load %class.array.Array_char*, %class.array.Array_char** %tmp468
    %tmp472 = load %class.array.Array_char, %class.array.Array_char* %tmp471
    %tmp473 = load %class.array.Array_char*, %class.array.Array_char** %tmp468
    %tmp474 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp473, i32 0, i32 1
    %tmp475 = load i64, i64* %tmp474
    %tmp476 = load %class.array.Array_char*, %class.array.Array_char** %tmp468
    %tmp477 = load %class.array.Array_char, %class.array.Array_char* %tmp476
    %tmp478 = load %class.array.Array_char*, %class.array.Array_char** %tmp468
    %tmp479 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp478, i32 0, i32 1
    %tmp480 = load i64, i64* %tmp479
    %tmp481 = icmp eq i64 %tmp480, 0
    br i1 %tmp481, label %if_then.39, label %if_else.40
if_then.39:
    %tmp482 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp482)
    br label %if_end.41
if_else.40:
    br label %if_end.41
if_end.41:
    %tmp483 = load %class.array.Array_char*, %class.array.Array_char** %tmp468
    %tmp484 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp483, i32 0, i32 1
    %tmp485 = load %class.array.Array_char*, %class.array.Array_char** %tmp468
    %tmp486 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp485, i32 0, i32 1
    %tmp487 = load %class.array.Array_char*, %class.array.Array_char** %tmp468
    %tmp488 = load %class.array.Array_char, %class.array.Array_char* %tmp487
    %tmp489 = load %class.array.Array_char*, %class.array.Array_char** %tmp468
    %tmp490 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp489, i32 0, i32 1
    %tmp491 = load i64, i64* %tmp490
    %tmp492 = load %class.array.Array_char*, %class.array.Array_char** %tmp468
    %tmp493 = load %class.array.Array_char, %class.array.Array_char* %tmp492
    %tmp494 = load %class.array.Array_char*, %class.array.Array_char** %tmp468
    %tmp495 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp494, i32 0, i32 1
    %tmp496 = load i64, i64* %tmp495
    %tmp497 = sub i64 %tmp496, 1
    store i64 %tmp497, i64* %tmp484
    %tmp498 = load %class.array.Array_char*, %class.array.Array_char** %tmp468
    %tmp499 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp498, i32 0, i32 0
    %tmp500 = load %class.array.Array_char*, %class.array.Array_char** %tmp468
    %tmp501 = load %class.array.Array_char, %class.array.Array_char* %tmp500
    %tmp502 = load %class.array.Array_char*, %class.array.Array_char** %tmp468
    %tmp503 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp502, i32 0, i32 0
    %tmp504 = load i8*, i8** %tmp503
    %tmp505 = load %class.array.Array_char*, %class.array.Array_char** %tmp468
    %tmp506 = load %class.array.Array_char, %class.array.Array_char* %tmp505
    %tmp507 = load %class.array.Array_char*, %class.array.Array_char** %tmp468
    %tmp508 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp507, i32 0, i32 1
    %tmp509 = load i64, i64* %tmp508
    %tmp510 = load %class.array.Array_char*, %class.array.Array_char** %tmp468
    %tmp511 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp510, i32 0, i32 0
    %tmp512 = load %class.array.Array_char*, %class.array.Array_char** %tmp468
    %tmp513 = load %class.array.Array_char, %class.array.Array_char* %tmp512
    %tmp514 = load %class.array.Array_char*, %class.array.Array_char** %tmp468
    %tmp515 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp514, i32 0, i32 0
    %tmp516 = load i8*, i8** %tmp515
    %tmp517 = getelementptr inbounds i8, i8* %tmp516, i64 %tmp509
    %tmp518 = load i8, i8* %tmp517
    ret i8 %tmp518
}

define i8 @"array.Array_char.operator_index"(%class.array.Array_char* %self, i64 %index) {
entry:
    %tmp519 = alloca %class.array.Array_char*
    store %class.array.Array_char* %self, %class.array.Array_char** %tmp519
    %tmp520 = alloca i64
    store i64 %index, i64* %tmp520
    %tmp521 = load i64, i64* %tmp520
    %tmp522 = load i64, i64* %tmp520
    %tmp523 = icmp slt i64 %tmp522, 0
    %tmp524 = load i64, i64* %tmp520
    %tmp525 = load i64, i64* %tmp520
    %tmp526 = load %class.array.Array_char*, %class.array.Array_char** %tmp519
    %tmp527 = load %class.array.Array_char, %class.array.Array_char* %tmp526
    %tmp528 = load %class.array.Array_char*, %class.array.Array_char** %tmp519
    %tmp529 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp528, i32 0, i32 1
    %tmp530 = load i64, i64* %tmp529
    %tmp531 = icmp sge i64 %tmp525, %tmp530
    %tmp532 = or i1 %tmp523, %tmp531
    br i1 %tmp532, label %if_then.42, label %if_else.43
if_then.42:
    %tmp533 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp533)
    br label %if_end.44
if_else.43:
    br label %if_end.44
if_end.44:
    %tmp534 = load %class.array.Array_char*, %class.array.Array_char** %tmp519
    %tmp535 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp534, i32 0, i32 0
    %tmp536 = load %class.array.Array_char*, %class.array.Array_char** %tmp519
    %tmp537 = load %class.array.Array_char, %class.array.Array_char* %tmp536
    %tmp538 = load %class.array.Array_char*, %class.array.Array_char** %tmp519
    %tmp539 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp538, i32 0, i32 0
    %tmp540 = load i8*, i8** %tmp539
    %tmp541 = load i64, i64* %tmp520
    %tmp542 = load %class.array.Array_char*, %class.array.Array_char** %tmp519
    %tmp543 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp542, i32 0, i32 0
    %tmp544 = load %class.array.Array_char*, %class.array.Array_char** %tmp519
    %tmp545 = load %class.array.Array_char, %class.array.Array_char* %tmp544
    %tmp546 = load %class.array.Array_char*, %class.array.Array_char** %tmp519
    %tmp547 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp546, i32 0, i32 0
    %tmp548 = load i8*, i8** %tmp547
    %tmp549 = getelementptr inbounds i8, i8* %tmp548, i64 %tmp541
    %tmp550 = load i8, i8* %tmp549
    ret i8 %tmp550
}

define void @"array.Array_char.operator_index_set"(%class.array.Array_char* %self, i64 %index, i8 %item) {
entry:
    %tmp551 = alloca %class.array.Array_char*
    store %class.array.Array_char* %self, %class.array.Array_char** %tmp551
    %tmp552 = alloca i64
    store i64 %index, i64* %tmp552
    %tmp553 = alloca i8
    store i8 %item, i8* %tmp553
    %tmp554 = load i64, i64* %tmp552
    %tmp555 = load i64, i64* %tmp552
    %tmp556 = icmp slt i64 %tmp555, 0
    %tmp557 = load i64, i64* %tmp552
    %tmp558 = load i64, i64* %tmp552
    %tmp559 = load %class.array.Array_char*, %class.array.Array_char** %tmp551
    %tmp560 = load %class.array.Array_char, %class.array.Array_char* %tmp559
    %tmp561 = load %class.array.Array_char*, %class.array.Array_char** %tmp551
    %tmp562 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp561, i32 0, i32 1
    %tmp563 = load i64, i64* %tmp562
    %tmp564 = icmp sge i64 %tmp558, %tmp563
    %tmp565 = or i1 %tmp556, %tmp564
    br i1 %tmp565, label %if_then.45, label %if_else.46
if_then.45:
    %tmp566 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp566)
    br label %if_end.47
if_else.46:
    br label %if_end.47
if_end.47:
    %tmp567 = load i64, i64* %tmp552
    %tmp568 = load %class.array.Array_char*, %class.array.Array_char** %tmp551
    %tmp569 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp568, i32 0, i32 0
    %tmp570 = load %class.array.Array_char*, %class.array.Array_char** %tmp551
    %tmp571 = load %class.array.Array_char, %class.array.Array_char* %tmp570
    %tmp572 = load %class.array.Array_char*, %class.array.Array_char** %tmp551
    %tmp573 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp572, i32 0, i32 0
    %tmp574 = load i8*, i8** %tmp573
    %tmp575 = getelementptr inbounds i8, i8* %tmp574, i64 %tmp567
    %tmp576 = load i64, i64* %tmp552
    %tmp577 = load %class.array.Array_char*, %class.array.Array_char** %tmp551
    %tmp578 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp577, i32 0, i32 0
    %tmp579 = load %class.array.Array_char*, %class.array.Array_char** %tmp551
    %tmp580 = load %class.array.Array_char, %class.array.Array_char* %tmp579
    %tmp581 = load %class.array.Array_char*, %class.array.Array_char** %tmp551
    %tmp582 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp581, i32 0, i32 0
    %tmp583 = load i8*, i8** %tmp582
    %tmp584 = getelementptr inbounds i8, i8* %tmp583, i64 %tmp576
    %tmp585 = call i8* @"memcpy"(i8* %tmp584, i8* %tmp553, i64 1)
    ret void
}

define void @"array.Array_char.insert"(%class.array.Array_char* %self, i64 %index, i8 %item) {
entry:
    %tmp586 = alloca %class.array.Array_char*
    store %class.array.Array_char* %self, %class.array.Array_char** %tmp586
    %tmp587 = alloca i64
    store i64 %index, i64* %tmp587
    %tmp588 = alloca i8
    store i8 %item, i8* %tmp588
    %tmp589 = load i64, i64* %tmp587
    %tmp590 = load i64, i64* %tmp587
    %tmp591 = icmp slt i64 %tmp590, 0
    %tmp592 = load i64, i64* %tmp587
    %tmp593 = load i64, i64* %tmp587
    %tmp594 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp595 = load %class.array.Array_char, %class.array.Array_char* %tmp594
    %tmp596 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp597 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp596, i32 0, i32 1
    %tmp598 = load i64, i64* %tmp597
    %tmp599 = icmp sgt i64 %tmp593, %tmp598
    %tmp600 = or i1 %tmp591, %tmp599
    br i1 %tmp600, label %if_then.48, label %if_else.49
if_then.48:
    %tmp601 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp601)
    br label %if_end.50
if_else.49:
    br label %if_end.50
if_end.50:
    %tmp602 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp603 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp602, i32 0, i32 1
    %tmp604 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp605 = load %class.array.Array_char, %class.array.Array_char* %tmp604
    %tmp606 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp607 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp606, i32 0, i32 1
    %tmp608 = load i64, i64* %tmp607
    %tmp609 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp610 = load %class.array.Array_char, %class.array.Array_char* %tmp609
    %tmp611 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp612 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp611, i32 0, i32 1
    %tmp613 = load i64, i64* %tmp612
    %tmp614 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp615 = load %class.array.Array_char, %class.array.Array_char* %tmp614
    %tmp616 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp617 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp616, i32 0, i32 2
    %tmp618 = load i64, i64* %tmp617
    %tmp619 = icmp eq i64 %tmp613, %tmp618
    br i1 %tmp619, label %if_then.51, label %if_else.52
if_then.51:
    %tmp620 = alloca i64
    store i64 4, i64* %tmp620
    %tmp621 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp622 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp621, i32 0, i32 2
    %tmp623 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp624 = load %class.array.Array_char, %class.array.Array_char* %tmp623
    %tmp625 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp626 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp625, i32 0, i32 2
    %tmp627 = load i64, i64* %tmp626
    %tmp628 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp629 = load %class.array.Array_char, %class.array.Array_char* %tmp628
    %tmp630 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp631 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp630, i32 0, i32 2
    %tmp632 = load i64, i64* %tmp631
    %tmp633 = icmp sgt i64 %tmp632, 0
    br i1 %tmp633, label %if_then.54, label %if_else.55
if_then.54:
    %tmp634 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp635 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp634, i32 0, i32 2
    %tmp636 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp637 = load %class.array.Array_char, %class.array.Array_char* %tmp636
    %tmp638 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp639 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp638, i32 0, i32 2
    %tmp640 = load i64, i64* %tmp639
    %tmp641 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp642 = load %class.array.Array_char, %class.array.Array_char* %tmp641
    %tmp643 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp644 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp643, i32 0, i32 2
    %tmp645 = load i64, i64* %tmp644
    %tmp646 = mul i64 %tmp645, 2
    store i64 %tmp646, i64* %tmp620
    br label %if_end.56
if_else.55:
    br label %if_end.56
if_end.56:
    %tmp647 = load i64, i64* %tmp620
    %tmp648 = load i64, i64* %tmp620
    %tmp649 = mul i64 %tmp648, 1
    %tmp650 = call i8* @"malloc"(i64 %tmp649)
    %tmp651 = alloca i8*
    store i8* %tmp650, i8** %tmp651
    %tmp652 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp653 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp652, i32 0, i32 0
    %tmp654 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp655 = load %class.array.Array_char, %class.array.Array_char* %tmp654
    %tmp656 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp657 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp656, i32 0, i32 0
    %tmp658 = load i8*, i8** %tmp657
    %tmp659 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp660 = load %class.array.Array_char, %class.array.Array_char* %tmp659
    %tmp661 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp662 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp661, i32 0, i32 0
    %tmp663 = load i8*, i8** %tmp662
    %tmp664 = icmp ne i8* %tmp663, null
    br i1 %tmp664, label %if_then.57, label %if_else.58
if_then.57:
    %tmp665 = load i64, i64* %tmp587
    %tmp666 = load i64, i64* %tmp587
    %tmp667 = icmp sgt i64 %tmp666, 0
    br i1 %tmp667, label %if_then.60, label %if_else.61
if_then.60:
    %tmp668 = load i8*, i8** %tmp651
    %tmp669 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp670 = load %class.array.Array_char, %class.array.Array_char* %tmp669
    %tmp671 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp672 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp671, i32 0, i32 0
    %tmp673 = load i8*, i8** %tmp672
    %tmp674 = bitcast i8* %tmp673 to i8*
    %tmp675 = load i64, i64* %tmp587
    %tmp676 = load i64, i64* %tmp587
    %tmp677 = mul i64 %tmp676, 1
    %tmp678 = call i8* @"memcpy"(i8* %tmp668, i8* %tmp674, i64 %tmp677)
    br label %if_end.62
if_else.61:
    br label %if_end.62
if_end.62:
    %tmp679 = load i64, i64* %tmp587
    %tmp680 = load i64, i64* %tmp587
    %tmp681 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp682 = load %class.array.Array_char, %class.array.Array_char* %tmp681
    %tmp683 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp684 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp683, i32 0, i32 1
    %tmp685 = load i64, i64* %tmp684
    %tmp686 = icmp slt i64 %tmp680, %tmp685
    br i1 %tmp686, label %if_then.63, label %if_else.64
if_then.63:
    %tmp687 = load i64, i64* %tmp587
    %tmp688 = load i64, i64* %tmp587
    %tmp689 = add i64 %tmp688, 1
    %tmp690 = load i8*, i8** %tmp651
    %tmp691 = getelementptr inbounds i8, i8* %tmp690, i64 %tmp689
    %tmp692 = load i64, i64* %tmp587
    %tmp693 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp694 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp693, i32 0, i32 0
    %tmp695 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp696 = load %class.array.Array_char, %class.array.Array_char* %tmp695
    %tmp697 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp698 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp697, i32 0, i32 0
    %tmp699 = load i8*, i8** %tmp698
    %tmp700 = getelementptr inbounds i8, i8* %tmp699, i64 %tmp692
    %tmp701 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp702 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp701, i32 0, i32 1
    %tmp703 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp704 = load %class.array.Array_char, %class.array.Array_char* %tmp703
    %tmp705 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp706 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp705, i32 0, i32 1
    %tmp707 = load i64, i64* %tmp706
    %tmp708 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp709 = load %class.array.Array_char, %class.array.Array_char* %tmp708
    %tmp710 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp711 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp710, i32 0, i32 1
    %tmp712 = load i64, i64* %tmp711
    %tmp713 = load i64, i64* %tmp587
    %tmp714 = sub i64 %tmp712, %tmp713
    %tmp715 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp716 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp715, i32 0, i32 1
    %tmp717 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp718 = load %class.array.Array_char, %class.array.Array_char* %tmp717
    %tmp719 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp720 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp719, i32 0, i32 1
    %tmp721 = load i64, i64* %tmp720
    %tmp722 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp723 = load %class.array.Array_char, %class.array.Array_char* %tmp722
    %tmp724 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp725 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp724, i32 0, i32 1
    %tmp726 = load i64, i64* %tmp725
    %tmp727 = load i64, i64* %tmp587
    %tmp728 = sub i64 %tmp726, %tmp727
    %tmp729 = mul i64 %tmp728, 1
    %tmp730 = call i8* @"memcpy"(i8* %tmp691, i8* %tmp700, i64 %tmp729)
    br label %if_end.65
if_else.64:
    br label %if_end.65
if_end.65:
    %tmp731 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp732 = load %class.array.Array_char, %class.array.Array_char* %tmp731
    %tmp733 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp734 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp733, i32 0, i32 0
    %tmp735 = load i8*, i8** %tmp734
    %tmp736 = bitcast i8* %tmp735 to i8*
    call void @"free"(i8* %tmp736)
    br label %if_end.59
if_else.58:
    br label %if_end.59
if_end.59:
    %tmp737 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp738 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp737, i32 0, i32 2
    %tmp739 = load i64, i64* %tmp620
    store i64 %tmp739, i64* %tmp738
    %tmp740 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp741 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp740, i32 0, i32 0
    %tmp742 = load i8*, i8** %tmp651
    store i8* %tmp742, i8** %tmp741
    br label %if_end.53
if_else.52:
    %tmp743 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp744 = load %class.array.Array_char, %class.array.Array_char* %tmp743
    %tmp745 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp746 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp745, i32 0, i32 1
    %tmp747 = load i64, i64* %tmp746
    %tmp748 = alloca i64
    store i64 %tmp747, i64* %tmp748
    br label %while_cond.66
while_cond.66:
    %tmp749 = load i64, i64* %tmp748
    %tmp750 = load i64, i64* %tmp748
    %tmp751 = load i64, i64* %tmp587
    %tmp752 = icmp sgt i64 %tmp750, %tmp751
    br i1 %tmp752, label %while_body.67, label %while_end.68
while_body.67:
    %tmp753 = load i64, i64* %tmp748
    %tmp754 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp755 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp754, i32 0, i32 0
    %tmp756 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp757 = load %class.array.Array_char, %class.array.Array_char* %tmp756
    %tmp758 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp759 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp758, i32 0, i32 0
    %tmp760 = load i8*, i8** %tmp759
    %tmp761 = getelementptr inbounds i8, i8* %tmp760, i64 %tmp753
    %tmp762 = load i64, i64* %tmp748
    %tmp763 = load i64, i64* %tmp748
    %tmp764 = sub i64 %tmp763, 1
    %tmp765 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp766 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp765, i32 0, i32 0
    %tmp767 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp768 = load %class.array.Array_char, %class.array.Array_char* %tmp767
    %tmp769 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp770 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp769, i32 0, i32 0
    %tmp771 = load i8*, i8** %tmp770
    %tmp772 = getelementptr inbounds i8, i8* %tmp771, i64 %tmp764
    %tmp773 = call i8* @"memcpy"(i8* %tmp761, i8* %tmp772, i64 1)
    %tmp774 = load i64, i64* %tmp748
    %tmp775 = load i64, i64* %tmp748
    %tmp776 = sub i64 %tmp775, 1
    store i64 %tmp776, i64* %tmp748
    br label %while_cond.66
while_end.68:
    br label %if_end.53
if_end.53:
    %tmp777 = load i64, i64* %tmp587
    %tmp778 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp779 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp778, i32 0, i32 0
    %tmp780 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp781 = load %class.array.Array_char, %class.array.Array_char* %tmp780
    %tmp782 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp783 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp782, i32 0, i32 0
    %tmp784 = load i8*, i8** %tmp783
    %tmp785 = getelementptr inbounds i8, i8* %tmp784, i64 %tmp777
    %tmp786 = call i8* @"memcpy"(i8* %tmp785, i8* %tmp588, i64 1)
    %tmp787 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp788 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp787, i32 0, i32 1
    %tmp789 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp790 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp789, i32 0, i32 1
    %tmp791 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp792 = load %class.array.Array_char, %class.array.Array_char* %tmp791
    %tmp793 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp794 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp793, i32 0, i32 1
    %tmp795 = load i64, i64* %tmp794
    %tmp796 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp797 = load %class.array.Array_char, %class.array.Array_char* %tmp796
    %tmp798 = load %class.array.Array_char*, %class.array.Array_char** %tmp586
    %tmp799 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp798, i32 0, i32 1
    %tmp800 = load i64, i64* %tmp799
    %tmp801 = add i64 %tmp800, 1
    store i64 %tmp801, i64* %tmp788
    ret void
}

define i8 @"array.Array_char.remove"(%class.array.Array_char* %self, i64 %index) {
entry:
    %tmp802 = alloca %class.array.Array_char*
    store %class.array.Array_char* %self, %class.array.Array_char** %tmp802
    %tmp803 = alloca i64
    store i64 %index, i64* %tmp803
    %tmp804 = load i64, i64* %tmp803
    %tmp805 = load i64, i64* %tmp803
    %tmp806 = icmp slt i64 %tmp805, 0
    %tmp807 = load i64, i64* %tmp803
    %tmp808 = load i64, i64* %tmp803
    %tmp809 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp810 = load %class.array.Array_char, %class.array.Array_char* %tmp809
    %tmp811 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp812 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp811, i32 0, i32 1
    %tmp813 = load i64, i64* %tmp812
    %tmp814 = icmp sge i64 %tmp808, %tmp813
    %tmp815 = or i1 %tmp806, %tmp814
    br i1 %tmp815, label %if_then.69, label %if_else.70
if_then.69:
    %tmp816 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp816)
    br label %if_end.71
if_else.70:
    br label %if_end.71
if_end.71:
    %tmp817 = call i8* @"malloc"(i64 1)
    %tmp818 = alloca i8*
    store i8* %tmp817, i8** %tmp818
    %tmp819 = load i64, i64* %tmp803
    %tmp820 = alloca i64
    store i64 %tmp819, i64* %tmp820
    br label %while_cond.72
while_cond.72:
    %tmp821 = load i64, i64* %tmp820
    %tmp822 = load i64, i64* %tmp820
    %tmp823 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp824 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp823, i32 0, i32 1
    %tmp825 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp826 = load %class.array.Array_char, %class.array.Array_char* %tmp825
    %tmp827 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp828 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp827, i32 0, i32 1
    %tmp829 = load i64, i64* %tmp828
    %tmp830 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp831 = load %class.array.Array_char, %class.array.Array_char* %tmp830
    %tmp832 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp833 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp832, i32 0, i32 1
    %tmp834 = load i64, i64* %tmp833
    %tmp835 = sub i64 %tmp834, 1
    %tmp836 = icmp slt i64 %tmp822, %tmp835
    br i1 %tmp836, label %while_body.73, label %while_end.74
while_body.73:
    %tmp837 = load i8*, i8** %tmp818
    %tmp838 = load i64, i64* %tmp820
    %tmp839 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp840 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp839, i32 0, i32 0
    %tmp841 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp842 = load %class.array.Array_char, %class.array.Array_char* %tmp841
    %tmp843 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp844 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp843, i32 0, i32 0
    %tmp845 = load i8*, i8** %tmp844
    %tmp846 = getelementptr inbounds i8, i8* %tmp845, i64 %tmp838
    %tmp847 = call i8* @"memcpy"(i8* %tmp837, i8* %tmp846, i64 1)
    %tmp848 = load i64, i64* %tmp820
    %tmp849 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp850 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp849, i32 0, i32 0
    %tmp851 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp852 = load %class.array.Array_char, %class.array.Array_char* %tmp851
    %tmp853 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp854 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp853, i32 0, i32 0
    %tmp855 = load i8*, i8** %tmp854
    %tmp856 = getelementptr inbounds i8, i8* %tmp855, i64 %tmp848
    %tmp857 = load i64, i64* %tmp820
    %tmp858 = load i64, i64* %tmp820
    %tmp859 = add i64 %tmp858, 1
    %tmp860 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp861 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp860, i32 0, i32 0
    %tmp862 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp863 = load %class.array.Array_char, %class.array.Array_char* %tmp862
    %tmp864 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp865 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp864, i32 0, i32 0
    %tmp866 = load i8*, i8** %tmp865
    %tmp867 = getelementptr inbounds i8, i8* %tmp866, i64 %tmp859
    %tmp868 = call i8* @"memcpy"(i8* %tmp856, i8* %tmp867, i64 1)
    %tmp869 = load i64, i64* %tmp820
    %tmp870 = load i64, i64* %tmp820
    %tmp871 = add i64 %tmp870, 1
    %tmp872 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp873 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp872, i32 0, i32 0
    %tmp874 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp875 = load %class.array.Array_char, %class.array.Array_char* %tmp874
    %tmp876 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp877 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp876, i32 0, i32 0
    %tmp878 = load i8*, i8** %tmp877
    %tmp879 = getelementptr inbounds i8, i8* %tmp878, i64 %tmp871
    %tmp880 = load i8*, i8** %tmp818
    %tmp881 = call i8* @"memcpy"(i8* %tmp879, i8* %tmp880, i64 1)
    %tmp882 = load i64, i64* %tmp820
    %tmp883 = load i64, i64* %tmp820
    %tmp884 = add i64 %tmp883, 1
    store i64 %tmp884, i64* %tmp820
    br label %while_cond.72
while_end.74:
    %tmp885 = load i8*, i8** %tmp818
    call void @"free"(i8* %tmp885)
    %tmp886 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp887 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp886, i32 0, i32 1
    %tmp888 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp889 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp888, i32 0, i32 1
    %tmp890 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp891 = load %class.array.Array_char, %class.array.Array_char* %tmp890
    %tmp892 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp893 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp892, i32 0, i32 1
    %tmp894 = load i64, i64* %tmp893
    %tmp895 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp896 = load %class.array.Array_char, %class.array.Array_char* %tmp895
    %tmp897 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp898 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp897, i32 0, i32 1
    %tmp899 = load i64, i64* %tmp898
    %tmp900 = sub i64 %tmp899, 1
    store i64 %tmp900, i64* %tmp887
    %tmp901 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp902 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp901, i32 0, i32 0
    %tmp903 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp904 = load %class.array.Array_char, %class.array.Array_char* %tmp903
    %tmp905 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp906 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp905, i32 0, i32 0
    %tmp907 = load i8*, i8** %tmp906
    %tmp908 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp909 = load %class.array.Array_char, %class.array.Array_char* %tmp908
    %tmp910 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp911 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp910, i32 0, i32 1
    %tmp912 = load i64, i64* %tmp911
    %tmp913 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp914 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp913, i32 0, i32 0
    %tmp915 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp916 = load %class.array.Array_char, %class.array.Array_char* %tmp915
    %tmp917 = load %class.array.Array_char*, %class.array.Array_char** %tmp802
    %tmp918 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp917, i32 0, i32 0
    %tmp919 = load i8*, i8** %tmp918
    %tmp920 = getelementptr inbounds i8, i8* %tmp919, i64 %tmp912
    %tmp921 = load i8, i8* %tmp920
    ret i8 %tmp921
}

define void @"array.Array_char.clear"(%class.array.Array_char* %self) {
entry:
    %tmp922 = alloca %class.array.Array_char*
    store %class.array.Array_char* %self, %class.array.Array_char** %tmp922
    %tmp923 = alloca i64
    store i64 0, i64* %tmp923
    br label %while_cond.75
while_cond.75:
    %tmp924 = load i64, i64* %tmp923
    %tmp925 = load i64, i64* %tmp923
    %tmp926 = load %class.array.Array_char*, %class.array.Array_char** %tmp922
    %tmp927 = load %class.array.Array_char, %class.array.Array_char* %tmp926
    %tmp928 = load %class.array.Array_char*, %class.array.Array_char** %tmp922
    %tmp929 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp928, i32 0, i32 1
    %tmp930 = load i64, i64* %tmp929
    %tmp931 = icmp slt i64 %tmp925, %tmp930
    br i1 %tmp931, label %while_body.76, label %while_end.77
while_body.76:
    %tmp932 = load i64, i64* %tmp923
    %tmp933 = load %class.array.Array_char*, %class.array.Array_char** %tmp922
    %tmp934 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp933, i32 0, i32 0
    %tmp935 = load %class.array.Array_char*, %class.array.Array_char** %tmp922
    %tmp936 = load %class.array.Array_char, %class.array.Array_char* %tmp935
    %tmp937 = load %class.array.Array_char*, %class.array.Array_char** %tmp922
    %tmp938 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp937, i32 0, i32 0
    %tmp939 = load i8*, i8** %tmp938
    %tmp940 = getelementptr inbounds i8, i8* %tmp939, i64 %tmp932
    %tmp941 = load i64, i64* %tmp923
    %tmp942 = load i64, i64* %tmp923
    %tmp943 = add i64 %tmp942, 1
    store i64 %tmp943, i64* %tmp923
    br label %while_cond.75
while_end.77:
    %tmp944 = load %class.array.Array_char*, %class.array.Array_char** %tmp922
    %tmp945 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp944, i32 0, i32 1
    store i64 0, i64* %tmp945
    ret void
}

define void @"array.Array_char.destroy"(%class.array.Array_char* %self) {
entry:
    %tmp946 = alloca %class.array.Array_char*
    store %class.array.Array_char* %self, %class.array.Array_char** %tmp946
    %tmp947 = load %class.array.Array_char*, %class.array.Array_char** %tmp946
    %tmp948 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp947, i32 0, i32 0
    %tmp949 = load %class.array.Array_char*, %class.array.Array_char** %tmp946
    %tmp950 = load %class.array.Array_char, %class.array.Array_char* %tmp949
    %tmp951 = load %class.array.Array_char*, %class.array.Array_char** %tmp946
    %tmp952 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp951, i32 0, i32 0
    %tmp953 = load i8*, i8** %tmp952
    %tmp954 = load %class.array.Array_char*, %class.array.Array_char** %tmp946
    %tmp955 = load %class.array.Array_char, %class.array.Array_char* %tmp954
    %tmp956 = load %class.array.Array_char*, %class.array.Array_char** %tmp946
    %tmp957 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp956, i32 0, i32 0
    %tmp958 = load i8*, i8** %tmp957
    %tmp959 = icmp ne i8* %tmp958, null
    br i1 %tmp959, label %if_then.78, label %if_else.79
if_then.78:
    %tmp960 = alloca i64
    store i64 0, i64* %tmp960
    br label %while_cond.81
while_cond.81:
    %tmp961 = load i64, i64* %tmp960
    %tmp962 = load i64, i64* %tmp960
    %tmp963 = load %class.array.Array_char*, %class.array.Array_char** %tmp946
    %tmp964 = load %class.array.Array_char, %class.array.Array_char* %tmp963
    %tmp965 = load %class.array.Array_char*, %class.array.Array_char** %tmp946
    %tmp966 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp965, i32 0, i32 1
    %tmp967 = load i64, i64* %tmp966
    %tmp968 = icmp slt i64 %tmp962, %tmp967
    br i1 %tmp968, label %while_body.82, label %while_end.83
while_body.82:
    %tmp969 = load i64, i64* %tmp960
    %tmp970 = load %class.array.Array_char*, %class.array.Array_char** %tmp946
    %tmp971 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp970, i32 0, i32 0
    %tmp972 = load %class.array.Array_char*, %class.array.Array_char** %tmp946
    %tmp973 = load %class.array.Array_char, %class.array.Array_char* %tmp972
    %tmp974 = load %class.array.Array_char*, %class.array.Array_char** %tmp946
    %tmp975 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp974, i32 0, i32 0
    %tmp976 = load i8*, i8** %tmp975
    %tmp977 = getelementptr inbounds i8, i8* %tmp976, i64 %tmp969
    %tmp978 = load i64, i64* %tmp960
    %tmp979 = load i64, i64* %tmp960
    %tmp980 = add i64 %tmp979, 1
    store i64 %tmp980, i64* %tmp960
    br label %while_cond.81
while_end.83:
    %tmp981 = load %class.array.Array_char*, %class.array.Array_char** %tmp946
    %tmp982 = load %class.array.Array_char, %class.array.Array_char* %tmp981
    %tmp983 = load %class.array.Array_char*, %class.array.Array_char** %tmp946
    %tmp984 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp983, i32 0, i32 0
    %tmp985 = load i8*, i8** %tmp984
    %tmp986 = bitcast i8* %tmp985 to i8*
    call void @"free"(i8* %tmp986)
    %tmp987 = load %class.array.Array_char*, %class.array.Array_char** %tmp946
    %tmp988 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp987, i32 0, i32 0
    store i8* null, i8** %tmp988
    br label %if_end.80
if_else.79:
    br label %if_end.80
if_end.80:
    %tmp989 = load %class.array.Array_char*, %class.array.Array_char** %tmp946
    %tmp990 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp989, i32 0, i32 2
    store i64 0, i64* %tmp990
    %tmp991 = load %class.array.Array_char*, %class.array.Array_char** %tmp946
    %tmp992 = getelementptr inbounds %class.array.Array_char, %class.array.Array_char* %tmp991, i32 0, i32 1
    store i64 0, i64* %tmp992
    ret void
}

define %class.array.Array_char @"array.Array_char.clone"(%class.array.Array_char* %self) {
entry:
    %tmp0 = load %class.array.Array_char, %class.array.Array_char* %self
    ret %class.array.Array_char %tmp0
}

define void @"io.print_char"(i8 %c) {
entry:
    %tmp993 = alloca i8
    store i8 %c, i8* %tmp993
    %tmp994 = load i8, i8* %tmp993
    %tmp995 = zext i8 %tmp994 to i32
    %tmp996 = call i32 @"putchar"(i32 %tmp995)
    ret void
}

define void @"io.print_str"(i8* %s) {
entry:
    %tmp997 = alloca i8*
    store i8* %s, i8** %tmp997
    %tmp998 = alloca i64
    store i64 0, i64* %tmp998
    br label %while_cond.84
while_cond.84:
    %tmp999 = load i64, i64* %tmp998
    %tmp1000 = load i8*, i8** %tmp997
    %tmp1001 = getelementptr inbounds i8, i8* %tmp1000, i64 %tmp999
    %tmp1002 = load i8*, i8** %tmp997
    %tmp1003 = load i64, i64* %tmp998
    %tmp1004 = load i8*, i8** %tmp997
    %tmp1005 = getelementptr inbounds i8, i8* %tmp1004, i64 %tmp1003
    %tmp1006 = load i8, i8* %tmp1005
    %tmp1007 = load i8*, i8** %tmp997
    %tmp1008 = load i64, i64* %tmp998
    %tmp1009 = load i8*, i8** %tmp997
    %tmp1010 = getelementptr inbounds i8, i8* %tmp1009, i64 %tmp1008
    %tmp1011 = load i8, i8* %tmp1010
    %tmp1012 = icmp ne i8 %tmp1011, 0
    br i1 %tmp1012, label %while_body.85, label %while_end.86
while_body.85:
    %tmp1013 = load i8*, i8** %tmp997
    %tmp1014 = load i64, i64* %tmp998
    %tmp1015 = load i8*, i8** %tmp997
    %tmp1016 = getelementptr inbounds i8, i8* %tmp1015, i64 %tmp1014
    %tmp1017 = load i8, i8* %tmp1016
    %tmp1018 = zext i8 %tmp1017 to i32
    %tmp1019 = call i32 @"putchar"(i32 %tmp1018)
    %tmp1020 = load i64, i64* %tmp998
    %tmp1021 = load i64, i64* %tmp998
    %tmp1022 = add i64 %tmp1021, 1
    store i64 %tmp1022, i64* %tmp998
    br label %while_cond.84
while_end.86:
    ret void
}

define void @"io.println_str"(i8* %s) {
entry:
    %tmp1023 = alloca i8*
    store i8* %s, i8** %tmp1023
    %tmp1024 = load i8*, i8** %tmp1023
    %tmp1025 = call i32 @"puts"(i8* %tmp1024)
    ret void
}

define i32 @"main"() {
entry:
    %tmp1026 = alloca %class.array.Array_char
    store %class.array.Array_char zeroinitializer, %class.array.Array_char* %tmp1026
    call void @"array.Array_char.init"(%class.array.Array_char* %tmp1026)
    %tmp1027 = load %class.array.Array_char, %class.array.Array_char* %tmp1026
    %tmp1028 = alloca %class.array.Array_char
    store %class.array.Array_char %tmp1027, %class.array.Array_char* %tmp1028
    %tmp1029 = load %class.array.Array_char, %class.array.Array_char* %tmp1028
    call void @"array.Array_char.push"(%class.array.Array_char* %tmp1028, i8 65)
    %tmp1030 = load %class.array.Array_char, %class.array.Array_char* %tmp1028
    call void @"array.Array_char.push"(%class.array.Array_char* %tmp1028, i8 66)
    %tmp1031 = call i8 @"array.Array_char.operator_index"(%class.array.Array_char* %tmp1028, i64 0)
    %tmp1032 = zext i8 %tmp1031 to i32
    %tmp1033 = call i32 @"putchar"(i32 %tmp1032)
    %tmp1034 = call i8 @"array.Array_char.operator_index"(%class.array.Array_char* %tmp1028, i64 1)
    %tmp1035 = zext i8 %tmp1034 to i32
    %tmp1036 = call i32 @"putchar"(i32 %tmp1035)
    %tmp1037 = load %class.array.Array_char, %class.array.Array_char* %tmp1028
    %tmp1038 = call i8 @"array.Array_char.pop"(%class.array.Array_char* %tmp1028)
    %tmp1039 = alloca i8
    store i8 %tmp1038, i8* %tmp1039
    %tmp1040 = load %class.array.Array_char, %class.array.Array_char* %tmp1028
    %tmp1041 = call i8 @"array.Array_char.pop"(%class.array.Array_char* %tmp1028)
    %tmp1042 = alloca i8
    store i8 %tmp1041, i8* %tmp1042
    %tmp1043 = load i8, i8* %tmp1042
    %tmp1044 = zext i8 %tmp1043 to i32
    %tmp1045 = call i32 @"putchar"(i32 %tmp1044)
    %tmp1046 = load i8, i8* %tmp1039
    %tmp1047 = zext i8 %tmp1046 to i32
    %tmp1048 = call i32 @"putchar"(i32 %tmp1047)
    %tmp1049 = trunc i64 0 to i32
    call void @"array.Array_char.destroy"(%class.array.Array_char* %tmp1028)
    ret i32 %tmp1049
}

