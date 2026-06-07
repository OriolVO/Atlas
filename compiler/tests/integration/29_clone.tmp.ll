; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

%class.main.CustomClone = type { i64 }
%class.main.Simple = type { i64 }

declare i32 @"putchar"(i32)

define void @"main.Simple.init"(%class.main.Simple* %self, i64 %v) {
entry:
    %tmp0 = alloca %class.main.Simple*
    store %class.main.Simple* %self, %class.main.Simple** %tmp0
    %tmp1 = alloca i64
    store i64 %v, i64* %tmp1
    %tmp2 = load %class.main.Simple*, %class.main.Simple** %tmp0
    %tmp3 = getelementptr inbounds %class.main.Simple, %class.main.Simple* %tmp2, i32 0, i32 0
    %tmp4 = load i64, i64* %tmp1
    store i64 %tmp4, i64* %tmp3
    ret void
}

define void @"main.Simple.destroy"(%class.main.Simple* %self) {
entry:
    ret void
}

define %class.main.Simple @"main.Simple.clone"(%class.main.Simple* %self) {
entry:
    %tmp0 = load %class.main.Simple, %class.main.Simple* %self
    ret %class.main.Simple %tmp0
}

define void @"main.CustomClone.init"(%class.main.CustomClone* %self, i64 %v) {
entry:
    %tmp5 = alloca %class.main.CustomClone*
    store %class.main.CustomClone* %self, %class.main.CustomClone** %tmp5
    %tmp6 = alloca i64
    store i64 %v, i64* %tmp6
    %tmp7 = load %class.main.CustomClone*, %class.main.CustomClone** %tmp5
    %tmp8 = getelementptr inbounds %class.main.CustomClone, %class.main.CustomClone* %tmp7, i32 0, i32 0
    %tmp9 = load i64, i64* %tmp6
    store i64 %tmp9, i64* %tmp8
    ret void
}

define %class.main.CustomClone @"main.CustomClone.clone"(%class.main.CustomClone* %self) {
entry:
    %tmp10 = alloca %class.main.CustomClone*
    store %class.main.CustomClone* %self, %class.main.CustomClone** %tmp10
    %tmp11 = alloca %class.main.CustomClone
    store %class.main.CustomClone zeroinitializer, %class.main.CustomClone* %tmp11
    %tmp12 = load %class.main.CustomClone*, %class.main.CustomClone** %tmp10
    %tmp13 = getelementptr inbounds %class.main.CustomClone, %class.main.CustomClone* %tmp12, i32 0, i32 0
    %tmp14 = load %class.main.CustomClone*, %class.main.CustomClone** %tmp10
    %tmp15 = load %class.main.CustomClone, %class.main.CustomClone* %tmp14
    %tmp16 = load %class.main.CustomClone*, %class.main.CustomClone** %tmp10
    %tmp17 = getelementptr inbounds %class.main.CustomClone, %class.main.CustomClone* %tmp16, i32 0, i32 0
    %tmp18 = load i64, i64* %tmp17
    %tmp19 = load %class.main.CustomClone*, %class.main.CustomClone** %tmp10
    %tmp20 = load %class.main.CustomClone, %class.main.CustomClone* %tmp19
    %tmp21 = load %class.main.CustomClone*, %class.main.CustomClone** %tmp10
    %tmp22 = getelementptr inbounds %class.main.CustomClone, %class.main.CustomClone* %tmp21, i32 0, i32 0
    %tmp23 = load i64, i64* %tmp22
    %tmp24 = add i64 %tmp23, 10
    call void @"main.CustomClone.init"(%class.main.CustomClone* %tmp11, i64 %tmp24)
    %tmp25 = load %class.main.CustomClone, %class.main.CustomClone* %tmp11
    %tmp26 = alloca %class.main.CustomClone
    store %class.main.CustomClone %tmp25, %class.main.CustomClone* %tmp26
    %tmp27 = load %class.main.CustomClone, %class.main.CustomClone* %tmp26
    ret %class.main.CustomClone %tmp27
}

define void @"main.CustomClone.destroy"(%class.main.CustomClone* %self) {
entry:
    ret void
}

define void @"main.print_char"(i32 %c) {
entry:
    %tmp28 = alloca i32
    store i32 %c, i32* %tmp28
    %tmp29 = load i32, i32* %tmp28
    %tmp30 = call i32 @"putchar"(i32 %tmp29)
    ret void
}

