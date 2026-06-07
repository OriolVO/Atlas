; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

%class.array.Array_string.String = type { %class.string.String*, i64, i64 }
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

define void @"array.Array_string.String.init"(%class.array.Array_string.String* %self) {
entry:
    %tmp322 = alloca %class.array.Array_string.String*
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %tmp322
    %tmp323 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp322
    %tmp324 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp323, i32 0, i32 1
    store i64 0, i64* %tmp324
    %tmp325 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp322
    %tmp326 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp325, i32 0, i32 2
    store i64 0, i64* %tmp326
    %tmp327 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp322
    %tmp328 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp327, i32 0, i32 0
    store %class.string.String* null, %class.string.String** %tmp328
    ret void
}

define i64 @"array.Array_string.String.length"(%class.array.Array_string.String* %self) {
entry:
    %tmp329 = alloca %class.array.Array_string.String*
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %tmp329
    %tmp330 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp329
    %tmp331 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp330
    %tmp332 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp329
    %tmp333 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp332, i32 0, i32 1
    %tmp334 = load i64, i64* %tmp333
    ret i64 %tmp334
}

define i64 @"array.Array_string.String.capacity"(%class.array.Array_string.String* %self) {
entry:
    %tmp335 = alloca %class.array.Array_string.String*
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %tmp335
    %tmp336 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp335
    %tmp337 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp336
    %tmp338 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp335
    %tmp339 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp338, i32 0, i32 2
    %tmp340 = load i64, i64* %tmp339
    ret i64 %tmp340
}

define void @"array.Array_string.String.push"(%class.array.Array_string.String* %self, %class.string.String %item) {
entry:
    %tmp341 = alloca %class.array.Array_string.String*
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %tmp341
    %tmp342 = alloca %class.string.String
    store %class.string.String %item, %class.string.String* %tmp342
    %tmp343 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp344 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp343, i32 0, i32 1
    %tmp345 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp346 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp345
    %tmp347 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp348 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp347, i32 0, i32 1
    %tmp349 = load i64, i64* %tmp348
    %tmp350 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp351 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp350
    %tmp352 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp353 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp352, i32 0, i32 1
    %tmp354 = load i64, i64* %tmp353
    %tmp355 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp356 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp355
    %tmp357 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp358 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp357, i32 0, i32 2
    %tmp359 = load i64, i64* %tmp358
    %tmp360 = icmp eq i64 %tmp354, %tmp359
    br i1 %tmp360, label %if_then.30, label %if_else.31
if_then.30:
    %tmp361 = alloca i64
    store i64 4, i64* %tmp361
    %tmp362 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp363 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp362, i32 0, i32 2
    %tmp364 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp365 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp364
    %tmp366 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp367 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp366, i32 0, i32 2
    %tmp368 = load i64, i64* %tmp367
    %tmp369 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp370 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp369
    %tmp371 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp372 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp371, i32 0, i32 2
    %tmp373 = load i64, i64* %tmp372
    %tmp374 = icmp sgt i64 %tmp373, 0
    br i1 %tmp374, label %if_then.33, label %if_else.34
if_then.33:
    %tmp375 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp376 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp375, i32 0, i32 2
    %tmp377 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp378 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp377
    %tmp379 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp380 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp379, i32 0, i32 2
    %tmp381 = load i64, i64* %tmp380
    %tmp382 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp383 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp382
    %tmp384 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp385 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp384, i32 0, i32 2
    %tmp386 = load i64, i64* %tmp385
    %tmp387 = mul i64 %tmp386, 2
    store i64 %tmp387, i64* %tmp361
    br label %if_end.35
if_else.34:
    br label %if_end.35
if_end.35:
    %tmp388 = load i64, i64* %tmp361
    %tmp389 = load i64, i64* %tmp361
    %tmp390 = mul i64 %tmp389, 16
    %tmp391 = call i8* @"malloc"(i64 %tmp390)
    %tmp392 = bitcast i8* %tmp391 to %class.string.String*
    %tmp393 = alloca %class.string.String*
    store %class.string.String* %tmp392, %class.string.String** %tmp393
    %tmp394 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp395 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp394, i32 0, i32 0
    %tmp396 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp397 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp396
    %tmp398 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp399 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp398, i32 0, i32 0
    %tmp400 = load %class.string.String*, %class.string.String** %tmp399
    %tmp401 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp402 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp401
    %tmp403 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp404 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp403, i32 0, i32 0
    %tmp405 = load %class.string.String*, %class.string.String** %tmp404
    %tmp406 = icmp ne %class.string.String* %tmp405, null
    br i1 %tmp406, label %if_then.36, label %if_else.37
if_then.36:
    %tmp407 = load %class.string.String*, %class.string.String** %tmp393
    %tmp408 = bitcast %class.string.String* %tmp407 to i8*
    %tmp409 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp410 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp409
    %tmp411 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp412 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp411, i32 0, i32 0
    %tmp413 = load %class.string.String*, %class.string.String** %tmp412
    %tmp414 = bitcast %class.string.String* %tmp413 to i8*
    %tmp415 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp416 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp415, i32 0, i32 1
    %tmp417 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp418 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp417
    %tmp419 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp420 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp419, i32 0, i32 1
    %tmp421 = load i64, i64* %tmp420
    %tmp422 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp423 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp422
    %tmp424 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp425 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp424, i32 0, i32 1
    %tmp426 = load i64, i64* %tmp425
    %tmp427 = mul i64 %tmp426, 16
    %tmp428 = call i8* @"memcpy"(i8* %tmp408, i8* %tmp414, i64 %tmp427)
    %tmp429 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp430 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp429
    %tmp431 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp432 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp431, i32 0, i32 0
    %tmp433 = load %class.string.String*, %class.string.String** %tmp432
    %tmp434 = bitcast %class.string.String* %tmp433 to i8*
    call void @"free"(i8* %tmp434)
    br label %if_end.38
if_else.37:
    br label %if_end.38
if_end.38:
    %tmp435 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp436 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp435, i32 0, i32 2
    %tmp437 = load i64, i64* %tmp361
    store i64 %tmp437, i64* %tmp436
    %tmp438 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp439 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp438, i32 0, i32 0
    %tmp440 = load %class.string.String*, %class.string.String** %tmp393
    store %class.string.String* %tmp440, %class.string.String** %tmp439
    br label %if_end.32
if_else.31:
    br label %if_end.32
if_end.32:
    %tmp441 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp442 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp441
    %tmp443 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp444 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp443, i32 0, i32 1
    %tmp445 = load i64, i64* %tmp444
    %tmp446 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp447 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp446, i32 0, i32 0
    %tmp448 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp449 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp448
    %tmp450 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp451 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp450, i32 0, i32 0
    %tmp452 = load %class.string.String*, %class.string.String** %tmp451
    %tmp453 = getelementptr inbounds %class.string.String, %class.string.String* %tmp452, i64 %tmp445
    %tmp454 = bitcast %class.string.String* %tmp453 to i8*
    %tmp455 = bitcast %class.string.String* %tmp342 to i8*
    %tmp456 = call i8* @"memcpy"(i8* %tmp454, i8* %tmp455, i64 16)
    %tmp457 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp458 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp457, i32 0, i32 1
    %tmp459 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp460 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp459, i32 0, i32 1
    %tmp461 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp462 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp461
    %tmp463 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp464 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp463, i32 0, i32 1
    %tmp465 = load i64, i64* %tmp464
    %tmp466 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp467 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp466
    %tmp468 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp341
    %tmp469 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp468, i32 0, i32 1
    %tmp470 = load i64, i64* %tmp469
    %tmp471 = add i64 %tmp470, 1
    store i64 %tmp471, i64* %tmp458
    ret void
}

