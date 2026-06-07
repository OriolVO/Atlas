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
    ret void
}

define %class.hashmap.HashMapEntry_string.String_int @"hashmap.HashMapEntry_string.String_int.clone"(%class.hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %tmp0 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %self
    ret %class.hashmap.HashMapEntry_string.String_int %tmp0
}

define void @"array.Array_hashmap.HashMapEntry_string.String_int.init"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %tmp325 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp325
    %tmp326 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp325
    %tmp327 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp326, i32 0, i32 1
    store i64 0, i64* %tmp327
    %tmp328 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp325
    %tmp329 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp328, i32 0, i32 2
    store i64 0, i64* %tmp329
    %tmp330 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp325
    %tmp331 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp330, i32 0, i32 0
    store %class.hashmap.HashMapEntry_string.String_int* null, %class.hashmap.HashMapEntry_string.String_int** %tmp331
    ret void
}

define i64 @"array.Array_hashmap.HashMapEntry_string.String_int.length"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %tmp332 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp332
    %tmp333 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp332
    %tmp334 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp333
    %tmp335 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp332
    %tmp336 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp335, i32 0, i32 1
    %tmp337 = load i64, i64* %tmp336
    ret i64 %tmp337
}

define i64 @"array.Array_hashmap.HashMapEntry_string.String_int.capacity"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %tmp338 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp338
    %tmp339 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp338
    %tmp340 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp339
    %tmp341 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp338
    %tmp342 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp341, i32 0, i32 2
    %tmp343 = load i64, i64* %tmp342
    ret i64 %tmp343
}

define void @"array.Array_hashmap.HashMapEntry_string.String_int.push"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.hashmap.HashMapEntry_string.String_int %item) {
entry:
    %tmp344 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp345 = alloca %class.hashmap.HashMapEntry_string.String_int
    store %class.hashmap.HashMapEntry_string.String_int %item, %class.hashmap.HashMapEntry_string.String_int* %tmp345
    %tmp346 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp347 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp346, i32 0, i32 1
    %tmp348 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp349 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp348
    %tmp350 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp351 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp350, i32 0, i32 1
    %tmp352 = load i64, i64* %tmp351
    %tmp353 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp354 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp353
    %tmp355 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp356 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp355, i32 0, i32 1
    %tmp357 = load i64, i64* %tmp356
    %tmp358 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp359 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp358
    %tmp360 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp361 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp360, i32 0, i32 2
    %tmp362 = load i64, i64* %tmp361
    %tmp363 = icmp eq i64 %tmp357, %tmp362
    br i1 %tmp363, label %if_then.30, label %if_else.31
if_then.30:
    %tmp364 = alloca i64
    store i64 4, i64* %tmp364
    %tmp365 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp366 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp365, i32 0, i32 2
    %tmp367 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp368 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp367
    %tmp369 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp370 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp369, i32 0, i32 2
    %tmp371 = load i64, i64* %tmp370
    %tmp372 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp373 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp372
    %tmp374 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp375 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp374, i32 0, i32 2
    %tmp376 = load i64, i64* %tmp375
    %tmp377 = icmp sgt i64 %tmp376, 0
    br i1 %tmp377, label %if_then.33, label %if_else.34
if_then.33:
    %tmp378 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp379 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp378, i32 0, i32 2
    %tmp380 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp381 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp380
    %tmp382 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp383 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp382, i32 0, i32 2
    %tmp384 = load i64, i64* %tmp383
    %tmp385 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp386 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp385
    %tmp387 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp388 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp387, i32 0, i32 2
    %tmp389 = load i64, i64* %tmp388
    %tmp390 = mul i64 %tmp389, 2
    store i64 %tmp390, i64* %tmp364
    br label %if_end.35
if_else.34:
    br label %if_end.35
if_end.35:
    %tmp391 = load i64, i64* %tmp364
    %tmp392 = load i64, i64* %tmp364
    %tmp393 = mul i64 %tmp392, 32
    %tmp394 = call i8* @"malloc"(i64 %tmp393)
    %tmp395 = bitcast i8* %tmp394 to %class.hashmap.HashMapEntry_string.String_int*
    %tmp396 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp395, %class.hashmap.HashMapEntry_string.String_int** %tmp396
    %tmp397 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp398 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp397, i32 0, i32 0
    %tmp399 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp400 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp399
    %tmp401 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp402 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp401, i32 0, i32 0
    %tmp403 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp402
    %tmp404 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp405 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp404
    %tmp406 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp407 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp406, i32 0, i32 0
    %tmp408 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp407
    %tmp409 = icmp ne %class.hashmap.HashMapEntry_string.String_int* %tmp408, null
    br i1 %tmp409, label %if_then.36, label %if_else.37
if_then.36:
    %tmp410 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp396
    %tmp411 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp410 to i8*
    %tmp412 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp413 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp412
    %tmp414 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp415 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp414, i32 0, i32 0
    %tmp416 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp415
    %tmp417 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp416 to i8*
    %tmp418 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp419 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp418, i32 0, i32 1
    %tmp420 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp421 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp420
    %tmp422 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp423 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp422, i32 0, i32 1
    %tmp424 = load i64, i64* %tmp423
    %tmp425 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp426 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp425
    %tmp427 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp428 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp427, i32 0, i32 1
    %tmp429 = load i64, i64* %tmp428
    %tmp430 = mul i64 %tmp429, 32
    %tmp431 = call i8* @"memcpy"(i8* %tmp411, i8* %tmp417, i64 %tmp430)
    %tmp432 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp433 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp432
    %tmp434 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp435 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp434, i32 0, i32 0
    %tmp436 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp435
    %tmp437 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp436 to i8*
    call void @"free"(i8* %tmp437)
    br label %if_end.38
if_else.37:
    br label %if_end.38
if_end.38:
    %tmp438 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp439 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp438, i32 0, i32 2
    %tmp440 = load i64, i64* %tmp364
    store i64 %tmp440, i64* %tmp439
    %tmp441 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp442 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp441, i32 0, i32 0
    %tmp443 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp396
    store %class.hashmap.HashMapEntry_string.String_int* %tmp443, %class.hashmap.HashMapEntry_string.String_int** %tmp442
    br label %if_end.32
if_else.31:
    br label %if_end.32
if_end.32:
    %tmp444 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp445 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp444
    %tmp446 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp447 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp446, i32 0, i32 1
    %tmp448 = load i64, i64* %tmp447
    %tmp449 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp450 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp449, i32 0, i32 0
    %tmp451 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp452 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp451
    %tmp453 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp454 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp453, i32 0, i32 0
    %tmp455 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp454
    %tmp456 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp455, i64 %tmp448
    %tmp457 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp456 to i8*
    %tmp458 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp345 to i8*
    %tmp459 = call i8* @"memcpy"(i8* %tmp457, i8* %tmp458, i64 32)
    %tmp460 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp461 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp460, i32 0, i32 1
    %tmp462 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp463 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp462, i32 0, i32 1
    %tmp464 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp465 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp464
    %tmp466 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp467 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp466, i32 0, i32 1
    %tmp468 = load i64, i64* %tmp467
    %tmp469 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp470 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp469
    %tmp471 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp344
    %tmp472 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp471, i32 0, i32 1
    %tmp473 = load i64, i64* %tmp472
    %tmp474 = add i64 %tmp473, 1
    store i64 %tmp474, i64* %tmp461
    ret void
}

define %class.hashmap.HashMapEntry_string.String_int @"array.Array_hashmap.HashMapEntry_string.String_int.pop"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %tmp475 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp475
    %tmp476 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp475
    %tmp477 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp476, i32 0, i32 1
    %tmp478 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp475
    %tmp479 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp478
    %tmp480 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp475
    %tmp481 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp480, i32 0, i32 1
    %tmp482 = load i64, i64* %tmp481
    %tmp483 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp475
    %tmp484 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp483
    %tmp485 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp475
    %tmp486 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp485, i32 0, i32 1
    %tmp487 = load i64, i64* %tmp486
    %tmp488 = icmp eq i64 %tmp487, 0
    br i1 %tmp488, label %if_then.39, label %if_else.40
if_then.39:
    %tmp489 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp489)
    br label %if_end.41
if_else.40:
    br label %if_end.41
if_end.41:
    %tmp490 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp475
    %tmp491 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp490, i32 0, i32 1
    %tmp492 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp475
    %tmp493 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp492, i32 0, i32 1
    %tmp494 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp475
    %tmp495 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp494
    %tmp496 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp475
    %tmp497 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp496, i32 0, i32 1
    %tmp498 = load i64, i64* %tmp497
    %tmp499 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp475
    %tmp500 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp499
    %tmp501 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp475
    %tmp502 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp501, i32 0, i32 1
    %tmp503 = load i64, i64* %tmp502
    %tmp504 = sub i64 %tmp503, 1
    store i64 %tmp504, i64* %tmp491
    %tmp505 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp475
    %tmp506 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp505, i32 0, i32 0
    %tmp507 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp475
    %tmp508 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp507
    %tmp509 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp475
    %tmp510 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp509, i32 0, i32 0
    %tmp511 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp510
    %tmp512 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp475
    %tmp513 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp512
    %tmp514 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp475
    %tmp515 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp514, i32 0, i32 1
    %tmp516 = load i64, i64* %tmp515
    %tmp517 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp475
    %tmp518 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp517, i32 0, i32 0
    %tmp519 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp475
    %tmp520 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp519
    %tmp521 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp475
    %tmp522 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp521, i32 0, i32 0
    %tmp523 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp522
    %tmp524 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp523, i64 %tmp516
    %tmp525 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp524
    ret %class.hashmap.HashMapEntry_string.String_int %tmp525
}

define %class.hashmap.HashMapEntry_string.String_int @"array.Array_hashmap.HashMapEntry_string.String_int.operator_index"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self, i64 %index) {
entry:
    %tmp526 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp526
    %tmp527 = alloca i64
    store i64 %index, i64* %tmp527
    %tmp528 = load i64, i64* %tmp527
    %tmp529 = load i64, i64* %tmp527
    %tmp530 = icmp slt i64 %tmp529, 0
    %tmp531 = load i64, i64* %tmp527
    %tmp532 = load i64, i64* %tmp527
    %tmp533 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp526
    %tmp534 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp533
    %tmp535 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp526
    %tmp536 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp535, i32 0, i32 1
    %tmp537 = load i64, i64* %tmp536
    %tmp538 = icmp sge i64 %tmp532, %tmp537
    %tmp539 = or i1 %tmp530, %tmp538
    br i1 %tmp539, label %if_then.42, label %if_else.43
if_then.42:
    %tmp540 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp540)
    br label %if_end.44
