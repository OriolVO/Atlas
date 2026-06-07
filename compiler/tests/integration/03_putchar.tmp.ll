; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

declare i32 @"putchar"(i32)
define i32 @"main"() {
entry:
    %tmp0 = call i32 @"putchar"(i32 65)
    %tmp1 = call i32 @"putchar"(i32 10)
    %tmp2 = trunc i64 0 to i32
    ret i32 %tmp2
}

