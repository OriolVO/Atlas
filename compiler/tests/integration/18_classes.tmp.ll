; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.main.Counter = type { i64 }


define void @main.Counter.init(%class.main.Counter* %self, i64 %start) {
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

define void @main.Counter.increment(%class.main.Counter* %self) {
entry:
    %tmp5 = alloca %class.main.Counter*
    store %class.main.Counter* %self, %class.main.Counter** %tmp5
    %tmp6 = load %class.main.Counter*, %class.main.Counter** %tmp5
    %tmp7 = getelementptr inbounds %class.main.Counter, %class.main.Counter* %tmp6, i32 0, i32 0
    %tmp8 = load %class.main.Counter*, %class.main.Counter** %tmp5
    %tmp9 = load %class.main.Counter, %class.main.Counter* %tmp8
    %tmp10 = load %class.main.Counter*, %class.main.Counter** %tmp5
    %tmp11 = getelementptr inbounds %class.main.Counter, %class.main.Counter* %tmp10, i32 0, i32 0
    %tmp12 = load i64, i64* %tmp11
    %tmp13 = add i64 %tmp12, 1
    store i64 %tmp13, i64* %tmp7
    ret void
}

define i64 @main.Counter.get_val(%class.main.Counter* %self) {
entry:
    %tmp14 = alloca %class.main.Counter*
    store %class.main.Counter* %self, %class.main.Counter** %tmp14
    %tmp15 = load %class.main.Counter*, %class.main.Counter** %tmp14
    %tmp16 = load %class.main.Counter, %class.main.Counter* %tmp15
    %tmp17 = load %class.main.Counter*, %class.main.Counter** %tmp14
    %tmp18 = getelementptr inbounds %class.main.Counter, %class.main.Counter* %tmp17, i32 0, i32 0
    %tmp19 = load i64, i64* %tmp18
    ret i64 %tmp19
}

define i64 @main.Counter.double_val(i64 %val) {
entry:
    %tmp20 = alloca i64
    store i64 %val, i64* %tmp20
    %tmp21 = load i64, i64* %tmp20
    %tmp22 = mul i64 %tmp21, 2
    ret i64 %tmp22
}

define void @main.Counter.destroy(%class.main.Counter* %self) {
entry:
    ret void
}

define %class.main.Counter @main.Counter.clone(%class.main.Counter* %self) {
entry:
    %tmp0 = load %class.main.Counter, %class.main.Counter* %self
    ret %class.main.Counter %tmp0
}

define i32 @main() {
entry:
    %tmp23 = alloca %class.main.Counter
    call void @main.Counter.init(%class.main.Counter* %tmp23, i64 20)
    %tmp24 = load %class.main.Counter, %class.main.Counter* %tmp23
    %tmp25 = alloca %class.main.Counter
    store %class.main.Counter %tmp24, %class.main.Counter* %tmp25
    call void @main.Counter.increment(%class.main.Counter* %tmp25)
    %tmp26 = call i64 @main.Counter.get_val(%class.main.Counter* %tmp25)
    %tmp27 = alloca i64
    store i64 %tmp26, i64* %tmp27
    %tmp28 = load i64, i64* %tmp27
    %tmp29 = call i64 @main.Counter.double_val(i64 %tmp28)
    %tmp30 = trunc i64 %tmp29 to i32
    call void @main.Counter.destroy(%class.main.Counter* %tmp25)
    ret i32 %tmp30
}