if_else.43:
    br label %if_end.44
if_end.44:
    %tmp541 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp526
    %tmp542 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp541, i32 0, i32 0
    %tmp543 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp526
    %tmp544 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp543
    %tmp545 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp526
    %tmp546 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp545, i32 0, i32 0
    %tmp547 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp546
    %tmp548 = load i64, i64* %tmp527
    %tmp549 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp526
    %tmp550 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp549, i32 0, i32 0
    %tmp551 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp526
    %tmp552 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp551
    %tmp553 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp526
    %tmp554 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp553, i32 0, i32 0
    %tmp555 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp554
    %tmp556 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp555, i64 %tmp548
    %tmp557 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp556
    ret %class.hashmap.HashMapEntry_string.String_int %tmp557
}

define void @"array.Array_hashmap.HashMapEntry_string.String_int.operator_index_set"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self, i64 %index, %class.hashmap.HashMapEntry_string.String_int %item) {
entry:
    %tmp558 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp558
    %tmp559 = alloca i64
    store i64 %index, i64* %tmp559
    %tmp560 = alloca %class.hashmap.HashMapEntry_string.String_int
    store %class.hashmap.HashMapEntry_string.String_int %item, %class.hashmap.HashMapEntry_string.String_int* %tmp560
    %tmp561 = load i64, i64* %tmp559
    %tmp562 = load i64, i64* %tmp559
    %tmp563 = icmp slt i64 %tmp562, 0
    %tmp564 = load i64, i64* %tmp559
    %tmp565 = load i64, i64* %tmp559
    %tmp566 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp558
    %tmp567 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp566
    %tmp568 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp558
    %tmp569 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp568, i32 0, i32 1
    %tmp570 = load i64, i64* %tmp569
    %tmp571 = icmp sge i64 %tmp565, %tmp570
    %tmp572 = or i1 %tmp563, %tmp571
    br i1 %tmp572, label %if_then.45, label %if_else.46
if_then.45:
    %tmp573 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp573)
    br label %if_end.47
if_else.46:
    br label %if_end.47
if_end.47:
    %tmp574 = load i64, i64* %tmp559
    %tmp575 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp558
    %tmp576 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp575, i32 0, i32 0
    %tmp577 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp558
    %tmp578 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp577
    %tmp579 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp558
    %tmp580 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp579, i32 0, i32 0
    %tmp581 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp580
    %tmp582 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp581, i64 %tmp574
    call void @"hashmap.HashMapEntry_string.String_int.destroy"(%class.hashmap.HashMapEntry_string.String_int* %tmp582)
    %tmp583 = load i64, i64* %tmp559
    %tmp584 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp558
    %tmp585 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp584, i32 0, i32 0
    %tmp586 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp558
    %tmp587 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp586
    %tmp588 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp558
    %tmp589 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp588, i32 0, i32 0
    %tmp590 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp589
    %tmp591 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp590, i64 %tmp583
    %tmp592 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp591 to i8*
    %tmp593 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp560 to i8*
    %tmp594 = call i8* @"memcpy"(i8* %tmp592, i8* %tmp593, i64 32)
    ret void
}

define void @"array.Array_hashmap.HashMapEntry_string.String_int.insert"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self, i64 %index, %class.hashmap.HashMapEntry_string.String_int %item) {
entry:
    %tmp595 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp596 = alloca i64
    store i64 %index, i64* %tmp596
    %tmp597 = alloca %class.hashmap.HashMapEntry_string.String_int
    store %class.hashmap.HashMapEntry_string.String_int %item, %class.hashmap.HashMapEntry_string.String_int* %tmp597
    %tmp598 = load i64, i64* %tmp596
    %tmp599 = load i64, i64* %tmp596
    %tmp600 = icmp slt i64 %tmp599, 0
    %tmp601 = load i64, i64* %tmp596
    %tmp602 = load i64, i64* %tmp596
    %tmp603 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp604 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp603
    %tmp605 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp606 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp605, i32 0, i32 1
    %tmp607 = load i64, i64* %tmp606
    %tmp608 = icmp sgt i64 %tmp602, %tmp607
    %tmp609 = or i1 %tmp600, %tmp608
    br i1 %tmp609, label %if_then.48, label %if_else.49
if_then.48:
    %tmp610 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp610)
    br label %if_end.50
if_else.49:
    br label %if_end.50
if_end.50:
    %tmp611 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp612 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp611, i32 0, i32 1
    %tmp613 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp614 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp613
    %tmp615 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp616 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp615, i32 0, i32 1
    %tmp617 = load i64, i64* %tmp616
    %tmp618 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp619 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp618
    %tmp620 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp621 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp620, i32 0, i32 1
    %tmp622 = load i64, i64* %tmp621
    %tmp623 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp624 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp623
    %tmp625 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp626 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp625, i32 0, i32 2
    %tmp627 = load i64, i64* %tmp626
    %tmp628 = icmp eq i64 %tmp622, %tmp627
    br i1 %tmp628, label %if_then.51, label %if_else.52
if_then.51:
    %tmp629 = alloca i64
    store i64 4, i64* %tmp629
    %tmp630 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp631 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp630, i32 0, i32 2
    %tmp632 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp633 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp632
    %tmp634 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp635 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp634, i32 0, i32 2
    %tmp636 = load i64, i64* %tmp635
    %tmp637 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp638 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp637
    %tmp639 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp640 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp639, i32 0, i32 2
    %tmp641 = load i64, i64* %tmp640
    %tmp642 = icmp sgt i64 %tmp641, 0
    br i1 %tmp642, label %if_then.54, label %if_else.55
if_then.54:
    %tmp643 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp644 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp643, i32 0, i32 2
    %tmp645 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp646 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp645
    %tmp647 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp648 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp647, i32 0, i32 2
    %tmp649 = load i64, i64* %tmp648
    %tmp650 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp651 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp650
    %tmp652 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp653 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp652, i32 0, i32 2
    %tmp654 = load i64, i64* %tmp653
    %tmp655 = mul i64 %tmp654, 2
    store i64 %tmp655, i64* %tmp629
    br label %if_end.56
if_else.55:
    br label %if_end.56
if_end.56:
    %tmp656 = load i64, i64* %tmp629
    %tmp657 = load i64, i64* %tmp629
    %tmp658 = mul i64 %tmp657, 32
    %tmp659 = call i8* @"malloc"(i64 %tmp658)
    %tmp660 = bitcast i8* %tmp659 to %class.hashmap.HashMapEntry_string.String_int*
    %tmp661 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp660, %class.hashmap.HashMapEntry_string.String_int** %tmp661
    %tmp662 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp663 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp662, i32 0, i32 0
    %tmp664 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp665 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp664
    %tmp666 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp667 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp666, i32 0, i32 0
    %tmp668 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp667
    %tmp669 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp670 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp669
    %tmp671 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp672 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp671, i32 0, i32 0
    %tmp673 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp672
    %tmp674 = icmp ne %class.hashmap.HashMapEntry_string.String_int* %tmp673, null
    br i1 %tmp674, label %if_then.57, label %if_else.58
if_then.57:
    %tmp675 = load i64, i64* %tmp596
    %tmp676 = load i64, i64* %tmp596
    %tmp677 = icmp sgt i64 %tmp676, 0
    br i1 %tmp677, label %if_then.60, label %if_else.61
if_then.60:
    %tmp678 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp661
    %tmp679 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp678 to i8*
    %tmp680 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp681 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp680
    %tmp682 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp683 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp682, i32 0, i32 0
    %tmp684 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp683
    %tmp685 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp684 to i8*
    %tmp686 = load i64, i64* %tmp596
    %tmp687 = load i64, i64* %tmp596
    %tmp688 = mul i64 %tmp687, 32
    %tmp689 = call i8* @"memcpy"(i8* %tmp679, i8* %tmp685, i64 %tmp688)
    br label %if_end.62
if_else.61:
    br label %if_end.62
if_end.62:
    %tmp690 = load i64, i64* %tmp596
    %tmp691 = load i64, i64* %tmp596
    %tmp692 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp693 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp692
    %tmp694 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp695 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp694, i32 0, i32 1
    %tmp696 = load i64, i64* %tmp695
    %tmp697 = icmp slt i64 %tmp691, %tmp696
    br i1 %tmp697, label %if_then.63, label %if_else.64
if_then.63:
    %tmp698 = load i64, i64* %tmp596
    %tmp699 = load i64, i64* %tmp596
    %tmp700 = add i64 %tmp699, 1
    %tmp701 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp661
    %tmp702 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp701, i64 %tmp700
    %tmp703 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp702 to i8*
    %tmp704 = load i64, i64* %tmp596
    %tmp705 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp706 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp705, i32 0, i32 0
    %tmp707 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp708 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp707
    %tmp709 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp710 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp709, i32 0, i32 0
    %tmp711 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp710
    %tmp712 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp711, i64 %tmp704
    %tmp713 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp712 to i8*
    %tmp714 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp715 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp714, i32 0, i32 1
    %tmp716 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp717 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp716
    %tmp718 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp719 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp718, i32 0, i32 1
    %tmp720 = load i64, i64* %tmp719
    %tmp721 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp722 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp721
    %tmp723 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp724 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp723, i32 0, i32 1
    %tmp725 = load i64, i64* %tmp724
    %tmp726 = load i64, i64* %tmp596
    %tmp727 = sub i64 %tmp725, %tmp726
    %tmp728 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp729 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp728, i32 0, i32 1
    %tmp730 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp731 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp730
    %tmp732 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp733 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp732, i32 0, i32 1
    %tmp734 = load i64, i64* %tmp733
    %tmp735 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp736 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp735
    %tmp737 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp738 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp737, i32 0, i32 1
    %tmp739 = load i64, i64* %tmp738
    %tmp740 = load i64, i64* %tmp596
    %tmp741 = sub i64 %tmp739, %tmp740
    %tmp742 = mul i64 %tmp741, 32
    %tmp743 = call i8* @"memcpy"(i8* %tmp703, i8* %tmp713, i64 %tmp742)
    br label %if_end.65
if_else.64:
    br label %if_end.65
if_end.65:
    %tmp744 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp745 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp744
    %tmp746 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp747 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp746, i32 0, i32 0
    %tmp748 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp747
    %tmp749 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp748 to i8*
    call void @"free"(i8* %tmp749)
    br label %if_end.59
if_else.58:
    br label %if_end.59
