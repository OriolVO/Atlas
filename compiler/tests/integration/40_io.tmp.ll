; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.io.File = type { i8*, i1 }
%class.string.String = type { i8*, i64 }

declare i8* @malloc(i64)
declare void @free(i8*)
declare i8* @memcpy(i8*, i8*, i64)
declare i32 @putchar(i32)
declare i32 @puts(i8*)
declare i8* @fopen(i8*, i8*)
declare i32 @fclose(i8*)
declare i32 @fputs(i8*, i8*)
declare i32 @fgetc(i8*)
declare void @exit(i32)

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

define void @io.File.init(%class.io.File* %self) {
entry:
    %tmp144 = alloca %class.io.File*
    store %class.io.File* %self, %class.io.File** %tmp144
    %tmp145 = load %class.io.File*, %class.io.File** %tmp144
    %tmp146 = getelementptr inbounds %class.io.File, %class.io.File* %tmp145, i32 0, i32 0
    store i8* null, i8** %tmp146
    %tmp147 = load %class.io.File*, %class.io.File** %tmp144
    %tmp148 = getelementptr inbounds %class.io.File, %class.io.File* %tmp147, i32 0, i32 1
    store i1 0, i1* %tmp148
    ret void
}

define void @io.File.destroy(%class.io.File* %self) {
entry:
    %tmp149 = alloca %class.io.File*
    store %class.io.File* %self, %class.io.File** %tmp149
    %tmp150 = load %class.io.File*, %class.io.File** %tmp149
    %tmp151 = load %class.io.File, %class.io.File* %tmp150
    %tmp152 = load %class.io.File*, %class.io.File** %tmp149
    %tmp153 = getelementptr inbounds %class.io.File, %class.io.File* %tmp152, i32 0, i32 1
    %tmp154 = load i1, i1* %tmp153
    br i1 %tmp154, label %if_then.15, label %if_else.16
if_then.15:
    %tmp155 = load %class.io.File*, %class.io.File** %tmp149
    call void @io.File.close(%class.io.File* %tmp155)
    br label %if_end.17
if_else.16:
    br label %if_end.17
if_end.17:
    ret void
}

define i1 @io.File.open(%class.io.File* %self, i8* %filename, i8* %mode) {
entry:
    %tmp156 = alloca %class.io.File*
    store %class.io.File* %self, %class.io.File** %tmp156
    %tmp157 = alloca i8*
    store i8* %filename, i8** %tmp157
    %tmp158 = alloca i8*
    store i8* %mode, i8** %tmp158
    %tmp159 = load %class.io.File*, %class.io.File** %tmp156
    %tmp160 = getelementptr inbounds %class.io.File, %class.io.File* %tmp159, i32 0, i32 0
    %tmp161 = load i8*, i8** %tmp157
    %tmp162 = load i8*, i8** %tmp158
    %tmp163 = call i8* @fopen(i8* %tmp161, i8* %tmp162)
    store i8* %tmp163, i8** %tmp160
    %tmp164 = load %class.io.File*, %class.io.File** %tmp156
    %tmp165 = load %class.io.File, %class.io.File* %tmp164
    %tmp166 = load %class.io.File*, %class.io.File** %tmp156
    %tmp167 = getelementptr inbounds %class.io.File, %class.io.File* %tmp166, i32 0, i32 0
    %tmp168 = load i8*, i8** %tmp167
    %tmp169 = icmp ne i8* %tmp168, null
    br i1 %tmp169, label %if_then.18, label %if_else.19
if_then.18:
    %tmp170 = load %class.io.File*, %class.io.File** %tmp156
    %tmp171 = getelementptr inbounds %class.io.File, %class.io.File* %tmp170, i32 0, i32 1
    store i1 1, i1* %tmp171
    ret i1 1
if_else.19:
    br label %if_end.20
if_end.20:
    ret i1 0
}

