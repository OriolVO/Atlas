; Atlas compiler v0.1.0 — auto-generated LLVM IR
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.main.GlobalState = type { i64 }

%class.main.PureClass = type { i64 }
%class.main.Resource = type { %struct.main.GlobalState* }

declare i32 @putchar(i32)
define void @"main.Resource.init"(%class.main.Resource* %self, %struct.main.GlobalState* %state) {
entry:
    %self.addr = alloca %class.main.Resource*
    %state.addr = alloca %struct.main.GlobalState*
    store %class.main.Resource* %self, %class.main.Resource** %self.addr
    store %struct.main.GlobalState* %state, %struct.main.GlobalState** %state.addr
    %tmp0 = load %struct.main.GlobalState*, %struct.main.GlobalState** %state.addr
    %tmp1 = load %class.main.Resource*, %class.main.Resource** %self.addr
    %tmp2 = getelementptr %class.main.Resource, %class.main.Resource* %tmp1, i32 0, i32 0
    store %struct.main.GlobalState* %tmp0, %struct.main.GlobalState** %tmp2
    ret void
}

define void @"main.Resource.destroy"(%class.main.Resource* %self) {
entry:
    %self.addr = alloca %class.main.Resource*
    store %class.main.Resource* %self, %class.main.Resource** %self.addr
    %tmp0 = load %class.main.Resource*, %class.main.Resource** %self.addr
    %tmp1 = getelementptr %class.main.Resource, %class.main.Resource* %tmp0, i32 0, i32 0
    %tmp2 = load %struct.main.GlobalState*, %struct.main.GlobalState** %tmp1
    %tmp3 = getelementptr %struct.main.GlobalState, %struct.main.GlobalState* %tmp2, i32 0, i32 0
    store i64 42, i64* %tmp3
    ret void
}

define void @"main.PureClass.init"(%class.main.PureClass* %self) {
entry:
    %self.addr = alloca %class.main.PureClass*
    store %class.main.PureClass* %self, %class.main.PureClass** %self.addr
    %tmp0 = load %class.main.PureClass*, %class.main.PureClass** %self.addr
    %tmp1 = getelementptr %class.main.PureClass, %class.main.PureClass* %tmp0, i32 0, i32 0
    store i64 0, i64* %tmp1
    ret void
}

define void @"main.PureClass.destroy"(%class.main.PureClass* %self) {
entry:
    %self.addr = alloca %class.main.PureClass*
    store %class.main.PureClass* %self, %class.main.PureClass** %self.addr
    ret void
}

define void @"main.print_char"(i32 %c) {
entry:
    %c.addr = alloca i32
    store i32 %c, i32* %c.addr
    %tmp0 = load i32, i32* %c.addr
    %tmp1 = call i32 @"putchar"(i32 %tmp0)
    ret void
}

define i64 @main() {
entry:
    %state.addr.0 = alloca %struct.main.GlobalState
    %tmp0 = alloca %struct.main.GlobalState
    %r.addr.1 = alloca %class.main.Resource
    %tmp3 = alloca %class.main.Resource
    %x.addr.2 = alloca i64
    %s.addr.3 = alloca %struct.main.GlobalState
    %tmp10 = alloca %struct.main.GlobalState
    %p.addr.4 = alloca %class.main.PureClass
    %tmp13 = alloca %class.main.PureClass
    %tmp1 = getelementptr %struct.main.GlobalState, %struct.main.GlobalState* %tmp0, i32 0, i32 0
    store i64 0, i64* %tmp1
    %tmp2 = load %struct.main.GlobalState, %struct.main.GlobalState* %tmp0
    store %struct.main.GlobalState %tmp2, %struct.main.GlobalState* %state.addr.0
    call void @"main.Resource.init"(%class.main.Resource* %tmp3, %struct.main.GlobalState* %state.addr.0)
    %tmp4 = load %class.main.Resource, %class.main.Resource* %tmp3
    store %class.main.Resource %tmp4, %class.main.Resource* %r.addr.1
    %tmp5 = load %class.main.Resource, %class.main.Resource* %r.addr.1
    call void @"main.Resource.destroy"(%class.main.Resource %tmp5)
    %tmp6 = getelementptr %struct.main.GlobalState, %struct.main.GlobalState* %state.addr.0, i32 0, i32 0
    %tmp7 = load i64, i64* %tmp6
    %tmp8 = icmp ne i64 %tmp7, 42
    br i1 %tmp8, label %if.then.0, label %if.end.0
if.then.0:
    call void @"main.Resource.destroy"(%class.main.Resource* %r.addr.1)
    ret i64 1
if.end.0:
    store i64 100, i64* %x.addr.2
    %tmp9 = load i64, i64* %x.addr.2
    %tmp11 = getelementptr %struct.main.GlobalState, %struct.main.GlobalState* %tmp10, i32 0, i32 0
    store i64 1, i64* %tmp11
    %tmp12 = load %struct.main.GlobalState, %struct.main.GlobalState* %tmp10
    store %struct.main.GlobalState %tmp12, %struct.main.GlobalState* %s.addr.3
    call void @"main.PureClass.init"(%class.main.PureClass* %tmp13)
    %tmp14 = load %class.main.PureClass, %class.main.PureClass* %tmp13
    store %class.main.PureClass %tmp14, %class.main.PureClass* %p.addr.4
    call void @"main.print_char"(i32 52)
    call void @"main.print_char"(i32 50)
    call void @"main.print_char"(i32 10)
    call void @"main.PureClass.destroy"(%class.main.PureClass* %p.addr.4)
    call void @"main.Resource.destroy"(%class.main.Resource* %r.addr.1)
    ret i64 42
}


declare i8* @malloc(i64)

declare void @free(i8*)