if_end.59:
    %tmp750 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp751 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp750, i32 0, i32 2
    %tmp752 = load i64, i64* %tmp629
    store i64 %tmp752, i64* %tmp751
    %tmp753 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp754 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp753, i32 0, i32 0
    %tmp755 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp661
    store %class.hashmap.HashMapEntry_string.String_int* %tmp755, %class.hashmap.HashMapEntry_string.String_int** %tmp754
    br label %if_end.53
if_else.52:
    %tmp756 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp757 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp756
    %tmp758 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp759 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp758, i32 0, i32 1
    %tmp760 = load i64, i64* %tmp759
    %tmp761 = alloca i64
    store i64 %tmp760, i64* %tmp761
    br label %while_cond.66
while_cond.66:
    %tmp762 = load i64, i64* %tmp761
    %tmp763 = load i64, i64* %tmp761
    %tmp764 = load i64, i64* %tmp596
    %tmp765 = icmp sgt i64 %tmp763, %tmp764
    br i1 %tmp765, label %while_body.67, label %while_end.68
while_body.67:
    %tmp766 = load i64, i64* %tmp761
    %tmp767 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp768 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp767, i32 0, i32 0
    %tmp769 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp770 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp769
    %tmp771 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp772 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp771, i32 0, i32 0
    %tmp773 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp772
    %tmp774 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp773, i64 %tmp766
    %tmp775 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp774 to i8*
    %tmp776 = load i64, i64* %tmp761
    %tmp777 = load i64, i64* %tmp761
    %tmp778 = sub i64 %tmp777, 1
    %tmp779 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp780 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp779, i32 0, i32 0
    %tmp781 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp782 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp781
    %tmp783 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp784 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp783, i32 0, i32 0
    %tmp785 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp784
    %tmp786 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp785, i64 %tmp778
    %tmp787 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp786 to i8*
    %tmp788 = call i8* @"memcpy"(i8* %tmp775, i8* %tmp787, i64 32)
    %tmp789 = load i64, i64* %tmp761
    %tmp790 = load i64, i64* %tmp761
    %tmp791 = sub i64 %tmp790, 1
    store i64 %tmp791, i64* %tmp761
    br label %while_cond.66
while_end.68:
    br label %if_end.53
if_end.53:
    %tmp792 = load i64, i64* %tmp596
    %tmp793 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp794 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp793, i32 0, i32 0
    %tmp795 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp796 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp795
    %tmp797 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp798 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp797, i32 0, i32 0
    %tmp799 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp798
    %tmp800 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp799, i64 %tmp792
    %tmp801 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp800 to i8*
    %tmp802 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp597 to i8*
    %tmp803 = call i8* @"memcpy"(i8* %tmp801, i8* %tmp802, i64 32)
    %tmp804 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp805 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp804, i32 0, i32 1
    %tmp806 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp807 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp806, i32 0, i32 1
    %tmp808 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp809 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp808
    %tmp810 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp811 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp810, i32 0, i32 1
    %tmp812 = load i64, i64* %tmp811
    %tmp813 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp814 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp813
    %tmp815 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp595
    %tmp816 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp815, i32 0, i32 1
    %tmp817 = load i64, i64* %tmp816
    %tmp818 = add i64 %tmp817, 1
    store i64 %tmp818, i64* %tmp805
    ret void
}

define %class.hashmap.HashMapEntry_string.String_int @"array.Array_hashmap.HashMapEntry_string.String_int.remove"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self, i64 %index) {
entry:
    %tmp819 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp820 = alloca i64
    store i64 %index, i64* %tmp820
    %tmp821 = load i64, i64* %tmp820
    %tmp822 = load i64, i64* %tmp820
    %tmp823 = icmp slt i64 %tmp822, 0
    %tmp824 = load i64, i64* %tmp820
    %tmp825 = load i64, i64* %tmp820
    %tmp826 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp827 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp826
    %tmp828 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp829 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp828, i32 0, i32 1
    %tmp830 = load i64, i64* %tmp829
    %tmp831 = icmp sge i64 %tmp825, %tmp830
    %tmp832 = or i1 %tmp823, %tmp831
    br i1 %tmp832, label %if_then.69, label %if_else.70
if_then.69:
    %tmp833 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp833)
    br label %if_end.71
if_else.70:
    br label %if_end.71
if_end.71:
    %tmp834 = call i8* @"malloc"(i64 32)
    %tmp835 = bitcast i8* %tmp834 to %class.hashmap.HashMapEntry_string.String_int*
    %tmp836 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp835, %class.hashmap.HashMapEntry_string.String_int** %tmp836
    %tmp837 = load i64, i64* %tmp820
    %tmp838 = alloca i64
    store i64 %tmp837, i64* %tmp838
    br label %while_cond.72
while_cond.72:
    %tmp839 = load i64, i64* %tmp838
    %tmp840 = load i64, i64* %tmp838
    %tmp841 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp842 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp841, i32 0, i32 1
    %tmp843 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp844 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp843
    %tmp845 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp846 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp845, i32 0, i32 1
    %tmp847 = load i64, i64* %tmp846
    %tmp848 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp849 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp848
    %tmp850 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp851 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp850, i32 0, i32 1
    %tmp852 = load i64, i64* %tmp851
    %tmp853 = sub i64 %tmp852, 1
    %tmp854 = icmp slt i64 %tmp840, %tmp853
    br i1 %tmp854, label %while_body.73, label %while_end.74
while_body.73:
    %tmp855 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp836
    %tmp856 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp855 to i8*
    %tmp857 = load i64, i64* %tmp838
    %tmp858 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp859 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp858, i32 0, i32 0
    %tmp860 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp861 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp860
    %tmp862 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp863 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp862, i32 0, i32 0
    %tmp864 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp863
    %tmp865 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp864, i64 %tmp857
    %tmp866 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp865 to i8*
    %tmp867 = call i8* @"memcpy"(i8* %tmp856, i8* %tmp866, i64 32)
    %tmp868 = load i64, i64* %tmp838
    %tmp869 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp870 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp869, i32 0, i32 0
    %tmp871 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp872 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp871
    %tmp873 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp874 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp873, i32 0, i32 0
    %tmp875 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp874
    %tmp876 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp875, i64 %tmp868
    %tmp877 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp876 to i8*
    %tmp878 = load i64, i64* %tmp838
    %tmp879 = load i64, i64* %tmp838
    %tmp880 = add i64 %tmp879, 1
    %tmp881 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp882 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp881, i32 0, i32 0
    %tmp883 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp884 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp883
    %tmp885 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp886 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp885, i32 0, i32 0
    %tmp887 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp886
    %tmp888 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp887, i64 %tmp880
    %tmp889 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp888 to i8*
    %tmp890 = call i8* @"memcpy"(i8* %tmp877, i8* %tmp889, i64 32)
    %tmp891 = load i64, i64* %tmp838
    %tmp892 = load i64, i64* %tmp838
    %tmp893 = add i64 %tmp892, 1
    %tmp894 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp895 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp894, i32 0, i32 0
    %tmp896 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp897 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp896
    %tmp898 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp899 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp898, i32 0, i32 0
    %tmp900 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp899
    %tmp901 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp900, i64 %tmp893
    %tmp902 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp901 to i8*
    %tmp903 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp836
    %tmp904 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp903 to i8*
    %tmp905 = call i8* @"memcpy"(i8* %tmp902, i8* %tmp904, i64 32)
    %tmp906 = load i64, i64* %tmp838
    %tmp907 = load i64, i64* %tmp838
    %tmp908 = add i64 %tmp907, 1
    store i64 %tmp908, i64* %tmp838
    br label %while_cond.72
while_end.74:
    %tmp909 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp836
    %tmp910 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp909 to i8*
    call void @"free"(i8* %tmp910)
    %tmp911 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp912 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp911, i32 0, i32 1
    %tmp913 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp914 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp913, i32 0, i32 1
    %tmp915 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp916 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp915
    %tmp917 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp918 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp917, i32 0, i32 1
    %tmp919 = load i64, i64* %tmp918
    %tmp920 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp921 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp920
    %tmp922 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp923 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp922, i32 0, i32 1
    %tmp924 = load i64, i64* %tmp923
    %tmp925 = sub i64 %tmp924, 1
    store i64 %tmp925, i64* %tmp912
    %tmp926 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp927 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp926, i32 0, i32 0
    %tmp928 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp929 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp928
    %tmp930 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp931 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp930, i32 0, i32 0
    %tmp932 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp931
    %tmp933 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp934 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp933
    %tmp935 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp936 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp935, i32 0, i32 1
    %tmp937 = load i64, i64* %tmp936
    %tmp938 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp939 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp938, i32 0, i32 0
    %tmp940 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp941 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp940
    %tmp942 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp819
    %tmp943 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp942, i32 0, i32 0
    %tmp944 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp943
    %tmp945 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp944, i64 %tmp937
    %tmp946 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp945
    ret %class.hashmap.HashMapEntry_string.String_int %tmp946
}

define void @"array.Array_hashmap.HashMapEntry_string.String_int.clear"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %tmp947 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp947
    %tmp948 = alloca i64
    store i64 0, i64* %tmp948
    br label %while_cond.75
while_cond.75:
    %tmp949 = load i64, i64* %tmp948
    %tmp950 = load i64, i64* %tmp948
    %tmp951 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp947
    %tmp952 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp951
    %tmp953 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp947
    %tmp954 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp953, i32 0, i32 1
    %tmp955 = load i64, i64* %tmp954
    %tmp956 = icmp slt i64 %tmp950, %tmp955
    br i1 %tmp956, label %while_body.76, label %while_end.77
while_body.76:
    %tmp957 = load i64, i64* %tmp948
    %tmp958 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp947
    %tmp959 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp958, i32 0, i32 0
    %tmp960 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp947
    %tmp961 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp960
    %tmp962 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp947
    %tmp963 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp962, i32 0, i32 0
    %tmp964 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp963
    %tmp965 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp964, i64 %tmp957
    call void @"hashmap.HashMapEntry_string.String_int.destroy"(%class.hashmap.HashMapEntry_string.String_int* %tmp965)
    %tmp966 = load i64, i64* %tmp948
    %tmp967 = load i64, i64* %tmp948
    %tmp968 = add i64 %tmp967, 1
    store i64 %tmp968, i64* %tmp948
    br label %while_cond.75
while_end.77:
    %tmp969 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp947
    %tmp970 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp969, i32 0, i32 1
    store i64 0, i64* %tmp970
    ret void
}

