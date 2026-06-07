; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

%struct.main.GlobalState = type { i64 }
%class.main.PureClass = type { i64 }
%class.main.Resource = type { %struct.main.GlobalState* }

declare i32 @"putchar"(i32)

define void @"main.Resource.init"(%class.main.Resource* %self, %struct.main.GlobalState* %state) {
entry:
    %tmp0 = alloca %class.main.Resource*
    store %class.main.Resource* %self, %class.main.Resource** %tmp0
    %tmp1 = alloca %struct.main.GlobalState*
    store %struct.main.GlobalState* %state, %struct.main.GlobalState** %tmp1
    %tmp2 = load %class.main.Resource*, %class.main.Resource** %tmp0
    %tmp3 = getelementptr inbounds %class.main.Resource, %class.main.Resource* %tmp2, i32 0, i32 0
    %tmp4 = load %struct.main.GlobalState*, %struct.main.GlobalState** %tmp1
    store %struct.main.GlobalState* %tmp4, %struct.main.GlobalState** %tmp3
    ret void
}

define void @"main.Resource.destroy"(%class.main.Resource* %self) {
entry:
    %tmp5 = alloca %class.main.Resource*
    store %class.main.Resource* %self, %class.main.Resource** %tmp5
    %tmp6 = load %class.main.Resource*, %class.main.Resource** %tmp5
    %tmp7 = load %class.main.Resource, %class.main.Resource* %tmp6
    %tmp8 = load %class.main.Resource*, %class.main.Resource** %tmp5
    %tmp9 = getelementptr inbounds %class.main.Resource, %class.main.Resource* %tmp8, i32 0, i32 0
    %tmp10 = load %struct.main.GlobalState*, %struct.main.GlobalState** %tmp9
    %tmp11 = getelementptr inbounds %struct.main.GlobalState, %struct.main.GlobalState* %tmp10, i32 0, i32 0
    store i64 42, i64* %tmp11
    ret void
}

define %class.main.Resource @"main.Resource.clone"(%class.main.Resource* %self) {
entry:
    %tmp0 = load %class.main.Resource, %class.main.Resource* %self
    ret %class.main.Resource %tmp0
}

define void @"main.PureClass.init"(%class.main.PureClass* %self) {
entry:
    %tmp12 = alloca %class.main.PureClass*
    store %class.main.PureClass* %self, %class.main.PureClass** %tmp12
    %tmp13 = load %class.main.PureClass*, %class.main.PureClass** %tmp12
    %tmp14 = getelementptr inbounds %class.main.PureClass, %class.main.PureClass* %tmp13, i32 0, i32 0
    store i64 0, i64* %tmp14
    ret void
}

define void @"main.PureClass.destroy"(%class.main.PureClass* %self) {
entry:
    ret void
}

define %class.main.PureClass @"main.PureClass.clone"(%class.main.PureClass* %self) {
entry:
    %tmp0 = load %class.main.PureClass, %class.main.PureClass* %self
    ret %class.main.PureClass %tmp0
}

define void @"main.print_char"(i32 %c) {
entry:
    %tmp15 = alloca i32
    store i32 %c, i32* %tmp15
    %tmp16 = load i32, i32* %tmp15
    %tmp17 = call i32 @"putchar"(i32 %tmp16)
    ret void
}

define i32 @"main"() {
entry:
    %tmp18 = insertvalue %struct.main.GlobalState undef, i64 0, 0
    %tmp19 = alloca %struct.main.GlobalState
    store %struct.main.GlobalState %tmp18, %struct.main.GlobalState* %tmp19
    %tmp20 = alloca %class.main.Resource
    store %class.main.Resource zeroinitializer, %class.main.Resource* %tmp20
    call void @"main.Resource.init"(%class.main.Resource* %tmp20, %struct.main.GlobalState* %tmp19)
    %tmp21 = load %class.main.Resource, %class.main.Resource* %tmp20
    %tmp22 = alloca %class.main.Resource
    store %class.main.Resource %tmp21, %class.main.Resource* %tmp22
    call void @"main.Resource.destroy"(%class.main.Resource* %tmp22)
    %tmp23 = getelementptr inbounds %struct.main.GlobalState, %struct.main.GlobalState* %tmp19, i32 0, i32 0
    %tmp24 = load %struct.main.GlobalState, %struct.main.GlobalState* %tmp19
    %tmp25 = getelementptr inbounds %struct.main.GlobalState, %struct.main.GlobalState* %tmp19, i32 0, i32 0
    %tmp26 = load i64, i64* %tmp25
    %tmp27 = load %struct.main.GlobalState, %struct.main.GlobalState* %tmp19
    %tmp28 = getelementptr inbounds %struct.main.GlobalState, %struct.main.GlobalState* %tmp19, i32 0, i32 0
    %tmp29 = load i64, i64* %tmp28
    %tmp30 = icmp ne i64 %tmp29, 42
    br i1 %tmp30, label %if_then.0, label %if_else.1
if_then.0:
    %tmp31 = trunc i64 1 to i32
    call void @"main.Resource.destroy"(%class.main.Resource* %tmp22)
    ret i32 %tmp31
if_else.1:
    br label %if_end.2
if_end.2:
    %tmp32 = alloca i64
    store i64 100, i64* %tmp32
    %tmp33 = insertvalue %struct.main.GlobalState undef, i64 1, 0
    %tmp34 = alloca %struct.main.GlobalState
    store %struct.main.GlobalState %tmp33, %struct.main.GlobalState* %tmp34
    %tmp35 = alloca %class.main.PureClass
    store %class.main.PureClass zeroinitializer, %class.main.PureClass* %tmp35
    call void @"main.PureClass.init"(%class.main.PureClass* %tmp35)
    %tmp36 = load %class.main.PureClass, %class.main.PureClass* %tmp35
    %tmp37 = alloca %class.main.PureClass
    store %class.main.PureClass %tmp36, %class.main.PureClass* %tmp37
    call void @"main.PureClass.destroy"(%class.main.PureClass* %tmp37)
    call void @"main.print_char"(i32 52)
    call void @"main.print_char"(i32 50)
    call void @"main.print_char"(i32 10)
    %tmp38 = trunc i64 42 to i32
    call void @"main.PureClass.destroy"(%class.main.PureClass* %tmp37)
    call void @"main.Resource.destroy"(%class.main.Resource* %tmp22)
    ret i32 %tmp38
}

