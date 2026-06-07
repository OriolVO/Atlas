; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

%struct.LocalPoint = type { i64, i64 }
%struct.main.Parser.State = type { i64, i64 }
%class.main.Parser = type { %struct.main.Parser.State* }

declare i8* @"malloc"(i64)
declare void @"free"(i8*)

define void @"main.Parser.init"(%class.main.Parser* %self) {
entry:
    %tmp0 = alloca %class.main.Parser*
    store %class.main.Parser* %self, %class.main.Parser** %tmp0
    %tmp1 = load %class.main.Parser*, %class.main.Parser** %tmp0
    %tmp2 = getelementptr inbounds %class.main.Parser, %class.main.Parser* %tmp1, i32 0, i32 0
    %tmp4 = call i8* @"malloc"(i64 16)
    %tmp5 = bitcast i8* %tmp4 to %struct.main.Parser.State*
    store %struct.main.Parser.State* %tmp5, %struct.main.Parser.State** %tmp2
    %tmp6 = load %class.main.Parser*, %class.main.Parser** %tmp0
    %tmp7 = load %class.main.Parser, %class.main.Parser* %tmp6
    %tmp8 = load %class.main.Parser*, %class.main.Parser** %tmp0
    %tmp9 = getelementptr inbounds %class.main.Parser, %class.main.Parser* %tmp8, i32 0, i32 0
    %tmp10 = load %struct.main.Parser.State*, %struct.main.Parser.State** %tmp9
    %tmp11 = getelementptr inbounds %struct.main.Parser.State, %struct.main.Parser.State* %tmp10, i32 0, i32 0
    store i64 0, i64* %tmp11
    %tmp13 = load %class.main.Parser*, %class.main.Parser** %tmp0
    %tmp14 = load %class.main.Parser, %class.main.Parser* %tmp13
    %tmp15 = load %class.main.Parser*, %class.main.Parser** %tmp0
    %tmp16 = getelementptr inbounds %class.main.Parser, %class.main.Parser* %tmp15, i32 0, i32 0
    %tmp17 = load %struct.main.Parser.State*, %struct.main.Parser.State** %tmp16
    %tmp18 = getelementptr inbounds %struct.main.Parser.State, %struct.main.Parser.State* %tmp17, i32 0, i32 1
    store i64 0, i64* %tmp18
    ret void
}