define void @"array.Array_hashmap.HashMapEntry_string.String_int.destroy"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %tmp971 = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp971
    %tmp972 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp971
    %tmp973 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp972, i32 0, i32 0
    %tmp974 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp971
    %tmp975 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp974
    %tmp976 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp971
    %tmp977 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp976, i32 0, i32 0
    %tmp978 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp977
    %tmp979 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp971
    %tmp980 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp979
    %tmp981 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp971
    %tmp982 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp981, i32 0, i32 0
    %tmp983 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp982
    %tmp984 = icmp ne %class.hashmap.HashMapEntry_string.String_int* %tmp983, null
    br i1 %tmp984, label %if_then.78, label %if_else.79
if_then.78:
    %tmp985 = alloca i64
    store i64 0, i64* %tmp985
    br label %while_cond.81
while_cond.81:
    %tmp986 = load i64, i64* %tmp985
    %tmp987 = load i64, i64* %tmp985
    %tmp988 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp971
    %tmp989 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp988
    %tmp990 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp971
    %tmp991 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp990, i32 0, i32 1
    %tmp992 = load i64, i64* %tmp991
    %tmp993 = icmp slt i64 %tmp987, %tmp992
    br i1 %tmp993, label %while_body.82, label %while_end.83
while_body.82:
    %tmp994 = load i64, i64* %tmp985
    %tmp995 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp971
    %tmp996 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp995, i32 0, i32 0
    %tmp997 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp971
    %tmp998 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp997
    %tmp999 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp971
    %tmp1000 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp999, i32 0, i32 0
    %tmp1001 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1000
    %tmp1002 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1001, i64 %tmp994
    call void @"hashmap.HashMapEntry_string.String_int.destroy"(%class.hashmap.HashMapEntry_string.String_int* %tmp1002)
    %tmp1003 = load i64, i64* %tmp985
    %tmp1004 = load i64, i64* %tmp985
    %tmp1005 = add i64 %tmp1004, 1
    store i64 %tmp1005, i64* %tmp985
    br label %while_cond.81
while_end.83:
    %tmp1006 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp971
    %tmp1007 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1006
    %tmp1008 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp971
    %tmp1009 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1008, i32 0, i32 0
    %tmp1010 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1009
    %tmp1011 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp1010 to i8*
    call void @"free"(i8* %tmp1011)
    %tmp1012 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp971
    %tmp1013 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1012, i32 0, i32 0
    store %class.hashmap.HashMapEntry_string.String_int* null, %class.hashmap.HashMapEntry_string.String_int** %tmp1013
    br label %if_end.80
if_else.79:
    br label %if_end.80
if_end.80:
    %tmp1014 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp971
    %tmp1015 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1014, i32 0, i32 2
    store i64 0, i64* %tmp1015
    %tmp1016 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %tmp971
    %tmp1017 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1016, i32 0, i32 1
    store i64 0, i64* %tmp1017
    ret void
}

define %class.array.Array_hashmap.HashMapEntry_string.String_int @"array.Array_hashmap.HashMapEntry_string.String_int.clone"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %tmp0 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %self
    ret %class.array.Array_hashmap.HashMapEntry_string.String_int %tmp0
}

define void @"hashmap.HashMap_string.String_int.init"(%class.hashmap.HashMap_string.String_int* %self) {
entry:
    %tmp1018 = alloca %class.hashmap.HashMap_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %tmp1018
    %tmp1019 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1018
    %tmp1020 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1019, i32 0, i32 1
    store i64 0, i64* %tmp1020
    %tmp1021 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1018
    %tmp1022 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1021, i32 0, i32 2
    store i64 16, i64* %tmp1022
    %tmp1023 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1018
    %tmp1024 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1023
    %tmp1025 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1018
    %tmp1026 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1025, i32 0, i32 0
    %tmp1027 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1026
    %tmp1028 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1018
    %tmp1029 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1028, i32 0, i32 0
    call void @"array.Array_hashmap.HashMapEntry_string.String_int.init"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1029)
    %tmp1030 = alloca i64
    store i64 0, i64* %tmp1030
    br label %while_cond.84
while_cond.84:
    %tmp1031 = load i64, i64* %tmp1030
    %tmp1032 = load i64, i64* %tmp1030
    %tmp1033 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1018
    %tmp1034 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1033
    %tmp1035 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1018
    %tmp1036 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1035, i32 0, i32 2
    %tmp1037 = load i64, i64* %tmp1036
    %tmp1038 = icmp slt i64 %tmp1032, %tmp1037
    br i1 %tmp1038, label %while_body.85, label %while_end.86
while_body.85:
    %tmp1039 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1018
    %tmp1040 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1039
    %tmp1041 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1018
    %tmp1042 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1041, i32 0, i32 0
    %tmp1043 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1042
    %tmp1044 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1018
    %tmp1045 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1044, i32 0, i32 0
    %tmp1046 = alloca %class.hashmap.HashMapEntry_string.String_int
    store %class.hashmap.HashMapEntry_string.String_int zeroinitializer, %class.hashmap.HashMapEntry_string.String_int* %tmp1046
    call void @"hashmap.HashMapEntry_string.String_int.init"(%class.hashmap.HashMapEntry_string.String_int* %tmp1046)
    %tmp1047 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1046
    call void @"array.Array_hashmap.HashMapEntry_string.String_int.push"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1045, %class.hashmap.HashMapEntry_string.String_int %tmp1047)
    %tmp1048 = load i64, i64* %tmp1030
    %tmp1049 = load i64, i64* %tmp1030
    %tmp1050 = add i64 %tmp1049, 1
    store i64 %tmp1050, i64* %tmp1030
    br label %while_cond.84
while_end.86:
    ret void
}

define i64 @"hashmap.HashMap_string.String_int.length"(%class.hashmap.HashMap_string.String_int* %self) {
entry:
    %tmp1051 = alloca %class.hashmap.HashMap_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %tmp1051
    %tmp1052 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1051
    %tmp1053 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1052
    %tmp1054 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1051
    %tmp1055 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1054, i32 0, i32 1
    %tmp1056 = load i64, i64* %tmp1055
    ret i64 %tmp1056
}

define void @"hashmap.HashMap_string.String_int.operator_index_set"(%class.hashmap.HashMap_string.String_int* %self, %class.string.String %key, i64 %value) {
entry:
    %tmp1057 = alloca %class.hashmap.HashMap_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1058 = alloca %class.string.String
    store %class.string.String %key, %class.string.String* %tmp1058
    %tmp1059 = alloca i64
    store i64 %value, i64* %tmp1059
    %tmp1060 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1061 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1060, i32 0, i32 1
    %tmp1062 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1063 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1062
    %tmp1064 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1065 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1064, i32 0, i32 1
    %tmp1066 = load i64, i64* %tmp1065
    %tmp1067 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1068 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1067
    %tmp1069 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1070 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1069, i32 0, i32 1
    %tmp1071 = load i64, i64* %tmp1070
    %tmp1072 = mul i64 %tmp1071, 100
    %tmp1073 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1074 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1073, i32 0, i32 1
    %tmp1075 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1076 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1075
    %tmp1077 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1078 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1077, i32 0, i32 1
    %tmp1079 = load i64, i64* %tmp1078
    %tmp1080 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1081 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1080
    %tmp1082 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1083 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1082, i32 0, i32 1
    %tmp1084 = load i64, i64* %tmp1083
    %tmp1085 = mul i64 %tmp1084, 100
    %tmp1086 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1087 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1086, i32 0, i32 2
    %tmp1088 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1089 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1088
    %tmp1090 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1091 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1090, i32 0, i32 2
    %tmp1092 = load i64, i64* %tmp1091
    %tmp1093 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1094 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1093
    %tmp1095 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1096 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1095, i32 0, i32 2
    %tmp1097 = load i64, i64* %tmp1096
    %tmp1098 = mul i64 %tmp1097, 70
    %tmp1099 = icmp sgt i64 %tmp1085, %tmp1098
    br i1 %tmp1099, label %if_then.87, label %if_else.88
if_then.87:
    %tmp1100 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1101 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    call void @"hashmap.HashMap_string.String_int.resize"(%class.hashmap.HashMap_string.String_int* %tmp1101)
    br label %if_end.89
if_else.88:
    br label %if_end.89
if_end.89:
    %tmp1102 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1103 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1104 = call i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %tmp1103, %class.string.String* %tmp1058)
    %tmp1105 = alloca i64
    store i64 %tmp1104, i64* %tmp1105
    %tmp1106 = load i64, i64* %tmp1105
    %tmp1107 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1108 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1107, i32 0, i32 0
    %tmp1109 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1108, i32 0, i32 0
    %tmp1110 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1111 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1110
    %tmp1112 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1113 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1112, i32 0, i32 0
    %tmp1114 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1113
    %tmp1115 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1116 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1115, i32 0, i32 0
    %tmp1117 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1116, i32 0, i32 0
    %tmp1118 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1117
    %tmp1119 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1118, i64 %tmp1106
    %tmp1120 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp1119, %class.hashmap.HashMapEntry_string.String_int** %tmp1120
    %tmp1121 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1120
    %tmp1122 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1121
    %tmp1123 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1120
    %tmp1124 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1123, i32 0, i32 2
    %tmp1125 = load i1, i1* %tmp1124
    %tmp1126 = xor i1 %tmp1125, true
    br i1 %tmp1126, label %if_then.90, label %if_else.91
if_then.90:
    %tmp1127 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1128 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1127, i32 0, i32 1
    %tmp1129 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1130 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1129, i32 0, i32 1
    %tmp1131 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1132 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1131
    %tmp1133 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1134 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1133, i32 0, i32 1
    %tmp1135 = load i64, i64* %tmp1134
    %tmp1136 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1137 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1136
    %tmp1138 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1057
    %tmp1139 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1138, i32 0, i32 1
    %tmp1140 = load i64, i64* %tmp1139
    %tmp1141 = add i64 %tmp1140, 1
    store i64 %tmp1141, i64* %tmp1128
    br label %if_end.92
if_else.91:
    %tmp1142 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1120
    %tmp1143 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1142, i32 0, i32 0
    call void @"string.String.destroy"(%class.string.String* %tmp1143)
    %tmp1144 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1120
    %tmp1145 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1144, i32 0, i32 1
    br label %if_end.92