define void @io.File.close(%class.io.File* %self) {
entry:
    %tmp172 = alloca %class.io.File*
    store %class.io.File* %self, %class.io.File** %tmp172
    %tmp173 = load %class.io.File*, %class.io.File** %tmp172
    %tmp174 = load %class.io.File, %class.io.File* %tmp173
    %tmp175 = load %class.io.File*, %class.io.File** %tmp172
    %tmp176 = getelementptr inbounds %class.io.File, %class.io.File* %tmp175, i32 0, i32 1
    %tmp177 = load i1, i1* %tmp176
    br i1 %tmp177, label %if_then.21, label %if_else.22
if_then.21:
    %tmp178 = load %class.io.File*, %class.io.File** %tmp172
    %tmp179 = load %class.io.File, %class.io.File* %tmp178
    %tmp180 = load %class.io.File*, %class.io.File** %tmp172
    %tmp181 = getelementptr inbounds %class.io.File, %class.io.File* %tmp180, i32 0, i32 0
    %tmp182 = load i8*, i8** %tmp181
    %tmp183 = bitcast i8* %tmp182 to i8*
    %tmp184 = call i32 @fclose(i8* %tmp183)
    %tmp185 = load %class.io.File*, %class.io.File** %tmp172
    %tmp186 = getelementptr inbounds %class.io.File, %class.io.File* %tmp185, i32 0, i32 1
    store i1 0, i1* %tmp186
    %tmp187 = load %class.io.File*, %class.io.File** %tmp172
    %tmp188 = getelementptr inbounds %class.io.File, %class.io.File* %tmp187, i32 0, i32 0
    store i8* null, i8** %tmp188
    br label %if_end.23
if_else.22:
    br label %if_end.23
if_end.23:
    ret void
}

define i1 @io.File.write_string(%class.io.File* %self, i8* %s) {
entry:
    %tmp189 = alloca %class.io.File*
    store %class.io.File* %self, %class.io.File** %tmp189
    %tmp190 = alloca i8*
    store i8* %s, i8** %tmp190
    %tmp191 = load %class.io.File*, %class.io.File** %tmp189
    %tmp192 = load %class.io.File, %class.io.File* %tmp191
    %tmp193 = load %class.io.File*, %class.io.File** %tmp189
    %tmp194 = getelementptr inbounds %class.io.File, %class.io.File* %tmp193, i32 0, i32 1
    %tmp195 = load i1, i1* %tmp194
    br i1 %tmp195, label %if_then.24, label %if_else.25
if_then.24:
    %tmp196 = load i8*, i8** %tmp190
    %tmp197 = load %class.io.File*, %class.io.File** %tmp189
    %tmp198 = load %class.io.File, %class.io.File* %tmp197
    %tmp199 = load %class.io.File*, %class.io.File** %tmp189
    %tmp200 = getelementptr inbounds %class.io.File, %class.io.File* %tmp199, i32 0, i32 0
    %tmp201 = load i8*, i8** %tmp200
    %tmp202 = bitcast i8* %tmp201 to i8*
    %tmp203 = call i32 @fputs(i8* %tmp196, i8* %tmp202)
    %tmp204 = icmp sge i32 %tmp203, 0
    ret i1 %tmp204
if_else.25:
    br label %if_end.26
if_end.26:
    ret i1 0
}

define i64 @io.File.read_char(%class.io.File* %self) {
entry:
    %tmp205 = alloca %class.io.File*
    store %class.io.File* %self, %class.io.File** %tmp205
    %tmp206 = load %class.io.File*, %class.io.File** %tmp205
    %tmp207 = load %class.io.File, %class.io.File* %tmp206
    %tmp208 = load %class.io.File*, %class.io.File** %tmp205
    %tmp209 = getelementptr inbounds %class.io.File, %class.io.File* %tmp208, i32 0, i32 1
    %tmp210 = load i1, i1* %tmp209
    br i1 %tmp210, label %if_then.27, label %if_else.28
if_then.27:
    %tmp211 = load %class.io.File*, %class.io.File** %tmp205
    %tmp212 = load %class.io.File, %class.io.File* %tmp211
    %tmp213 = load %class.io.File*, %class.io.File** %tmp205
    %tmp214 = getelementptr inbounds %class.io.File, %class.io.File* %tmp213, i32 0, i32 0
    %tmp215 = load i8*, i8** %tmp214
    %tmp216 = bitcast i8* %tmp215 to i8*
    %tmp217 = call i32 @fgetc(i8* %tmp216)
    %tmp218 = sext i32 %tmp217 to i64
    ret i64 %tmp218
if_else.28:
    br label %if_end.29
if_end.29:
    %tmp219 = sub i64 0, 1
    ret i64 %tmp219
}