define %class.string.String @"array.Array_string.String.pop"(%class.array.Array_string.String* %self) {
entry:
    %tmp472 = alloca %class.array.Array_string.String*
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %tmp472
    %tmp473 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp472
    %tmp474 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp473, i32 0, i32 1
    %tmp475 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp472
    %tmp476 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp475
    %tmp477 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp472
    %tmp478 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp477, i32 0, i32 1
    %tmp479 = load i64, i64* %tmp478
    %tmp480 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp472
    %tmp481 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp480
    %tmp482 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp472
    %tmp483 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp482, i32 0, i32 1
    %tmp484 = load i64, i64* %tmp483
    %tmp485 = icmp eq i64 %tmp484, 0
    br i1 %tmp485, label %if_then.39, label %if_else.40
if_then.39:
    %tmp486 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp486)
    br label %if_end.41
if_else.40:
    br label %if_end.41
if_end.41:
    %tmp487 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp472
    %tmp488 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp487, i32 0, i32 1
    %tmp489 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp472
    %tmp490 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp489, i32 0, i32 1
    %tmp491 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp472
    %tmp492 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp491
    %tmp493 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp472
    %tmp494 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp493, i32 0, i32 1
    %tmp495 = load i64, i64* %tmp494
    %tmp496 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp472
    %tmp497 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp496
    %tmp498 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp472
    %tmp499 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp498, i32 0, i32 1
    %tmp500 = load i64, i64* %tmp499
    %tmp501 = sub i64 %tmp500, 1
    store i64 %tmp501, i64* %tmp488
    %tmp502 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp472
    %tmp503 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp502, i32 0, i32 0
    %tmp504 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp472
    %tmp505 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp504
    %tmp506 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp472
    %tmp507 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp506, i32 0, i32 0
    %tmp508 = load %class.string.String*, %class.string.String** %tmp507
    %tmp509 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp472
    %tmp510 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp509
    %tmp511 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp472
    %tmp512 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp511, i32 0, i32 1
    %tmp513 = load i64, i64* %tmp512
    %tmp514 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp472
    %tmp515 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp514, i32 0, i32 0
    %tmp516 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp472
    %tmp517 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp516
    %tmp518 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp472
    %tmp519 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp518, i32 0, i32 0
    %tmp520 = load %class.string.String*, %class.string.String** %tmp519
    %tmp521 = getelementptr inbounds %class.string.String, %class.string.String* %tmp520, i64 %tmp513
    %tmp522 = load %class.string.String, %class.string.String* %tmp521
    ret %class.string.String %tmp522
}

