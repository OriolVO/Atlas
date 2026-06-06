; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.main.CustomClone = type { i64 }
%class.main.Simple = type { i64 }

declare i32 @putchar(i32)

define void @main.Simple.init(%class.main.Simple* %self, i64 %v) {
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

define void @main.Simple.destroy(%class.main.Simple* %self) {
entry:
    ret void
}

define %class.main.Simple @main.Simple.clone(%class.main.Simple* %self) {
entry:
    %tmp0 = load %class.main.Simple, %class.main.Simple* %self
    ret %class.main.Simple %tmp0
}

define void @main.CustomClone.init(%class.main.CustomClone* %self, i64 %v) {
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

define %class.main.CustomClone @main.CustomClone.clone(%class.main.CustomClone* %self) {
entry:
    %tmp10 = alloca %class.main.CustomClone*
    store %class.main.CustomClone* %self, %class.main.CustomClone** %tmp10
    %tmp11 = alloca %class.main.CustomClone
    %tmp12 = load %class.main.CustomClone*, %class.main.CustomClone** %tmp10
    %tmp13 = load %class.main.CustomClone, %class.main.CustomClone* %tmp12
    %tmp14 = load %class.main.CustomClone*, %class.main.CustomClone** %tmp10
    %tmp15 = getelementptr inbounds %class.main.CustomClone, %class.main.CustomClone* %tmp14, i32 0, i32 0
    %tmp16 = load i64, i64* %tmp15
    %tmp17 = add i64 %tmp16, 10
    call void @main.CustomClone.init(%class.main.CustomClone* %tmp11, i64 %tmp17)
    %tmp18 = load %class.main.CustomClone, %class.main.CustomClone* %tmp11
    %tmp19 = alloca %class.main.CustomClone
    store %class.main.CustomClone %tmp18, %class.main.CustomClone* %tmp19
    %tmp20 = load %class.main.CustomClone, %class.main.CustomClone* %tmp19
    ret %class.main.CustomClone %tmp20
}

define void @main.CustomClone.destroy(%class.main.CustomClone* %self) {
entry:
    ret void
}

define void @main.print_char(i32 %c) {
entry:
    %tmp21 = alloca i32
    store i32 %c, i32* %tmp21
    %tmp22 = load i32, i32* %tmp21
    %tmp23 = call i32 @putchar(i32 %tmp22)
    ret void
}

define i32 @main() {
entry:
    %tmp24 = alloca %class.main.Simple
    call void @main.Simple.init(%class.main.Simple* %tmp24, i64 10)
    %tmp25 = load %class.main.Simple, %class.main.Simple* %tmp24
    %tmp26 = alloca %class.main.Simple
    store %class.main.Simple %tmp25, %class.main.Simple* %tmp26
    %tmp27 = call %class.main.Simple @main.Simple.clone(%class.main.Simple* %tmp26)
    %tmp28 = alloca %class.main.Simple
    store %class.main.Simple %tmp27, %class.main.Simple* %tmp28
    %tmp29 = getelementptr inbounds %class.main.Simple, %class.main.Simple* %tmp28, i32 0, i32 0
    store i64 20, i64* %tmp29
    %tmp30 = load %class.main.Simple, %class.main.Simple* %tmp26
    %tmp31 = getelementptr inbounds %class.main.Simple, %class.main.Simple* %tmp26, i32 0, i32 0
    %tmp32 = load i64, i64* %tmp31
    %tmp33 = alloca i64
    store i64 %tmp32, i64* %tmp33
    %tmp34 = alloca %class.main.CustomClone
    call void @main.CustomClone.init(%class.main.CustomClone* %tmp34, i64 22)
    %tmp35 = load %class.main.CustomClone, %class.main.CustomClone* %tmp34
    %tmp36 = alloca %class.main.CustomClone
    store %class.main.CustomClone %tmp35, %class.main.CustomClone* %tmp36
    %tmp37 = call %class.main.CustomClone @main.CustomClone.clone(%class.main.CustomClone* %tmp36)
    %tmp38 = alloca %class.main.CustomClone
    store %class.main.CustomClone %tmp37, %class.main.CustomClone* %tmp38
    %tmp39 = load %class.main.CustomClone, %class.main.CustomClone* %tmp38
    %tmp40 = getelementptr inbounds %class.main.CustomClone, %class.main.CustomClone* %tmp38, i32 0, i32 0
    %tmp41 = load i64, i64* %tmp40
    %tmp42 = alloca i64
    store i64 %tmp41, i64* %tmp42
    %tmp43 = load i64, i64* %tmp33
    %tmp44 = load i64, i64* %tmp42
    %tmp45 = add i64 %tmp43, %tmp44
    %tmp46 = icmp eq i64 %tmp45, 42
    br i1 %tmp46, label %if_then.0, label %if_else.1
if_then.0:
    call void @main.print_char(i32 52)
    call void @main.print_char(i32 50)
    call void @main.print_char(i32 10)
    %tmp47 = trunc i64 42 to i32
    call void @main.CustomClone.destroy(%class.main.CustomClone* %tmp38)
    call void @main.CustomClone.destroy(%class.main.CustomClone* %tmp36)
    call void @main.Simple.destroy(%class.main.Simple* %tmp28)
    call void @main.Simple.destroy(%class.main.Simple* %tmp26)
    ret i32 %tmp47
if_else.1:
    br label %if_end.2
if_end.2:
    %tmp48 = trunc i64 0 to i32
    call void @main.CustomClone.destroy(%class.main.CustomClone* %tmp38)
    call void @main.CustomClone.destroy(%class.main.CustomClone* %tmp36)
    call void @main.Simple.destroy(%class.main.Simple* %tmp28)
    call void @main.Simple.destroy(%class.main.Simple* %tmp26)
    ret i32 %tmp48
}