define %class.io.File @io.File.clone(%class.io.File* %self) {
entry:
    %tmp0 = load %class.io.File, %class.io.File* %self
    ret %class.io.File %tmp0
}

define void @io.print_char(i8 %c) {
entry:
    %tmp220 = alloca i8
    store i8 %c, i8* %tmp220
    %tmp221 = load i8, i8* %tmp220
    %tmp222 = zext i8 %tmp221 to i32
    %tmp223 = call i32 @putchar(i32 %tmp222)
    ret void
}

define void @io.print_str(i8* %s) {
entry:
    %tmp224 = alloca i8*
    store i8* %s, i8** %tmp224
    %tmp225 = alloca i64
    store i64 0, i64* %tmp225
    br label %while_cond.30
while_cond.30:
    %tmp226 = load i64, i64* %tmp225
    %tmp227 = load i8*, i8** %tmp224
    %tmp228 = getelementptr inbounds i8, i8* %tmp227, i64 %tmp226
    %tmp229 = load i8, i8* %tmp228
    %tmp230 = icmp ne i8 %tmp229, 0
    br i1 %tmp230, label %while_body.31, label %while_end.32
while_body.31:
    %tmp231 = load i64, i64* %tmp225
    %tmp232 = load i8*, i8** %tmp224
    %tmp233 = getelementptr inbounds i8, i8* %tmp232, i64 %tmp231
    %tmp234 = load i8, i8* %tmp233
    %tmp235 = zext i8 %tmp234 to i32
    %tmp236 = call i32 @putchar(i32 %tmp235)
    %tmp237 = load i64, i64* %tmp225
    %tmp238 = add i64 %tmp237, 1
    store i64 %tmp238, i64* %tmp225
    br label %while_cond.30
while_end.32:
    ret void
}

define void @io.println_str(i8* %s) {
entry:
    %tmp239 = alloca i8*
    store i8* %s, i8** %tmp239
    %tmp240 = load i8*, i8** %tmp239
    %tmp241 = call i32 @puts(i8* %tmp240)
    ret void
}

