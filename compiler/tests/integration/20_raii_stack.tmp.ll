; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

%struct.main.State = type { i64 }
%class.main.Logger = type { i64, %struct.main.State* }


define void @"main.Logger.init"(%class.main.Logger* %self, i64 %id, %struct.main.State* %st) {
entry:
    %tmp0 = alloca %class.main.Logger*
    store %class.main.Logger* %self, %class.main.Logger** %tmp0
    %tmp1 = alloca i64
    store i64 %id, i64* %tmp1
    %tmp2 = alloca %struct.main.State*
    store %struct.main.State* %st, %struct.main.State** %tmp2
    %tmp3 = load %class.main.Logger*, %class.main.Logger** %tmp0
    %tmp4 = getelementptr inbounds %class.main.Logger, %class.main.Logger* %tmp3, i32 0, i32 0
    %tmp5 = load i64, i64* %tmp1
    store i64 %tmp5, i64* %tmp4
    %tmp6 = load %class.main.Logger*, %class.main.Logger** %tmp0
    %tmp7 = getelementptr inbounds %class.main.Logger, %class.main.Logger* %tmp6, i32 0, i32 1
    %tmp8 = load %struct.main.State*, %struct.main.State** %tmp2
    store %struct.main.State* %tmp8, %struct.main.State** %tmp7
    ret void
}

define void @"main.Logger.destroy"(%class.main.Logger* %self) {
entry:
    %tmp9 = alloca %class.main.Logger*
    store %class.main.Logger* %self, %class.main.Logger** %tmp9
    %tmp10 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp11 = load %class.main.Logger, %class.main.Logger* %tmp10
    %tmp12 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp13 = getelementptr inbounds %class.main.Logger, %class.main.Logger* %tmp12, i32 0, i32 1
    %tmp14 = load %struct.main.State*, %struct.main.State** %tmp13
    %tmp15 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp14, i32 0, i32 0
    %tmp16 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp17 = load %class.main.Logger, %class.main.Logger* %tmp16
    %tmp18 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp19 = getelementptr inbounds %class.main.Logger, %class.main.Logger* %tmp18, i32 0, i32 1
    %tmp20 = load %struct.main.State*, %struct.main.State** %tmp19
    %tmp21 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp20, i32 0, i32 0
    %tmp22 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp23 = load %class.main.Logger, %class.main.Logger* %tmp22
    %tmp24 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp25 = getelementptr inbounds %class.main.Logger, %class.main.Logger* %tmp24, i32 0, i32 1
    %tmp26 = load %struct.main.State*, %struct.main.State** %tmp25
    %tmp27 = load %struct.main.State, %struct.main.State* %tmp26
    %tmp28 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp29 = load %class.main.Logger, %class.main.Logger* %tmp28
    %tmp30 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp31 = getelementptr inbounds %class.main.Logger, %class.main.Logger* %tmp30, i32 0, i32 1
    %tmp32 = load %struct.main.State*, %struct.main.State** %tmp31
    %tmp33 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp32, i32 0, i32 0
    %tmp34 = load i64, i64* %tmp33
    %tmp35 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp36 = load %class.main.Logger, %class.main.Logger* %tmp35
    %tmp37 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp38 = getelementptr inbounds %class.main.Logger, %class.main.Logger* %tmp37, i32 0, i32 1
    %tmp39 = load %struct.main.State*, %struct.main.State** %tmp38
    %tmp40 = load %struct.main.State, %struct.main.State* %tmp39
    %tmp41 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp42 = load %class.main.Logger, %class.main.Logger* %tmp41
    %tmp43 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp44 = getelementptr inbounds %class.main.Logger, %class.main.Logger* %tmp43, i32 0, i32 1
    %tmp45 = load %struct.main.State*, %struct.main.State** %tmp44
    %tmp46 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp45, i32 0, i32 0
    %tmp47 = load i64, i64* %tmp46
    %tmp48 = mul i64 %tmp47, 10
    %tmp49 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp50 = load %class.main.Logger, %class.main.Logger* %tmp49
    %tmp51 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp52 = getelementptr inbounds %class.main.Logger, %class.main.Logger* %tmp51, i32 0, i32 1
    %tmp53 = load %struct.main.State*, %struct.main.State** %tmp52
    %tmp54 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp53, i32 0, i32 0
    %tmp55 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp56 = load %class.main.Logger, %class.main.Logger* %tmp55
    %tmp57 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp58 = getelementptr inbounds %class.main.Logger, %class.main.Logger* %tmp57, i32 0, i32 1
    %tmp59 = load %struct.main.State*, %struct.main.State** %tmp58
    %tmp60 = load %struct.main.State, %struct.main.State* %tmp59
    %tmp61 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp62 = load %class.main.Logger, %class.main.Logger* %tmp61
    %tmp63 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp64 = getelementptr inbounds %class.main.Logger, %class.main.Logger* %tmp63, i32 0, i32 1
    %tmp65 = load %struct.main.State*, %struct.main.State** %tmp64
    %tmp66 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp65, i32 0, i32 0
    %tmp67 = load i64, i64* %tmp66
    %tmp68 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp69 = load %class.main.Logger, %class.main.Logger* %tmp68
    %tmp70 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp71 = getelementptr inbounds %class.main.Logger, %class.main.Logger* %tmp70, i32 0, i32 1
    %tmp72 = load %struct.main.State*, %struct.main.State** %tmp71
    %tmp73 = load %struct.main.State, %struct.main.State* %tmp72
    %tmp74 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp75 = load %class.main.Logger, %class.main.Logger* %tmp74
    %tmp76 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp77 = getelementptr inbounds %class.main.Logger, %class.main.Logger* %tmp76, i32 0, i32 1
    %tmp78 = load %struct.main.State*, %struct.main.State** %tmp77
    %tmp79 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp78, i32 0, i32 0
    %tmp80 = load i64, i64* %tmp79
    %tmp81 = mul i64 %tmp80, 10
    %tmp82 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp83 = load %class.main.Logger, %class.main.Logger* %tmp82
    %tmp84 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp85 = getelementptr inbounds %class.main.Logger, %class.main.Logger* %tmp84, i32 0, i32 0
    %tmp86 = load i64, i64* %tmp85
    %tmp87 = add i64 %tmp81, %tmp86
    store i64 %tmp87, i64* %tmp15
    ret void
}

