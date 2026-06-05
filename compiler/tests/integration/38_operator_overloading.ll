; Atlas compiler v0.1.0 — auto-generated LLVM IR
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.main.Vec2 = type { i64, i64 }

define void @"main.Vec2.init"(%class.main.Vec2* %self, i64 %x, i64 %y) {
entry:
    %self.addr = alloca %class.main.Vec2*
    %x.addr = alloca i64
    %y.addr = alloca i64
    store %class.main.Vec2* %self, %class.main.Vec2** %self.addr
    store i64 %x, i64* %x.addr
    store i64 %y, i64* %y.addr
    %tmp0 = load i64, i64* %x.addr
    %tmp1 = load %class.main.Vec2*, %class.main.Vec2** %self.addr
    %tmp2 = getelementptr %class.main.Vec2, %class.main.Vec2* %tmp1, i32 0, i32 0
    store i64 %tmp0, i64* %tmp2
    %tmp3 = load i64, i64* %y.addr
    %tmp4 = load %class.main.Vec2*, %class.main.Vec2** %self.addr
    %tmp5 = getelementptr %class.main.Vec2, %class.main.Vec2* %tmp4, i32 0, i32 1
    store i64 %tmp3, i64* %tmp5
    ret void
}

define %class.main.Vec2 @"main.Vec2.operator_add"(%class.main.Vec2* %self, %class.main.Vec2* %other) {
entry:
    %self.addr = alloca %class.main.Vec2*
    %other.addr = alloca %class.main.Vec2*
    %res.addr.0 = alloca %class.main.Vec2
    %tmp0 = alloca %class.main.Vec2
    store %class.main.Vec2* %self, %class.main.Vec2** %self.addr
    store %class.main.Vec2* %other, %class.main.Vec2** %other.addr
    %tmp1 = load %class.main.Vec2*, %class.main.Vec2** %self.addr
    %tmp2 = getelementptr %class.main.Vec2, %class.main.Vec2* %tmp1, i32 0, i32 0
    %tmp3 = load i64, i64* %tmp2
    %tmp4 = load %class.main.Vec2*, %class.main.Vec2** %other.addr
    %tmp5 = getelementptr %class.main.Vec2, %class.main.Vec2* %tmp4, i32 0, i32 0
    %tmp6 = load i64, i64* %tmp5
    %tmp7 = add i64 %tmp3, %tmp6
    %tmp8 = load %class.main.Vec2*, %class.main.Vec2** %self.addr
    %tmp9 = getelementptr %class.main.Vec2, %class.main.Vec2* %tmp8, i32 0, i32 1
    %tmp10 = load i64, i64* %tmp9
    %tmp11 = load %class.main.Vec2*, %class.main.Vec2** %other.addr
    %tmp12 = getelementptr %class.main.Vec2, %class.main.Vec2* %tmp11, i32 0, i32 1
    %tmp13 = load i64, i64* %tmp12
    %tmp14 = add i64 %tmp10, %tmp13
    call void @"main.Vec2.init"(%class.main.Vec2* %tmp0, i64 %tmp7, i64 %tmp14)
    %tmp15 = load %class.main.Vec2, %class.main.Vec2* %tmp0
    store %class.main.Vec2 %tmp15, %class.main.Vec2* %res.addr.0
    %tmp16 = load %class.main.Vec2, %class.main.Vec2* %res.addr.0
    ret %class.main.Vec2 %tmp16
}

define void @"main.Vec2.destroy"(%class.main.Vec2* %self) {
entry:
    %self.addr = alloca %class.main.Vec2*
    store %class.main.Vec2* %self, %class.main.Vec2** %self.addr
    ret void
}

define i64 @main() {
entry:
    %a.addr.1 = alloca %class.main.Vec2
    %tmp0 = alloca %class.main.Vec2
    %b.addr.2 = alloca %class.main.Vec2
    %tmp2 = alloca %class.main.Vec2
    %c.addr.3 = alloca %class.main.Vec2
    %tmp7 = alloca %class.main.Vec2
    call void @"main.Vec2.init"(%class.main.Vec2* %tmp0, i64 10, i64 20)
    %tmp1 = load %class.main.Vec2, %class.main.Vec2* %tmp0
    store %class.main.Vec2 %tmp1, %class.main.Vec2* %a.addr.1
    call void @"main.Vec2.init"(%class.main.Vec2* %tmp2, i64 5, i64 5)
    %tmp3 = load %class.main.Vec2, %class.main.Vec2* %tmp2
    store %class.main.Vec2 %tmp3, %class.main.Vec2* %b.addr.2
    %tmp4 = load %class.main.Vec2, %class.main.Vec2* %b.addr.2
    %tmp6 = call %class.main.Vec2 @"main.Vec2.operator_add"(%class.main.Vec2* %a.addr.1, %class.main.Vec2 %tmp4)
    store %class.main.Vec2 %tmp6, %class.main.Vec2* %tmp7
    %tmp8 = load %class.main.Vec2, %class.main.Vec2* %tmp7
    store %class.main.Vec2 %tmp8, %class.main.Vec2* %c.addr.3
    %tmp9 = getelementptr %class.main.Vec2, %class.main.Vec2* %c.addr.3, i32 0, i32 0
    %tmp10 = load i64, i64* %tmp9
    %tmp11 = getelementptr %class.main.Vec2, %class.main.Vec2* %c.addr.3, i32 0, i32 1
    %tmp12 = load i64, i64* %tmp11
    %tmp13 = add i64 %tmp10, %tmp12
    call void @"main.Vec2.destroy"(%class.main.Vec2* %c.addr.3)
    call void @"main.Vec2.destroy"(%class.main.Vec2* %b.addr.2)
    call void @"main.Vec2.destroy"(%class.main.Vec2* %a.addr.1)
    ret i64 %tmp13
}


declare i8* @malloc(i64)

declare void @free(i8*)
