; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

%class.array.Array_hashmap.HashMapEntry_string.String_int = type { %class.hashmap.HashMapEntry_string.String_int*, i64, i64 }
%class.hashmap.HashMapEntry_string.String_int = type { %class.string.String, i64, i1 }
%class.hashmap.HashMap_string.String_int = type { %class.array.Array_hashmap.HashMapEntry_string.String_int, i64, i64 }
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

define void @"hashmap.HashMapEntry_string.String_int.init"(%class.hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %tmp322 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %self, %class.hashmap.HashMapEntry_string.String_int** %tmp322
    %tmp323 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp322
    %tmp324 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp323, i32 0, i32 2
    store i1 0, i1* %tmp324
    ret void
}

define void @"hashmap.HashMapEntry_string.String_int.destroy"(%class.hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %tmp325 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %self, %class.hashmap.HashMapEntry_string.String_int** %tmp325
    %tmp326 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp325
    %tmp327 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp326
    %tmp328 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp325
    %tmp329 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp328, i32 0, i32 2
    %tmp330 = load i1, i1* %tmp329
    br i1 %tmp330, label %if_then.30, label %if_else.31
if_then.30:
    %tmp331 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp325
    %tmp332 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp331, i32 0, i32 0
    call void @"string.String.destroy"(%class.string.String* %tmp332)
    %tmp333 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp325
    %tmp334 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp333, i32 0, i32 1
    %tmp335 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp325
    %tmp336 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp335, i32 0, i32 2
    store i1 0, i1* %tmp336
    br label %if_end.32
if_else.31:
    br label %if_end.32
if_end.32:
    ret void
}

define %class.hashmap.HashMapEntry_string.String_int @"hashmap.HashMapEntry_string.String_int.clone"(%class.hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %tmp0 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %self
    ret %class.hashmap.HashMapEntry_string.String_int %tmp0
}

define void @"array.Array_hashmap.HashMapEntry_string.String_int.init"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %tmp337 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp337
    %tmp338 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp337
    %tmp339 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp338, i32 0, i32 1
    store i64 0, i64* %tmp339
    %tmp340 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp337
    %tmp341 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp340, i32 0, i32 2
    store i64 0, i64* %tmp341
    %tmp342 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp337
    %tmp343 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp342, i32 0, i32 0
    store %class.hashmap.HashMapEntry_string.String_int* null, %class.hashmap.HashMapEntry_string.String_int** %tmp343
    ret void
}

define i64 @"array.Array_hashmap.HashMapEntry_string.String_int.length"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %tmp344 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp345 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp346 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp345
    %tmp347 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp348 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp347, i32 0, i32 1
    %tmp349 = load i64, i64* %tmp348
    ret i64 %tmp349
}

define i64 @"array.Array_hashmap.HashMapEntry_string.String_int.capacity"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %tmp350 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp350
    %tmp351 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp350
    %tmp352 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp351
    %tmp353 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp350
    %tmp354 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp353, i32 0, i32 2
    %tmp355 = load i64, i64* %tmp354
    ret i64 %tmp355
}

define void @"array.Array_hashmap.HashMapEntry_string.String_int.push"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.hashmap.HashMapEntry_string.String_int %item) {
entry:
    %tmp356 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp357 = alloca %class.hashmap.HashMapEntry_string.String_int
    store %class.hashmap.HashMapEntry_string.String_int %item, %class.hashmap.HashMapEntry_string.String_int* %tmp357
    %tmp358 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp359 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp358, i32 0, i32 1
    %tmp360 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp361 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp360
    %tmp362 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp363 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp362, i32 0, i32 1
    %tmp364 = load i64, i64* %tmp363
    %tmp365 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp366 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp365
    %tmp367 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp368 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp367, i32 0, i32 1
    %tmp369 = load i64, i64* %tmp368
    %tmp370 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp371 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp370
    %tmp372 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp373 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp372, i32 0, i32 2
    %tmp374 = load i64, i64* %tmp373
    %tmp375 = icmp eq i64 %tmp369, %tmp374
    br i1 %tmp375, label %if_then.33, label %if_else.34
if_then.33:
    %tmp376 = alloca i64
    store i64 4, i64* %tmp376
    %tmp377 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp378 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp377, i32 0, i32 2
    %tmp379 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp380 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp379
    %tmp381 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp382 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp381, i32 0, i32 2
    %tmp383 = load i64, i64* %tmp382
    %tmp384 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp385 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp384
    %tmp386 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp387 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp386, i32 0, i32 2
    %tmp388 = load i64, i64* %tmp387
    %tmp389 = icmp sgt i64 %tmp388, 0
    br i1 %tmp389, label %if_then.36, label %if_else.37
if_then.36:
    %tmp390 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp391 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp390, i32 0, i32 2
    %tmp392 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp393 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp392
    %tmp394 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp395 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp394, i32 0, i32 2
    %tmp396 = load i64, i64* %tmp395
    %tmp397 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp398 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp397
    %tmp399 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp400 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp399, i32 0, i32 2
    %tmp401 = load i64, i64* %tmp400
    %tmp402 = mul i64 %tmp401, 2
    store i64 %tmp402, i64* %tmp376
    br label %if_end.38
if_else.37:
    br label %if_end.38
if_end.38:
    %tmp403 = load i64, i64* %tmp376
    %tmp404 = load i64, i64* %tmp376
    %tmp405 = mul i64 %tmp404, 32
    %tmp406 = call i8* @"malloc"(i64 %tmp405)
    %tmp407 = bitcast i8* %tmp406 to %class.hashmap.HashMapEntry_string.String_int*
    %tmp408 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp407, %class.hashmap.HashMapEntry_string.String_int** %tmp408
    %tmp409 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp410 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp409, i32 0, i32 0
    %tmp411 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp412 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp411
    %tmp413 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp414 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp413, i32 0, i32 0
    %tmp415 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp414
    %tmp416 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp417 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp416
    %tmp418 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp419 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp418, i32 0, i32 0
    %tmp420 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp419
    %tmp421 = icmp ne %class.hashmap.HashMapEntry_string.String_int* %tmp420, null
    br i1 %tmp421, label %if_then.39, label %if_else.40
if_then.39:
    %tmp422 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp408
    %tmp423 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp422 to i8*
    %tmp424 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp425 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp424
    %tmp426 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp427 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp426, i32 0, i32 0
    %tmp428 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp427
    %tmp429 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp428 to i8*
    %tmp430 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp431 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp430, i32 0, i32 1
    %tmp432 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp433 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp432
    %tmp434 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp435 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp434, i32 0, i32 1
    %tmp436 = load i64, i64* %tmp435
    %tmp437 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp438 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp437
    %tmp439 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp440 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp439, i32 0, i32 1
    %tmp441 = load i64, i64* %tmp440
    %tmp442 = mul i64 %tmp441, 32
    %tmp443 = call i8* @"memcpy"(i8* %tmp423, i8* %tmp429, i64 %tmp442)
    %tmp444 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp445 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp444
    %tmp446 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp447 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp446, i32 0, i32 0
    %tmp448 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp447
    %tmp449 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp448 to i8*
    call void @"free"(i8* %tmp449)
    br label %if_end.41
if_else.40:
    br label %if_end.41
if_end.41:
    %tmp450 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp451 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp450, i32 0, i32 2
    %tmp452 = load i64, i64* %tmp376
    store i64 %tmp452, i64* %tmp451
    %tmp453 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp454 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp453, i32 0, i32 0
    %tmp455 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp408
    store %class.hashmap.HashMapEntry_string.String_int* %tmp455, %class.hashmap.HashMapEntry_string.String_int** %tmp454
    br label %if_end.35
if_else.34:
    br label %if_end.35
if_end.35:
    %tmp456 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp457 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp456
    %tmp458 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp459 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp458, i32 0, i32 1
    %tmp460 = load i64, i64* %tmp459
    %tmp461 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp462 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp461, i32 0, i32 0
    %tmp463 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp464 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp463
    %tmp465 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp466 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp465, i32 0, i32 0
    %tmp467 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp466
    %tmp468 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp467, i64 %tmp460
    %tmp469 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp468 to i8*
    %tmp470 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp357 to i8*
    %tmp471 = call i8* @"memcpy"(i8* %tmp469, i8* %tmp470, i64 32)
    %tmp472 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp473 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp472, i32 0, i32 1
    %tmp474 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp475 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp474, i32 0, i32 1
    %tmp476 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp477 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp476
    %tmp478 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp479 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp478, i32 0, i32 1
    %tmp480 = load i64, i64* %tmp479
    %tmp481 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp482 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp481
    %tmp483 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp356
    %tmp484 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp483, i32 0, i32 1
    %tmp485 = load i64, i64* %tmp484
    %tmp486 = add i64 %tmp485, 1
    store i64 %tmp486, i64* %tmp473
    ret void
}

define %class.hashmap.HashMapEntry_string.String_int @"array.Array_hashmap.HashMapEntry_string.String_int.pop"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %tmp487 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp487
    %tmp488 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp487
    %tmp489 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp488, i32 0, i32 1
    %tmp490 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp487
    %tmp491 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp490
    %tmp492 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp487
    %tmp493 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp492, i32 0, i32 1
    %tmp494 = load i64, i64* %tmp493
    %tmp495 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp487
    %tmp496 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp495
    %tmp497 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp487
    %tmp498 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp497, i32 0, i32 1
    %tmp499 = load i64, i64* %tmp498
    %tmp500 = icmp eq i64 %tmp499, 0
    br i1 %tmp500, label %if_then.42, label %if_else.43
if_then.42:
    %tmp501 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp501)
    br label %if_end.44
if_else.43:
    br label %if_end.44
if_end.44:
    %tmp502 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp487
    %tmp503 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp502, i32 0, i32 1
    %tmp504 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp487
    %tmp505 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp504, i32 0, i32 1
    %tmp506 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp487
    %tmp507 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp506
    %tmp508 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp487
    %tmp509 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp508, i32 0, i32 1
    %tmp510 = load i64, i64* %tmp509
    %tmp511 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp487
    %tmp512 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp511
    %tmp513 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp487
    %tmp514 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp513, i32 0, i32 1
    %tmp515 = load i64, i64* %tmp514
    %tmp516 = sub i64 %tmp515, 1
    store i64 %tmp516, i64* %tmp503
    %tmp517 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp487
    %tmp518 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp517, i32 0, i32 0
    %tmp519 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp487
    %tmp520 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp519
    %tmp521 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp487
    %tmp522 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp521, i32 0, i32 0
    %tmp523 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp522
    %tmp524 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp487
    %tmp525 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp524
    %tmp526 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp487
    %tmp527 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp526, i32 0, i32 1
    %tmp528 = load i64, i64* %tmp527
    %tmp529 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp487
    %tmp530 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp529, i32 0, i32 0
    %tmp531 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp487
    %tmp532 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp531
    %tmp533 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp487
    %tmp534 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp533, i32 0, i32 0
    %tmp535 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp534
    %tmp536 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp535, i64 %tmp528
    %tmp537 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp536
    ret %class.hashmap.HashMapEntry_string.String_int %tmp537
}