define %class.string.String @"array.Array_string.String.operator_index"(%class.array.Array_string.String* %self, i64 %index) {
entry:
    %tmp523 = alloca %class.array.Array_string.String*
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %tmp523
    %tmp524 = alloca i64
    store i64 %index, i64* %tmp524
    %tmp525 = load i64, i64* %tmp524
    %tmp526 = load i64, i64* %tmp524
    %tmp527 = icmp slt i64 %tmp526, 0
    %tmp528 = load i64, i64* %tmp524
    %tmp529 = load i64, i64* %tmp524
    %tmp530 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp523
    %tmp531 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp530
    %tmp532 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp523
    %tmp533 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp532, i32 0, i32 1
    %tmp534 = load i64, i64* %tmp533
    %tmp535 = icmp sge i64 %tmp529, %tmp534
    %tmp536 = or i1 %tmp527, %tmp535
    br i1 %tmp536, label %if_then.42, label %if_else.43
if_then.42:
    %tmp537 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp537)
    br label %if_end.44
if_else.43:
    br label %if_end.44
if_end.44:
    %tmp538 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp523
    %tmp539 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp538, i32 0, i32 0
    %tmp540 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp523
    %tmp541 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp540
    %tmp542 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp523
    %tmp543 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp542, i32 0, i32 0
    %tmp544 = load %class.string.String*, %class.string.String** %tmp543
    %tmp545 = load i64, i64* %tmp524
    %tmp546 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp523
    %tmp547 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp546, i32 0, i32 0
    %tmp548 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp523
    %tmp549 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp548
    %tmp550 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp523
    %tmp551 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp550, i32 0, i32 0
    %tmp552 = load %class.string.String*, %class.string.String** %tmp551
    %tmp553 = getelementptr inbounds %class.string.String, %class.string.String* %tmp552, i64 %tmp545
    %tmp554 = load %class.string.String, %class.string.String* %tmp553
    ret %class.string.String %tmp554
}

define void @"array.Array_string.String.operator_index_set"(%class.array.Array_string.String* %self, i64 %index, %class.string.String %item) {
entry:
    %tmp555 = alloca %class.array.Array_string.String*
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %tmp555
    %tmp556 = alloca i64
    store i64 %index, i64* %tmp556
    %tmp557 = alloca %class.string.String
    store %class.string.String %item, %class.string.String* %tmp557
    %tmp558 = load i64, i64* %tmp556
    %tmp559 = load i64, i64* %tmp556
    %tmp560 = icmp slt i64 %tmp559, 0
    %tmp561 = load i64, i64* %tmp556
    %tmp562 = load i64, i64* %tmp556
    %tmp563 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp555
    %tmp564 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp563
    %tmp565 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp555
    %tmp566 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp565, i32 0, i32 1
    %tmp567 = load i64, i64* %tmp566
    %tmp568 = icmp sge i64 %tmp562, %tmp567
    %tmp569 = or i1 %tmp560, %tmp568
    br i1 %tmp569, label %if_then.45, label %if_else.46
if_then.45:
    %tmp570 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp570)
    br label %if_end.47
if_else.46:
    br label %if_end.47
if_end.47:
    %tmp571 = load i64, i64* %tmp556
    %tmp572 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp555
    %tmp573 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp572, i32 0, i32 0
    %tmp574 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp555
    %tmp575 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp574
    %tmp576 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp555
    %tmp577 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp576, i32 0, i32 0
    %tmp578 = load %class.string.String*, %class.string.String** %tmp577
    %tmp579 = getelementptr inbounds %class.string.String, %class.string.String* %tmp578, i64 %tmp571
    call void @"string.String.destroy"(%class.string.String* %tmp579)
    %tmp580 = load i64, i64* %tmp556
    %tmp581 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp555
    %tmp582 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp581, i32 0, i32 0
    %tmp583 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp555
    %tmp584 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp583
    %tmp585 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp555
    %tmp586 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp585, i32 0, i32 0
    %tmp587 = load %class.string.String*, %class.string.String** %tmp586
    %tmp588 = getelementptr inbounds %class.string.String, %class.string.String* %tmp587, i64 %tmp580
    %tmp589 = bitcast %class.string.String* %tmp588 to i8*
    %tmp590 = bitcast %class.string.String* %tmp557 to i8*
    %tmp591 = call i8* @"memcpy"(i8* %tmp589, i8* %tmp590, i64 16)
    ret void
}

define void @"array.Array_string.String.insert"(%class.array.Array_string.String* %self, i64 %index, %class.string.String %item) {
entry:
    %tmp592 = alloca %class.array.Array_string.String*
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %tmp592
    %tmp593 = alloca i64
    store i64 %index, i64* %tmp593
    %tmp594 = alloca %class.string.String
    store %class.string.String %item, %class.string.String* %tmp594
    %tmp595 = load i64, i64* %tmp593
    %tmp596 = load i64, i64* %tmp593
    %tmp597 = icmp slt i64 %tmp596, 0
    %tmp598 = load i64, i64* %tmp593
    %tmp599 = load i64, i64* %tmp593
    %tmp600 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp601 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp600
    %tmp602 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp603 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp602, i32 0, i32 1
    %tmp604 = load i64, i64* %tmp603
    %tmp605 = icmp sgt i64 %tmp599, %tmp604
    %tmp606 = or i1 %tmp597, %tmp605
    br i1 %tmp606, label %if_then.48, label %if_else.49
if_then.48:
    %tmp607 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp607)
    br label %if_end.50
if_else.49:
    br label %if_end.50
