; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

%struct.main.Log = type { i64 }
%class.main.First = type { %struct.main.Log* }
%class.main.Pair = type { %class.main.First, %class.main.Second }
%class.main.Second = type { %struct.main.Log* }

declare i32 @"putchar"(i32)

define void @"main.First.init"(%class.main.First* %self, %struct.main.Log* %log) {
entry:
    %tmp0 = alloca %class.main.First*
    store %class.main.First* %self, %class.main.First** %tmp0
    %tmp1 = alloca %struct.main.Log*
    store %struct.main.Log* %log, %struct.main.Log** %tmp1
    %tmp2 = load %class.main.First*, %class.main.First** %tmp0
    %tmp3 = getelementptr inbounds %class.main.First, %class.main.First* %tmp2, i32 0, i32 0
    %tmp4 = load %struct.main.Log*, %struct.main.Log** %tmp1
    store %struct.main.Log* %tmp4, %struct.main.Log** %tmp3
    ret void
}

define void @"main.First.destroy"(%class.main.First* %self) {
entry:
    %tmp5 = alloca %class.main.First*
    store %class.main.First* %self, %class.main.First** %tmp5
    %tmp6 = load %class.main.First*, %class.main.First** %tmp5
    %tmp7 = load %class.main.First, %class.main.First* %tmp6
    %tmp8 = load %class.main.First*, %class.main.First** %tmp5
    %tmp9 = getelementptr inbounds %class.main.First, %class.main.First* %tmp8, i32 0, i32 0
    %tmp10 = load %struct.main.Log*, %struct.main.Log** %tmp9
    %tmp11 = getelementptr inbounds %struct.main.Log, %struct.main.Log* %tmp10, i32 0, i32 0
    %tmp12 = load %class.main.First*, %class.main.First** %tmp5
    %tmp13 = load %class.main.First, %class.main.First* %tmp12
    %tmp14 = load %class.main.First*, %class.main.First** %tmp5
    %tmp15 = getelementptr inbounds %class.main.First, %class.main.First* %tmp14, i32 0, i32 0
    %tmp16 = load %struct.main.Log*, %struct.main.Log** %tmp15
    %tmp17 = getelementptr inbounds %struct.main.Log, %struct.main.Log* %tmp16, i32 0, i32 0
    %tmp18 = load %class.main.First*, %class.main.First** %tmp5
    %tmp19 = load %class.main.First, %class.main.First* %tmp18
    %tmp20 = load %class.main.First*, %class.main.First** %tmp5
    %tmp21 = getelementptr inbounds %class.main.First, %class.main.First* %tmp20, i32 0, i32 0
    %tmp22 = load %struct.main.Log*, %struct.main.Log** %tmp21
    %tmp23 = load %struct.main.Log, %struct.main.Log* %tmp22
    %tmp24 = load %class.main.First*, %class.main.First** %tmp5
    %tmp25 = load %class.main.First, %class.main.First* %tmp24
    %tmp26 = load %class.main.First*, %class.main.First** %tmp5
    %tmp27 = getelementptr inbounds %class.main.First, %class.main.First* %tmp26, i32 0, i32 0
    %tmp28 = load %struct.main.Log*, %struct.main.Log** %tmp27
    %tmp29 = getelementptr inbounds %struct.main.Log, %struct.main.Log* %tmp28, i32 0, i32 0
    %tmp30 = load i64, i64* %tmp29
    %tmp31 = load %class.main.First*, %class.main.First** %tmp5
    %tmp32 = load %class.main.First, %class.main.First* %tmp31
    %tmp33 = load %class.main.First*, %class.main.First** %tmp5
    %tmp34 = getelementptr inbounds %class.main.First, %class.main.First* %tmp33, i32 0, i32 0
    %tmp35 = load %struct.main.Log*, %struct.main.Log** %tmp34
    %tmp36 = load %struct.main.Log, %struct.main.Log* %tmp35
    %tmp37 = load %class.main.First*, %class.main.First** %tmp5
    %tmp38 = load %class.main.First, %class.main.First* %tmp37
    %tmp39 = load %class.main.First*, %class.main.First** %tmp5
    %tmp40 = getelementptr inbounds %class.main.First, %class.main.First* %tmp39, i32 0, i32 0
    %tmp41 = load %struct.main.Log*, %struct.main.Log** %tmp40
    %tmp42 = getelementptr inbounds %struct.main.Log, %struct.main.Log* %tmp41, i32 0, i32 0
    %tmp43 = load i64, i64* %tmp42
    %tmp44 = mul i64 %tmp43, 10
    %tmp45 = load %class.main.First*, %class.main.First** %tmp5
    %tmp46 = load %class.main.First, %class.main.First* %tmp45
    %tmp47 = load %class.main.First*, %class.main.First** %tmp5
    %tmp48 = getelementptr inbounds %class.main.First, %class.main.First* %tmp47, i32 0, i32 0
    %tmp49 = load %struct.main.Log*, %struct.main.Log** %tmp48
    %tmp50 = getelementptr inbounds %struct.main.Log, %struct.main.Log* %tmp49, i32 0, i32 0
    %tmp51 = load %class.main.First*, %class.main.First** %tmp5
    %tmp52 = load %class.main.First, %class.main.First* %tmp51
    %tmp53 = load %class.main.First*, %class.main.First** %tmp5
    %tmp54 = getelementptr inbounds %class.main.First, %class.main.First* %tmp53, i32 0, i32 0
    %tmp55 = load %struct.main.Log*, %struct.main.Log** %tmp54
    %tmp56 = load %struct.main.Log, %struct.main.Log* %tmp55
    %tmp57 = load %class.main.First*, %class.main.First** %tmp5
    %tmp58 = load %class.main.First, %class.main.First* %tmp57
    %tmp59 = load %class.main.First*, %class.main.First** %tmp5
    %tmp60 = getelementptr inbounds %class.main.First, %class.main.First* %tmp59, i32 0, i32 0
    %tmp61 = load %struct.main.Log*, %struct.main.Log** %tmp60
    %tmp62 = getelementptr inbounds %struct.main.Log, %struct.main.Log* %tmp61, i32 0, i32 0
    %tmp63 = load i64, i64* %tmp62
    %tmp64 = load %class.main.First*, %class.main.First** %tmp5
    %tmp65 = load %class.main.First, %class.main.First* %tmp64
    %tmp66 = load %class.main.First*, %class.main.First** %tmp5
    %tmp67 = getelementptr inbounds %class.main.First, %class.main.First* %tmp66, i32 0, i32 0
    %tmp68 = load %struct.main.Log*, %struct.main.Log** %tmp67
    %tmp69 = load %struct.main.Log, %struct.main.Log* %tmp68
    %tmp70 = load %class.main.First*, %class.main.First** %tmp5
    %tmp71 = load %class.main.First, %class.main.First* %tmp70
    %tmp72 = load %class.main.First*, %class.main.First** %tmp5
    %tmp73 = getelementptr inbounds %class.main.First, %class.main.First* %tmp72, i32 0, i32 0
    %tmp74 = load %struct.main.Log*, %struct.main.Log** %tmp73
    %tmp75 = getelementptr inbounds %struct.main.Log, %struct.main.Log* %tmp74, i32 0, i32 0
    %tmp76 = load i64, i64* %tmp75
    %tmp77 = mul i64 %tmp76, 10
    %tmp78 = add i64 %tmp77, 1
    store i64 %tmp78, i64* %tmp11
    ret void
}