define %class.hashmap.HashMapEntry_string.String_int @"array.Array_hashmap.HashMapEntry_string.String_int.operator_index"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self, i64 %index) {
entry:
    %tmp538 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp538
    %tmp539 = alloca i64
    store i64 %index, i64* %tmp539
    %tmp540 = load i64, i64* %tmp539
    %tmp541 = load i64, i64* %tmp539
    %tmp542 = icmp slt i64 %tmp541, 0
    %tmp543 = load i64, i64* %tmp539
    %tmp544 = load i64, i64* %tmp539
    %tmp545 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp538
    %tmp546 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp545
    %tmp547 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp538
    %tmp548 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp547, i32 0, i32 1
    %tmp549 = load i64, i64* %tmp548
    %tmp550 = icmp sge i64 %tmp544, %tmp549
    %tmp551 = or i1 %tmp542, %tmp550
    br i1 %tmp551, label %if_then.45, label %if_else.46
if_then.45:
    %tmp552 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp552)
    br label %if_end.47
if_else.46:
    br label %if_end.47
if_end.47:
    %tmp553 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp538
    %tmp554 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp553, i32 0, i32 0
    %tmp555 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp538
    %tmp556 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp555
    %tmp557 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp538
    %tmp558 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp557, i32 0, i32 0
    %tmp559 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp558
    %tmp560 = load i64, i64* %tmp539
    %tmp561 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp538
    %tmp562 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp561, i32 0, i32 0
    %tmp563 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp538
    %tmp564 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp563
    %tmp565 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp538
    %tmp566 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp565, i32 0, i32 0
    %tmp567 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp566
    %tmp568 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp567, i64 %tmp560
    %tmp569 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp568
    ret %class.hashmap.HashMapEntry_string.String_int %tmp569
}

define void @"array.Array_hashmap.HashMapEntry_string.String_int.operator_index_set"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self, i64 %index, %class.hashmap.HashMapEntry_string.String_int %item) {
entry:
    %tmp570 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp570
    %tmp571 = alloca i64
    store i64 %index, i64* %tmp571
    %tmp572 = alloca %class.hashmap.HashMapEntry_string.String_int
    store %class.hashmap.HashMapEntry_string.String_int %item, %class.hashmap.HashMapEntry_string.String_int* %tmp572
    %tmp573 = load i64, i64* %tmp571
    %tmp574 = load i64, i64* %tmp571
    %tmp575 = icmp slt i64 %tmp574, 0
    %tmp576 = load i64, i64* %tmp571
    %tmp577 = load i64, i64* %tmp571
    %tmp578 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp570
    %tmp579 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp578
    %tmp580 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp570
    %tmp581 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp580, i32 0, i32 1
    %tmp582 = load i64, i64* %tmp581
    %tmp583 = icmp sge i64 %tmp577, %tmp582
    %tmp584 = or i1 %tmp575, %tmp583
    br i1 %tmp584, label %if_then.48, label %if_else.49
if_then.48:
    %tmp585 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp585)
    br label %if_end.50
if_else.49:
    br label %if_end.50
if_end.50:
    %tmp586 = load i64, i64* %tmp571
    %tmp587 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp570
    %tmp588 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp587, i32 0, i32 0
    %tmp589 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp570
    %tmp590 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp589
    %tmp591 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp570
    %tmp592 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp591, i32 0, i32 0
    %tmp593 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp592
    %tmp594 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp593, i64 %tmp586
    call void @"hashmap.HashMapEntry_string.String_int.destroy"(%class.hashmap.HashMapEntry_string.String_int* %tmp594)
    %tmp595 = load i64, i64* %tmp571
    %tmp596 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp570
    %tmp597 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp596, i32 0, i32 0
    %tmp598 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp570
    %tmp599 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp598
    %tmp600 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp570
    %tmp601 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp600, i32 0, i32 0
    %tmp602 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp601
    %tmp603 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp602, i64 %tmp595
    %tmp604 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp603 to i8*
    %tmp605 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp572 to i8*
    %tmp606 = call i8* @"memcpy"(i8* %tmp604, i8* %tmp605, i64 32)
    ret void
}

define void @"array.Array_hashmap.HashMapEntry_string.String_int.insert"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self, i64 %index, %class.hashmap.HashMapEntry_string.String_int %item) {
entry:
    %tmp607 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp608 = alloca i64
    store i64 %index, i64* %tmp608
    %tmp609 = alloca %class.hashmap.HashMapEntry_string.String_int
    store %class.hashmap.HashMapEntry_string.String_int %item, %class.hashmap.HashMapEntry_string.String_int* %tmp609
    %tmp610 = load i64, i64* %tmp608
    %tmp611 = load i64, i64* %tmp608
    %tmp612 = icmp slt i64 %tmp611, 0
    %tmp613 = load i64, i64* %tmp608
    %tmp614 = load i64, i64* %tmp608
    %tmp615 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp616 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp615
    %tmp617 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp618 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp617, i32 0, i32 1
    %tmp619 = load i64, i64* %tmp618
    %tmp620 = icmp sgt i64 %tmp614, %tmp619
    %tmp621 = or i1 %tmp612, %tmp620
    br i1 %tmp621, label %if_then.51, label %if_else.52
if_then.51:
    %tmp622 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp622)
    br label %if_end.53
if_else.52:
    br label %if_end.53
if_end.53:
    %tmp623 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp624 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp623, i32 0, i32 1
    %tmp625 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp626 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp625
    %tmp627 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp628 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp627, i32 0, i32 1
    %tmp629 = load i64, i64* %tmp628
    %tmp630 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp631 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp630
    %tmp632 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp633 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp632, i32 0, i32 1
    %tmp634 = load i64, i64* %tmp633
    %tmp635 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp636 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp635
    %tmp637 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp638 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp637, i32 0, i32 2
    %tmp639 = load i64, i64* %tmp638
    %tmp640 = icmp eq i64 %tmp634, %tmp639
    br i1 %tmp640, label %if_then.54, label %if_else.55
if_then.54:
    %tmp641 = alloca i64
    store i64 4, i64* %tmp641
    %tmp642 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp643 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp642, i32 0, i32 2
    %tmp644 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp645 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp644
    %tmp646 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp647 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp646, i32 0, i32 2
    %tmp648 = load i64, i64* %tmp647
    %tmp649 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp650 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp649
    %tmp651 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp652 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp651, i32 0, i32 2
    %tmp653 = load i64, i64* %tmp652
    %tmp654 = icmp sgt i64 %tmp653, 0
    br i1 %tmp654, label %if_then.57, label %if_else.58
if_then.57:
    %tmp655 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp656 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp655, i32 0, i32 2
    %tmp657 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp658 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp657
    %tmp659 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp660 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp659, i32 0, i32 2
    %tmp661 = load i64, i64* %tmp660
    %tmp662 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp663 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp662
    %tmp664 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp665 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp664, i32 0, i32 2
    %tmp666 = load i64, i64* %tmp665
    %tmp667 = mul i64 %tmp666, 2
    store i64 %tmp667, i64* %tmp641
    br label %if_end.59
if_else.58:
    br label %if_end.59
if_end.59:
    %tmp668 = load i64, i64* %tmp641
    %tmp669 = load i64, i64* %tmp641
    %tmp670 = mul i64 %tmp669, 32
    %tmp671 = call i8* @"malloc"(i64 %tmp670)
    %tmp672 = bitcast i8* %tmp671 to %class.hashmap.HashMapEntry_string.String_int*
    %tmp673 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp672, %class.hashmap.HashMapEntry_string.String_int** %tmp673
    %tmp674 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp675 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp674, i32 0, i32 0
    %tmp676 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp677 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp676
    %tmp678 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp679 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp678, i32 0, i32 0
    %tmp680 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp679
    %tmp681 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp682 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp681
    %tmp683 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp684 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp683, i32 0, i32 0
    %tmp685 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp684
    %tmp686 = icmp ne %class.hashmap.HashMapEntry_string.String_int* %tmp685, null
    br i1 %tmp686, label %if_then.60, label %if_else.61
if_then.60:
    %tmp687 = load i64, i64* %tmp608
    %tmp688 = load i64, i64* %tmp608
    %tmp689 = icmp sgt i64 %tmp688, 0
    br i1 %tmp689, label %if_then.63, label %if_else.64
if_then.63:
    %tmp690 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp673
    %tmp691 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp690 to i8*
    %tmp692 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp693 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp692
    %tmp694 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp695 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp694, i32 0, i32 0
    %tmp696 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp695
    %tmp697 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp696 to i8*
    %tmp698 = load i64, i64* %tmp608
    %tmp699 = load i64, i64* %tmp608
    %tmp700 = mul i64 %tmp699, 32
    %tmp701 = call i8* @"memcpy"(i8* %tmp691, i8* %tmp697, i64 %tmp700)
    br label %if_end.65
if_else.64:
    br label %if_end.65
if_end.65:
    %tmp702 = load i64, i64* %tmp608
    %tmp703 = load i64, i64* %tmp608
    %tmp704 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp705 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp704
    %tmp706 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp707 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp706, i32 0, i32 1
    %tmp708 = load i64, i64* %tmp707
    %tmp709 = icmp slt i64 %tmp703, %tmp708
    br i1 %tmp709, label %if_then.66, label %if_else.67
if_then.66:
    %tmp710 = load i64, i64* %tmp608
    %tmp711 = load i64, i64* %tmp608
    %tmp712 = add i64 %tmp711, 1
    %tmp713 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp673
    %tmp714 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp713, i64 %tmp712
    %tmp715 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp714 to i8*
    %tmp716 = load i64, i64* %tmp608
    %tmp717 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp718 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp717, i32 0, i32 0
    %tmp719 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp720 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp719
    %tmp721 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp722 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp721, i32 0, i32 0
    %tmp723 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp722
    %tmp724 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp723, i64 %tmp716
    %tmp725 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp724 to i8*
    %tmp726 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp727 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp726, i32 0, i32 1
    %tmp728 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp729 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp728
    %tmp730 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp731 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp730, i32 0, i32 1
    %tmp732 = load i64, i64* %tmp731
    %tmp733 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp734 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp733
    %tmp735 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp736 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp735, i32 0, i32 1
    %tmp737 = load i64, i64* %tmp736
    %tmp738 = load i64, i64* %tmp608
    %tmp739 = sub i64 %tmp737, %tmp738
    %tmp740 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp741 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp740, i32 0, i32 1
    %tmp742 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp743 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp742
    %tmp744 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp745 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp744, i32 0, i32 1
    %tmp746 = load i64, i64* %tmp745
    %tmp747 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp748 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp747
    %tmp749 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp750 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp749, i32 0, i32 1
    %tmp751 = load i64, i64* %tmp750
    %tmp752 = load i64, i64* %tmp608
    %tmp753 = sub i64 %tmp751, %tmp752
    %tmp754 = mul i64 %tmp753, 32
    %tmp755 = call i8* @"memcpy"(i8* %tmp715, i8* %tmp725, i64 %tmp754)
    br label %if_end.68