if_end.50:
    %tmp608 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp609 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp608, i32 0, i32 1
    %tmp610 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp611 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp610
    %tmp612 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp613 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp612, i32 0, i32 1
    %tmp614 = load i64, i64* %tmp613
    %tmp615 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp616 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp615
    %tmp617 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp618 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp617, i32 0, i32 1
    %tmp619 = load i64, i64* %tmp618
    %tmp620 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp621 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp620
    %tmp622 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp623 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp622, i32 0, i32 2
    %tmp624 = load i64, i64* %tmp623
    %tmp625 = icmp eq i64 %tmp619, %tmp624
    br i1 %tmp625, label %if_then.51, label %if_else.52
if_then.51:
    %tmp626 = alloca i64
    store i64 4, i64* %tmp626
    %tmp627 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp628 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp627, i32 0, i32 2
    %tmp629 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp630 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp629
    %tmp631 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp632 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp631, i32 0, i32 2
    %tmp633 = load i64, i64* %tmp632
    %tmp634 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp635 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp634
    %tmp636 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp637 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp636, i32 0, i32 2
    %tmp638 = load i64, i64* %tmp637
    %tmp639 = icmp sgt i64 %tmp638, 0
    br i1 %tmp639, label %if_then.54, label %if_else.55
if_then.54:
    %tmp640 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp641 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp640, i32 0, i32 2
    %tmp642 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp643 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp642
    %tmp644 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp645 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp644, i32 0, i32 2
    %tmp646 = load i64, i64* %tmp645
    %tmp647 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp648 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp647
    %tmp649 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp650 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp649, i32 0, i32 2
    %tmp651 = load i64, i64* %tmp650
    %tmp652 = mul i64 %tmp651, 2
    store i64 %tmp652, i64* %tmp626
    br label %if_end.56
if_else.55:
    br label %if_end.56
if_end.56:
    %tmp653 = load i64, i64* %tmp626
    %tmp654 = load i64, i64* %tmp626
    %tmp655 = mul i64 %tmp654, 16
    %tmp656 = call i8* @"malloc"(i64 %tmp655)
    %tmp657 = bitcast i8* %tmp656 to %class.string.String*
    %tmp658 = alloca %class.string.String*
    store %class.string.String* %tmp657, %class.string.String** %tmp658
    %tmp659 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp660 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp659, i32 0, i32 0
    %tmp661 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp662 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp661
    %tmp663 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp664 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp663, i32 0, i32 0
    %tmp665 = load %class.string.String*, %class.string.String** %tmp664
    %tmp666 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp667 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp666
    %tmp668 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp669 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp668, i32 0, i32 0
    %tmp670 = load %class.string.String*, %class.string.String** %tmp669
    %tmp671 = icmp ne %class.string.String* %tmp670, null
    br i1 %tmp671, label %if_then.57, label %if_else.58
if_then.57:
    %tmp672 = load i64, i64* %tmp593
    %tmp673 = load i64, i64* %tmp593
    %tmp674 = icmp sgt i64 %tmp673, 0
    br i1 %tmp674, label %if_then.60, label %if_else.61
if_then.60:
    %tmp675 = load %class.string.String*, %class.string.String** %tmp658
    %tmp676 = bitcast %class.string.String* %tmp675 to i8*
    %tmp677 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp678 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp677
    %tmp679 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp680 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp679, i32 0, i32 0
    %tmp681 = load %class.string.String*, %class.string.String** %tmp680
    %tmp682 = bitcast %class.string.String* %tmp681 to i8*
    %tmp683 = load i64, i64* %tmp593
    %tmp684 = load i64, i64* %tmp593
    %tmp685 = mul i64 %tmp684, 16
    %tmp686 = call i8* @"memcpy"(i8* %tmp676, i8* %tmp682, i64 %tmp685)
    br label %if_end.62
if_else.61:
    br label %if_end.62
if_end.62:
    %tmp687 = load i64, i64* %tmp593
    %tmp688 = load i64, i64* %tmp593
    %tmp689 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp690 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp689
    %tmp691 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp692 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp691, i32 0, i32 1
    %tmp693 = load i64, i64* %tmp692
    %tmp694 = icmp slt i64 %tmp688, %tmp693
    br i1 %tmp694, label %if_then.63, label %if_else.64