define %class.main.First @"main.First.clone"(%class.main.First* %self) {
entry:
    %tmp0 = load %class.main.First, %class.main.First* %self
    ret %class.main.First %tmp0
}

define void @"main.Second.init"(%class.main.Second* %self, %struct.main.Log* %log) {
entry:
    %tmp79 = alloca %class.main.Second*
    store %class.main.Second* %self, %class.main.Second** %tmp79
    %tmp80 = alloca %struct.main.Log*
    store %struct.main.Log* %log, %struct.main.Log** %tmp80
    %tmp81 = load %class.main.Second*, %class.main.Second** %tmp79
    %tmp82 = getelementptr inbounds %class.main.Second, %class.main.Second* %tmp81, i32 0, i32 0
    %tmp83 = load %struct.main.Log*, %struct.main.Log** %tmp80
    store %struct.main.Log* %tmp83, %struct.main.Log** %tmp82
    ret void
}

define void @"main.Second.destroy"(%class.main.Second* %self) {
entry:
    %tmp84 = alloca %class.main.Second*
    store %class.main.Second* %self, %class.main.Second** %tmp84
    %tmp85 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp86 = load %class.main.Second, %class.main.Second* %tmp85
    %tmp87 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp88 = getelementptr inbounds %class.main.Second, %class.main.Second* %tmp87, i32 0, i32 0
    %tmp89 = load %struct.main.Log*, %struct.main.Log** %tmp88
    %tmp90 = getelementptr inbounds %struct.main.Log, %struct.main.Log* %tmp89, i32 0, i32 0
    %tmp91 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp92 = load %class.main.Second, %class.main.Second* %tmp91
    %tmp93 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp94 = getelementptr inbounds %class.main.Second, %class.main.Second* %tmp93, i32 0, i32 0
    %tmp95 = load %struct.main.Log*, %struct.main.Log** %tmp94
    %tmp96 = getelementptr inbounds %struct.main.Log, %struct.main.Log* %tmp95, i32 0, i32 0
    %tmp97 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp98 = load %class.main.Second, %class.main.Second* %tmp97
    %tmp99 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp100 = getelementptr inbounds %class.main.Second, %class.main.Second* %tmp99, i32 0, i32 0
    %tmp101 = load %struct.main.Log*, %struct.main.Log** %tmp100
    %tmp102 = load %struct.main.Log, %struct.main.Log* %tmp101
    %tmp103 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp104 = load %class.main.Second, %class.main.Second* %tmp103
    %tmp105 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp106 = getelementptr inbounds %class.main.Second, %class.main.Second* %tmp105, i32 0, i32 0
    %tmp107 = load %struct.main.Log*, %struct.main.Log** %tmp106
    %tmp108 = getelementptr inbounds %struct.main.Log, %struct.main.Log* %tmp107, i32 0, i32 0
    %tmp109 = load i64, i64* %tmp108
    %tmp110 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp111 = load %class.main.Second, %class.main.Second* %tmp110
    %tmp112 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp113 = getelementptr inbounds %class.main.Second, %class.main.Second* %tmp112, i32 0, i32 0
    %tmp114 = load %struct.main.Log*, %struct.main.Log** %tmp113
    %tmp115 = load %struct.main.Log, %struct.main.Log* %tmp114
    %tmp116 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp117 = load %class.main.Second, %class.main.Second* %tmp116
    %tmp118 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp119 = getelementptr inbounds %class.main.Second, %class.main.Second* %tmp118, i32 0, i32 0
    %tmp120 = load %struct.main.Log*, %struct.main.Log** %tmp119
    %tmp121 = getelementptr inbounds %struct.main.Log, %struct.main.Log* %tmp120, i32 0, i32 0
    %tmp122 = load i64, i64* %tmp121
    %tmp123 = mul i64 %tmp122, 10
    %tmp124 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp125 = load %class.main.Second, %class.main.Second* %tmp124
    %tmp126 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp127 = getelementptr inbounds %class.main.Second, %class.main.Second* %tmp126, i32 0, i32 0
    %tmp128 = load %struct.main.Log*, %struct.main.Log** %tmp127
    %tmp129 = getelementptr inbounds %struct.main.Log, %struct.main.Log* %tmp128, i32 0, i32 0
    %tmp130 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp131 = load %class.main.Second, %class.main.Second* %tmp130
    %tmp132 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp133 = getelementptr inbounds %class.main.Second, %class.main.Second* %tmp132, i32 0, i32 0
    %tmp134 = load %struct.main.Log*, %struct.main.Log** %tmp133
    %tmp135 = load %struct.main.Log, %struct.main.Log* %tmp134
    %tmp136 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp137 = load %class.main.Second, %class.main.Second* %tmp136
    %tmp138 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp139 = getelementptr inbounds %class.main.Second, %class.main.Second* %tmp138, i32 0, i32 0
    %tmp140 = load %struct.main.Log*, %struct.main.Log** %tmp139
    %tmp141 = getelementptr inbounds %struct.main.Log, %struct.main.Log* %tmp140, i32 0, i32 0
    %tmp142 = load i64, i64* %tmp141
    %tmp143 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp144 = load %class.main.Second, %class.main.Second* %tmp143
    %tmp145 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp146 = getelementptr inbounds %class.main.Second, %class.main.Second* %tmp145, i32 0, i32 0
    %tmp147 = load %struct.main.Log*, %struct.main.Log** %tmp146
    %tmp148 = load %struct.main.Log, %struct.main.Log* %tmp147
    %tmp149 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp150 = load %class.main.Second, %class.main.Second* %tmp149
    %tmp151 = load %class.main.Second*, %class.main.Second** %tmp84
    %tmp152 = getelementptr inbounds %class.main.Second, %class.main.Second* %tmp151, i32 0, i32 0
    %tmp153 = load %struct.main.Log*, %struct.main.Log** %tmp152
    %tmp154 = getelementptr inbounds %struct.main.Log, %struct.main.Log* %tmp153, i32 0, i32 0
    %tmp155 = load i64, i64* %tmp154
    %tmp156 = mul i64 %tmp155, 10
    %tmp157 = add i64 %tmp156, 2
    store i64 %tmp157, i64* %tmp90
    ret void
}

