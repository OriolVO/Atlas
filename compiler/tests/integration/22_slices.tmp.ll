; Atlas compiler v0.1.0 — auto-generated LLVM IR
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @"main.sum_slice"({ i64*, i64 } %s) {
entry:
    %s.addr = alloca { i64*, i64 }
    %sum.addr.0 = alloca i64
    %i.addr.1 = alloca i64
    store { i64*, i64 } %s, { i64*, i64 }* %s.addr
    store i64 0, i64* %sum.addr.0
    store i64 0, i64* %i.addr.1
    br label %while.cond.0
while.cond.0:
    %tmp0 = load i64, i64* %i.addr.1
    %tmp1 = getelementptr { i64*, i64 }, { i64*, i64 }* %s.addr, i32 0, i32 1
    %tmp2 = load i64, i64* %tmp1
    %tmp3 = icmp slt i64 %tmp0, %tmp2
    br i1 %tmp3, label %while.body.0, label %while.end.0
while.body.0:
    %tmp4 = load i64, i64* %sum.addr.0
    %tmp5 = load i64, i64* %i.addr.1
    %tmp6 = getelementptr { i64*, i64 }, { i64*, i64 }* %s.addr, i32 0, i32 0
    %tmp7 = load i64*, i64** %tmp6
    %tmp8 = getelementptr i64, i64* %tmp7, i64 %tmp5
    %tmp9 = load i64, i64* %tmp8
    %tmp10 = add i64 %tmp4, %tmp9
    store i64 %tmp10, i64* %sum.addr.0
    %tmp11 = load i64, i64* %i.addr.1
    %tmp12 = add i64 %tmp11, 1
    store i64 %tmp12, i64* %i.addr.1
    br label %while.cond.0
while.end.0:
    %tmp13 = load i64, i64* %sum.addr.0
    ret i64 %tmp13
}

define i64 @main() {
entry:
    %arr.addr.2 = alloca [4 x i64]
    %slice.coerce.3 = alloca { i64*, i64 }
    %tmp0 = getelementptr [4 x i64], [4 x i64]* %arr.addr.2, i32 0, i64 0
    store i64 3, i64* %tmp0
    %tmp1 = getelementptr [4 x i64], [4 x i64]* %arr.addr.2, i32 0, i64 1
    store i64 9, i64* %tmp1
    %tmp2 = getelementptr [4 x i64], [4 x i64]* %arr.addr.2, i32 0, i64 2
    store i64 12, i64* %tmp2
    %tmp3 = getelementptr [4 x i64], [4 x i64]* %arr.addr.2, i32 0, i64 3
    store i64 21, i64* %tmp3
    %tmp4 = getelementptr [4 x i64], [4 x i64]* %arr.addr.2, i32 0, i32 0
    %tmp5 = getelementptr { i64*, i64 }, { i64*, i64 }* %slice.coerce.3, i32 0, i32 0
    store i64* %tmp4, i64** %tmp5
    %tmp6 = getelementptr { i64*, i64 }, { i64*, i64 }* %slice.coerce.3, i32 0, i32 1
    store i64 4, i64* %tmp6
    %tmp7 = load { i64*, i64 }, { i64*, i64 }* %slice.coerce.3
    %tmp8 = call i64 @"main.sum_slice"({ i64*, i64 } %tmp7)
    ret i64 %tmp8
}


declare i8* @malloc(i64)

declare void @free(i8*)

%class.string.String = type { i8*, i64 }

declare i32 @sprintf(i8*, i8*, ...)

@.int_fmt = private unnamed_addr constant [3 x i8] c"%d\00"
define %class.string.String @primitive_int_format(i64 %val) {
entry:
    %buf = call i8* @malloc(i64 32)
    %fmt = getelementptr [3 x i8], [3 x i8]* @.int_fmt, i32 0, i32 0
    %len32 = call i32 (i8*, i8*, ...) @sprintf(i8* %buf, i8* %fmt, i64 %val)
    %len = sext i32 %len32 to i64
    %s.addr = alloca %class.string.String
    %s.data = getelementptr %class.string.String, %class.string.String* %s.addr, i32 0, i32 0
    store i8* %buf, i8** %s.data
    %s.len = getelementptr %class.string.String, %class.string.String* %s.addr, i32 0, i32 1
    store i64 %len, i64** %s.len
    %res = load %class.string.String, %class.string.String* %s.addr
    ret %class.string.String %res
}

define i64 @primitive_int_hash(i64 %val) {
entry:
    ret i64 %val
}

define i1 @primitive_int_equals(i64 %val, i64 %other) {
entry:
    %cmp = icmp eq i64 %val, %other
    ret i1 %cmp
}

@.char_fmt = private unnamed_addr constant [3 x i8] c"%c\00"
define %class.string.String @primitive_char_format(i8 %val) {
entry:
    %buf = call i8* @malloc(i64 2)
    %fmt = getelementptr [3 x i8], [3 x i8]* @.char_fmt, i32 0, i32 0
    %val32 = sext i8 %val to i32
    %len32 = call i32 (i8*, i8*, ...) @sprintf(i8* %buf, i8* %fmt, i32 %val32)
    %len = sext i32 %len32 to i64
    %s.addr = alloca %class.string.String
    %s.data = getelementptr %class.string.String, %class.string.String* %s.addr, i32 0, i32 0
    store i8* %buf, i8** %s.data
    %s.len = getelementptr %class.string.String, %class.string.String* %s.addr, i32 0, i32 1
    store i64 %len, i64** %s.len
    %res = load %class.string.String, %class.string.String* %s.addr
    ret %class.string.String %res
}

define i64 @primitive_char_hash(i8 %val) {
entry:
    %ext = sext i8 %val to i64
    ret i64 %ext
}

define i1 @primitive_char_equals(i8 %val, i8 %other) {
entry:
    %cmp = icmp eq i8 %val, %other
    ret i1 %cmp
}

@.true_str = private unnamed_addr constant [5 x i8] c"true\00"
@.false_str = private unnamed_addr constant [6 x i8] c"false\00"
@.str_fmt = private unnamed_addr constant [3 x i8] c"%s\00"
define %class.string.String @primitive_bool_format(i1 %val) {
entry:
    %buf = call i8* @malloc(i64 6)
    %fmt = getelementptr [3 x i8], [3 x i8]* @.str_fmt, i32 0, i32 0
    %str = select i1 %val, i8* getelementptr ([5 x i8], [5 x i8]* @.true_str, i32 0, i32 0), i8* getelementptr ([6 x i8], [6 x i8]* @.false_str, i32 0, i32 0)
    %len32 = call i32 (i8*, i8*, ...) @sprintf(i8* %buf, i8* %fmt, i8* %str)
    %len = sext i32 %len32 to i64
    %s.addr = alloca %class.string.String
    %s.data = getelementptr %class.string.String, %class.string.String* %s.addr, i32 0, i32 0
    store i8* %buf, i8** %s.data
    %s.len = getelementptr %class.string.String, %class.string.String* %s.addr, i32 0, i32 1
    store i64 %len, i64** %s.len
    %res = load %class.string.String, %class.string.String* %s.addr
    ret %class.string.String %res
}

define i64 @primitive_bool_hash(i1 %val) {
entry:
    %ext = zext i1 %val to i64
    ret i64 %ext
}

define i1 @primitive_bool_equals(i1 %val, i1 %other) {
entry:
    %cmp = icmp eq i1 %val, %other
    ret i1 %cmp
}