if_end.92:
    %tmp1146 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1120
    %tmp1147 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1146, i32 0, i32 0
    %tmp1148 = bitcast %class.string.String* %tmp1147 to i8*
    %tmp1149 = bitcast %class.string.String* %tmp1058 to i8*
    %tmp1150 = call i8* @"memcpy"(i8* %tmp1148, i8* %tmp1149, i64 16)
    %tmp1151 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1120
    %tmp1152 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1151, i32 0, i32 1
    %tmp1153 = bitcast i64* %tmp1152 to i8*
    %tmp1154 = bitcast i64* %tmp1059 to i8*
    %tmp1155 = call i8* @"memcpy"(i8* %tmp1153, i8* %tmp1154, i64 8)
    %tmp1156 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1120
    %tmp1157 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1156, i32 0, i32 2
    store i1 1, i1* %tmp1157
    ret void
}

define i64* @"hashmap.HashMap_string.String_int.get"(%class.hashmap.HashMap_string.String_int* %self, %class.string.String* %key) {
entry:
    %tmp1158 = alloca %class.hashmap.HashMap_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %tmp1158
    %tmp1159 = alloca %class.string.String*
    store %class.string.String* %key, %class.string.String** %tmp1159
    %tmp1160 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1158
    %tmp1161 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1158
    %tmp1162 = load %class.string.String*, %class.string.String** %tmp1159
    %tmp1163 = call i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %tmp1161, %class.string.String* %tmp1162)
    %tmp1164 = alloca i64
    store i64 %tmp1163, i64* %tmp1164
    %tmp1165 = load i64, i64* %tmp1164
    %tmp1166 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1158
    %tmp1167 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1166, i32 0, i32 0
    %tmp1168 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1167, i32 0, i32 0
    %tmp1169 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1158
    %tmp1170 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1169
    %tmp1171 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1158
    %tmp1172 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1171, i32 0, i32 0
    %tmp1173 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1172
    %tmp1174 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1158
    %tmp1175 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1174, i32 0, i32 0
    %tmp1176 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1175, i32 0, i32 0
    %tmp1177 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1176
    %tmp1178 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1177, i64 %tmp1165
    %tmp1179 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp1178, %class.hashmap.HashMapEntry_string.String_int** %tmp1179
    %tmp1180 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1179
    %tmp1181 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1180
    %tmp1182 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1179
    %tmp1183 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1182, i32 0, i32 2
    %tmp1184 = load i1, i1* %tmp1183
    br i1 %tmp1184, label %if_then.93, label %if_else.94
if_then.93:
    %tmp1185 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1179
    %tmp1186 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1185, i32 0, i32 1
    ret i64* %tmp1186
if_else.94:
    br label %if_end.95
if_end.95:
    ret i64* null
}

define i1 @"hashmap.HashMap_string.String_int.contains"(%class.hashmap.HashMap_string.String_int* %self, %class.string.String* %key) {
entry:
    %tmp1187 = alloca %class.hashmap.HashMap_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %tmp1187
    %tmp1188 = alloca %class.string.String*
    store %class.string.String* %key, %class.string.String** %tmp1188
    %tmp1189 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1187
    %tmp1190 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1187
    %tmp1191 = load %class.string.String*, %class.string.String** %tmp1188
    %tmp1192 = call i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %tmp1190, %class.string.String* %tmp1191)
    %tmp1193 = alloca i64
    store i64 %tmp1192, i64* %tmp1193
    %tmp1194 = load i64, i64* %tmp1193
    %tmp1195 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1187
    %tmp1196 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1195, i32 0, i32 0
    %tmp1197 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1196, i32 0, i32 0
    %tmp1198 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1187
    %tmp1199 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1198
    %tmp1200 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1187
    %tmp1201 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1200, i32 0, i32 0
    %tmp1202 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1201
    %tmp1203 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1187
    %tmp1204 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1203, i32 0, i32 0
    %tmp1205 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1204, i32 0, i32 0
    %tmp1206 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1205
    %tmp1207 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1206, i64 %tmp1194
    %tmp1208 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp1207, %class.hashmap.HashMapEntry_string.String_int** %tmp1208
    %tmp1209 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1208
    %tmp1210 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1209
    %tmp1211 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1208
    %tmp1212 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1211, i32 0, i32 2
    %tmp1213 = load i1, i1* %tmp1212
    ret i1 %tmp1213
}

define i1 @"hashmap.HashMap_string.String_int.remove"(%class.hashmap.HashMap_string.String_int* %self, %class.string.String* %key) {
entry:
    %tmp1214 = alloca %class.hashmap.HashMap_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1215 = alloca %class.string.String*
    store %class.string.String* %key, %class.string.String** %tmp1215
    %tmp1216 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1217 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1218 = load %class.string.String*, %class.string.String** %tmp1215
    %tmp1219 = call i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %tmp1217, %class.string.String* %tmp1218)
    %tmp1220 = alloca i64
    store i64 %tmp1219, i64* %tmp1220
    %tmp1221 = load i64, i64* %tmp1220
    %tmp1222 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1223 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1222, i32 0, i32 0
    %tmp1224 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1223, i32 0, i32 0
    %tmp1225 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1226 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1225
    %tmp1227 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1228 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1227, i32 0, i32 0
    %tmp1229 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1228
    %tmp1230 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1231 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1230, i32 0, i32 0
    %tmp1232 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1231, i32 0, i32 0
    %tmp1233 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1232
    %tmp1234 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1233, i64 %tmp1221
    %tmp1235 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp1234, %class.hashmap.HashMapEntry_string.String_int** %tmp1235
    %tmp1236 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1235
    %tmp1237 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1236
    %tmp1238 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1235
    %tmp1239 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1238, i32 0, i32 2
    %tmp1240 = load i1, i1* %tmp1239
    br i1 %tmp1240, label %if_then.96, label %if_else.97
if_then.96:
    %tmp1241 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1235
    %tmp1242 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1241, i32 0, i32 0
    call void @"string.String.destroy"(%class.string.String* %tmp1242)
    %tmp1243 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1235
    %tmp1244 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1243, i32 0, i32 1
    %tmp1245 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1235
    %tmp1246 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1245, i32 0, i32 2
    store i1 0, i1* %tmp1246
    %tmp1247 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1248 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1247, i32 0, i32 1
    %tmp1249 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1250 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1249, i32 0, i32 1
    %tmp1251 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1252 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1251
    %tmp1253 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1254 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1253, i32 0, i32 1
    %tmp1255 = load i64, i64* %tmp1254
    %tmp1256 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1257 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1256
    %tmp1258 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1259 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1258, i32 0, i32 1
    %tmp1260 = load i64, i64* %tmp1259
    %tmp1261 = sub i64 %tmp1260, 1
    store i64 %tmp1261, i64* %tmp1248
    %tmp1262 = load i64, i64* %tmp1220
    %tmp1263 = load i64, i64* %tmp1220
    %tmp1264 = add i64 %tmp1263, 1
    %tmp1265 = load i64, i64* %tmp1220
    %tmp1266 = load i64, i64* %tmp1220
    %tmp1267 = add i64 %tmp1266, 1
    %tmp1268 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1269 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1268
    %tmp1270 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1271 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1270, i32 0, i32 2
    %tmp1272 = load i64, i64* %tmp1271
    %tmp1273 = srem i64 %tmp1267, %tmp1272
    %tmp1274 = alloca i64
    store i64 %tmp1273, i64* %tmp1274
    br label %while_cond.99
while_cond.99:
    %tmp1275 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1276 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1275, i32 0, i32 0
    %tmp1277 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1276, i32 0, i32 0
    %tmp1278 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1279 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1278
    %tmp1280 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1281 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1280, i32 0, i32 0
    %tmp1282 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1281
    %tmp1283 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1284 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1283, i32 0, i32 0
    %tmp1285 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1284, i32 0, i32 0
    %tmp1286 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1285
    %tmp1287 = load i64, i64* %tmp1274
    %tmp1288 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1289 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1288, i32 0, i32 0
    %tmp1290 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1289, i32 0, i32 0
    %tmp1291 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1292 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1291
    %tmp1293 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1294 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1293, i32 0, i32 0
    %tmp1295 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1294
    %tmp1296 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1297 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1296, i32 0, i32 0
    %tmp1298 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1297, i32 0, i32 0
    %tmp1299 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1298
    %tmp1300 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1299, i64 %tmp1287
    %tmp1301 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1300
    %tmp1302 = load i64, i64* %tmp1274
    %tmp1303 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1304 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1303, i32 0, i32 0
    %tmp1305 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1304, i32 0, i32 0
    %tmp1306 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1307 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1306
    %tmp1308 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1309 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1308, i32 0, i32 0
    %tmp1310 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1309
    %tmp1311 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1312 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1311, i32 0, i32 0
    %tmp1313 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1312, i32 0, i32 0
    %tmp1314 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1313
    %tmp1315 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1314, i64 %tmp1302
    %tmp1316 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1315, i32 0, i32 2
    %tmp1317 = load i1, i1* %tmp1316
    br i1 %tmp1317, label %while_body.100, label %while_end.101