if_else.67:
    br label %if_end.68
if_end.68:
    %tmp756 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp757 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp756
    %tmp758 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp759 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp758, i32 0, i32 0
    %tmp760 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp759
    %tmp761 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp760 to i8*
    call void @"free"(i8* %tmp761)
    br label %if_end.62
if_else.61:
    br label %if_end.62
if_end.62:
    %tmp762 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp763 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp762, i32 0, i32 2
    %tmp764 = load i64, i64* %tmp641
    store i64 %tmp764, i64* %tmp763
    %tmp765 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp766 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp765, i32 0, i32 0
    %tmp767 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp673
    store %class.hashmap.HashMapEntry_string.String_int* %tmp767, %class.hashmap.HashMapEntry_string.String_int** %tmp766
    br label %if_end.56
if_else.55:
    %tmp768 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp769 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp768
    %tmp770 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp771 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp770, i32 0, i32 1
    %tmp772 = load i64, i64* %tmp771
    %tmp773 = alloca i64
    store i64 %tmp772, i64* %tmp773
    br label %while_cond.69
while_cond.69:
    %tmp774 = load i64, i64* %tmp773
    %tmp775 = load i64, i64* %tmp773
    %tmp776 = load i64, i64* %tmp608
    %tmp777 = icmp sgt i64 %tmp775, %tmp776
    br i1 %tmp777, label %while_body.70, label %while_end.71
while_body.70:
    %tmp778 = load i64, i64* %tmp773
    %tmp779 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp780 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp779, i32 0, i32 0
    %tmp781 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp782 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp781
    %tmp783 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp784 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp783, i32 0, i32 0
    %tmp785 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp784
    %tmp786 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp785, i64 %tmp778
    %tmp787 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp786 to i8*
    %tmp788 = load i64, i64* %tmp773
    %tmp789 = load i64, i64* %tmp773
    %tmp790 = sub i64 %tmp789, 1
    %tmp791 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp792 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp791, i32 0, i32 0
    %tmp793 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp794 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp793
    %tmp795 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp796 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp795, i32 0, i32 0
    %tmp797 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp796
    %tmp798 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp797, i64 %tmp790
    %tmp799 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp798 to i8*
    %tmp800 = call i8* @"memcpy"(i8* %tmp787, i8* %tmp799, i64 32)
    %tmp801 = load i64, i64* %tmp773
    %tmp802 = load i64, i64* %tmp773
    %tmp803 = sub i64 %tmp802, 1
    store i64 %tmp803, i64* %tmp773
    br label %while_cond.69
while_end.71:
    br label %if_end.56
if_end.56:
    %tmp804 = load i64, i64* %tmp608
    %tmp805 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp806 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp805, i32 0, i32 0
    %tmp807 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp808 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp807
    %tmp809 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp810 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp809, i32 0, i32 0
    %tmp811 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp810
    %tmp812 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp811, i64 %tmp804
    %tmp813 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp812 to i8*
    %tmp814 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp609 to i8*
    %tmp815 = call i8* @"memcpy"(i8* %tmp813, i8* %tmp814, i64 32)
    %tmp816 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp817 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp816, i32 0, i32 1
    %tmp818 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp819 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp818, i32 0, i32 1
    %tmp820 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp821 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp820
    %tmp822 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp823 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp822, i32 0, i32 1
    %tmp824 = load i64, i64* %tmp823
    %tmp825 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp826 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp825
    %tmp827 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp607
    %tmp828 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp827, i32 0, i32 1
    %tmp829 = load i64, i64* %tmp828
    %tmp830 = add i64 %tmp829, 1
    store i64 %tmp830, i64* %tmp817
    ret void
}

define %class.hashmap.HashMapEntry_string.String_int @"array.Array_hashmap.HashMapEntry_string.String_int.remove"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self, i64 %index) {
entry:
    %tmp831 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp832 = alloca i64
    store i64 %index, i64* %tmp832
    %tmp833 = load i64, i64* %tmp832
    %tmp834 = load i64, i64* %tmp832
    %tmp835 = icmp slt i64 %tmp834, 0
    %tmp836 = load i64, i64* %tmp832
    %tmp837 = load i64, i64* %tmp832
    %tmp838 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp839 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp838
    %tmp840 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp841 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp840, i32 0, i32 1
    %tmp842 = load i64, i64* %tmp841
    %tmp843 = icmp sge i64 %tmp837, %tmp842
    %tmp844 = or i1 %tmp835, %tmp843
    br i1 %tmp844, label %if_then.72, label %if_else.73
if_then.72:
    %tmp845 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp845)
    br label %if_end.74
if_else.73:
    br label %if_end.74
if_end.74:
    %tmp846 = call i8* @"malloc"(i64 32)
    %tmp847 = bitcast i8* %tmp846 to %class.hashmap.HashMapEntry_string.String_int*
    %tmp848 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp847, %class.hashmap.HashMapEntry_string.String_int** %tmp848
    %tmp849 = load i64, i64* %tmp832
    %tmp850 = alloca i64
    store i64 %tmp849, i64* %tmp850
    br label %while_cond.75
while_cond.75:
    %tmp851 = load i64, i64* %tmp850
    %tmp852 = load i64, i64* %tmp850
    %tmp853 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp854 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp853, i32 0, i32 1
    %tmp855 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp856 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp855
    %tmp857 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp858 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp857, i32 0, i32 1
    %tmp859 = load i64, i64* %tmp858
    %tmp860 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp861 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp860
    %tmp862 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp863 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp862, i32 0, i32 1
    %tmp864 = load i64, i64* %tmp863
    %tmp865 = sub i64 %tmp864, 1
    %tmp866 = icmp slt i64 %tmp852, %tmp865
    br i1 %tmp866, label %while_body.76, label %while_end.77
while_body.76:
    %tmp867 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp848
    %tmp868 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp867 to i8*
    %tmp869 = load i64, i64* %tmp850
    %tmp870 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp871 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp870, i32 0, i32 0
    %tmp872 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp873 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp872
    %tmp874 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp875 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp874, i32 0, i32 0
    %tmp876 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp875
    %tmp877 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp876, i64 %tmp869
    %tmp878 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp877 to i8*
    %tmp879 = call i8* @"memcpy"(i8* %tmp868, i8* %tmp878, i64 32)
    %tmp880 = load i64, i64* %tmp850
    %tmp881 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp882 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp881, i32 0, i32 0
    %tmp883 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp884 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp883
    %tmp885 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp886 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp885, i32 0, i32 0
    %tmp887 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp886
    %tmp888 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp887, i64 %tmp880
    %tmp889 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp888 to i8*
    %tmp890 = load i64, i64* %tmp850
    %tmp891 = load i64, i64* %tmp850
    %tmp892 = add i64 %tmp891, 1
    %tmp893 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp894 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp893, i32 0, i32 0
    %tmp895 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp896 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp895
    %tmp897 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp898 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp897, i32 0, i32 0
    %tmp899 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp898
    %tmp900 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp899, i64 %tmp892
    %tmp901 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp900 to i8*
    %tmp902 = call i8* @"memcpy"(i8* %tmp889, i8* %tmp901, i64 32)
    %tmp903 = load i64, i64* %tmp850
    %tmp904 = load i64, i64* %tmp850
    %tmp905 = add i64 %tmp904, 1
    %tmp906 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp907 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp906, i32 0, i32 0
    %tmp908 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp909 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp908
    %tmp910 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp911 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp910, i32 0, i32 0
    %tmp912 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp911
    %tmp913 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp912, i64 %tmp905
    %tmp914 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp913 to i8*
    %tmp915 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp848
    %tmp916 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp915 to i8*
    %tmp917 = call i8* @"memcpy"(i8* %tmp914, i8* %tmp916, i64 32)
    %tmp918 = load i64, i64* %tmp850
    %tmp919 = load i64, i64* %tmp850
    %tmp920 = add i64 %tmp919, 1
    store i64 %tmp920, i64* %tmp850
    br label %while_cond.75
while_end.77:
    %tmp921 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp848
    %tmp922 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp921 to i8*
    call void @"free"(i8* %tmp922)
    %tmp923 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp924 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp923, i32 0, i32 1
    %tmp925 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp926 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp925, i32 0, i32 1
    %tmp927 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp928 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp927
    %tmp929 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp930 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp929, i32 0, i32 1
    %tmp931 = load i64, i64* %tmp930
    %tmp932 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp933 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp932
    %tmp934 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp935 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp934, i32 0, i32 1
    %tmp936 = load i64, i64* %tmp935
    %tmp937 = sub i64 %tmp936, 1
    store i64 %tmp937, i64* %tmp924
    %tmp938 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp939 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp938, i32 0, i32 0
    %tmp940 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp941 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp940
    %tmp942 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp943 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp942, i32 0, i32 0
    %tmp944 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp943
    %tmp945 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp946 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp945
    %tmp947 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp948 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp947, i32 0, i32 1
    %tmp949 = load i64, i64* %tmp948
    %tmp950 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp951 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp950, i32 0, i32 0
    %tmp952 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp953 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp952
    %tmp954 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp831
    %tmp955 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp954, i32 0, i32 0
    %tmp956 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp955
    %tmp957 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp956, i64 %tmp949
    %tmp958 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp957
    ret %class.hashmap.HashMapEntry_string.String_int %tmp958
}

define void @"array.Array_hashmap.HashMapEntry_string.String_int.clear"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %tmp959 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp959
    %tmp960 = alloca i64
    store i64 0, i64* %tmp960
    br label %while_cond.78
while_cond.78:
    %tmp961 = load i64, i64* %tmp960
    %tmp962 = load i64, i64* %tmp960
    %tmp963 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp959
    %tmp964 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp963
    %tmp965 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp959
    %tmp966 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp965, i32 0, i32 1
    %tmp967 = load i64, i64* %tmp966
    %tmp968 = icmp slt i64 %tmp962, %tmp967
    br i1 %tmp968, label %while_body.79, label %while_end.80