define i32 @"main"() {
entry:
    %tmp31 = alloca %class.main.Simple
    store %class.main.Simple zeroinitializer, %class.main.Simple* %tmp31
    call void @"main.Simple.init"(%class.main.Simple* %tmp31, i64 10)
    %tmp32 = load %class.main.Simple, %class.main.Simple* %tmp31
    %tmp33 = alloca %class.main.Simple
    store %class.main.Simple %tmp32, %class.main.Simple* %tmp33
    %tmp34 = load %class.main.Simple, %class.main.Simple* %tmp33
    %tmp35 = call %class.main.Simple @"main.Simple.clone"(%class.main.Simple* %tmp33)
    %tmp36 = alloca %class.main.Simple
    store %class.main.Simple %tmp35, %class.main.Simple* %tmp36
    %tmp37 = getelementptr inbounds %class.main.Simple, %class.main.Simple* %tmp36, i32 0, i32 0
    store i64 20, i64* %tmp37
    %tmp38 = load %class.main.Simple, %class.main.Simple* %tmp33
    %tmp39 = getelementptr inbounds %class.main.Simple, %class.main.Simple* %tmp33, i32 0, i32 0
    %tmp40 = load i64, i64* %tmp39
    %tmp41 = alloca i64
    store i64 %tmp40, i64* %tmp41
    %tmp42 = alloca %class.main.CustomClone
    store %class.main.CustomClone zeroinitializer, %class.main.CustomClone* %tmp42
    call void @"main.CustomClone.init"(%class.main.CustomClone* %tmp42, i64 22)
    %tmp43 = load %class.main.CustomClone, %class.main.CustomClone* %tmp42
    %tmp44 = alloca %class.main.CustomClone
    store %class.main.CustomClone %tmp43, %class.main.CustomClone* %tmp44
    %tmp45 = load %class.main.CustomClone, %class.main.CustomClone* %tmp44
    %tmp46 = call %class.main.CustomClone @"main.CustomClone.clone"(%class.main.CustomClone* %tmp44)
    %tmp47 = alloca %class.main.CustomClone
    store %class.main.CustomClone %tmp46, %class.main.CustomClone* %tmp47
    %tmp48 = load %class.main.CustomClone, %class.main.CustomClone* %tmp47
    %tmp49 = getelementptr inbounds %class.main.CustomClone, %class.main.CustomClone* %tmp47, i32 0, i32 0
    %tmp50 = load i64, i64* %tmp49
    %tmp51 = alloca i64
    store i64 %tmp50, i64* %tmp51
    %tmp52 = load i64, i64* %tmp41
    %tmp53 = load i64, i64* %tmp41
    %tmp54 = load i64, i64* %tmp51
    %tmp55 = add i64 %tmp53, %tmp54
    %tmp56 = load i64, i64* %tmp41
    %tmp57 = load i64, i64* %tmp41
    %tmp58 = load i64, i64* %tmp51
    %tmp59 = add i64 %tmp57, %tmp58
    %tmp60 = icmp eq i64 %tmp59, 42
    br i1 %tmp60, label %if_then.0, label %if_else.1
if_then.0:
    call void @"main.print_char"(i32 52)
    call void @"main.print_char"(i32 50)
    call void @"main.print_char"(i32 10)
    %tmp61 = trunc i64 42 to i32
    call void @"main.CustomClone.destroy"(%class.main.CustomClone* %tmp47)
    call void @"main.CustomClone.destroy"(%class.main.CustomClone* %tmp44)
    call void @"main.Simple.destroy"(%class.main.Simple* %tmp36)
    call void @"main.Simple.destroy"(%class.main.Simple* %tmp33)
    ret i32 %tmp61
if_else.1:
    br label %if_end.2
if_end.2:
    %tmp62 = trunc i64 0 to i32
    call void @"main.CustomClone.destroy"(%class.main.CustomClone* %tmp47)
    call void @"main.CustomClone.destroy"(%class.main.CustomClone* %tmp44)
    call void @"main.Simple.destroy"(%class.main.Simple* %tmp36)
    call void @"main.Simple.destroy"(%class.main.Simple* %tmp33)
    ret i32 %tmp62
}