define void @"main.Parser.advance"(%class.main.Parser* %self) {
entry:
    %tmp20 = alloca %class.main.Parser*
    store %class.main.Parser* %self, %class.main.Parser** %tmp20
    %tmp21 = load %class.main.Parser*, %class.main.Parser** %tmp20
    %tmp22 = load %class.main.Parser, %class.main.Parser* %tmp21
    %tmp23 = load %class.main.Parser*, %class.main.Parser** %tmp20
    %tmp24 = getelementptr inbounds %class.main.Parser, %class.main.Parser* %tmp23, i32 0, i32 0
    %tmp25 = load %struct.main.Parser.State*, %struct.main.Parser.State** %tmp24
    %tmp26 = getelementptr inbounds %struct.main.Parser.State, %struct.main.Parser.State* %tmp25, i32 0, i32 0
    %tmp27 = load %class.main.Parser*, %class.main.Parser** %tmp20
    %tmp28 = load %class.main.Parser, %class.main.Parser* %tmp27
    %tmp29 = load %class.main.Parser*, %class.main.Parser** %tmp20
    %tmp30 = getelementptr inbounds %class.main.Parser, %class.main.Parser* %tmp29, i32 0, i32 0
    %tmp31 = load %struct.main.Parser.State*, %struct.main.Parser.State** %tmp30
    %tmp32 = getelementptr inbounds %struct.main.Parser.State, %struct.main.Parser.State* %tmp31, i32 0, i32 0
    %tmp33 = load %class.main.Parser*, %class.main.Parser** %tmp20
    %tmp34 = load %class.main.Parser, %class.main.Parser* %tmp33
    %tmp35 = load %class.main.Parser*, %class.main.Parser** %tmp20
    %tmp36 = getelementptr inbounds %class.main.Parser, %class.main.Parser* %tmp35, i32 0, i32 0
    %tmp37 = load %struct.main.Parser.State*, %struct.main.Parser.State** %tmp36
    %tmp38 = load %struct.main.Parser.State, %struct.main.Parser.State* %tmp37
    %tmp39 = load %class.main.Parser*, %class.main.Parser** %tmp20
    %tmp40 = load %class.main.Parser, %class.main.Parser* %tmp39
    %tmp41 = load %class.main.Parser*, %class.main.Parser** %tmp20
    %tmp42 = getelementptr inbounds %class.main.Parser, %class.main.Parser* %tmp41, i32 0, i32 0
    %tmp43 = load %struct.main.Parser.State*, %struct.main.Parser.State** %tmp42
    %tmp44 = getelementptr inbounds %struct.main.Parser.State, %struct.main.Parser.State* %tmp43, i32 0, i32 0
    %tmp45 = load i64, i64* %tmp44
    %tmp46 = load %class.main.Parser*, %class.main.Parser** %tmp20
    %tmp47 = load %class.main.Parser, %class.main.Parser* %tmp46
    %tmp48 = load %class.main.Parser*, %class.main.Parser** %tmp20
    %tmp49 = getelementptr inbounds %class.main.Parser, %class.main.Parser* %tmp48, i32 0, i32 0
    %tmp50 = load %struct.main.Parser.State*, %struct.main.Parser.State** %tmp49
    %tmp51 = load %struct.main.Parser.State, %struct.main.Parser.State* %tmp50
    %tmp52 = load %class.main.Parser*, %class.main.Parser** %tmp20
    %tmp53 = load %class.main.Parser, %class.main.Parser* %tmp52
    %tmp54 = load %class.main.Parser*, %class.main.Parser** %tmp20
    %tmp55 = getelementptr inbounds %class.main.Parser, %class.main.Parser* %tmp54, i32 0, i32 0
    %tmp56 = load %struct.main.Parser.State*, %struct.main.Parser.State** %tmp55
    %tmp57 = getelementptr inbounds %struct.main.Parser.State, %struct.main.Parser.State* %tmp56, i32 0, i32 0
    %tmp58 = load i64, i64* %tmp57
    %tmp60 = add i64 %tmp58, 1
    store i64 %tmp60, i64* %tmp26
    ret void
}

define i64 @"main.Parser.get_index"(%class.main.Parser* %self) {
entry:
    %tmp61 = alloca %class.main.Parser*
    store %class.main.Parser* %self, %class.main.Parser** %tmp61
    %tmp62 = load %class.main.Parser*, %class.main.Parser** %tmp61
    %tmp63 = load %class.main.Parser, %class.main.Parser* %tmp62
    %tmp64 = load %class.main.Parser*, %class.main.Parser** %tmp61
    %tmp65 = getelementptr inbounds %class.main.Parser, %class.main.Parser* %tmp64, i32 0, i32 0
    %tmp66 = load %struct.main.Parser.State*, %struct.main.Parser.State** %tmp65
    %tmp67 = load %struct.main.Parser.State, %struct.main.Parser.State* %tmp66
    %tmp68 = load %class.main.Parser*, %class.main.Parser** %tmp61
    %tmp69 = load %class.main.Parser, %class.main.Parser* %tmp68
    %tmp70 = load %class.main.Parser*, %class.main.Parser** %tmp61
    %tmp71 = getelementptr inbounds %class.main.Parser, %class.main.Parser* %tmp70, i32 0, i32 0
    %tmp72 = load %struct.main.Parser.State*, %struct.main.Parser.State** %tmp71
    %tmp73 = getelementptr inbounds %struct.main.Parser.State, %struct.main.Parser.State* %tmp72, i32 0, i32 0
    %tmp74 = load i64, i64* %tmp73
    ret i64 %tmp74
}