if_then.63:
    %tmp695 = load i64, i64* %tmp593
    %tmp696 = load i64, i64* %tmp593
    %tmp697 = add i64 %tmp696, 1
    %tmp698 = load %class.string.String*, %class.string.String** %tmp658
    %tmp699 = getelementptr inbounds %class.string.String, %class.string.String* %tmp698, i64 %tmp697
    %tmp700 = bitcast %class.string.String* %tmp699 to i8*
    %tmp701 = load i64, i64* %tmp593
    %tmp702 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp703 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp702, i32 0, i32 0
    %tmp704 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp705 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp704
    %tmp706 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp707 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp706, i32 0, i32 0
    %tmp708 = load %class.string.String*, %class.string.String** %tmp707
    %tmp709 = getelementptr inbounds %class.string.String, %class.string.String* %tmp708, i64 %tmp701
    %tmp710 = bitcast %class.string.String* %tmp709 to i8*
    %tmp711 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp712 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp711, i32 0, i32 1
    %tmp713 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp714 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp713
    %tmp715 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp716 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp715, i32 0, i32 1
    %tmp717 = load i64, i64* %tmp716
    %tmp718 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp719 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp718
    %tmp720 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp721 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp720, i32 0, i32 1
    %tmp722 = load i64, i64* %tmp721
    %tmp723 = load i64, i64* %tmp593
    %tmp724 = sub i64 %tmp722, %tmp723
    %tmp725 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp726 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp725, i32 0, i32 1
    %tmp727 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp728 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp727
    %tmp729 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp730 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp729, i32 0, i32 1
    %tmp731 = load i64, i64* %tmp730
    %tmp732 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp733 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp732
    %tmp734 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp735 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp734, i32 0, i32 1
    %tmp736 = load i64, i64* %tmp735
    %tmp737 = load i64, i64* %tmp593
    %tmp738 = sub i64 %tmp736, %tmp737
    %tmp739 = mul i64 %tmp738, 16
    %tmp740 = call i8* @"memcpy"(i8* %tmp700, i8* %tmp710, i64 %tmp739)
    br label %if_end.65
if_else.64:
    br label %if_end.65
if_end.65:
    %tmp741 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp742 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp741
    %tmp743 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp744 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp743, i32 0, i32 0
    %tmp745 = load %class.string.String*, %class.string.String** %tmp744
    %tmp746 = bitcast %class.string.String* %tmp745 to i8*
    call void @"free"(i8* %tmp746)
    br label %if_end.59
if_else.58:
    br label %if_end.59
if_end.59:
    %tmp747 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp748 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp747, i32 0, i32 2
    %tmp749 = load i64, i64* %tmp626
    store i64 %tmp749, i64* %tmp748
    %tmp750 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp751 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp750, i32 0, i32 0
    %tmp752 = load %class.string.String*, %class.string.String** %tmp658
    store %class.string.String* %tmp752, %class.string.String** %tmp751
    br label %if_end.53
if_else.52:
    %tmp753 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp754 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp753
    %tmp755 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp756 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp755, i32 0, i32 1
    %tmp757 = load i64, i64* %tmp756
    %tmp758 = alloca i64
    store i64 %tmp757, i64* %tmp758
    br label %while_cond.66
while_cond.66:
    %tmp759 = load i64, i64* %tmp758
    %tmp760 = load i64, i64* %tmp758
    %tmp761 = load i64, i64* %tmp593
    %tmp762 = icmp sgt i64 %tmp760, %tmp761
    br i1 %tmp762, label %while_body.67, label %while_end.68
while_body.67:
    %tmp763 = load i64, i64* %tmp758
    %tmp764 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp765 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp764, i32 0, i32 0
    %tmp766 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp767 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp766
    %tmp768 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp769 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp768, i32 0, i32 0
    %tmp770 = load %class.string.String*, %class.string.String** %tmp769
    %tmp771 = getelementptr inbounds %class.string.String, %class.string.String* %tmp770, i64 %tmp763
    %tmp772 = bitcast %class.string.String* %tmp771 to i8*
    %tmp773 = load i64, i64* %tmp758
    %tmp774 = load i64, i64* %tmp758
    %tmp775 = sub i64 %tmp774, 1
    %tmp776 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp777 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp776, i32 0, i32 0
    %tmp778 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp779 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp778
    %tmp780 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp781 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp780, i32 0, i32 0
    %tmp782 = load %class.string.String*, %class.string.String** %tmp781
    %tmp783 = getelementptr inbounds %class.string.String, %class.string.String* %tmp782, i64 %tmp775
    %tmp784 = bitcast %class.string.String* %tmp783 to i8*
    %tmp785 = call i8* @"memcpy"(i8* %tmp772, i8* %tmp784, i64 16)
    %tmp786 = load i64, i64* %tmp758
    %tmp787 = load i64, i64* %tmp758
    %tmp788 = sub i64 %tmp787, 1
    store i64 %tmp788, i64* %tmp758
    br label %while_cond.66
while_end.68:
    br label %if_end.53
if_end.53:
    %tmp789 = load i64, i64* %tmp593
    %tmp790 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp791 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp790, i32 0, i32 0
    %tmp792 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp793 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp792
    %tmp794 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp795 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp794, i32 0, i32 0
    %tmp796 = load %class.string.String*, %class.string.String** %tmp795
    %tmp797 = getelementptr inbounds %class.string.String, %class.string.String* %tmp796, i64 %tmp789
    %tmp798 = bitcast %class.string.String* %tmp797 to i8*
    %tmp799 = bitcast %class.string.String* %tmp594 to i8*
    %tmp800 = call i8* @"memcpy"(i8* %tmp798, i8* %tmp799, i64 16)
    %tmp801 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp802 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp801, i32 0, i32 1
    %tmp803 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp804 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp803, i32 0, i32 1
    %tmp805 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp806 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp805
    %tmp807 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp808 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp807, i32 0, i32 1
    %tmp809 = load i64, i64* %tmp808
    %tmp810 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp811 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp810
    %tmp812 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp592
    %tmp813 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp812, i32 0, i32 1
    %tmp814 = load i64, i64* %tmp813
    %tmp815 = add i64 %tmp814, 1
    store i64 %tmp815, i64* %tmp802
    ret void
}