define %class.main.Logger @"main.Logger.clone"(%class.main.Logger* %self) {
entry:
    %tmp0 = load %class.main.Logger, %class.main.Logger* %self
    ret %class.main.Logger %tmp0
}

define void @"main.test_stack"(%struct.main.State* %st) {
entry:
    %tmp88 = alloca %struct.main.State*
    store %struct.main.State* %st, %struct.main.State** %tmp88
    %tmp89 = alloca %class.main.Logger
    store %class.main.Logger zeroinitializer, %class.main.Logger* %tmp89
    %tmp90 = load %struct.main.State*, %struct.main.State** %tmp88
    call void @"main.Logger.init"(%class.main.Logger* %tmp89, i64 1, %struct.main.State* %tmp90)
    %tmp91 = load %class.main.Logger, %class.main.Logger* %tmp89
    %tmp92 = alloca %class.main.Logger
    store %class.main.Logger %tmp91, %class.main.Logger* %tmp92
    %tmp93 = alloca %class.main.Logger
    store %class.main.Logger zeroinitializer, %class.main.Logger* %tmp93
    %tmp94 = load %struct.main.State*, %struct.main.State** %tmp88
    call void @"main.Logger.init"(%class.main.Logger* %tmp93, i64 2, %struct.main.State* %tmp94)
    %tmp95 = load %class.main.Logger, %class.main.Logger* %tmp93
    %tmp96 = alloca %class.main.Logger
    store %class.main.Logger %tmp95, %class.main.Logger* %tmp96
    call void @"main.Logger.destroy"(%class.main.Logger* %tmp96)
    call void @"main.Logger.destroy"(%class.main.Logger* %tmp92)
    ret void
}

define i32 @"main"() {
entry:
    %tmp97 = insertvalue %struct.main.State undef, i64 0, 0
    %tmp98 = alloca %struct.main.State
    store %struct.main.State %tmp97, %struct.main.State* %tmp98
    call void @"main.test_stack"(%struct.main.State* %tmp98)
    %tmp99 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp98, i32 0, i32 0
    %tmp100 = load %struct.main.State, %struct.main.State* %tmp98
    %tmp101 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp98, i32 0, i32 0
    %tmp102 = load i64, i64* %tmp101
    %tmp103 = load %struct.main.State, %struct.main.State* %tmp98
    %tmp104 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp98, i32 0, i32 0
    %tmp105 = load i64, i64* %tmp104
    %tmp106 = add i64 %tmp105, 21
    %tmp107 = trunc i64 %tmp106 to i32
    ret i32 %tmp107
}

