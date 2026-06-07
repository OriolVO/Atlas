; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

%class.main.Counter = type { i64 }


define void @"main.Counter.init"(%class.main.Counter* %self, i64 %start) {
entry:
    %tmp0 = alloca %class.main.Counter*
    store %class.main.Counter* %self, %class.main.Counter** %tmp0
    %tmp1 = alloca i64
    store i64 %start, i64* %tmp1
    %tmp2 = load %class.main.Counter*, %class.main.Counter** %tmp0
    %tmp3 = getelementptr inbounds %class.main.Counter, %class.main.Counter* %tmp2, i32 0, i32 0
    %tmp4 = load i64, i64* %tmp1
    store i64 %tmp4, i64* %tmp3
    ret void
}

define void @"main.Counter.increment"(%class.main.Counter* %self) {
entry:
    %tmp5 = alloca %class.main.Counter*
    store %class.main.Counter* %self, %class.main.Counter** %tmp5
    %tmp6 = load %class.main.Counter*, %class.main.Counter** %tmp5
    %tmp7 = getelementptr inbounds %class.main.Counter, %class.main.Counter* %tmp6, i32 0, i32 0
    %tmp8 = load %class.main.Counter*, %class.main.Counter** %tmp5
    %tmp9 = getelementptr inbounds %class.main.Counter, %class.main.Counter* %tmp8, i32 0, i32 0
    %tmp10 = load %class.main.Counter*, %class.main.Counter** %tmp5
    %tmp11 = load %class.main.Counter, %class.main.Counter* %tmp10
    %tmp12 = load %class.main.Counter*, %class.main.Counter** %tmp5
    %tmp13 = getelementptr inbounds %class.main.Counter, %class.main.Counter* %tmp12, i32 0, i32 0
    %tmp14 = load i64, i64* %tmp13
    %tmp15 = load %class.main.Counter*, %class.main.Counter** %tmp5
    %tmp16 = load %class.main.Counter, %class.main.Counter* %tmp15
    %tmp17 = load %class.main.Counter*, %class.main.Counter** %tmp5
    %tmp18 = getelementptr inbounds %class.main.Counter, %class.main.Counter* %tmp17, i32 0, i32 0
    %tmp19 = load i64, i64* %tmp18
    %tmp20 = add i64 %tmp19, 1
    store i64 %tmp20, i64* %tmp7
    ret void
}

define i64 @"main.Counter.get_val"(%class.main.Counter* %self) {
entry:
    %tmp21 = alloca %class.main.Counter*
    store %class.main.Counter* %self, %class.main.Counter** %tmp21
    %tmp22 = load %class.main.Counter*, %class.main.Counter** %tmp21
    %tmp23 = load %class.main.Counter, %class.main.Counter* %tmp22
    %tmp24 = load %class.main.Counter*, %class.main.Counter** %tmp21
    %tmp25 = getelementptr inbounds %class.main.Counter, %class.main.Counter* %tmp24, i32 0, i32 0
    %tmp26 = load i64, i64* %tmp25
    ret i64 %tmp26
}

define i64 @"main.Counter.double_val"(i64 %val) {
entry:
    %tmp27 = alloca i64
    store i64 %val, i64* %tmp27
    %tmp28 = load i64, i64* %tmp27
    %tmp29 = load i64, i64* %tmp27
    %tmp30 = mul i64 %tmp29, 2
    ret i64 %tmp30
}

define void @"main.Counter.destroy"(%class.main.Counter* %self) {
entry:
    ret void
}

define %class.main.Counter @"main.Counter.clone"(%class.main.Counter* %self) {
entry:
    %tmp0 = load %class.main.Counter, %class.main.Counter* %self
    ret %class.main.Counter %tmp0
}

define i32 @"main"() {
entry:
    %tmp31 = alloca %class.main.Counter
    store %class.main.Counter zeroinitializer, %class.main.Counter* %tmp31
    call void @"main.Counter.init"(%class.main.Counter* %tmp31, i64 20)
    %tmp32 = load %class.main.Counter, %class.main.Counter* %tmp31
    %tmp33 = alloca %class.main.Counter
    store %class.main.Counter %tmp32, %class.main.Counter* %tmp33
    %tmp34 = load %class.main.Counter, %class.main.Counter* %tmp33
    call void @"main.Counter.increment"(%class.main.Counter* %tmp33)
    %tmp35 = load %class.main.Counter, %class.main.Counter* %tmp33
    %tmp36 = call i64 @"main.Counter.get_val"(%class.main.Counter* %tmp33)
    %tmp37 = alloca i64
    store i64 %tmp36, i64* %tmp37
    %tmp38 = load i64, i64* %tmp37
    %tmp39 = call i64 @"main.Counter.double_val"(i64 %tmp38)
    %tmp40 = trunc i64 %tmp39 to i32
    call void @"main.Counter.destroy"(%class.main.Counter* %tmp33)
    ret i32 %tmp40
}