while_body.79:
    %tmp969 = load i64, i64* %tmp960
    %tmp970 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp959
    %tmp971 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp970, i32 0, i32 0
    %tmp972 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp959
    %tmp973 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp972
    %tmp974 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp959
    %tmp975 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp974, i32 0, i32 0
    %tmp976 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp975
    %tmp977 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp976, i64 %tmp969
    call void @"hashmap.HashMapEntry_string.String_int.destroy"(%class.hashmap.HashMapEntry_string.String_int* %tmp977)
    %tmp978 = load i64, i64* %tmp960
    %tmp979 = load i64, i64* %tmp960
    %tmp980 = add i64 %tmp979, 1
    store i64 %tmp980, i64* %tmp960
    br label %while_cond.78
while_end.80:
    %tmp981 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp959
    %tmp982 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp981, i32 0, i32 1
    store i64 0, i64* %tmp982
    ret void
}

define void @"array.Array_hashmap.HashMapEntry_string.String_int.destroy"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %tmp983 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp983
    %tmp984 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp983
    %tmp985 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp984, i32 0, i32 0
    %tmp986 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp983
    %tmp987 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp986
    %tmp988 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp983
    %tmp989 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp988, i32 0, i32 0
    %tmp990 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp989
    %tmp991 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp983
    %tmp992 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp991
    %tmp993 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp983
    %tmp994 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp993, i32 0, i32 0
    %tmp995 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp994
    %tmp996 = icmp ne %class.hashmap.HashMapEntry_string.String_int* %tmp995, null
    br i1 %tmp996, label %if_then.81, label %if_else.82
if_then.81:
    %tmp997 = alloca i64
    store i64 0, i64* %tmp997
    br label %while_cond.84
while_cond.84:
    %tmp998 = load i64, i64* %tmp997
    %tmp999 = load i64, i64* %tmp997
    %tmp1000 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp983
    %tmp1001 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1000
    %tmp1002 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp983
    %tmp1003 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1002, i32 0, i32 1
    %tmp1004 = load i64, i64* %tmp1003
    %tmp1005 = icmp slt i64 %tmp999, %tmp1004
    br i1 %tmp1005, label %while_body.85, label %while_end.86
while_body.85:
    %tmp1006 = load i64, i64* %tmp997
    %tmp1007 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp983
    %tmp1008 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1007, i32 0, i32 0
    %tmp1009 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp983
    %tmp1010 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1009
    %tmp1011 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp983
    %tmp1012 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1011, i32 0, i32 0
    %tmp1013 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1012
    %tmp1014 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1013, i64 %tmp1006
    call void @"hashmap.HashMapEntry_string.String_int.destroy"(%class.hashmap.HashMapEntry_string.String_int* %tmp1014)
    %tmp1015 = load i64, i64* %tmp997
    %tmp1016 = load i64, i64* %tmp997
    %tmp1017 = add i64 %tmp1016, 1
    store i64 %tmp1017, i64* %tmp997
    br label %while_cond.84
while_end.86:
    %tmp1018 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp983
    %tmp1019 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1018
    %tmp1020 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp983
    %tmp1021 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1020, i32 0, i32 0
    %tmp1022 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1021
    %tmp1023 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp1022 to i8*
    call void @"free"(i8* %tmp1023)
    %tmp1024 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp983
    %tmp1025 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1024, i32 0, i32 0
    store %class.hashmap.HashMapEntry_string.String_int* null, %class.hashmap.HashMapEntry_string.String_int** %tmp1025
    br label %if_end.83
if_else.82:
    br label %if_end.83
if_end.83:
    %tmp1026 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp983
    %tmp1027 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1026, i32 0, i32 2
    store i64 0, i64* %tmp1027
    %tmp1028 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp983
    %tmp1029 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1028, i32 0, i32 1
    store i64 0, i64* %tmp1029
    ret void
}

define %class.array.Array_hashmap.HashMapEntry_string.String_int @"array.Array_hashmap.HashMapEntry_string.String_int.clone"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %tmp0 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %self
    ret %class.array.Array_hashmap.HashMapEntry_string.String_int %tmp0
}

define void @"hashmap.HashMap_string.String_int.init"(%class.hashmap.HashMap_string.String_int* %self) {
entry:
    %tmp1030 = alloca %class.hashmap.HashMap_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %tmp1030
    %tmp1031 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1030
    %tmp1032 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1031, i32 0, i32 1
    store i64 0, i64* %tmp1032
    %tmp1033 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1030
    %tmp1034 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1033, i32 0, i32 2
    store i64 16, i64* %tmp1034
    %tmp1035 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1030
    %tmp1036 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1035
    %tmp1037 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1030
    %tmp1038 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1037, i32 0, i32 0
    %tmp1039 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1038
    %tmp1040 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1030
    %tmp1041 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1040, i32 0, i32 0
    call void @"array.Array_hashmap.HashMapEntry_string.String_int.init"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1041)
    %tmp1042 = alloca i64
    store i64 0, i64* %tmp1042
    br label %while_cond.87
while_cond.87:
    %tmp1043 = load i64, i64* %tmp1042
    %tmp1044 = load i64, i64* %tmp1042
    %tmp1045 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1030
    %tmp1046 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1045
    %tmp1047 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1030
    %tmp1048 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1047, i32 0, i32 2
    %tmp1049 = load i64, i64* %tmp1048
    %tmp1050 = icmp slt i64 %tmp1044, %tmp1049
    br i1 %tmp1050, label %while_body.88, label %while_end.89
while_body.88:
    %tmp1051 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1030
    %tmp1052 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1051
    %tmp1053 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1030
    %tmp1054 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1053, i32 0, i32 0
    %tmp1055 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1054
    %tmp1056 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1030
    %tmp1057 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1056, i32 0, i32 0
    %tmp1058 = alloca %class.hashmap.HashMapEntry_string.String_int
    store %class.hashmap.HashMapEntry_string.String_int zeroinitializer, %class.hashmap.HashMapEntry_string.String_int* %tmp1058
    call void @"hashmap.HashMapEntry_string.String_int.init"(%class.hashmap.HashMapEntry_string.String_int* %tmp1058)
    %tmp1059 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1058
    call void @"array.Array_hashmap.HashMapEntry_string.String_int.push"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1057, %class.hashmap.HashMapEntry_string.String_int %tmp1059)
    %tmp1060 = load i64, i64* %tmp1042
    %tmp1061 = load i64, i64* %tmp1042
    %tmp1062 = add i64 %tmp1061, 1
    store i64 %tmp1062, i64* %tmp1042
    br label %while_cond.87
while_end.89:
    ret void
}

define i64 @"hashmap.HashMap_string.String_int.length"(%class.hashmap.HashMap_string.String_int* %self) {
entry:
    %tmp1063 = alloca %class.hashmap.HashMap_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %tmp1063
    %tmp1064 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1063
    %tmp1065 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1064
    %tmp1066 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1063
    %tmp1067 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1066, i32 0, i32 1
    %tmp1068 = load i64, i64* %tmp1067
    ret i64 %tmp1068
}

define void @"hashmap.HashMap_string.String_int.operator_index_set"(%class.hashmap.HashMap_string.String_int* %self, %class.string.String %key, i64 %value) {
entry:
    %tmp1069 = alloca %class.hashmap.HashMap_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1070 = alloca %class.string.String
    store %class.string.String %key, %class.string.String* %tmp1070
    %tmp1071 = alloca i64
    store i64 %value, i64* %tmp1071
    %tmp1072 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1073 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1072, i32 0, i32 1
    %tmp1074 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1075 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1074
    %tmp1076 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1077 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1076, i32 0, i32 1
    %tmp1078 = load i64, i64* %tmp1077
    %tmp1079 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1080 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1079
    %tmp1081 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1082 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1081, i32 0, i32 1
    %tmp1083 = load i64, i64* %tmp1082
    %tmp1084 = mul i64 %tmp1083, 100
    %tmp1085 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1086 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1085, i32 0, i32 1
    %tmp1087 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1088 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1087
    %tmp1089 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1090 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1089, i32 0, i32 1
    %tmp1091 = load i64, i64* %tmp1090
    %tmp1092 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1093 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1092
    %tmp1094 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1095 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1094, i32 0, i32 1
    %tmp1096 = load i64, i64* %tmp1095
    %tmp1097 = mul i64 %tmp1096, 100
    %tmp1098 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1099 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1098, i32 0, i32 2
    %tmp1100 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1101 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1100
    %tmp1102 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1103 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1102, i32 0, i32 2
    %tmp1104 = load i64, i64* %tmp1103
    %tmp1105 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1106 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1105
    %tmp1107 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1108 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1107, i32 0, i32 2
    %tmp1109 = load i64, i64* %tmp1108
    %tmp1110 = mul i64 %tmp1109, 70
    %tmp1111 = icmp sgt i64 %tmp1097, %tmp1110
    br i1 %tmp1111, label %if_then.90, label %if_else.91
if_then.90:
    %tmp1112 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1113 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    call void @"hashmap.HashMap_string.String_int.resize"(%class.hashmap.HashMap_string.String_int* %tmp1113)
    br label %if_end.92
if_else.91:
    br label %if_end.92
if_end.92:
    %tmp1114 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1115 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1116 = call i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %tmp1115, %class.string.String* %tmp1070)
    %tmp1117 = alloca i64
    store i64 %tmp1116, i64* %tmp1117
    %tmp1118 = load i64, i64* %tmp1117
    %tmp1119 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1120 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1119, i32 0, i32 0
    %tmp1121 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1120, i32 0, i32 0
    %tmp1122 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1123 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1122
    %tmp1124 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1125 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1124, i32 0, i32 0
    %tmp1126 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1125
    %tmp1127 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1128 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1127, i32 0, i32 0
    %tmp1129 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1128, i32 0, i32 0
    %tmp1130 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1129
    %tmp1131 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1130, i64 %tmp1118
    %tmp1132 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp1131, %class.hashmap.HashMapEntry_string.String_int** %tmp1132
    %tmp1133 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1132
    %tmp1134 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1133
    %tmp1135 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1132
    %tmp1136 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1135, i32 0, i32 2
    %tmp1137 = load i1, i1* %tmp1136
    %tmp1138 = xor i1 %tmp1137, true
    br i1 %tmp1138, label %if_then.93, label %if_else.94
if_then.93:
    %tmp1139 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1140 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1139, i32 0, i32 1
    %tmp1141 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1142 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1141, i32 0, i32 1
    %tmp1143 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1144 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1143
    %tmp1145 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1146 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1145, i32 0, i32 1
    %tmp1147 = load i64, i64* %tmp1146
    %tmp1148 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1149 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1148
    %tmp1150 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1069
    %tmp1151 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1150, i32 0, i32 1
    %tmp1152 = load i64, i64* %tmp1151
    %tmp1153 = add i64 %tmp1152, 1
    store i64 %tmp1153, i64* %tmp1140
    br label %if_end.95
