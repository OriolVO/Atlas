; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

%struct.main.GlobalState = type { i64 }

declare i32 @"putchar"(i32)

define void @"main.print_char"(i32 %c) {
entry:
    %tmp0 = alloca i32
    store i32 %c, i32* %tmp0
    %tmp1 = load i32, i32* %tmp0
    %tmp2 = call i32 @"putchar"(i32 %tmp1)
    ret void
}

define i32 @"main"() {
entry:
    %tmp3 = alloca i64
    store i64 100, i64* %tmp3
    %tmp4 = insertvalue %struct.main.GlobalState undef, i64 1, 0
    %tmp5 = alloca %struct.main.GlobalState
    store %struct.main.GlobalState %tmp4, %struct.main.GlobalState* %tmp5
    call void @"main.print_char"(i32 52)
    call void @"main.print_char"(i32 50)
    call void @"main.print_char"(i32 10)
    %tmp6 = trunc i64 42 to i32
    ret i32 %tmp6
}

