; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.main.State = type { i64 }
%class.main.Tracker = type { %struct.main.State* }

declare i8* @malloc(i64)
declare void @free(i8*)
declare i8* @memcpy(i8*, i8*, i64)

define void @main.Tracker.init(%class.main.Tracker* %self, %struct.main.State* %st) {
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

define void @main.Tracker.destroy(%class.main.Tracker* %self) {
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
    %tmp17 = load %struct.main.State, %struct.main.State* %tmp16
    %tmp18 = load %class.main.Tracker*, %class.main.Tracker** %tmp5
    %tmp19 = load %class.main.Tracker, %class.main.Tracker* %tmp18
    %tmp20 = load %class.main.Tracker*, %class.main.Tracker** %tmp5
    %tmp21 = getelementptr inbounds %class.main.Tracker, %class.main.Tracker* %tmp20, i32 0, i32 0
    %tmp22 = load %struct.main.State*, %struct.main.State** %tmp21
    %tmp23 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp22, i32 0, i32 0
    %tmp24 = load i64, i64* %tmp23
    %tmp25 = add i64 %tmp24, 1
    store i64 %tmp25, i64* %tmp11
    ret void
}

define %class.main.Tracker @main.Tracker.clone(%class.main.Tracker* %self) {
entry:
    %tmp0 = load %class.main.Tracker, %class.main.Tracker* %self
    ret %class.main.Tracker %tmp0
}

define void @main.test_heap(%struct.main.State* %st) {
entry:
    %tmp26 = alloca %struct.main.State*
    store %struct.main.State* %st, %struct.main.State** %tmp26
    %tmp27 = call i8* @malloc(i64 8)
    %tmp28 = alloca i8*
    store i8* %tmp27, i8** %tmp28
    %tmp29 = load i8*, i8** %tmp28
    %tmp30 = bitcast i8* %tmp29 to %class.main.Tracker*
    %tmp31 = alloca %class.main.Tracker*
    store %class.main.Tracker* %tmp30, %class.main.Tracker** %tmp31
    %tmp32 = load %class.main.Tracker*, %class.main.Tracker** %tmp31
    %tmp33 = getelementptr inbounds %class.main.Tracker, %class.main.Tracker* %tmp32, i32 0, i32 0
    %tmp34 = load %struct.main.State*, %struct.main.State** %tmp26
    store %struct.main.State* %tmp34, %struct.main.State** %tmp33
    %tmp35 = load %class.main.Tracker*, %class.main.Tracker** %tmp31
    call void @main.Tracker.destroy(%class.main.Tracker* %tmp35)
    %tmp36 = load i8*, i8** %tmp28
    call void @free(i8* %tmp36)
    ret void
}

define i32 @main() {
entry:
    %tmp37 = insertvalue %struct.main.State undef, i64 0, 0
    %tmp38 = alloca %struct.main.State
    store %struct.main.State %tmp37, %struct.main.State* %tmp38
    call void @main.test_heap(%struct.main.State* %tmp38)
    %tmp39 = load %struct.main.State, %struct.main.State* %tmp38
    %tmp40 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp38, i32 0, i32 0
    %tmp41 = load i64, i64* %tmp40
    %tmp42 = add i64 %tmp41, 41
    %tmp43 = trunc i64 %tmp42 to i32
    ret i32 %tmp43
}

