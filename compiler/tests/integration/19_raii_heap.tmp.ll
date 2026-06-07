; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

%struct.main.State = type { i64 }
%class.main.Tracker = type { %struct.main.State* }

declare i8* @"malloc"(i64)
declare void @"free"(i8*)
declare i8* @"memcpy"(i8*, i8*, i64)

define void @"main.Tracker.init"(%class.main.Tracker* %self, %struct.main.State* %st) {
entry:
    %tmp0 = alloca %class.main.Tracker*
    store %class.main.Tracker* %self, %class.main.Tracker** %tmp0
    %tmp1 = alloca %struct.main.State*
    store %struct.main.State* %st, %struct.main.State** %tmp1
    %tmp2 = load %class.main.Tracker*, %class.main.Tracker** %tmp0
    %tmp3 = getelementptr inbounds %class.main.Tracker, %class.main.Tracker* %tmp2, i32 0, i32 0
    %tmp4 = load %struct.main.State*, %struct.main.State** %tmp1
    store %struct.main.State* %tmp4, %struct.main.State** %tmp3
    ret void
}

define void @"main.Tracker.destroy"(%class.main.Tracker* %self) {
entry:
    %tmp5 = alloca %class.main.Tracker*
    store %class.main.Tracker* %self, %class.main.Tracker** %tmp5
    %tmp6 = load %class.main.Tracker*, %class.main.Tracker** %tmp5
    %tmp7 = load %class.main.Tracker, %class.main.Tracker* %tmp6
    %tmp8 = load %class.main.Tracker*, %class.main.Tracker** %tmp5
    %tmp9 = getelementptr inbounds %class.main.Tracker, %class.main.Tracker* %tmp8, i32 0, i32 0
    %tmp10 = load %struct.main.State*, %struct.main.State** %tmp9
    %tmp11 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp10, i32 0, i32 0
    %tmp12 = load %class.main.Tracker*, %class.main.Tracker** %tmp5
    %tmp13 = load %class.main.Tracker, %class.main.Tracker* %tmp12
    %tmp14 = load %class.main.Tracker*, %class.main.Tracker** %tmp5
    %tmp15 = getelementptr inbounds %class.main.Tracker, %class.main.Tracker* %tmp14, i32 0, i32 0
    %tmp16 = load %struct.main.State*, %struct.main.State** %tmp15
    %tmp17 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp16, i32 0, i32 0
    %tmp18 = load %class.main.Tracker*, %class.main.Tracker** %tmp5
    %tmp19 = load %class.main.Tracker, %class.main.Tracker* %tmp18
    %tmp20 = load %class.main.Tracker*, %class.main.Tracker** %tmp5
    %tmp21 = getelementptr inbounds %class.main.Tracker, %class.main.Tracker* %tmp20, i32 0, i32 0
    %tmp22 = load %struct.main.State*, %struct.main.State** %tmp21
    %tmp23 = load %struct.main.State, %struct.main.State* %tmp22
    %tmp24 = load %class.main.Tracker*, %class.main.Tracker** %tmp5
    %tmp25 = load %class.main.Tracker, %class.main.Tracker* %tmp24
    %tmp26 = load %class.main.Tracker*, %class.main.Tracker** %tmp5
    %tmp27 = getelementptr inbounds %class.main.Tracker, %class.main.Tracker* %tmp26, i32 0, i32 0
    %tmp28 = load %struct.main.State*, %struct.main.State** %tmp27
    %tmp29 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp28, i32 0, i32 0
    %tmp30 = load i64, i64* %tmp29
    %tmp31 = load %class.main.Tracker*, %class.main.Tracker** %tmp5
    %tmp32 = load %class.main.Tracker, %class.main.Tracker* %tmp31
    %tmp33 = load %class.main.Tracker*, %class.main.Tracker** %tmp5
    %tmp34 = getelementptr inbounds %class.main.Tracker, %class.main.Tracker* %tmp33, i32 0, i32 0
    %tmp35 = load %struct.main.State*, %struct.main.State** %tmp34
    %tmp36 = load %struct.main.State, %struct.main.State* %tmp35
    %tmp37 = load %class.main.Tracker*, %class.main.Tracker** %tmp5
    %tmp38 = load %class.main.Tracker, %class.main.Tracker* %tmp37
    %tmp39 = load %class.main.Tracker*, %class.main.Tracker** %tmp5
    %tmp40 = getelementptr inbounds %class.main.Tracker, %class.main.Tracker* %tmp39, i32 0, i32 0
    %tmp41 = load %struct.main.State*, %struct.main.State** %tmp40
    %tmp42 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp41, i32 0, i32 0
    %tmp43 = load i64, i64* %tmp42
    %tmp44 = add i64 %tmp43, 1
    store i64 %tmp44, i64* %tmp11
    ret void
}

define %class.main.Tracker @"main.Tracker.clone"(%class.main.Tracker* %self) {
entry:
    %tmp0 = load %class.main.Tracker, %class.main.Tracker* %self
    ret %class.main.Tracker %tmp0
}

define void @"main.test_heap"(%struct.main.State* %st) {
entry:
    %tmp45 = alloca %struct.main.State*
    store %struct.main.State* %st, %struct.main.State** %tmp45
    %tmp46 = call i8* @"malloc"(i64 8)
    %tmp47 = alloca i8*
    store i8* %tmp46, i8** %tmp47
    %tmp48 = load i8*, i8** %tmp47
    %tmp49 = bitcast i8* %tmp48 to %class.main.Tracker*
    %tmp50 = alloca %class.main.Tracker*
    store %class.main.Tracker* %tmp49, %class.main.Tracker** %tmp50
    %tmp51 = load %class.main.Tracker*, %class.main.Tracker** %tmp50
    %tmp52 = getelementptr inbounds %class.main.Tracker, %class.main.Tracker* %tmp51, i32 0, i32 0
    %tmp53 = load %struct.main.State*, %struct.main.State** %tmp45
    store %struct.main.State* %tmp53, %struct.main.State** %tmp52
    %tmp54 = load %class.main.Tracker*, %class.main.Tracker** %tmp50
    call void @"main.Tracker.destroy"(%class.main.Tracker* %tmp54)
    %tmp55 = load i8*, i8** %tmp47
    call void @"free"(i8* %tmp55)
    ret void
}

define i32 @"main"() {
entry:
    %tmp56 = insertvalue %struct.main.State undef, i64 0, 0
    %tmp57 = alloca %struct.main.State
    store %struct.main.State %tmp56, %struct.main.State* %tmp57
    call void @"main.test_heap"(%struct.main.State* %tmp57)
    %tmp58 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp57, i32 0, i32 0
    %tmp59 = load %struct.main.State, %struct.main.State* %tmp57
    %tmp60 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp57, i32 0, i32 0
    %tmp61 = load i64, i64* %tmp60
    %tmp62 = load %struct.main.State, %struct.main.State* %tmp57
    %tmp63 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp57, i32 0, i32 0
    %tmp64 = load i64, i64* %tmp63
    %tmp65 = add i64 %tmp64, 41
    %tmp66 = trunc i64 %tmp65 to i32
    ret i32 %tmp66
}