define i32 @main() {
entry:
    %tmp242 = alloca %class.io.File
    call void @io.File.init(%class.io.File* %tmp242)
    %tmp243 = load %class.io.File, %class.io.File* %tmp242
    %tmp244 = alloca %class.io.File
    store %class.io.File %tmp243, %class.io.File* %tmp244
    %tmp245 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.0, i64 0, i64 0
    %tmp246 = insertvalue { i8*, i64 } undef, i8* %tmp245, 0
    %tmp247 = insertvalue { i8*, i64 } %tmp246, i64 15, 1
    %tmp248 = call %class.string.String @string.String.from({ i8*, i64 } %tmp247)
    %tmp249 = alloca %class.string.String
    store %class.string.String %tmp248, %class.string.String* %tmp249
    %tmp250 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.1, i64 0, i64 0
    %tmp251 = insertvalue { i8*, i64 } undef, i8* %tmp250, 0
    %tmp252 = insertvalue { i8*, i64 } %tmp251, i64 1, 1
    %tmp253 = call %class.string.String @string.String.from({ i8*, i64 } %tmp252)
    %tmp254 = alloca %class.string.String
    store %class.string.String %tmp253, %class.string.String* %tmp254
    %tmp255 = call i8* @string.String.c_str(%class.string.String* %tmp249)
    %tmp256 = call i8* @string.String.c_str(%class.string.String* %tmp254)
    %tmp257 = call i1 @io.File.open(%class.io.File* %tmp244, i8* %tmp255, i8* %tmp256)
    %tmp258 = xor i1 %tmp257, true
    br i1 %tmp258, label %if_then.33, label %if_else.34
if_then.33:
    %tmp259 = trunc i64 1 to i32
    call void @exit(i32 %tmp259)
    br label %if_end.35
if_else.34:
    br label %if_end.35
if_end.35:
    %tmp260 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.2, i64 0, i64 0
    %tmp261 = insertvalue { i8*, i64 } undef, i8* %tmp260, 0
    %tmp262 = insertvalue { i8*, i64 } %tmp261, i64 14, 1
    %tmp263 = call %class.string.String @string.String.from({ i8*, i64 } %tmp262)
    %tmp264 = alloca %class.string.String
    store %class.string.String %tmp263, %class.string.String* %tmp264
    %tmp265 = call i8* @string.String.c_str(%class.string.String* %tmp264)
    %tmp266 = call i1 @io.File.write_string(%class.io.File* %tmp244, i8* %tmp265)
    %tmp267 = xor i1 %tmp266, true
    br i1 %tmp267, label %if_then.36, label %if_else.37
if_then.36:
    %tmp268 = trunc i64 2 to i32
    call void @exit(i32 %tmp268)
    br label %if_end.38
if_else.37:
    br label %if_end.38
if_end.38:
    call void @io.File.close(%class.io.File* %tmp244)
    %tmp269 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i64 0, i64 0
    %tmp270 = insertvalue { i8*, i64 } undef, i8* %tmp269, 0
    %tmp271 = insertvalue { i8*, i64 } %tmp270, i64 1, 1
    %tmp272 = call %class.string.String @string.String.from({ i8*, i64 } %tmp271)
    %tmp273 = alloca %class.string.String
    store %class.string.String %tmp272, %class.string.String* %tmp273
    %tmp274 = call i8* @string.String.c_str(%class.string.String* %tmp249)
    %tmp275 = call i8* @string.String.c_str(%class.string.String* %tmp273)
    %tmp276 = call i1 @io.File.open(%class.io.File* %tmp244, i8* %tmp274, i8* %tmp275)
    %tmp277 = xor i1 %tmp276, true
    br i1 %tmp277, label %if_then.39, label %if_else.40
if_then.39:
    %tmp278 = trunc i64 3 to i32
    call void @exit(i32 %tmp278)
    br label %if_end.41
if_else.40:
    br label %if_end.41
if_end.41:
    %tmp279 = call i64 @io.File.read_char(%class.io.File* %tmp244)
    %tmp280 = alloca i64
    store i64 %tmp279, i64* %tmp280
    %tmp281 = load i64, i64* %tmp280
    %tmp282 = zext i8 72 to i64
    %tmp283 = icmp ne i64 %tmp281, %tmp282
    br i1 %tmp283, label %if_then.42, label %if_else.43
if_then.42:
    %tmp284 = trunc i64 4 to i32
    call void @exit(i32 %tmp284)
    br label %if_end.44
if_else.43:
    br label %if_end.44
if_end.44:
    call void @io.File.close(%class.io.File* %tmp244)
    %tmp285 = trunc i64 0 to i32
    call void @string.String.destroy(%class.string.String* %tmp273)
    call void @string.String.destroy(%class.string.String* %tmp264)
    call void @string.String.destroy(%class.string.String* %tmp254)
    call void @string.String.destroy(%class.string.String* %tmp249)
    call void @io.File.destroy(%class.io.File* %tmp244)
    ret i32 %tmp285
}


@.str.0 = private unnamed_addr constant [16 x i8] c"test_output.txt\00"
@.str.1 = private unnamed_addr constant [2 x i8] c"w\00"
@.str.2 = private unnamed_addr constant [15 x i8] c"Hello File IO!\00"
@.str.3 = private unnamed_addr constant [2 x i8] c"r\00"