if_else.94:
    %tmp1154 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1132
    %tmp1155 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1154, i32 0, i32 0
    call void @"string.String.destroy"(%class.string.String* %tmp1155)
    %tmp1156 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1132
    %tmp1157 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1156, i32 0, i32 1
    %tmp1158 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1132
    %tmp1159 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1158, i32 0, i32 2
    store i1 0, i1* %tmp1159
    br label %if_end.95
if_end.95:
    %tmp1160 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1132
    %tmp1161 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1160, i32 0, i32 0
    %tmp1162 = bitcast %class.string.String* %tmp1161 to i8*
    %tmp1163 = bitcast %class.string.String* %tmp1070 to i8*
    %tmp1164 = call i8* @"memcpy"(i8* %tmp1162, i8* %tmp1163, i64 16)
    %tmp1165 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1132
    %tmp1166 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1165, i32 0, i32 1
    %tmp1167 = bitcast i64* %tmp1166 to i8*
    %tmp1168 = bitcast i64* %tmp1071 to i8*
    %tmp1169 = call i8* @"memcpy"(i8* %tmp1167, i8* %tmp1168, i64 8)
    %tmp1170 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1132
    %tmp1171 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1170, i32 0, i32 2
    store i1 1, i1* %tmp1171
    ret void
}

define i64* @"hashmap.HashMap_string.String_int.get"(%class.hashmap.HashMap_string.String_int* %self, %class.string.String* %key) {
entry:
    %tmp1172 = alloca %class.hashmap.HashMap_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %tmp1172
    %tmp1173 = alloca %class.string.String*
    store %class.string.String* %key, %class.string.String** %tmp1173
    %tmp1174 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1172
    %tmp1175 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1172
    %tmp1176 = load %class.string.String*, %class.string.String** %tmp1173
    %tmp1177 = call i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %tmp1175, %class.string.String* %tmp1176)
    %tmp1178 = alloca i64
    store i64 %tmp1177, i64* %tmp1178
    %tmp1179 = load i64, i64* %tmp1178
    %tmp1180 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1172
    %tmp1181 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1180, i32 0, i32 0
    %tmp1182 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1181, i32 0, i32 0
    %tmp1183 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1172
    %tmp1184 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1183
    %tmp1185 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1172
    %tmp1186 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1185, i32 0, i32 0
    %tmp1187 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1186
    %tmp1188 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1172
    %tmp1189 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1188, i32 0, i32 0
    %tmp1190 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1189, i32 0, i32 0
    %tmp1191 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1190
    %tmp1192 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1191, i64 %tmp1179
    %tmp1193 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp1192, %class.hashmap.HashMapEntry_string.String_int** %tmp1193
    %tmp1194 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1193
    %tmp1195 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1194
    %tmp1196 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1193
    %tmp1197 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1196, i32 0, i32 2
    %tmp1198 = load i1, i1* %tmp1197
    br i1 %tmp1198, label %if_then.96, label %if_else.97
if_then.96:
    %tmp1199 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1193
    %tmp1200 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1199, i32 0, i32 1
    ret i64* %tmp1200
if_else.97:
    br label %if_end.98
if_end.98:
    ret i64* null
}

define i1 @"hashmap.HashMap_string.String_int.contains"(%class.hashmap.HashMap_string.String_int* %self, %class.string.String* %key) {
entry:
    %tmp1201 = alloca %class.hashmap.HashMap_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %tmp1201
    %tmp1202 = alloca %class.string.String*
    store %class.string.String* %key, %class.string.String** %tmp1202
    %tmp1203 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1201
    %tmp1204 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1201
    %tmp1205 = load %class.string.String*, %class.string.String** %tmp1202
    %tmp1206 = call i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %tmp1204, %class.string.String* %tmp1205)
    %tmp1207 = alloca i64
    store i64 %tmp1206, i64* %tmp1207
    %tmp1208 = load i64, i64* %tmp1207
    %tmp1209 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1201
    %tmp1210 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1209, i32 0, i32 0
    %tmp1211 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1210, i32 0, i32 0
    %tmp1212 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1201
    %tmp1213 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1212
    %tmp1214 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1201
    %tmp1215 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1214, i32 0, i32 0
    %tmp1216 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1215
    %tmp1217 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1201
    %tmp1218 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1217, i32 0, i32 0
    %tmp1219 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1218, i32 0, i32 0
    %tmp1220 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1219
    %tmp1221 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1220, i64 %tmp1208
    %tmp1222 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp1221, %class.hashmap.HashMapEntry_string.String_int** %tmp1222
    %tmp1223 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1222
    %tmp1224 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1223
    %tmp1225 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1222
    %tmp1226 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1225, i32 0, i32 2
    %tmp1227 = load i1, i1* %tmp1226
    ret i1 %tmp1227
}

define i1 @"hashmap.HashMap_string.String_int.remove"(%class.hashmap.HashMap_string.String_int* %self, %class.string.String* %key) {
entry:
    %tmp1228 = alloca %class.hashmap.HashMap_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1229 = alloca %class.string.String*
    store %class.string.String* %key, %class.string.String** %tmp1229
    %tmp1230 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1231 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1232 = load %class.string.String*, %class.string.String** %tmp1229
    %tmp1233 = call i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %tmp1231, %class.string.String* %tmp1232)
    %tmp1234 = alloca i64
    store i64 %tmp1233, i64* %tmp1234
    %tmp1235 = load i64, i64* %tmp1234
    %tmp1236 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1237 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1236, i32 0, i32 0
    %tmp1238 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1237, i32 0, i32 0
    %tmp1239 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1240 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1239
    %tmp1241 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1242 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1241, i32 0, i32 0
    %tmp1243 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1242
    %tmp1244 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1245 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1244, i32 0, i32 0
    %tmp1246 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1245, i32 0, i32 0
    %tmp1247 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1246
    %tmp1248 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1247, i64 %tmp1235
    %tmp1249 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp1248, %class.hashmap.HashMapEntry_string.String_int** %tmp1249
    %tmp1250 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1249
    %tmp1251 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1250
    %tmp1252 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1249
    %tmp1253 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1252, i32 0, i32 2
    %tmp1254 = load i1, i1* %tmp1253
    br i1 %tmp1254, label %if_then.99, label %if_else.100
if_then.99:
    %tmp1255 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1249
    %tmp1256 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1255, i32 0, i32 0
    call void @"string.String.destroy"(%class.string.String* %tmp1256)
    %tmp1257 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1249
    %tmp1258 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1257, i32 0, i32 1
    %tmp1259 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1249
    %tmp1260 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1259, i32 0, i32 2
    store i1 0, i1* %tmp1260
    %tmp1261 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1262 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1261, i32 0, i32 1
    %tmp1263 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1264 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1263, i32 0, i32 1
    %tmp1265 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1266 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1265
    %tmp1267 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1268 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1267, i32 0, i32 1
    %tmp1269 = load i64, i64* %tmp1268
    %tmp1270 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1271 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1270
    %tmp1272 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1273 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1272, i32 0, i32 1
    %tmp1274 = load i64, i64* %tmp1273
    %tmp1275 = sub i64 %tmp1274, 1
    store i64 %tmp1275, i64* %tmp1262
    %tmp1276 = load i64, i64* %tmp1234
    %tmp1277 = load i64, i64* %tmp1234
    %tmp1278 = add i64 %tmp1277, 1
    %tmp1279 = load i64, i64* %tmp1234
    %tmp1280 = load i64, i64* %tmp1234
    %tmp1281 = add i64 %tmp1280, 1
    %tmp1282 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1283 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1282
    %tmp1284 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1285 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1284, i32 0, i32 2
    %tmp1286 = load i64, i64* %tmp1285
    %tmp1287 = srem i64 %tmp1281, %tmp1286
    %tmp1288 = alloca i64
    store i64 %tmp1287, i64* %tmp1288
    br label %while_cond.102
while_cond.102:
    %tmp1289 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1290 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1289, i32 0, i32 0
    %tmp1291 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1290, i32 0, i32 0
    %tmp1292 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1293 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1292
    %tmp1294 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1295 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1294, i32 0, i32 0
    %tmp1296 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1295
    %tmp1297 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1298 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1297, i32 0, i32 0
    %tmp1299 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1298, i32 0, i32 0
    %tmp1300 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1299
    %tmp1301 = load i64, i64* %tmp1288
    %tmp1302 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1303 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1302, i32 0, i32 0
    %tmp1304 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1303, i32 0, i32 0
    %tmp1305 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1306 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1305
    %tmp1307 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1308 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1307, i32 0, i32 0
    %tmp1309 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1308
    %tmp1310 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1311 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1310, i32 0, i32 0
    %tmp1312 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1311, i32 0, i32 0
    %tmp1313 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1312
    %tmp1314 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1313, i64 %tmp1301
    %tmp1315 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1314
    %tmp1316 = load i64, i64* %tmp1288
    %tmp1317 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1318 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1317, i32 0, i32 0
    %tmp1319 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1318, i32 0, i32 0
    %tmp1320 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1321 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1320
    %tmp1322 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1323 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1322, i32 0, i32 0
    %tmp1324 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1323
    %tmp1325 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1326 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1325, i32 0, i32 0
    %tmp1327 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1326, i32 0, i32 0
    %tmp1328 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1327
    %tmp1329 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1328, i64 %tmp1316
    %tmp1330 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1329, i32 0, i32 2
    %tmp1331 = load i1, i1* %tmp1330
    br i1 %tmp1331, label %while_body.103, label %while_end.104