while_body.100:
    %tmp1318 = load i64, i64* %tmp1274
    %tmp1319 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1320 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1319, i32 0, i32 0
    %tmp1321 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1320, i32 0, i32 0
    %tmp1322 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1323 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1322
    %tmp1324 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1325 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1324, i32 0, i32 0
    %tmp1326 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1325
    %tmp1327 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1328 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1327, i32 0, i32 0
    %tmp1329 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1328, i32 0, i32 0
    %tmp1330 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1329
    %tmp1331 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1330, i64 %tmp1318
    %tmp1332 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp1331, %class.hashmap.HashMapEntry_string.String_int** %tmp1332
    %tmp1333 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1332
    %tmp1334 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1333, i32 0, i32 2
    store i1 0, i1* %tmp1334
    %tmp1335 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1336 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1335, i32 0, i32 1
    %tmp1337 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1338 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1337, i32 0, i32 1
    %tmp1339 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1340 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1339
    %tmp1341 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1342 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1341, i32 0, i32 1
    %tmp1343 = load i64, i64* %tmp1342
    %tmp1344 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1345 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1344
    %tmp1346 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1347 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1346, i32 0, i32 1
    %tmp1348 = load i64, i64* %tmp1347
    %tmp1349 = sub i64 %tmp1348, 1
    store i64 %tmp1349, i64* %tmp1336
    %tmp1350 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1351 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1352 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1332
    %tmp1353 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1352, i32 0, i32 0
    %tmp1354 = call i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %tmp1351, %class.string.String* %tmp1353)
    %tmp1355 = alloca i64
    store i64 %tmp1354, i64* %tmp1355
    %tmp1356 = load i64, i64* %tmp1355
    %tmp1357 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1358 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1357, i32 0, i32 0
    %tmp1359 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1358, i32 0, i32 0
    %tmp1360 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1361 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1360
    %tmp1362 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1363 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1362, i32 0, i32 0
    %tmp1364 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1363
    %tmp1365 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1366 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1365, i32 0, i32 0
    %tmp1367 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1366, i32 0, i32 0
    %tmp1368 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1367
    %tmp1369 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1368, i64 %tmp1356
    %tmp1370 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp1369, %class.hashmap.HashMapEntry_string.String_int** %tmp1370
    %tmp1371 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1370
    %tmp1372 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1371, i32 0, i32 0
    %tmp1373 = bitcast %class.string.String* %tmp1372 to i8*
    %tmp1374 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1332
    %tmp1375 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1374, i32 0, i32 0
    %tmp1376 = bitcast %class.string.String* %tmp1375 to i8*
    %tmp1377 = call i8* @"memcpy"(i8* %tmp1373, i8* %tmp1376, i64 16)
    %tmp1378 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1370
    %tmp1379 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1378, i32 0, i32 1
    %tmp1380 = bitcast i64* %tmp1379 to i8*
    %tmp1381 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1332
    %tmp1382 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1381, i32 0, i32 1
    %tmp1383 = bitcast i64* %tmp1382 to i8*
    %tmp1384 = call i8* @"memcpy"(i8* %tmp1380, i8* %tmp1383, i64 8)
    %tmp1385 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1370
    %tmp1386 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1385, i32 0, i32 2
    store i1 1, i1* %tmp1386
    %tmp1387 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1388 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1387, i32 0, i32 1
    %tmp1389 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1390 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1389, i32 0, i32 1
    %tmp1391 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1392 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1391
    %tmp1393 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1394 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1393, i32 0, i32 1
    %tmp1395 = load i64, i64* %tmp1394
    %tmp1396 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1397 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1396
    %tmp1398 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1399 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1398, i32 0, i32 1
    %tmp1400 = load i64, i64* %tmp1399
    %tmp1401 = add i64 %tmp1400, 1
    store i64 %tmp1401, i64* %tmp1388
    %tmp1402 = load i64, i64* %tmp1274
    %tmp1403 = load i64, i64* %tmp1274
    %tmp1404 = add i64 %tmp1403, 1
    %tmp1405 = load i64, i64* %tmp1274
    %tmp1406 = load i64, i64* %tmp1274
    %tmp1407 = add i64 %tmp1406, 1
    %tmp1408 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1409 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1408
    %tmp1410 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1214
    %tmp1411 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1410, i32 0, i32 2
    %tmp1412 = load i64, i64* %tmp1411
    %tmp1413 = srem i64 %tmp1407, %tmp1412
    store i64 %tmp1413, i64* %tmp1274
    br label %while_cond.99
while_end.101:
    ret i1 1
if_else.97:
    br label %if_end.98
if_end.98:
    ret i1 0
}

define i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %self, %class.string.String* %key) {
entry:
    %tmp1414 = alloca %class.hashmap.HashMap_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1415 = alloca %class.string.String*
    store %class.string.String* %key, %class.string.String** %tmp1415
    %tmp1416 = load %class.string.String*, %class.string.String** %tmp1415
    %tmp1417 = load %class.string.String*, %class.string.String** %tmp1415
    %tmp1418 = call i64 @"string.String.hash"(%class.string.String* %tmp1417)
    %tmp1419 = alloca i64
    store i64 %tmp1418, i64* %tmp1419
    %tmp1420 = load i64, i64* %tmp1419
    %tmp1421 = load i64, i64* %tmp1419
    %tmp1422 = icmp slt i64 %tmp1421, 0
    br i1 %tmp1422, label %if_then.102, label %if_else.103
if_then.102:
    %tmp1423 = load i64, i64* %tmp1419
    %tmp1424 = load i64, i64* %tmp1419
    %tmp1425 = sub i64 0, 1
    %tmp1426 = mul i64 %tmp1424, %tmp1425
    store i64 %tmp1426, i64* %tmp1419
    br label %if_end.104
if_else.103:
    br label %if_end.104
if_end.104:
    %tmp1427 = load i64, i64* %tmp1419
    %tmp1428 = load i64, i64* %tmp1419
    %tmp1429 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1430 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1429
    %tmp1431 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1432 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1431, i32 0, i32 2
    %tmp1433 = load i64, i64* %tmp1432
    %tmp1434 = srem i64 %tmp1428, %tmp1433
    %tmp1435 = alloca i64
    store i64 %tmp1434, i64* %tmp1435
    br label %while_cond.105
while_cond.105:
    %tmp1436 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1437 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1436, i32 0, i32 0
    %tmp1438 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1437, i32 0, i32 0
    %tmp1439 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1440 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1439
    %tmp1441 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1442 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1441, i32 0, i32 0
    %tmp1443 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1442
    %tmp1444 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1445 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1444, i32 0, i32 0
    %tmp1446 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1445, i32 0, i32 0
    %tmp1447 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1446
    %tmp1448 = load i64, i64* %tmp1435
    %tmp1449 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1450 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1449, i32 0, i32 0
    %tmp1451 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1450, i32 0, i32 0
    %tmp1452 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1453 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1452
    %tmp1454 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1455 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1454, i32 0, i32 0
    %tmp1456 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1455
    %tmp1457 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1458 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1457, i32 0, i32 0
    %tmp1459 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1458, i32 0, i32 0
    %tmp1460 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1459
    %tmp1461 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1460, i64 %tmp1448
    %tmp1462 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1461
    %tmp1463 = load i64, i64* %tmp1435
    %tmp1464 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1465 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1464, i32 0, i32 0
    %tmp1466 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1465, i32 0, i32 0
    %tmp1467 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1468 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1467
    %tmp1469 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1470 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1469, i32 0, i32 0
    %tmp1471 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1470
    %tmp1472 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1473 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1472, i32 0, i32 0
    %tmp1474 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1473, i32 0, i32 0
    %tmp1475 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1474
    %tmp1476 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1475, i64 %tmp1463
    %tmp1477 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1476, i32 0, i32 2
    %tmp1478 = load i1, i1* %tmp1477
    br i1 %tmp1478, label %while_body.106, label %while_end.107
while_body.106:
    %tmp1479 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1480 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1479, i32 0, i32 0
    %tmp1481 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1480, i32 0, i32 0
    %tmp1482 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1483 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1482
    %tmp1484 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1485 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1484, i32 0, i32 0
    %tmp1486 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1485
    %tmp1487 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1488 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1487, i32 0, i32 0
    %tmp1489 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1488, i32 0, i32 0
    %tmp1490 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1489
    %tmp1491 = load i64, i64* %tmp1435
    %tmp1492 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1493 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1492, i32 0, i32 0
    %tmp1494 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1493, i32 0, i32 0
    %tmp1495 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1496 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1495
    %tmp1497 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1498 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1497, i32 0, i32 0
    %tmp1499 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1498
    %tmp1500 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1501 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1500, i32 0, i32 0
    %tmp1502 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1501, i32 0, i32 0
    %tmp1503 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1502
    %tmp1504 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1503, i64 %tmp1491
    %tmp1505 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1504
    %tmp1506 = load i64, i64* %tmp1435
    %tmp1507 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1508 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1507, i32 0, i32 0
    %tmp1509 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1508, i32 0, i32 0
    %tmp1510 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1511 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1510
    %tmp1512 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1513 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1512, i32 0, i32 0
    %tmp1514 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1513
    %tmp1515 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1516 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1515, i32 0, i32 0
    %tmp1517 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1516, i32 0, i32 0
    %tmp1518 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1517
    %tmp1519 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1518, i64 %tmp1506
    %tmp1520 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1519, i32 0, i32 0
    %tmp1521 = load %class.string.String, %class.string.String* %tmp1520
    %tmp1522 = load i64, i64* %tmp1435
    %tmp1523 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1524 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1523, i32 0, i32 0
    %tmp1525 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1524, i32 0, i32 0
    %tmp1526 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1527 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1526
    %tmp1528 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1529 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1528, i32 0, i32 0
    %tmp1530 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1529
    %tmp1531 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1532 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1531, i32 0, i32 0
    %tmp1533 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1532, i32 0, i32 0
    %tmp1534 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1533
    %tmp1535 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1534, i64 %tmp1522
    %tmp1536 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1535, i32 0, i32 0
    %tmp1537 = load %class.string.String*, %class.string.String** %tmp1415
    %tmp1538 = call i1 @"string.String.equals"(%class.string.String* %tmp1536, %class.string.String* %tmp1537)
    br i1 %tmp1538, label %if_then.108, label %if_else.109
if_then.108:
    %tmp1539 = load i64, i64* %tmp1435
    ret i64 %tmp1539
if_else.109:
    br label %if_end.110
if_end.110:
    %tmp1540 = load i64, i64* %tmp1435
    %tmp1541 = load i64, i64* %tmp1435
    %tmp1542 = add i64 %tmp1541, 1
    %tmp1543 = load i64, i64* %tmp1435
    %tmp1544 = load i64, i64* %tmp1435
    %tmp1545 = add i64 %tmp1544, 1
    %tmp1546 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1547 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1546
    %tmp1548 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1414
    %tmp1549 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1548, i32 0, i32 2
    %tmp1550 = load i64, i64* %tmp1549
    %tmp1551 = srem i64 %tmp1545, %tmp1550
    store i64 %tmp1551, i64* %tmp1435
    br label %while_cond.105
while_end.107:
    %tmp1552 = load i64, i64* %tmp1435
    ret i64 %tmp1552
}