define %class.main.Second @"main.Second.clone"(%class.main.Second* %self) {
entry:
    %tmp0 = load %class.main.Second, %class.main.Second* %self
    ret %class.main.Second %tmp0
}

define void @"main.Pair.init"(%class.main.Pair* %self, %struct.main.Log* %log) {
entry:
    %tmp158 = alloca %class.main.Pair*
    store %class.main.Pair* %self, %class.main.Pair** %tmp158
    %tmp159 = alloca %struct.main.Log*
    store %struct.main.Log* %log, %struct.main.Log** %tmp159
    %tmp160 = load %class.main.Pair*, %class.main.Pair** %tmp158
    %tmp161 = getelementptr inbounds %class.main.Pair, %class.main.Pair* %tmp160, i32 0, i32 0
    %tmp162 = alloca %class.main.First
    store %class.main.First zeroinitializer, %class.main.First* %tmp162
    %tmp163 = load %struct.main.Log*, %struct.main.Log** %tmp159
    call void @"main.First.init"(%class.main.First* %tmp162, %struct.main.Log* %tmp163)
    %tmp164 = load %class.main.First, %class.main.First* %tmp162
    store %class.main.First %tmp164, %class.main.First* %tmp161
    %tmp165 = load %class.main.Pair*, %class.main.Pair** %tmp158
    %tmp166 = getelementptr inbounds %class.main.Pair, %class.main.Pair* %tmp165, i32 0, i32 1
    %tmp167 = alloca %class.main.Second
    store %class.main.Second zeroinitializer, %class.main.Second* %tmp167
    %tmp168 = load %struct.main.Log*, %struct.main.Log** %tmp159
    call void @"main.Second.init"(%class.main.Second* %tmp167, %struct.main.Log* %tmp168)
    %tmp169 = load %class.main.Second, %class.main.Second* %tmp167
    store %class.main.Second %tmp169, %class.main.Second* %tmp166
    ret void
}