while_body.103:
    %tmp1332 = load i64, i64* %tmp1288
    %tmp1333 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1334 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1333, i32 0, i32 0
    %tmp1335 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1334, i32 0, i32 0
    %tmp1336 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1337 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1336
    %tmp1338 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1339 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1338, i32 0, i32 0
    %tmp1340 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1339
    %tmp1341 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1342 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1341, i32 0, i32 0
    %tmp1343 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1342, i32 0, i32 0
    %tmp1344 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1343
    %tmp1345 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1344, i64 %tmp1332
    %tmp1346 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp1345, %class.hashmap.HashMapEntry_string.String_int** %tmp1346
    %tmp1347 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1346
    %tmp1348 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1347, i32 0, i32 2
    store i1 0, i1* %tmp1348
    %tmp1349 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1350 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1349, i32 0, i32 1
    %tmp1351 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1352 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1351, i32 0, i32 1
    %tmp1353 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1354 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1353
    %tmp1355 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1356 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1355, i32 0, i32 1
    %tmp1357 = load i64, i64* %tmp1356
    %tmp1358 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1359 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1358
    %tmp1360 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1361 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1360, i32 0, i32 1
    %tmp1362 = load i64, i64* %tmp1361
    %tmp1363 = sub i64 %tmp1362, 1
    store i64 %tmp1363, i64* %tmp1350
    %tmp1364 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1365 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1366 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1346
    %tmp1367 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1366, i32 0, i32 0
    %tmp1368 = call i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %tmp1365, %class.string.String* %tmp1367)
    %tmp1369 = alloca i64
    store i64 %tmp1368, i64* %tmp1369
    %tmp1370 = load i64, i64* %tmp1369
    %tmp1371 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1372 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1371, i32 0, i32 0
    %tmp1373 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1372, i32 0, i32 0
    %tmp1374 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1375 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1374
    %tmp1376 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1377 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1376, i32 0, i32 0
    %tmp1378 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1377
    %tmp1379 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1380 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1379, i32 0, i32 0
    %tmp1381 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1380, i32 0, i32 0
    %tmp1382 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1381
    %tmp1383 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1382, i64 %tmp1370
    %tmp1384 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp1383, %class.hashmap.HashMapEntry_string.String_int** %tmp1384
    %tmp1385 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1384
    %tmp1386 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1385, i32 0, i32 0
    %tmp1387 = bitcast %class.string.String* %tmp1386 to i8*
    %tmp1388 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1346
    %tmp1389 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1388, i32 0, i32 0
    %tmp1390 = bitcast %class.string.String* %tmp1389 to i8*
    %tmp1391 = call i8* @"memcpy"(i8* %tmp1387, i8* %tmp1390, i64 16)
    %tmp1392 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1384
    %tmp1393 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1392, i32 0, i32 1
    %tmp1394 = bitcast i64* %tmp1393 to i8*
    %tmp1395 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1346
    %tmp1396 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1395, i32 0, i32 1
    %tmp1397 = bitcast i64* %tmp1396 to i8*
    %tmp1398 = call i8* @"memcpy"(i8* %tmp1394, i8* %tmp1397, i64 8)
    %tmp1399 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1384
    %tmp1400 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1399, i32 0, i32 2
    store i1 1, i1* %tmp1400
    %tmp1401 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1402 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1401, i32 0, i32 1
    %tmp1403 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1404 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1403, i32 0, i32 1
    %tmp1405 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1406 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1405
    %tmp1407 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1408 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1407, i32 0, i32 1
    %tmp1409 = load i64, i64* %tmp1408
    %tmp1410 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1411 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1410
    %tmp1412 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1413 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1412, i32 0, i32 1
    %tmp1414 = load i64, i64* %tmp1413
    %tmp1415 = add i64 %tmp1414, 1
    store i64 %tmp1415, i64* %tmp1402
    %tmp1416 = load i64, i64* %tmp1288
    %tmp1417 = load i64, i64* %tmp1288
    %tmp1418 = add i64 %tmp1417, 1
    %tmp1419 = load i64, i64* %tmp1288
    %tmp1420 = load i64, i64* %tmp1288
    %tmp1421 = add i64 %tmp1420, 1
    %tmp1422 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1423 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1422
    %tmp1424 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1228
    %tmp1425 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1424, i32 0, i32 2
    %tmp1426 = load i64, i64* %tmp1425
    %tmp1427 = srem i64 %tmp1421, %tmp1426
    store i64 %tmp1427, i64* %tmp1288
    br label %while_cond.102
while_end.104:
    ret i1 1
if_else.100:
    br label %if_end.101
if_end.101:
    ret i1 0
}

define i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %self, %class.string.String* %key) {
entry:
    %tmp1428 = alloca %class.hashmap.HashMap_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1429 = alloca %class.string.String*
    store %class.string.String* %key, %class.string.String** %tmp1429
    %tmp1430 = load %class.string.String*, %class.string.String** %tmp1429
    %tmp1431 = load %class.string.String*, %class.string.String** %tmp1429
    %tmp1432 = call i64 @"string.String.hash"(%class.string.String* %tmp1431)
    %tmp1433 = alloca i64
    store i64 %tmp1432, i64* %tmp1433
    %tmp1434 = load i64, i64* %tmp1433
    %tmp1435 = load i64, i64* %tmp1433
    %tmp1436 = icmp slt i64 %tmp1435, 0
    br i1 %tmp1436, label %if_then.105, label %if_else.106
if_then.105:
    %tmp1437 = load i64, i64* %tmp1433
    %tmp1438 = load i64, i64* %tmp1433
    %tmp1439 = sub i64 0, 1
    %tmp1440 = mul i64 %tmp1438, %tmp1439
    store i64 %tmp1440, i64* %tmp1433
    br label %if_end.107
if_else.106:
    br label %if_end.107
if_end.107:
    %tmp1441 = load i64, i64* %tmp1433
    %tmp1442 = load i64, i64* %tmp1433
    %tmp1443 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1444 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1443
    %tmp1445 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1446 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1445, i32 0, i32 2
    %tmp1447 = load i64, i64* %tmp1446
    %tmp1448 = srem i64 %tmp1442, %tmp1447
    %tmp1449 = alloca i64
    store i64 %tmp1448, i64* %tmp1449
    br label %while_cond.108
while_cond.108:
    %tmp1450 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1451 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1450, i32 0, i32 0
    %tmp1452 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1451, i32 0, i32 0
    %tmp1453 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1454 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1453
    %tmp1455 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1456 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1455, i32 0, i32 0
    %tmp1457 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1456
    %tmp1458 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1459 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1458, i32 0, i32 0
    %tmp1460 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1459, i32 0, i32 0
    %tmp1461 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1460
    %tmp1462 = load i64, i64* %tmp1449
    %tmp1463 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1464 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1463, i32 0, i32 0
    %tmp1465 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1464, i32 0, i32 0
    %tmp1466 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1467 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1466
    %tmp1468 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1469 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1468, i32 0, i32 0
    %tmp1470 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1469
    %tmp1471 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1472 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1471, i32 0, i32 0
    %tmp1473 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1472, i32 0, i32 0
    %tmp1474 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1473
    %tmp1475 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1474, i64 %tmp1462
    %tmp1476 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1475
    %tmp1477 = load i64, i64* %tmp1449
    %tmp1478 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1479 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1478, i32 0, i32 0
    %tmp1480 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1479, i32 0, i32 0
    %tmp1481 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1482 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1481
    %tmp1483 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1484 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1483, i32 0, i32 0
    %tmp1485 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1484
    %tmp1486 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1487 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1486, i32 0, i32 0
    %tmp1488 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1487, i32 0, i32 0
    %tmp1489 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1488
    %tmp1490 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1489, i64 %tmp1477
    %tmp1491 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1490, i32 0, i32 2
    %tmp1492 = load i1, i1* %tmp1491
    br i1 %tmp1492, label %while_body.109, label %while_end.110
while_body.109:
    %tmp1493 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1494 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1493, i32 0, i32 0
    %tmp1495 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1494, i32 0, i32 0
    %tmp1496 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1497 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1496
    %tmp1498 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1499 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1498, i32 0, i32 0
    %tmp1500 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1499
    %tmp1501 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1502 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1501, i32 0, i32 0
    %tmp1503 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1502, i32 0, i32 0
    %tmp1504 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1503
    %tmp1505 = load i64, i64* %tmp1449
    %tmp1506 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1507 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1506, i32 0, i32 0
    %tmp1508 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1507, i32 0, i32 0
    %tmp1509 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1510 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1509
    %tmp1511 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1512 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1511, i32 0, i32 0
    %tmp1513 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1512
    %tmp1514 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1515 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1514, i32 0, i32 0
    %tmp1516 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1515, i32 0, i32 0
    %tmp1517 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1516
    %tmp1518 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1517, i64 %tmp1505
    %tmp1519 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1518
    %tmp1520 = load i64, i64* %tmp1449
    %tmp1521 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1522 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1521, i32 0, i32 0
    %tmp1523 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1522, i32 0, i32 0
    %tmp1524 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1525 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1524
    %tmp1526 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1527 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1526, i32 0, i32 0
    %tmp1528 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1527
    %tmp1529 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1530 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1529, i32 0, i32 0
    %tmp1531 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1530, i32 0, i32 0
    %tmp1532 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1531
    %tmp1533 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1532, i64 %tmp1520
    %tmp1534 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1533, i32 0, i32 0
    %tmp1535 = load %class.string.String, %class.string.String* %tmp1534
    %tmp1536 = load i64, i64* %tmp1449
    %tmp1537 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1538 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1537, i32 0, i32 0
    %tmp1539 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1538, i32 0, i32 0
    %tmp1540 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1541 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1540
    %tmp1542 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1543 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1542, i32 0, i32 0
    %tmp1544 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1543
    %tmp1545 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1546 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1545, i32 0, i32 0
    %tmp1547 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1546, i32 0, i32 0
    %tmp1548 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1547
    %tmp1549 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1548, i64 %tmp1536
    %tmp1550 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1549, i32 0, i32 0
    %tmp1551 = load %class.string.String*, %class.string.String** %tmp1429
    %tmp1552 = call i1 @"string.String.equals"(%class.string.String* %tmp1550, %class.string.String* %tmp1551)
    br i1 %tmp1552, label %if_then.111, label %if_else.112
if_then.111:
    %tmp1553 = load i64, i64* %tmp1449
    ret i64 %tmp1553
if_else.112:
    br label %if_end.113
if_end.113:
    %tmp1554 = load i64, i64* %tmp1449
    %tmp1555 = load i64, i64* %tmp1449
    %tmp1556 = add i64 %tmp1555, 1
    %tmp1557 = load i64, i64* %tmp1449
    %tmp1558 = load i64, i64* %tmp1449
    %tmp1559 = add i64 %tmp1558, 1
    %tmp1560 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1561 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1560
    %tmp1562 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1428
    %tmp1563 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1562, i32 0, i32 2
    %tmp1564 = load i64, i64* %tmp1563
    %tmp1565 = srem i64 %tmp1559, %tmp1564
    store i64 %tmp1565, i64* %tmp1449
    br label %while_cond.108
while_end.110:
    %tmp1566 = load i64, i64* %tmp1449
    ret i64 %tmp1566
}