define void @"hashmap.HashMap_string.String_int.resize"(%class.hashmap.HashMap_string.String_int* %self) {
entry:
    %tmp1553 = alloca %class.hashmap.HashMap_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1554 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1555 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1554
    %tmp1556 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1557 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1556, i32 0, i32 0
    %tmp1558 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1557
    %tmp1559 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1560 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1559, i32 0, i32 0
    %tmp1561 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1560, i32 0, i32 0
    %tmp1562 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1561
    %tmp1563 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp1562, %class.hashmap.HashMapEntry_string.String_int** %tmp1563
    %tmp1564 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1565 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1564
    %tmp1566 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1567 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1566, i32 0, i32 2
    %tmp1568 = load i64, i64* %tmp1567
    %tmp1569 = alloca i64
    store i64 %tmp1568, i64* %tmp1569
    %tmp1570 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1571 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1570, i32 0, i32 2
    %tmp1572 = load i64, i64* %tmp1569
    %tmp1573 = load i64, i64* %tmp1569
    %tmp1574 = mul i64 %tmp1573, 2
    store i64 %tmp1574, i64* %tmp1571
    %tmp1575 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1576 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1575, i32 0, i32 1
    store i64 0, i64* %tmp1576
    %tmp1577 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1578 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1577, i32 0, i32 0
    %tmp1579 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1578, i32 0, i32 0
    %tmp1580 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1581 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1580, i32 0, i32 2
    %tmp1582 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1583 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1582
    %tmp1584 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1585 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1584, i32 0, i32 2
    %tmp1586 = load i64, i64* %tmp1585
    %tmp1587 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1588 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1587
    %tmp1589 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1590 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1589, i32 0, i32 2
    %tmp1591 = load i64, i64* %tmp1590
    %tmp1592 = mul i64 %tmp1591, 32
    %tmp1593 = call i8* @"malloc"(i64 %tmp1592)
    %tmp1594 = bitcast i8* %tmp1593 to %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp1594, %class.hashmap.HashMapEntry_string.String_int** %tmp1579
    %tmp1595 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1596 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1595, i32 0, i32 0
    %tmp1597 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1596, i32 0, i32 2
    %tmp1598 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1599 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1598
    %tmp1600 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1601 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1600, i32 0, i32 2
    %tmp1602 = load i64, i64* %tmp1601
    store i64 %tmp1602, i64* %tmp1597
    %tmp1603 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1604 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1603, i32 0, i32 0
    %tmp1605 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1604, i32 0, i32 1
    store i64 0, i64* %tmp1605
    %tmp1606 = alloca i64
    store i64 0, i64* %tmp1606
    br label %while_cond.111
while_cond.111:
    %tmp1607 = load i64, i64* %tmp1606
    %tmp1608 = load i64, i64* %tmp1606
    %tmp1609 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1610 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1609
    %tmp1611 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1612 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1611, i32 0, i32 2
    %tmp1613 = load i64, i64* %tmp1612
    %tmp1614 = icmp slt i64 %tmp1608, %tmp1613
    br i1 %tmp1614, label %while_body.112, label %while_end.113
while_body.112:
    %tmp1615 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1616 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1615
    %tmp1617 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1618 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1617, i32 0, i32 0
    %tmp1619 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1618
    %tmp1620 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1621 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1620, i32 0, i32 0
    %tmp1622 = alloca %class.hashmap.HashMapEntry_string.String_int
    store %class.hashmap.HashMapEntry_string.String_int zeroinitializer, %class.hashmap.HashMapEntry_string.String_int* %tmp1622
    call void @"hashmap.HashMapEntry_string.String_int.init"(%class.hashmap.HashMapEntry_string.String_int* %tmp1622)
    %tmp1623 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1622
    call void @"array.Array_hashmap.HashMapEntry_string.String_int.push"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1621, %class.hashmap.HashMapEntry_string.String_int %tmp1623)
    %tmp1624 = load i64, i64* %tmp1606
    %tmp1625 = load i64, i64* %tmp1606
    %tmp1626 = add i64 %tmp1625, 1
    store i64 %tmp1626, i64* %tmp1606
    br label %while_cond.111
while_end.113:
    store i64 0, i64* %tmp1606
    br label %while_cond.114
while_cond.114:
    %tmp1627 = load i64, i64* %tmp1606
    %tmp1628 = load i64, i64* %tmp1606
    %tmp1629 = load i64, i64* %tmp1569
    %tmp1630 = icmp slt i64 %tmp1628, %tmp1629
    br i1 %tmp1630, label %while_body.115, label %while_end.116
while_body.115:
    %tmp1631 = load i64, i64* %tmp1606
    %tmp1632 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1563
    %tmp1633 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1632, i64 %tmp1631
    %tmp1634 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp1633, %class.hashmap.HashMapEntry_string.String_int** %tmp1634
    %tmp1635 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1634
    %tmp1636 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1635
    %tmp1637 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1634
    %tmp1638 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1637, i32 0, i32 2
    %tmp1639 = load i1, i1* %tmp1638
    br i1 %tmp1639, label %if_then.117, label %if_else.118
if_then.117:
    %tmp1640 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1641 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1642 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1634
    %tmp1643 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1642, i32 0, i32 0
    %tmp1644 = call i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %tmp1641, %class.string.String* %tmp1643)
    %tmp1645 = alloca i64
    store i64 %tmp1644, i64* %tmp1645
    %tmp1646 = load i64, i64* %tmp1645
    %tmp1647 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1648 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1647, i32 0, i32 0
    %tmp1649 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1648, i32 0, i32 0
    %tmp1650 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1651 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1650
    %tmp1652 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1653 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1652, i32 0, i32 0
    %tmp1654 = load %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1653
    %tmp1655 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1656 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1655, i32 0, i32 0
    %tmp1657 = getelementptr inbounds %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1656, i32 0, i32 0
    %tmp1658 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1657
    %tmp1659 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1658, i64 %tmp1646
    %tmp1660 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp1659, %class.hashmap.HashMapEntry_string.String_int** %tmp1660
    %tmp1661 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1660
    %tmp1662 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1661, i32 0, i32 0
    %tmp1663 = bitcast %class.string.String* %tmp1662 to i8*
    %tmp1664 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1634
    %tmp1665 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1664, i32 0, i32 0
    %tmp1666 = bitcast %class.string.String* %tmp1665 to i8*
    %tmp1667 = call i8* @"memcpy"(i8* %tmp1663, i8* %tmp1666, i64 16)
    %tmp1668 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1660
    %tmp1669 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1668, i32 0, i32 1
    %tmp1670 = bitcast i64* %tmp1669 to i8*
    %tmp1671 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1634
    %tmp1672 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1671, i32 0, i32 1
    %tmp1673 = bitcast i64* %tmp1672 to i8*
    %tmp1674 = call i8* @"memcpy"(i8* %tmp1670, i8* %tmp1673, i64 8)
    %tmp1675 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1660
    %tmp1676 = getelementptr inbounds %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp1675, i32 0, i32 2
    store i1 1, i1* %tmp1676
    %tmp1677 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1678 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1677, i32 0, i32 1
    %tmp1679 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1680 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1679, i32 0, i32 1
    %tmp1681 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1682 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1681
    %tmp1683 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1684 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1683, i32 0, i32 1
    %tmp1685 = load i64, i64* %tmp1684
    %tmp1686 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1687 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1686
    %tmp1688 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %tmp1553
    %tmp1689 = getelementptr inbounds %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1688, i32 0, i32 1
    %tmp1690 = load i64, i64* %tmp1689
    %tmp1691 = add i64 %tmp1690, 1
    store i64 %tmp1691, i64* %tmp1678
    br label %if_end.119
if_else.118:
    br label %if_end.119
if_end.119:
    %tmp1692 = load i64, i64* %tmp1606
    %tmp1693 = load i64, i64* %tmp1606
    %tmp1694 = add i64 %tmp1693, 1
    store i64 %tmp1694, i64* %tmp1606
    br label %while_cond.114
while_end.116:
    %tmp1695 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1563
    %tmp1696 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp1695 to i8*
    call void @"free"(i8* %tmp1696)
    ret void
}

define void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %self) {
entry:
    ret void
}

define %class.hashmap.HashMap_string.String_int @"hashmap.HashMap_string.String_int.clone"(%class.hashmap.HashMap_string.String_int* %self) {
entry:
    %tmp0 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %self
    ret %class.hashmap.HashMap_string.String_int %tmp0
}

define void @"io.print_char"(i8 %c) {
entry:
    %tmp1697 = alloca i8
    store i8 %c, i8* %tmp1697
    %tmp1698 = load i8, i8* %tmp1697
    %tmp1699 = zext i8 %tmp1698 to i32
    %tmp1700 = call i32 @"putchar"(i32 %tmp1699)
    ret void
}

define void @"io.print_str"(i8* %s) {
entry:
    %tmp1701 = alloca i8*
    store i8* %s, i8** %tmp1701
    %tmp1702 = alloca i64
    store i64 0, i64* %tmp1702
    br label %while_cond.120
while_cond.120:
    %tmp1703 = load i64, i64* %tmp1702
    %tmp1704 = load i8*, i8** %tmp1701
    %tmp1705 = getelementptr inbounds i8, i8* %tmp1704, i64 %tmp1703
    %tmp1706 = load i8*, i8** %tmp1701
    %tmp1707 = load i64, i64* %tmp1702
    %tmp1708 = load i8*, i8** %tmp1701
    %tmp1709 = getelementptr inbounds i8, i8* %tmp1708, i64 %tmp1707
    %tmp1710 = load i8, i8* %tmp1709
    %tmp1711 = load i8*, i8** %tmp1701
    %tmp1712 = load i64, i64* %tmp1702
    %tmp1713 = load i8*, i8** %tmp1701
    %tmp1714 = getelementptr inbounds i8, i8* %tmp1713, i64 %tmp1712
    %tmp1715 = load i8, i8* %tmp1714
    %tmp1716 = icmp ne i8 %tmp1715, 0
    br i1 %tmp1716, label %while_body.121, label %while_end.122
while_body.121:
    %tmp1717 = load i8*, i8** %tmp1701
    %tmp1718 = load i64, i64* %tmp1702
    %tmp1719 = load i8*, i8** %tmp1701
    %tmp1720 = getelementptr inbounds i8, i8* %tmp1719, i64 %tmp1718
    %tmp1721 = load i8, i8* %tmp1720
    %tmp1722 = zext i8 %tmp1721 to i32
    %tmp1723 = call i32 @"putchar"(i32 %tmp1722)
    %tmp1724 = load i64, i64* %tmp1702
    %tmp1725 = load i64, i64* %tmp1702
    %tmp1726 = add i64 %tmp1725, 1
    store i64 %tmp1726, i64* %tmp1702
    br label %while_cond.120
while_end.122:
    ret void
}

define void @"io.println_str"(i8* %s) {
entry:
    %tmp1727 = alloca i8*
    store i8* %s, i8** %tmp1727
    %tmp1728 = load i8*, i8** %tmp1727
    %tmp1729 = call i32 @"puts"(i8* %tmp1728)
    ret void
}

