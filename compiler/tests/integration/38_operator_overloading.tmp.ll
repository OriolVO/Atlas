; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

%class.main.Vec2 = type { i64, i64 }


define void @"main.Vec2.init"(%class.main.Vec2* %self, i64 %x, i64 %y) {
entry:
    %tmp0 = alloca %class.main.Vec2*
    store %class.main.Vec2* %self, %class.main.Vec2** %tmp0
    %tmp1 = alloca i64
    store i64 %x, i64* %tmp1
    %tmp2 = alloca i64
    store i64 %y, i64* %tmp2
    %tmp3 = load %class.main.Vec2*, %class.main.Vec2** %tmp0
    %tmp4 = getelementptr inbounds %class.main.Vec2, %class.main.Vec2* %tmp3, i32 0, i32 0
    %tmp5 = load i64, i64* %tmp1
    store i64 %tmp5, i64* %tmp4
    %tmp6 = load %class.main.Vec2*, %class.main.Vec2** %tmp0
    %tmp7 = getelementptr inbounds %class.main.Vec2, %class.main.Vec2* %tmp6, i32 0, i32 1
    %tmp8 = load i64, i64* %tmp2
    store i64 %tmp8, i64* %tmp7
    ret void
}

define %class.main.Vec2 @"main.Vec2.operator_add"(%class.main.Vec2* %self, %class.main.Vec2* %other) {
entry:
    %tmp9 = alloca %class.main.Vec2*
    store %class.main.Vec2* %self, %class.main.Vec2** %tmp9
    %tmp10 = alloca %class.main.Vec2*
    store %class.main.Vec2* %other, %class.main.Vec2** %tmp10
    %tmp11 = alloca %class.main.Vec2
    store %class.main.Vec2 zeroinitializer, %class.main.Vec2* %tmp11
    %tmp12 = load %class.main.Vec2*, %class.main.Vec2** %tmp9
    %tmp13 = getelementptr inbounds %class.main.Vec2, %class.main.Vec2* %tmp12, i32 0, i32 0
    %tmp14 = load %class.main.Vec2*, %class.main.Vec2** %tmp9
    %tmp15 = load %class.main.Vec2, %class.main.Vec2* %tmp14
    %tmp16 = load %class.main.Vec2*, %class.main.Vec2** %tmp9
    %tmp17 = getelementptr inbounds %class.main.Vec2, %class.main.Vec2* %tmp16, i32 0, i32 0
    %tmp18 = load i64, i64* %tmp17
    %tmp19 = load %class.main.Vec2*, %class.main.Vec2** %tmp9
    %tmp20 = load %class.main.Vec2, %class.main.Vec2* %tmp19
    %tmp21 = load %class.main.Vec2*, %class.main.Vec2** %tmp9
    %tmp22 = getelementptr inbounds %class.main.Vec2, %class.main.Vec2* %tmp21, i32 0, i32 0
    %tmp23 = load i64, i64* %tmp22
    %tmp24 = load %class.main.Vec2*, %class.main.Vec2** %tmp10
    %tmp25 = load %class.main.Vec2, %class.main.Vec2* %tmp24
    %tmp26 = load %class.main.Vec2*, %class.main.Vec2** %tmp10
    %tmp27 = getelementptr inbounds %class.main.Vec2, %class.main.Vec2* %tmp26, i32 0, i32 0
    %tmp28 = load i64, i64* %tmp27
    %tmp29 = add i64 %tmp23, %tmp28
    %tmp30 = load %class.main.Vec2*, %class.main.Vec2** %tmp9
    %tmp31 = getelementptr inbounds %class.main.Vec2, %class.main.Vec2* %tmp30, i32 0, i32 1
    %tmp32 = load %class.main.Vec2*, %class.main.Vec2** %tmp9
    %tmp33 = load %class.main.Vec2, %class.main.Vec2* %tmp32
    %tmp34 = load %class.main.Vec2*, %class.main.Vec2** %tmp9
    %tmp35 = getelementptr inbounds %class.main.Vec2, %class.main.Vec2* %tmp34, i32 0, i32 1
    %tmp36 = load i64, i64* %tmp35
    %tmp37 = load %class.main.Vec2*, %class.main.Vec2** %tmp9
    %tmp38 = load %class.main.Vec2, %class.main.Vec2* %tmp37
    %tmp39 = load %class.main.Vec2*, %class.main.Vec2** %tmp9
    %tmp40 = getelementptr inbounds %class.main.Vec2, %class.main.Vec2* %tmp39, i32 0, i32 1
    %tmp41 = load i64, i64* %tmp40
    %tmp42 = load %class.main.Vec2*, %class.main.Vec2** %tmp10
    %tmp43 = load %class.main.Vec2, %class.main.Vec2* %tmp42
    %tmp44 = load %class.main.Vec2*, %class.main.Vec2** %tmp10
    %tmp45 = getelementptr inbounds %class.main.Vec2, %class.main.Vec2* %tmp44, i32 0, i32 1
    %tmp46 = load i64, i64* %tmp45
    %tmp47 = add i64 %tmp41, %tmp46
    call void @"main.Vec2.init"(%class.main.Vec2* %tmp11, i64 %tmp29, i64 %tmp47)
    %tmp48 = load %class.main.Vec2, %class.main.Vec2* %tmp11
    %tmp49 = alloca %class.main.Vec2
    store %class.main.Vec2 %tmp48, %class.main.Vec2* %tmp49
    %tmp50 = load %class.main.Vec2, %class.main.Vec2* %tmp49
    ret %class.main.Vec2 %tmp50
}

