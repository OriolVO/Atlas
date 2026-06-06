; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.main.State = type { i64 }
%class.main.Logger = type { i64, %struct.main.State* }


define void @main.Logger.init(%class.main.Logger* %self, i64 %id, %struct.main.State* %st) {
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

define void @main.Logger.destroy(%class.main.Logger* %self) {
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
    %tmp21 = load %struct.main.State, %struct.main.State* %tmp20
    %tmp22 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp23 = load %class.main.Logger, %class.main.Logger* %tmp22
    %tmp24 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp25 = getelementptr inbounds %class.main.Logger, %class.main.Logger* %tmp24, i32 0, i32 1
    %tmp26 = load %struct.main.State*, %struct.main.State** %tmp25
    %tmp27 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp26, i32 0, i32 0
    %tmp28 = load i64, i64* %tmp27
    %tmp29 = mul i64 %tmp28, 10
    %tmp30 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp31 = load %class.main.Logger, %class.main.Logger* %tmp30
    %tmp32 = load %class.main.Logger*, %class.main.Logger** %tmp9
    %tmp33 = getelementptr inbounds %class.main.Logger, %class.main.Logger* %tmp32, i32 0, i32 0
    %tmp34 = load i64, i64* %tmp33
    %tmp35 = add i64 %tmp29, %tmp34
    store i64 %tmp35, i64* %tmp15
    ret void
}

define %class.main.Logger @main.Logger.clone(%class.main.Logger* %self) {
entry:
    %tmp0 = load %class.main.Logger, %class.main.Logger* %self
    ret %class.main.Logger %tmp0
}

define void @main.test_stack(%struct.main.State* %st) {
entry:
    %tmp36 = alloca %struct.main.State*
    store %struct.main.State* %st, %struct.main.State** %tmp36
    %tmp37 = alloca %class.main.Logger
    %tmp38 = load %struct.main.State*, %struct.main.State** %tmp36
    call void @main.Logger.init(%class.main.Logger* %tmp37, i64 1, %struct.main.State* %tmp38)
    %tmp39 = load %class.main.Logger, %class.main.Logger* %tmp37
    %tmp40 = alloca %class.main.Logger
    store %class.main.Logger %tmp39, %class.main.Logger* %tmp40
    %tmp41 = alloca %class.main.Logger
    %tmp42 = load %struct.main.State*, %struct.main.State** %tmp36
    call void @main.Logger.init(%class.main.Logger* %tmp41, i64 2, %struct.main.State* %tmp42)
    %tmp43 = load %class.main.Logger, %class.main.Logger* %tmp41
    %tmp44 = alloca %class.main.Logger
    store %class.main.Logger %tmp43, %class.main.Logger* %tmp44
    call void @main.Logger.destroy(%class.main.Logger* %tmp44)
    call void @main.Logger.destroy(%class.main.Logger* %tmp40)
    ret void
}

define i32 @main() {
entry:
    %tmp45 = insertvalue %struct.main.State undef, i64 0, 0
    %tmp46 = alloca %struct.main.State
    store %struct.main.State %tmp45, %struct.main.State* %tmp46
    call void @main.test_stack(%struct.main.State* %tmp46)
    %tmp47 = load %struct.main.State, %struct.main.State* %tmp46
    %tmp48 = getelementptr inbounds %struct.main.State, %struct.main.State* %tmp46, i32 0, i32 0
    %tmp49 = load i64, i64* %tmp48
    %tmp50 = add i64 %tmp49, 21
    %tmp51 = trunc i64 %tmp50 to i32
    ret i32 %tmp51
}