define i32 @"main"() {
entry:
    %tmp1730 = alloca %class.hashmap.HashMap_string.String_int
    store %class.hashmap.HashMap_string.String_int zeroinitializer, %class.hashmap.HashMap_string.String_int* %tmp1730
    call void @"hashmap.HashMap_string.String_int.init"(%class.hashmap.HashMap_string.String_int* %tmp1730)
    %tmp1731 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1730
    %tmp1732 = alloca %class.hashmap.HashMap_string.String_int
    store %class.hashmap.HashMap_string.String_int %tmp1731, %class.hashmap.HashMap_string.String_int* %tmp1732
    %tmp1733 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i64 0, i64 0
    %tmp1734 = insertvalue { i8*, i64 } undef, i8* %tmp1733, 0
    %tmp1735 = insertvalue { i8*, i64 } %tmp1734, i64 5, 1
    %tmp1736 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp1735)
    call void @"hashmap.HashMap_string.String_int.operator_index_set"(%class.hashmap.HashMap_string.String_int* %tmp1732, %class.string.String %tmp1736, i64 42)
    %tmp1737 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1, i64 0, i64 0
    %tmp1738 = insertvalue { i8*, i64 } undef, i8* %tmp1737, 0
    %tmp1739 = insertvalue { i8*, i64 } %tmp1738, i64 5, 1
    %tmp1740 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp1739)
    call void @"hashmap.HashMap_string.String_int.operator_index_set"(%class.hashmap.HashMap_string.String_int* %tmp1732, %class.string.String %tmp1740, i64 100)
    %tmp1741 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.2, i64 0, i64 0
    %tmp1742 = insertvalue { i8*, i64 } undef, i8* %tmp1741, 0
    %tmp1743 = insertvalue { i8*, i64 } %tmp1742, i64 5, 1
    %tmp1744 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp1743)
    call void @"hashmap.HashMap_string.String_int.operator_index_set"(%class.hashmap.HashMap_string.String_int* %tmp1732, %class.string.String %tmp1744, i64 999)
    %tmp1745 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1732
    %tmp1746 = call i64 @"hashmap.HashMap_string.String_int.length"(%class.hashmap.HashMap_string.String_int* %tmp1732)
    %tmp1747 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1732
    %tmp1748 = call i64 @"hashmap.HashMap_string.String_int.length"(%class.hashmap.HashMap_string.String_int* %tmp1732)
    %tmp1749 = icmp ne i64 %tmp1748, 3
    br i1 %tmp1749, label %if_then.123, label %if_else.124
if_then.123:
    %tmp1750 = trunc i64 1 to i32
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %tmp1732)
    ret i32 %tmp1750
if_else.124:
    br label %if_end.125
if_end.125:
    %tmp1751 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.3, i64 0, i64 0
    %tmp1752 = insertvalue { i8*, i64 } undef, i8* %tmp1751, 0
    %tmp1753 = insertvalue { i8*, i64 } %tmp1752, i64 5, 1
    %tmp1754 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp1753)
    %tmp1755 = alloca %class.string.String
    store %class.string.String %tmp1754, %class.string.String* %tmp1755
    %tmp1756 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1732
    %tmp1757 = call i64* @"hashmap.HashMap_string.String_int.get"(%class.hashmap.HashMap_string.String_int* %tmp1732, %class.string.String* %tmp1755)
    %tmp1758 = alloca i64*
    store i64* %tmp1757, i64** %tmp1758
    %tmp1759 = load i64*, i64** %tmp1758
    %tmp1760 = load i64*, i64** %tmp1758
    %tmp1761 = icmp ne i64* %tmp1760, null
    br i1 %tmp1761, label %if_then.126, label %if_else.127
if_then.126:
    %tmp1762 = load i64*, i64** %tmp1758
    %tmp1763 = load i64*, i64** %tmp1758
    %tmp1764 = load i64, i64* %tmp1763
    %tmp1765 = load i64*, i64** %tmp1758
    %tmp1766 = load i64, i64* %tmp1765
    %tmp1767 = icmp ne i64 %tmp1766, 42
    br i1 %tmp1767, label %if_then.129, label %if_else.130
if_then.129:
    %tmp1768 = trunc i64 3 to i32
    call void @"string.String.destroy"(%class.string.String* %tmp1755)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %tmp1732)
    ret i32 %tmp1768
if_else.130:
    br label %if_end.131
if_end.131:
    br label %if_end.128
if_else.127:
    %tmp1769 = trunc i64 2 to i32
    call void @"string.String.destroy"(%class.string.String* %tmp1755)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %tmp1732)
    ret i32 %tmp1769
if_end.128:
    %tmp1770 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.4, i64 0, i64 0
    %tmp1771 = insertvalue { i8*, i64 } undef, i8* %tmp1770, 0
    %tmp1772 = insertvalue { i8*, i64 } %tmp1771, i64 5, 1
    %tmp1773 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp1772)
    %tmp1774 = alloca %class.string.String
    store %class.string.String %tmp1773, %class.string.String* %tmp1774
    %tmp1775 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1732
    %tmp1776 = call i64* @"hashmap.HashMap_string.String_int.get"(%class.hashmap.HashMap_string.String_int* %tmp1732, %class.string.String* %tmp1774)
    %tmp1777 = alloca i64*
    store i64* %tmp1776, i64** %tmp1777
    %tmp1778 = load i64*, i64** %tmp1777
    %tmp1779 = load i64*, i64** %tmp1777
    %tmp1780 = icmp ne i64* %tmp1779, null
    br i1 %tmp1780, label %if_then.132, label %if_else.133
if_then.132:
    %tmp1781 = load i64*, i64** %tmp1777
    %tmp1782 = load i64*, i64** %tmp1777
    %tmp1783 = load i64, i64* %tmp1782
    %tmp1784 = load i64*, i64** %tmp1777
    %tmp1785 = load i64, i64* %tmp1784
    %tmp1786 = icmp ne i64 %tmp1785, 100
    br i1 %tmp1786, label %if_then.135, label %if_else.136
if_then.135:
    %tmp1787 = trunc i64 4 to i32
    call void @"string.String.destroy"(%class.string.String* %tmp1774)
    call void @"string.String.destroy"(%class.string.String* %tmp1755)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %tmp1732)
    ret i32 %tmp1787
if_else.136:
    br label %if_end.137
if_end.137:
    br label %if_end.134
if_else.133:
    %tmp1788 = trunc i64 4 to i32
    call void @"string.String.destroy"(%class.string.String* %tmp1774)
    call void @"string.String.destroy"(%class.string.String* %tmp1755)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %tmp1732)
    ret i32 %tmp1788
if_end.134:
    %tmp1789 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.5, i64 0, i64 0
    %tmp1790 = insertvalue { i8*, i64 } undef, i8* %tmp1789, 0
    %tmp1791 = insertvalue { i8*, i64 } %tmp1790, i64 5, 1
    %tmp1792 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp1791)
    %tmp1793 = alloca %class.string.String
    store %class.string.String %tmp1792, %class.string.String* %tmp1793
    %tmp1794 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1732
    %tmp1795 = call i1 @"hashmap.HashMap_string.String_int.contains"(%class.hashmap.HashMap_string.String_int* %tmp1732, %class.string.String* %tmp1793)
    %tmp1796 = xor i1 %tmp1795, true
    br i1 %tmp1796, label %if_then.138, label %if_else.139
if_then.138:
    %tmp1797 = trunc i64 5 to i32
    call void @"string.String.destroy"(%class.string.String* %tmp1793)
    call void @"string.String.destroy"(%class.string.String* %tmp1774)
    call void @"string.String.destroy"(%class.string.String* %tmp1755)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %tmp1732)
    ret i32 %tmp1797
if_else.139:
    br label %if_end.140
if_end.140:
    %tmp1798 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1732
    %tmp1799 = call i1 @"hashmap.HashMap_string.String_int.remove"(%class.hashmap.HashMap_string.String_int* %tmp1732, %class.string.String* %tmp1774)
    %tmp1800 = alloca i1
    store i1 %tmp1799, i1* %tmp1800
    %tmp1801 = load i1, i1* %tmp1800
    %tmp1802 = xor i1 %tmp1801, true
    br i1 %tmp1802, label %if_then.141, label %if_else.142
if_then.141:
    %tmp1803 = trunc i64 6 to i32
    call void @"string.String.destroy"(%class.string.String* %tmp1793)
    call void @"string.String.destroy"(%class.string.String* %tmp1774)
    call void @"string.String.destroy"(%class.string.String* %tmp1755)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %tmp1732)
    ret i32 %tmp1803
if_else.142:
    br label %if_end.143
if_end.143:
    %tmp1804 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1732
    %tmp1805 = call i64 @"hashmap.HashMap_string.String_int.length"(%class.hashmap.HashMap_string.String_int* %tmp1732)
    %tmp1806 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1732
    %tmp1807 = call i64 @"hashmap.HashMap_string.String_int.length"(%class.hashmap.HashMap_string.String_int* %tmp1732)
    %tmp1808 = icmp ne i64 %tmp1807, 2
    br i1 %tmp1808, label %if_then.144, label %if_else.145
if_then.144:
    %tmp1809 = trunc i64 7 to i32
    call void @"string.String.destroy"(%class.string.String* %tmp1793)
    call void @"string.String.destroy"(%class.string.String* %tmp1774)
    call void @"string.String.destroy"(%class.string.String* %tmp1755)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %tmp1732)
    ret i32 %tmp1809
if_else.145:
    br label %if_end.146
if_end.146:
    %tmp1810 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp1732
    %tmp1811 = call i1 @"hashmap.HashMap_string.String_int.contains"(%class.hashmap.HashMap_string.String_int* %tmp1732, %class.string.String* %tmp1774)
    br i1 %tmp1811, label %if_then.147, label %if_else.148
if_then.147:
    %tmp1812 = trunc i64 8 to i32
    call void @"string.String.destroy"(%class.string.String* %tmp1793)
    call void @"string.String.destroy"(%class.string.String* %tmp1774)
    call void @"string.String.destroy"(%class.string.String* %tmp1755)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %tmp1732)
    ret i32 %tmp1812
if_else.148:
    br label %if_end.149
if_end.149:
    %tmp1813 = trunc i64 0 to i32
    call void @"string.String.destroy"(%class.string.String* %tmp1793)
    call void @"string.String.destroy"(%class.string.String* %tmp1774)
    call void @"string.String.destroy"(%class.string.String* %tmp1755)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %tmp1732)
    ret i32 %tmp1813
}


@.str.0 = private unnamed_addr constant [6 x i8] c"hello\00"
@.str.1 = private unnamed_addr constant [6 x i8] c"world\00"
@.str.2 = private unnamed_addr constant [6 x i8] c"atlas\00"
@.str.3 = private unnamed_addr constant [6 x i8] c"hello\00"
@.str.4 = private unnamed_addr constant [6 x i8] c"world\00"
@.str.5 = private unnamed_addr constant [6 x i8] c"atlas\00"