define void @"hashmap.HashMap_string.String_int.resize"(%class.hashmap.HashMap_string.String_int* %self) {
entry:
    %tmp1567 = alloca %class.hashmap.HashMap_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1568 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1569 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1568
    %tmp1570 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1571 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1570, i32 0, i32 0
    %tmp1572 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1571
    %tmp1573 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1574 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1573, i32 0, i32 0
    %tmp1575 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1574, i32 0, i32 0
    %tmp1576 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1575
    %tmp1577 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp1576, %class.hashmap.HashMapEntry_string.String_int** %tmp1577
    %tmp1578 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1579 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1578
    %tmp1580 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1581 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1580, i32 0, i32 2
    %tmp1582 = load i64, i64* %tmp1581
    %tmp1583 = alloca i64
    store i64 %tmp1582, i64* %tmp1583
    %tmp1584 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1585 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1584, i32 0, i32 2
    %tmp1586 = load i64, i64* %tmp1583
    %tmp1587 = load i64, i64* %tmp1583
    %tmp1588 = mul i64 %tmp1587, 2
    store i64 %tmp1588, i64* %tmp1585
    %tmp1589 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1590 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1589, i32 0, i32 1
    store i64 0, i64* %tmp1590
    %tmp1591 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1592 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1591, i32 0, i32 0
    %tmp1593 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1592, i32 0, i32 0
    %tmp1594 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1595 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1594, i32 0, i32 2
    %tmp1596 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1597 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1596
    %tmp1598 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1599 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1598, i32 0, i32 2
    %tmp1600 = load i64, i64* %tmp1599
    %tmp1601 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1602 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1601
    %tmp1603 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1604 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1603, i32 0, i32 2
    %tmp1605 = load i64, i64* %tmp1604
    %tmp1606 = mul i64 %tmp1605, 32
    %tmp1607 = call i8* @"malloc"(i64 %tmp1606)
    %tmp1608 = bitcast i8* %tmp1607 to %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp1608, %class.hashmap.HashMapEntry_string.String_int** %tmp1593
    %tmp1609 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1610 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1609, i32 0, i32 0
    %tmp1611 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1610, i32 0, i32 2
    %tmp1612 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1613 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1612
    %tmp1614 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1615 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1614, i32 0, i32 2
    %tmp1616 = load i64, i64* %tmp1615
    store i64 %tmp1616, i64* %tmp1611
    %tmp1617 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1618 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1617, i32 0, i32 0
    %tmp1619 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1618, i32 0, i32 1
    store i64 0, i64* %tmp1619
    %tmp1620 = alloca i64
    store i64 0, i64* %tmp1620
    br label %while_cond.114
while_cond.114:
    %tmp1621 = load i64, i64* %tmp1620
    %tmp1622 = load i64, i64* %tmp1620
    %tmp1623 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1624 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1623
    %tmp1625 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1626 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1625, i32 0, i32 2
    %tmp1627 = load i64, i64* %tmp1626
    %tmp1628 = icmp slt i64 %tmp1622, %tmp1627
    br i1 %tmp1628, label %while_body.115, label %while_end.116
while_body.115:
    %tmp1629 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1630 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1629
    %tmp1631 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1632 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1631, i32 0, i32 0
    %tmp1633 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1632
    %tmp1634 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1635 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1634, i32 0, i32 0
    %tmp1636 = alloca %class.hashmap.HashMapEntry_string.String_int
    store %class.hashmap.HashMapEntry_string.String_int zeroinitializer, %class.hashmap.HashMapEntry_string.String_int* %tmp1636
    call void @"hashmap.HashMapEntry_string.String_int.init"(%class.hashmap.HashMapEntry_string.String_int* %tmp1636)
    %tmp1637 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1636
    call void @"array.Array_hashmap.HashMapEntry_string.String_int.push"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1635, %class.hashmap.HashMapEntry_string.String_int %tmp1637)
    %tmp1638 = load i64, i64* %tmp1620
    %tmp1639 = load i64, i64* %tmp1620
    %tmp1640 = add i64 %tmp1639, 1
    store i64 %tmp1640, i64* %tmp1620
    br label %while_cond.114
while_end.116:
    store i64 0, i64* %tmp1620
    br label %while_cond.117
while_cond.117:
    %tmp1641 = load i64, i64* %tmp1620
    %tmp1642 = load i64, i64* %tmp1620
    %tmp1643 = load i64, i64* %tmp1583
    %tmp1644 = icmp slt i64 %tmp1642, %tmp1643
    br i1 %tmp1644, label %while_body.118, label %while_end.119
while_body.118:
    %tmp1645 = load i64, i64* %tmp1620
    %tmp1646 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1577
    %tmp1647 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1646, i64 %tmp1645
    %tmp1648 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp1647, %class.hashmap.HashMapEntry_string.String_int** %tmp1648
    %tmp1649 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1648
    %tmp1650 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1649
    %tmp1651 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1648
    %tmp1652 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1651, i32 0, i32 2
    %tmp1653 = load i1, i1* %tmp1652
    br i1 %tmp1653, label %if_then.120, label %if_else.121
if_then.120:
    %tmp1654 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1655 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1656 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1648
    %tmp1657 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1656, i32 0, i32 0
    %tmp1658 = call i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %tmp1655, %class.string.String* %tmp1657)
    %tmp1659 = alloca i64
    store i64 %tmp1658, i64* %tmp1659
    %tmp1660 = load i64, i64* %tmp1659
    %tmp1661 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1662 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1661, i32 0, i32 0
    %tmp1663 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1662, i32 0, i32 0
    %tmp1664 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1665 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1664
    %tmp1666 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1667 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1666, i32 0, i32 0
    %tmp1668 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1667
    %tmp1669 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1670 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1669, i32 0, i32 0
    %tmp1671 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1670, i32 0, i32 0
    %tmp1672 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1671
    %tmp1673 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1672, i64 %tmp1660
    %tmp1674 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp1673, %class.hashmap.HashMapEntry_string.String_int** %tmp1674
    %tmp1675 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1674
    %tmp1676 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1675, i32 0, i32 0
    %tmp1677 = bitcast %class.string.String* %tmp1676 to i8*
    %tmp1678 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1648
    %tmp1679 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1678, i32 0, i32 0
    %tmp1680 = bitcast %class.string.String* %tmp1679 to i8*
    %tmp1681 = call i8* @"memcpy"(i8* %tmp1677, i8* %tmp1680, i64 16)
    %tmp1682 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1674
    %tmp1683 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1682, i32 0, i32 1
    %tmp1684 = bitcast i64* %tmp1683 to i8*
    %tmp1685 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1648
    %tmp1686 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1685, i32 0, i32 1
    %tmp1687 = bitcast i64* %tmp1686 to i8*
    %tmp1688 = call i8* @"memcpy"(i8* %tmp1684, i8* %tmp1687, i64 8)
    %tmp1689 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1674
    %tmp1690 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1689, i32 0, i32 2
    store i1 1, i1* %tmp1690
    %tmp1691 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1692 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1691, i32 0, i32 1
    %tmp1693 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1694 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1693, i32 0, i32 1
    %tmp1695 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1696 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1695
    %tmp1697 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1698 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1697, i32 0, i32 1
    %tmp1699 = load i64, i64* %tmp1698
    %tmp1700 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1701 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1700
    %tmp1702 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1567
    %tmp1703 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1702, i32 0, i32 1
    %tmp1704 = load i64, i64* %tmp1703
    %tmp1705 = add i64 %tmp1704, 1
    store i64 %tmp1705, i64* %tmp1692
    br label %if_end.122
if_else.121:
    br label %if_end.122
if_end.122:
    %tmp1706 = load i64, i64* %tmp1620
    %tmp1707 = load i64, i64* %tmp1620
    %tmp1708 = add i64 %tmp1707, 1
    store i64 %tmp1708, i64* %tmp1620
    br label %while_cond.117
while_end.119:
    %tmp1709 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1577
    %tmp1710 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp1709 to i8*
    call void @"free"(i8* %tmp1710)
    ret void
}

define void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %self) {
entry:
    %tmp1711 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %self, i32 0, i32 0
    call void @"array.Array_hashmap.HashMapEntry_string.String_int.destroy"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1711)
    ret void
}

define %class.hashmap.HashMap_string.String_int @"hashmap.HashMap_string.String_int.clone"(%class.hashmap.HashMap_string.String_int* %self) {
entry:
    %tmp0 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %self
    ret %class.hashmap.HashMap_string.String_int %tmp0
}

define void @"io.print_char"(i8 %c) {
entry:
    %tmp1712 = alloca i8
    store i8 %c, i8* %tmp1712
    %tmp1713 = load i8, i8* %tmp1712
    %tmp1714 = zext i8 %tmp1713 to i32
    %tmp1715 = call i32 @"putchar"(i32 %tmp1714)
    ret void
}

define void @"io.print_str"(i8* %s) {
entry:
    %tmp1716 = alloca i8*
    store i8* %s, i8** %tmp1716
    %tmp1717 = alloca i64
    store i64 0, i64* %tmp1717
    br label %while_cond.123
while_cond.123:
    %tmp1718 = load i64, i64* %tmp1717
    %tmp1719 = load i8*, i8** %tmp1716
    %tmp1720 = getelementptr inbounds i8, i8* %tmp1719, i64 %tmp1718
    %tmp1721 = load i8*, i8** %tmp1716
    %tmp1722 = load i64, i64* %tmp1717
    %tmp1723 = load i8*, i8** %tmp1716
    %tmp1724 = getelementptr inbounds i8, i8* %tmp1723, i64 %tmp1722
    %tmp1725 = load i8, i8* %tmp1724
    %tmp1726 = load i8*, i8** %tmp1716
    %tmp1727 = load i64, i64* %tmp1717
    %tmp1728 = load i8*, i8** %tmp1716
    %tmp1729 = getelementptr inbounds i8, i8* %tmp1728, i64 %tmp1727
    %tmp1730 = load i8, i8* %tmp1729
    %tmp1731 = icmp ne i8 %tmp1730, 0
    br i1 %tmp1731, label %while_body.124, label %while_end.125
while_body.124:
    %tmp1732 = load i8*, i8** %tmp1716
    %tmp1733 = load i64, i64* %tmp1717
    %tmp1734 = load i8*, i8** %tmp1716
    %tmp1735 = getelementptr inbounds i8, i8* %tmp1734, i64 %tmp1733
    %tmp1736 = load i8, i8* %tmp1735
    %tmp1737 = zext i8 %tmp1736 to i32
    %tmp1738 = call i32 @"putchar"(i32 %tmp1737)
    %tmp1739 = load i64, i64* %tmp1717
    %tmp1740 = load i64, i64* %tmp1717
    %tmp1741 = add i64 %tmp1740, 1
    store i64 %tmp1741, i64* %tmp1717
    br label %while_cond.123
while_end.125:
    ret void
}

define void @"io.println_str"(i8* %s) {
entry:
    %tmp1742 = alloca i8*
    store i8* %s, i8** %tmp1742
    %tmp1743 = load i8*, i8** %tmp1742
    %tmp1744 = call i32 @"puts"(i8* %tmp1743)
    ret void
}