define %class.string.String @"array.Array_string.String.remove"(%class.array.Array_string.String* %self, i64 %index) {
entry:
    %tmp816 = alloca %class.array.Array_string.String*
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %tmp816
    %tmp817 = alloca i64
    store i64 %index, i64* %tmp817
    %tmp818 = load i64, i64* %tmp817
    %tmp819 = load i64, i64* %tmp817
    %tmp820 = icmp slt i64 %tmp819, 0
    %tmp821 = load i64, i64* %tmp817
    %tmp822 = load i64, i64* %tmp817
    %tmp823 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp824 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp823
    %tmp825 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp826 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp825, i32 0, i32 1
    %tmp827 = load i64, i64* %tmp826
    %tmp828 = icmp sge i64 %tmp822, %tmp827
    %tmp829 = or i1 %tmp820, %tmp828
    br i1 %tmp829, label %if_then.69, label %if_else.70
if_then.69:
    %tmp830 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp830)
    br label %if_end.71
if_else.70:
    br label %if_end.71
if_end.71:
    %tmp831 = call i8* @"malloc"(i64 16)
    %tmp832 = bitcast i8* %tmp831 to %class.string.String*
    %tmp833 = alloca %class.string.String*
    store %class.string.String* %tmp832, %class.string.String** %tmp833
    %tmp834 = load i64, i64* %tmp817
    %tmp835 = alloca i64
    store i64 %tmp834, i64* %tmp835
    br label %while_cond.72
while_cond.72:
    %tmp836 = load i64, i64* %tmp835
    %tmp837 = load i64, i64* %tmp835
    %tmp838 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp839 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp838, i32 0, i32 1
    %tmp840 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp841 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp840
    %tmp842 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp843 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp842, i32 0, i32 1
    %tmp844 = load i64, i64* %tmp843
    %tmp845 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp846 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp845
    %tmp847 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp848 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp847, i32 0, i32 1
    %tmp849 = load i64, i64* %tmp848
    %tmp850 = sub i64 %tmp849, 1
    %tmp851 = icmp slt i64 %tmp837, %tmp850
    br i1 %tmp851, label %while_body.73, label %while_end.74
while_body.73:
    %tmp852 = load %class.string.String*, %class.string.String** %tmp833
    %tmp853 = bitcast %class.string.String* %tmp852 to i8*
    %tmp854 = load i64, i64* %tmp835
    %tmp855 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp856 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp855, i32 0, i32 0
    %tmp857 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp858 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp857
    %tmp859 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp860 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp859, i32 0, i32 0
    %tmp861 = load %class.string.String*, %class.string.String** %tmp860
    %tmp862 = getelementptr inbounds %class.string.String, %class.string.String* %tmp861, i64 %tmp854
    %tmp863 = bitcast %class.string.String* %tmp862 to i8*
    %tmp864 = call i8* @"memcpy"(i8* %tmp853, i8* %tmp863, i64 16)
    %tmp865 = load i64, i64* %tmp835
    %tmp866 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp867 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp866, i32 0, i32 0
    %tmp868 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp869 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp868
    %tmp870 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp871 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp870, i32 0, i32 0
    %tmp872 = load %class.string.String*, %class.string.String** %tmp871
    %tmp873 = getelementptr inbounds %class.string.String, %class.string.String* %tmp872, i64 %tmp865
    %tmp874 = bitcast %class.string.String* %tmp873 to i8*
    %tmp875 = load i64, i64* %tmp835
    %tmp876 = load i64, i64* %tmp835
    %tmp877 = add i64 %tmp876, 1
    %tmp878 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp879 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp878, i32 0, i32 0
    %tmp880 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp881 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp880
    %tmp882 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp883 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp882, i32 0, i32 0
    %tmp884 = load %class.string.String*, %class.string.String** %tmp883
    %tmp885 = getelementptr inbounds %class.string.String, %class.string.String* %tmp884, i64 %tmp877
    %tmp886 = bitcast %class.string.String* %tmp885 to i8*
    %tmp887 = call i8* @"memcpy"(i8* %tmp874, i8* %tmp886, i64 16)
    %tmp888 = load i64, i64* %tmp835
    %tmp889 = load i64, i64* %tmp835
    %tmp890 = add i64 %tmp889, 1
    %tmp891 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp892 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp891, i32 0, i32 0
    %tmp893 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp894 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp893
    %tmp895 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp896 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp895, i32 0, i32 0
    %tmp897 = load %class.string.String*, %class.string.String** %tmp896
    %tmp898 = getelementptr inbounds %class.string.String, %class.string.String* %tmp897, i64 %tmp890
    %tmp899 = bitcast %class.string.String* %tmp898 to i8*
    %tmp900 = load %class.string.String*, %class.string.String** %tmp833
    %tmp901 = bitcast %class.string.String* %tmp900 to i8*
    %tmp902 = call i8* @"memcpy"(i8* %tmp899, i8* %tmp901, i64 16)
    %tmp903 = load i64, i64* %tmp835
    %tmp904 = load i64, i64* %tmp835
    %tmp905 = add i64 %tmp904, 1
    store i64 %tmp905, i64* %tmp835
    br label %while_cond.72