define void @"main.Pair.destroy"(%class.main.Pair* %self) {
entry:
    %tmp170 = getelementptr inbounds %class.main.Pair, %class.main.Pair* %self, i32 0, i32 1
    call void @"main.Second.destroy"(%class.main.Second* %tmp170)
    %tmp171 = getelementptr inbounds %class.main.Pair, %class.main.Pair* %self, i32 0, i32 0
    call void @"main.First.destroy"(%class.main.First* %tmp171)
    ret void
}

define %class.main.Pair @"main.Pair.clone"(%class.main.Pair* %self) {
entry:
    %tmp0 = load %class.main.Pair, %class.main.Pair* %self
    ret %class.main.Pair %tmp0
}

define void @"main.test"(%struct.main.Log* %log) {
entry:
    %tmp172 = alloca %struct.main.Log*
    store %struct.main.Log* %log, %struct.main.Log** %tmp172
    %tmp173 = alloca %class.main.Pair
    store %class.main.Pair zeroinitializer, %class.main.Pair* %tmp173
    %tmp174 = load %struct.main.Log*, %struct.main.Log** %tmp172
    call void @"main.Pair.init"(%class.main.Pair* %tmp173, %struct.main.Log* %tmp174)
    %tmp175 = load %class.main.Pair, %class.main.Pair* %tmp173
    %tmp176 = alloca %class.main.Pair
    store %class.main.Pair %tmp175, %class.main.Pair* %tmp176
    call void @"main.Pair.destroy"(%class.main.Pair* %tmp176)
    ret void
}

define i32 @"main"() {
entry:
    %tmp177 = insertvalue %struct.main.Log undef, i64 0, 0
    %tmp178 = alloca %struct.main.Log
    store %struct.main.Log %tmp177, %struct.main.Log* %tmp178
    call void @"main.test"(%struct.main.Log* %tmp178)
    %tmp179 = getelementptr inbounds %struct.main.Log, %struct.main.Log* %tmp178, i32 0, i32 0
    %tmp180 = load %struct.main.Log, %struct.main.Log* %tmp178
    %tmp181 = getelementptr inbounds %struct.main.Log, %struct.main.Log* %tmp178, i32 0, i32 0
    %tmp182 = load i64, i64* %tmp181
    %tmp183 = load %struct.main.Log, %struct.main.Log* %tmp178
    %tmp184 = getelementptr inbounds %struct.main.Log, %struct.main.Log* %tmp178, i32 0, i32 0
    %tmp185 = load i64, i64* %tmp184
    %tmp186 = add i64 %tmp185, 21
    %tmp187 = trunc i64 %tmp186 to i32
    ret i32 %tmp187
}

