; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i8* @malloc(i64)
declare void @free(i8*)
declare i8* @memcpy(i8*, i8*, i64)
declare i32 @putchar(i32)
declare i32 @puts(i8*)
declare i8* @fopen(i8*, i8*)
declare i32 @fclose(i8*)
declare i32 @fputs(i8*, i8*)
declare i32 @fgetc(i8*)
define void @io.print_char(i8 %c) {
entry:
    %tmp0 = alloca i8
    store i8 %c, i8* %tmp0
    %tmp1 = load i8, i8* %tmp0
    %tmp2 = zext i8 %tmp1 to i32
    %tmp3 = call i32 @putchar(i32 %tmp2)
    ret void
}

define void @io.print_str(i8* %s) {
entry:
    %tmp4 = alloca i8*
    store i8* %s, i8** %tmp4
    %tmp5 = alloca i64
    store i64 0, i64* %tmp5
    br label %while_cond.0
while_cond.0:
    %tmp6 = load i64, i64* %tmp5
    %tmp7 = load i8*, i8** %tmp4
    %tmp8 = getelementptr inbounds i8, i8* %tmp7, i64 %tmp6
    %tmp9 = load i8, i8* %tmp8
    %tmp10 = icmp ne i8 %tmp9, 0
    br i1 %tmp10, label %while_body.1, label %while_end.2
while_body.1:
    %tmp11 = load i64, i64* %tmp5
    %tmp12 = load i8*, i8** %tmp4
    %tmp13 = getelementptr inbounds i8, i8* %tmp12, i64 %tmp11
    %tmp14 = load i8, i8* %tmp13
    %tmp15 = zext i8 %tmp14 to i32
    %tmp16 = call i32 @putchar(i32 %tmp15)
    %tmp17 = load i64, i64* %tmp5
    %tmp18 = add i64 %tmp17, 1
    store i64 %tmp18, i64* %tmp5
    br label %while_cond.0
while_end.2:
    ret void
}

define void @io.println_str(i8* %s) {
entry:
    %tmp19 = alloca i8*
    store i8* %s, i8** %tmp19
    %tmp20 = load i8*, i8** %tmp19
    %tmp21 = call i32 @puts(i8* %tmp20)
    ret void
}

define i32 @main() {
entry:
    %tmp22 = call i8* @malloc(i64 8)
    %tmp23 = bitcast i8* %tmp22 to i64*
    %tmp24 = alloca i64*
    store i64* %tmp23, i64** %tmp24
    %tmp25 = load i64*, i64** %tmp24
    %tmp26 = getelementptr inbounds i64, i64* %tmp25, i64 0
    store i64 42, i64* %tmp26
    %tmp27 = load i64*, i64** %tmp24
    %tmp28 = getelementptr inbounds i64, i64* %tmp27, i64 0
    %tmp29 = alloca i64*
    store i64* %tmp28, i64** %tmp29
    %tmp30 = load i64*, i64** %tmp29
    %tmp31 = load i64, i64* %tmp30
    %tmp32 = sub i64 %tmp31, 42
    %tmp33 = trunc i64 %tmp32 to i32
    ret i32 %tmp33
}