while_end.74:
    %tmp906 = load %class.string.String*, %class.string.String** %tmp833
    %tmp907 = bitcast %class.string.String* %tmp906 to i8*
    call void @"free"(i8* %tmp907)
    %tmp908 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp909 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp908, i32 0, i32 1
    %tmp910 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp911 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp910, i32 0, i32 1
    %tmp912 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp913 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp912
    %tmp914 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp915 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp914, i32 0, i32 1
    %tmp916 = load i64, i64* %tmp915
    %tmp917 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp918 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp917
    %tmp919 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp920 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp919, i32 0, i32 1
    %tmp921 = load i64, i64* %tmp920
    %tmp922 = sub i64 %tmp921, 1
    store i64 %tmp922, i64* %tmp909
    %tmp923 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp924 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp923, i32 0, i32 0
    %tmp925 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp926 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp925
    %tmp927 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp928 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp927, i32 0, i32 0
    %tmp929 = load %class.string.String*, %class.string.String** %tmp928
    %tmp930 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp931 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp930
    %tmp932 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp933 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp932, i32 0, i32 1
    %tmp934 = load i64, i64* %tmp933
    %tmp935 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp936 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp935, i32 0, i32 0
    %tmp937 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp938 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp937
    %tmp939 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp816
    %tmp940 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp939, i32 0, i32 0
    %tmp941 = load %class.string.String*, %class.string.String** %tmp940
    %tmp942 = getelementptr inbounds %class.string.String, %class.string.String* %tmp941, i64 %tmp934
    %tmp943 = load %class.string.String, %class.string.String* %tmp942
    ret %class.string.String %tmp943
}

define void @"array.Array_string.String.clear"(%class.array.Array_string.String* %self) {
entry:
    %tmp944 = alloca %class.array.Array_string.String*
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %tmp944
    %tmp945 = alloca i64
    store i64 0, i64* %tmp945
    br label %while_cond.75
while_cond.75:
    %tmp946 = load i64, i64* %tmp945
    %tmp947 = load i64, i64* %tmp945
    %tmp948 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp944
    %tmp949 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp948
    %tmp950 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp944
    %tmp951 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp950, i32 0, i32 1
    %tmp952 = load i64, i64* %tmp951
    %tmp953 = icmp slt i64 %tmp947, %tmp952
    br i1 %tmp953, label %while_body.76, label %while_end.77
while_body.76:
    %tmp954 = load i64, i64* %tmp945
    %tmp955 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp944
    %tmp956 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp955, i32 0, i32 0
    %tmp957 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp944
    %tmp958 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp957
    %tmp959 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp944
    %tmp960 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp959, i32 0, i32 0
    %tmp961 = load %class.string.String*, %class.string.String** %tmp960
    %tmp962 = getelementptr inbounds %class.string.String, %class.string.String* %tmp961, i64 %tmp954
    call void @"string.String.destroy"(%class.string.String* %tmp962)
    %tmp963 = load i64, i64* %tmp945
    %tmp964 = load i64, i64* %tmp945
    %tmp965 = add i64 %tmp964, 1
    store i64 %tmp965, i64* %tmp945
    br label %while_cond.75
while_end.77:
    %tmp966 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp944
    %tmp967 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp966, i32 0, i32 1
    store i64 0, i64* %tmp967
    ret void
}

define void @"array.Array_string.String.destroy"(%class.array.Array_string.String* %self) {
entry:
    %tmp968 = alloca %class.array.Array_string.String*
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %tmp968
    %tmp969 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp968
    %tmp970 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp969, i32 0, i32 0
    %tmp971 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp968
    %tmp972 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp971
    %tmp973 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp968
    %tmp974 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp973, i32 0, i32 0
    %tmp975 = load %class.string.String*, %class.string.String** %tmp974
    %tmp976 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp968
    %tmp977 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp976
    %tmp978 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp968
    %tmp979 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp978, i32 0, i32 0
    %tmp980 = load %class.string.String*, %class.string.String** %tmp979
    %tmp981 = icmp ne %class.string.String* %tmp980, null
    br i1 %tmp981, label %if_then.78, label %if_else.79
if_then.78:
    %tmp982 = alloca i64
    store i64 0, i64* %tmp982
    br label %while_cond.81
while_cond.81:
    %tmp983 = load i64, i64* %tmp982
    %tmp984 = load i64, i64* %tmp982
    %tmp985 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp968
    %tmp986 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp985
    %tmp987 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp968
    %tmp988 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp987, i32 0, i32 1
    %tmp989 = load i64, i64* %tmp988
    %tmp990 = icmp slt i64 %tmp984, %tmp989
    br i1 %tmp990, label %while_body.82, label %while_end.83
while_body.82:
    %tmp991 = load i64, i64* %tmp982
    %tmp992 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp968
    %tmp993 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp992, i32 0, i32 0
    %tmp994 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp968
    %tmp995 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp994
    %tmp996 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp968
    %tmp997 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp996, i32 0, i32 0
    %tmp998 = load %class.string.String*, %class.string.String** %tmp997
    %tmp999 = getelementptr inbounds %class.string.String, %class.string.String* %tmp998, i64 %tmp991
    call void @"string.String.destroy"(%class.string.String* %tmp999)
    %tmp1000 = load i64, i64* %tmp982
    %tmp1001 = load i64, i64* %tmp982
    %tmp1002 = add i64 %tmp1001, 1
    store i64 %tmp1002, i64* %tmp982
    br label %while_cond.81
while_end.83:
    %tmp1003 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp968
    %tmp1004 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp1003
    %tmp1005 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp968
    %tmp1006 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp1005, i32 0, i32 0
    %tmp1007 = load %class.string.String*, %class.string.String** %tmp1006
    %tmp1008 = bitcast %class.string.String* %tmp1007 to i8*
    call void @"free"(i8* %tmp1008)
    %tmp1009 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp968
    %tmp1010 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp1009, i32 0, i32 0
    store %class.string.String* null, %class.string.String** %tmp1010
    br label %if_end.80
if_else.79:
    br label %if_end.80
if_end.80:
    %tmp1011 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp968
    %tmp1012 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp1011, i32 0, i32 2
    store i64 0, i64* %tmp1012
    %tmp1013 = load %class.array.Array_string.String*, %class.array.Array_string.String** %tmp968
    %tmp1014 = getelementptr inbounds %class.array.Array_string.String, %class.array.Array_string.String* %tmp1013, i32 0, i32 1
    store i64 0, i64* %tmp1014
    ret void
}