define void @"main.Vec2.destroy"(%class.main.Vec2* %self) {
entry:
    ret void
}

define %class.main.Vec2 @"main.Vec2.clone"(%class.main.Vec2* %self) {
entry:
    %tmp0 = load %class.main.Vec2, %class.main.Vec2* %self
    ret %class.main.Vec2 %tmp0
}

define i32 @"main"() {
entry:
    %tmp51 = alloca %class.main.Vec2
    store %class.main.Vec2 zeroinitializer, %class.main.Vec2* %tmp51
    call void @"main.Vec2.init"(%class.main.Vec2* %tmp51, i64 10, i64 20)
    %tmp52 = load %class.main.Vec2, %class.main.Vec2* %tmp51
    %tmp53 = alloca %class.main.Vec2
    store %class.main.Vec2 %tmp52, %class.main.Vec2* %tmp53
    %tmp54 = alloca %class.main.Vec2
    store %class.main.Vec2 zeroinitializer, %class.main.Vec2* %tmp54
    call void @"main.Vec2.init"(%class.main.Vec2* %tmp54, i64 5, i64 5)
    %tmp55 = load %class.main.Vec2, %class.main.Vec2* %tmp54
    %tmp56 = alloca %class.main.Vec2
    store %class.main.Vec2 %tmp55, %class.main.Vec2* %tmp56
    %tmp57 = call %class.main.Vec2 @"main.Vec2.operator_add"(%class.main.Vec2* %tmp53, %class.main.Vec2* %tmp56)
    %tmp58 = alloca %class.main.Vec2
    store %class.main.Vec2 %tmp57, %class.main.Vec2* %tmp58
    %tmp59 = getelementptr inbounds %class.main.Vec2, %class.main.Vec2* %tmp58, i32 0, i32 0
    %tmp60 = load %class.main.Vec2, %class.main.Vec2* %tmp58
    %tmp61 = getelementptr inbounds %class.main.Vec2, %class.main.Vec2* %tmp58, i32 0, i32 0
    %tmp62 = load i64, i64* %tmp61
    %tmp63 = load %class.main.Vec2, %class.main.Vec2* %tmp58
    %tmp64 = getelementptr inbounds %class.main.Vec2, %class.main.Vec2* %tmp58, i32 0, i32 0
    %tmp65 = load i64, i64* %tmp64
    %tmp66 = load %class.main.Vec2, %class.main.Vec2* %tmp58
    %tmp67 = getelementptr inbounds %class.main.Vec2, %class.main.Vec2* %tmp58, i32 0, i32 1
    %tmp68 = load i64, i64* %tmp67
    %tmp69 = add i64 %tmp65, %tmp68
    %tmp70 = trunc i64 %tmp69 to i32
    call void @"main.Vec2.destroy"(%class.main.Vec2* %tmp58)
    call void @"main.Vec2.destroy"(%class.main.Vec2* %tmp56)
    call void @"main.Vec2.destroy"(%class.main.Vec2* %tmp53)
    ret i32 %tmp70
}