define void @"main.Parser.destroy"(%class.main.Parser* %self) {
entry:
    ret void
}

define %class.main.Parser @"main.Parser.clone"(%class.main.Parser* %self) {
entry:
    %tmp0 = load %class.main.Parser, %class.main.Parser* %self
    ret %class.main.Parser %tmp0
}

define i64 @"main.local_struct_test"() {
entry:
    %tmp75 = insertvalue %struct.LocalPoint undef, i64 10, 0
    %tmp76 = insertvalue %struct.LocalPoint %tmp75, i64 20, 1
    %tmp77 = alloca %struct.LocalPoint
    store %struct.LocalPoint %tmp76, %struct.LocalPoint* %tmp77
    %tmp78 = getelementptr inbounds %struct.LocalPoint, %struct.LocalPoint* %tmp77, i32 0, i32 0
    %tmp79 = load %struct.LocalPoint, %struct.LocalPoint* %tmp77
    %tmp80 = getelementptr inbounds %struct.LocalPoint, %struct.LocalPoint* %tmp77, i32 0, i32 0
    %tmp81 = load i64, i64* %tmp80
    %tmp82 = load %struct.LocalPoint, %struct.LocalPoint* %tmp77
    %tmp83 = getelementptr inbounds %struct.LocalPoint, %struct.LocalPoint* %tmp77, i32 0, i32 0
    %tmp84 = load i64, i64* %tmp83
    %tmp85 = load %struct.LocalPoint, %struct.LocalPoint* %tmp77
    %tmp86 = getelementptr inbounds %struct.LocalPoint, %struct.LocalPoint* %tmp77, i32 0, i32 1
    %tmp87 = load i64, i64* %tmp86
    %tmp88 = add i64 %tmp84, %tmp87
    ret i64 %tmp88
}

define i32 @"main"() {
entry:
    %tmp89 = alloca %class.main.Parser
    store %class.main.Parser zeroinitializer, %class.main.Parser* %tmp89
    call void @"main.Parser.init"(%class.main.Parser* %tmp89)
    %tmp90 = load %class.main.Parser, %class.main.Parser* %tmp89
    %tmp91 = alloca %class.main.Parser
    store %class.main.Parser %tmp90, %class.main.Parser* %tmp91
    %tmp92 = load %class.main.Parser, %class.main.Parser* %tmp91
    call void @"main.Parser.advance"(%class.main.Parser* %tmp91)
    %tmp93 = load %class.main.Parser, %class.main.Parser* %tmp91
    call void @"main.Parser.advance"(%class.main.Parser* %tmp91)
    %tmp94 = load %class.main.Parser, %class.main.Parser* %tmp91
    %tmp95 = call i64 @"main.Parser.get_index"(%class.main.Parser* %tmp91)
    %tmp96 = alloca i64
    store i64 %tmp95, i64* %tmp96
    %tmp97 = call i64 @"main.local_struct_test"()
    %tmp98 = alloca i64
    store i64 %tmp97, i64* %tmp98
    %tmp99 = load i64, i64* %tmp96
    %tmp100 = load i64, i64* %tmp96
    %tmp102 = icmp eq i64 %tmp100, 2
    br i1 %tmp102, label %if_then.0, label %if_else.1
if_then.0:
    %tmp103 = load i64, i64* %tmp98
    %tmp104 = load i64, i64* %tmp98
    %tmp105 = icmp eq i64 %tmp104, 30
    br i1 %tmp105, label %if_then.3, label %if_else.4
if_then.3:
    %tmp106 = trunc i64 0 to i32
    call void @"main.Parser.destroy"(%class.main.Parser* %tmp91)
    ret i32 %tmp106
if_else.4:
    br label %if_end.5
if_end.5:
    br label %if_end.2
if_else.1:
    br label %if_end.2
if_end.2:
    %tmp107 = trunc i64 1 to i32
    call void @"main.Parser.destroy"(%class.main.Parser* %tmp91)
    ret i32 %tmp107
}