define %class.array.Array_string.String @"array.Array_string.String.clone"(%class.array.Array_string.String* %self) {
entry:
    %tmp0 = load %class.array.Array_string.String, %class.array.Array_string.String* %self
    ret %class.array.Array_string.String %tmp0
}

define void @"io.print_char"(i8 %c) {
entry:
    %tmp1015 = alloca i8
    store i8 %c, i8* %tmp1015
    %tmp1016 = load i8, i8* %tmp1015
    %tmp1017 = zext i8 %tmp1016 to i32
    %tmp1018 = call i32 @"putchar"(i32 %tmp1017)
    ret void
}

define void @"io.print_str"(i8* %s) {
entry:
    %tmp1019 = alloca i8*
    store i8* %s, i8** %tmp1019
    %tmp1020 = alloca i64
    store i64 0, i64* %tmp1020
    br label %while_cond.84
while_cond.84:
    %tmp1021 = load i64, i64* %tmp1020
    %tmp1022 = load i8*, i8** %tmp1019
    %tmp1023 = getelementptr inbounds i8, i8* %tmp1022, i64 %tmp1021
    %tmp1024 = load i8*, i8** %tmp1019
    %tmp1025 = load i64, i64* %tmp1020
    %tmp1026 = load i8*, i8** %tmp1019
    %tmp1027 = getelementptr inbounds i8, i8* %tmp1026, i64 %tmp1025
    %tmp1028 = load i8, i8* %tmp1027
    %tmp1029 = load i8*, i8** %tmp1019
    %tmp1030 = load i64, i64* %tmp1020
    %tmp1031 = load i8*, i8** %tmp1019
    %tmp1032 = getelementptr inbounds i8, i8* %tmp1031, i64 %tmp1030
    %tmp1033 = load i8, i8* %tmp1032
    %tmp1034 = icmp ne i8 %tmp1033, 0
    br i1 %tmp1034, label %while_body.85, label %while_end.86
while_body.85:
    %tmp1035 = load i8*, i8** %tmp1019
    %tmp1036 = load i64, i64* %tmp1020
    %tmp1037 = load i8*, i8** %tmp1019
    %tmp1038 = getelementptr inbounds i8, i8* %tmp1037, i64 %tmp1036
    %tmp1039 = load i8, i8* %tmp1038
    %tmp1040 = zext i8 %tmp1039 to i32
    %tmp1041 = call i32 @"putchar"(i32 %tmp1040)
    %tmp1042 = load i64, i64* %tmp1020
    %tmp1043 = load i64, i64* %tmp1020
    %tmp1044 = add i64 %tmp1043, 1
    store i64 %tmp1044, i64* %tmp1020
    br label %while_cond.84
while_end.86:
    ret void
}

define void @"io.println_str"(i8* %s) {
entry:
    %tmp1045 = alloca i8*
    store i8* %s, i8** %tmp1045
    %tmp1046 = load i8*, i8** %tmp1045
    %tmp1047 = call i32 @"puts"(i8* %tmp1046)
    ret void
}

define i32 @"main"() {
entry:
    %tmp1048 = alloca %class.array.Array_string.String
    store %class.array.Array_string.String zeroinitializer, %class.array.Array_string.String* %tmp1048
    call void @"array.Array_string.String.init"(%class.array.Array_string.String* %tmp1048)
    %tmp1049 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp1048
    %tmp1050 = alloca %class.array.Array_string.String
    store %class.array.Array_string.String %tmp1049, %class.array.Array_string.String* %tmp1050
    %tmp1051 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp1050
    %tmp1052 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i64 0, i64 0
    %tmp1053 = insertvalue { i8*, i64 } undef, i8* %tmp1052, 0
    %tmp1054 = insertvalue { i8*, i64 } %tmp1053, i64 5, 1
    %tmp1055 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp1054)
    call void @"array.Array_string.String.push"(%class.array.Array_string.String* %tmp1050, %class.string.String %tmp1055)
    %tmp1056 = trunc i64 0 to i32
    call void @"array.Array_string.String.destroy"(%class.array.Array_string.String* %tmp1050)
    ret i32 %tmp1056
}


@.str.0 = private unnamed_addr constant [6 x i8] c"Hello\00"
