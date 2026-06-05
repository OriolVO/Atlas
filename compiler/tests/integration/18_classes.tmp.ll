; Atlas compiler v0.1.0 — auto-generated LLVM IR
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.main.Counter = type { i64 }

define void @"main.Counter.init"(%class.main.Counter* %self, i64 %start) {
entry:
    %self.addr = alloca %class.main.Counter*
    %start.addr = alloca i64
    store %class.main.Counter* %self, %class.main.Counter** %self.addr
    store i64 %start, i64* %start.addr
    %tmp0 = load i64, i64* %start.addr
    %tmp1 = load %class.main.Counter*, %class.main.Counter** %self.addr
    %tmp2 = getelementptr %class.main.Counter, %class.main.Counter* %tmp1, i32 0, i32 0
    store i64 %tmp0, i64* %tmp2
    ret void
}

define void @"main.Counter.increment"(%class.main.Counter* %self) {
entry:
    %self.addr = alloca %class.main.Counter*
    store %class.main.Counter* %self, %class.main.Counter** %self.addr
    %tmp0 = load %class.main.Counter*, %class.main.Counter** %self.addr
    %tmp1 = getelementptr %class.main.Counter, %class.main.Counter* %tmp0, i32 0, i32 0
    %tmp2 = load i64, i64* %tmp1
    %tmp3 = add i64 %tmp2, 1
    %tmp4 = load %class.main.Counter*, %class.main.Counter** %self.addr
    %tmp5 = getelementptr %class.main.Counter, %class.main.Counter* %tmp4, i32 0, i32 0
    store i64 %tmp3, i64* %tmp5
    ret void
}

define i64 @"main.Counter.get_val"(%class.main.Counter* %self) {
entry:
    %self.addr = alloca %class.main.Counter*
    store %class.main.Counter* %self, %class.main.Counter** %self.addr
    %tmp0 = load %class.main.Counter*, %class.main.Counter** %self.addr
    %tmp1 = getelementptr %class.main.Counter, %class.main.Counter* %tmp0, i32 0, i32 0
    %tmp2 = load i64, i64* %tmp1
    ret i64 %tmp2
}

define i64 @"main.Counter.double_val"(i64 %val) {
entry:
    %val.addr = alloca i64
    store i64 %val, i64* %val.addr
    %tmp0 = load i64, i64* %val.addr
    %tmp1 = mul i64 %tmp0, 2
    ret i64 %tmp1
}

define void @"main.Counter.destroy"(%class.main.Counter* %self) {
entry:
    %self.addr = alloca %class.main.Counter*
    store %class.main.Counter* %self, %class.main.Counter** %self.addr
    ret void
}

define i64 @main() {
entry:
    %c.addr.0 = alloca %class.main.Counter
    %tmp0 = alloca %class.main.Counter
    %v.addr.1 = alloca i64
    call void @"main.Counter.init"(%class.main.Counter* %tmp0, i64 20)
    %tmp1 = load %class.main.Counter, %class.main.Counter* %tmp0
    store %class.main.Counter %tmp1, %class.main.Counter* %c.addr.0
    call void @"main.Counter.increment"(%class.main.Counter* %c.addr.0)
    %tmp2 = call i64 @"main.Counter.get_val"(%class.main.Counter* %c.addr.0)
    store i64 %tmp2, i64* %v.addr.1
    %tmp3 = load i64, i64* %v.addr.1
    %tmp4 = call i64 @"main.Counter.double_val"(i64 %tmp3)
    call void @"main.Counter.destroy"(%class.main.Counter* %c.addr.0)
    ret i64 %tmp4
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