define i32 @"main"() {
entry:
    %tmp1745 = alloca %class.hashmap.HashMap_string.String_int
    store %class.hashmap.HashMap_string.String_int zeroinitializer, %class.hashmap.HashMap_string.String_int* %tmp1745
    call void @"hashmap.HashMap_string.String_int.init"(%class.hashmap.HashMap_string.String_int* %tmp1745)
    %tmp1746 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1745
    %tmp1747 = alloca %class.hashmap.HashMap_string.String_int
    store %class.hashmap.HashMap_string.String_int %tmp1746, %class.hashmap.HashMap_string.String_int* %tmp1747
    %tmp1748 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i64 0, i64 0
    %tmp1749 = insertvalue { i8*, i64 } undef, i8* %tmp1748, 0
    %tmp1750 = insertvalue { i8*, i64 } %tmp1749, i64 5, 1
    %tmp1751 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp1750)
    call void @"hashmap.HashMap_string.String_int.operator_index_set"(%class.hashmap.HashMap_string.String_int* %tmp1747, %class.string.String %tmp1751, i64 42)
    %tmp1752 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1, i64 0, i64 0
    %tmp1753 = insertvalue { i8*, i64 } undef, i8* %tmp1752, 0
    %tmp1754 = insertvalue { i8*, i64 } %tmp1753, i64 5, 1
    %tmp1755 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp1754)
    call void @"hashmap.HashMap_string.String_int.operator_index_set"(%class.hashmap.HashMap_string.String_int* %tmp1747, %class.string.String %tmp1755, i64 100)
    %tmp1756 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.2, i64 0, i64 0
    %tmp1757 = insertvalue { i8*, i64 } undef, i8* %tmp1756, 0
    %tmp1758 = insertvalue { i8*, i64 } %tmp1757, i64 5, 1
    %tmp1759 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp1758)
    call void @"hashmap.HashMap_string.String_int.operator_index_set"(%class.hashmap.HashMap_string.String_int* %tmp1747, %class.string.String %tmp1759, i64 999)
    %tmp1760 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1747
    %tmp1761 = call i64 @"hashmap.HashMap_string.String_int.length"(%class.hashmap.HashMap_string.String_int* %tmp1747)
    %tmp1762 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1747
    %tmp1763 = call i64 @"hashmap.HashMap_string.String_int.length"(%class.hashmap.HashMap_string.String_int* %tmp1747)
    %tmp1764 = icmp ne i64 %tmp1763, 3
    br i1 %tmp1764, label %if_then.126, label %if_else.127
if_then.126:
    %tmp1765 = trunc i64 1 to i32
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %tmp1747)
    ret i32 %tmp1765
if_else.127:
    br label %if_end.128
if_end.128:
    %tmp1766 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.3, i64 0, i64 0
    %tmp1767 = insertvalue { i8*, i64 } undef, i8* %tmp1766, 0
    %tmp1768 = insertvalue { i8*, i64 } %tmp1767, i64 5, 1
    %tmp1769 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp1768)
    %tmp1770 = alloca %class.string.String
    store %class.string.String %tmp1769, %class.string.String* %tmp1770
    %tmp1771 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1747
    %tmp1772 = call i64* @"hashmap.HashMap_string.String_int.get"(%class.hashmap.HashMap_string.String_int* %tmp1747, %class.string.String* %tmp1770)
    %tmp1773 = alloca i64*
    store i64* %tmp1772, i64** %tmp1773
    %tmp1774 = load i64*, i64** %tmp1773
    %tmp1775 = load i64*, i64** %tmp1773
    %tmp1776 = icmp ne i64* %tmp1775, null
    br i1 %tmp1776, label %if_then.129, label %if_else.130
if_then.129:
    %tmp1777 = load i64*, i64** %tmp1773
    %tmp1778 = load i64*, i64** %tmp1773
    %tmp1779 = load i64, i64* %tmp1778
    %tmp1780 = load i64*, i64** %tmp1773
    %tmp1781 = load i64, i64* %tmp1780
    %tmp1782 = icmp ne i64 %tmp1781, 42
    br i1 %tmp1782, label %if_then.132, label %if_else.133
if_then.132:
    %tmp1783 = trunc i64 3 to i32
    call void @"string.String.destroy"(%class.string.String* %tmp1770)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %tmp1747)
    ret i32 %tmp1783
if_else.133:
    br label %if_end.134
if_end.134:
    br label %if_end.131
if_else.130:
    %tmp1784 = trunc i64 2 to i32
    call void @"string.String.destroy"(%class.string.String* %tmp1770)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %tmp1747)
    ret i32 %tmp1784
if_end.131:
    %tmp1785 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.4, i64 0, i64 0
    %tmp1786 = insertvalue { i8*, i64 } undef, i8* %tmp1785, 0
    %tmp1787 = insertvalue { i8*, i64 } %tmp1786, i64 5, 1
    %tmp1788 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp1787)
    %tmp1789 = alloca %class.string.String
    store %class.string.String %tmp1788, %class.string.String* %tmp1789
    %tmp1790 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1747
    %tmp1791 = call i64* @"hashmap.HashMap_string.String_int.get"(%class.hashmap.HashMap_string.String_int* %tmp1747, %class.string.String* %tmp1789)
    %tmp1792 = alloca i64*
    store i64* %tmp1791, i64** %tmp1792
    %tmp1793 = load i64*, i64** %tmp1792
    %tmp1794 = load i64*, i64** %tmp1792
    %tmp1795 = icmp ne i64* %tmp1794, null
    br i1 %tmp1795, label %if_then.135, label %if_else.136
if_then.135:
    %tmp1796 = load i64*, i64** %tmp1792
    %tmp1797 = load i64*, i64** %tmp1792
    %tmp1798 = load i64, i64* %tmp1797
    %tmp1799 = load i64*, i64** %tmp1792
    %tmp1800 = load i64, i64* %tmp1799
    %tmp1801 = icmp ne i64 %tmp1800, 100
    br i1 %tmp1801, label %if_then.138, label %if_else.139
if_then.138:
    %tmp1802 = trunc i64 4 to i32
    call void @"string.String.destroy"(%class.string.String* %tmp1789)
    call void @"string.String.destroy"(%class.string.String* %tmp1770)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %tmp1747)
    ret i32 %tmp1802
if_else.139:
    br label %if_end.140
if_end.140:
    br label %if_end.137
if_else.136:
    %tmp1803 = trunc i64 4 to i32
    call void @"string.String.destroy"(%class.string.String* %tmp1789)
    call void @"string.String.destroy"(%class.string.String* %tmp1770)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %tmp1747)
    ret i32 %tmp1803
if_end.137:
    %tmp1804 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.5, i64 0, i64 0
    %tmp1805 = insertvalue { i8*, i64 } undef, i8* %tmp1804, 0
    %tmp1806 = insertvalue { i8*, i64 } %tmp1805, i64 5, 1
    %tmp1807 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp1806)
    %tmp1808 = alloca %class.string.String
    store %class.string.String %tmp1807, %class.string.String* %tmp1808
    %tmp1809 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1747
    %tmp1810 = call i1 @"hashmap.HashMap_string.String_int.contains"(%class.hashmap.HashMap_string.String_int* %tmp1747, %class.string.String* %tmp1808)
    %tmp1811 = xor i1 %tmp1810, true
    br i1 %tmp1811, label %if_then.141, label %if_else.142
if_then.141:
    %tmp1812 = trunc i64 5 to i32
    call void @"string.String.destroy"(%class.string.String* %tmp1808)
    call void @"string.String.destroy"(%class.string.String* %tmp1789)
    call void @"string.String.destroy"(%class.string.String* %tmp1770)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %tmp1747)
    ret i32 %tmp1812
if_else.142:
    br label %if_end.143
if_end.143:
    %tmp1813 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1747
    %tmp1814 = call i1 @"hashmap.HashMap_string.String_int.remove"(%class.hashmap.HashMap_string.String_int* %tmp1747, %class.string.String* %tmp1789)
    %tmp1815 = alloca i1
    store i1 %tmp1814, i1* %tmp1815
    %tmp1816 = load i1, i1* %tmp1815
    %tmp1817 = xor i1 %tmp1816, true
    br i1 %tmp1817, label %if_then.144, label %if_else.145
if_then.144:
    %tmp1818 = trunc i64 6 to i32
    call void @"string.String.destroy"(%class.string.String* %tmp1808)
    call void @"string.String.destroy"(%class.string.String* %tmp1789)
    call void @"string.String.destroy"(%class.string.String* %tmp1770)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %tmp1747)
    ret i32 %tmp1818
if_else.145:
    br label %if_end.146
if_end.146:
    %tmp1819 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1747
    %tmp1820 = call i64 @"hashmap.HashMap_string.String_int.length"(%class.hashmap.HashMap_string.String_int* %tmp1747)
    %tmp1821 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1747
    %tmp1822 = call i64 @"hashmap.HashMap_string.String_int.length"(%class.hashmap.HashMap_string.String_int* %tmp1747)
    %tmp1823 = icmp ne i64 %tmp1822, 2
    br i1 %tmp1823, label %if_then.147, label %if_else.148
if_then.147:
    %tmp1824 = trunc i64 7 to i32
    call void @"string.String.destroy"(%class.string.String* %tmp1808)
    call void @"string.String.destroy"(%class.string.String* %tmp1789)
    call void @"string.String.destroy"(%class.string.String* %tmp1770)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %tmp1747)
    ret i32 %tmp1824
if_else.148:
    br label %if_end.149
if_end.149:
    %tmp1825 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1747
    %tmp1826 = call i1 @"hashmap.HashMap_string.String_int.contains"(%class.hashmap.HashMap_string.String_int* %tmp1747, %class.string.String* %tmp1789)
    br i1 %tmp1826, label %if_then.150, label %if_else.151
if_then.150:
    %tmp1827 = trunc i64 8 to i32
    call void @"string.String.destroy"(%class.string.String* %tmp1808)
    call void @"string.String.destroy"(%class.string.String* %tmp1789)
    call void @"string.String.destroy"(%class.string.String* %tmp1770)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %tmp1747)
    ret i32 %tmp1827
if_else.151:
    br label %if_end.152
if_end.152:
    %tmp1828 = trunc i64 0 to i32
    call void @"string.String.destroy"(%class.string.String* %tmp1808)
    call void @"string.String.destroy"(%class.string.String* %tmp1789)
    call void @"string.String.destroy"(%class.string.String* %tmp1770)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %tmp1747)
    ret i32 %tmp1828
}


@.str.0 = private unnamed_addr constant [6 x i8] c"hello\00"
@.str.1 = private unnamed_addr constant [6 x i8] c"world\00"
@.str.2 = private unnamed_addr constant [6 x i8] c"atlas\00"
@.str.3 = private unnamed_addr constant [6 x i8] c"hello\00"
@.str.4 = private unnamed_addr constant [6 x i8] c"world\00"
@.str.5 = private unnamed_addr constant [6 x i8] c"atlas\00"
