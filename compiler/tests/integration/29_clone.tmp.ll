; Atlas compiler v0.1.0 — auto-generated LLVM IR
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.main.CustomClone = type { i64 }
%class.main.Simple = type { i64 }

declare i32 @putchar(i32)
define void @"main.Simple.init"(%class.main.Simple* %self, i64 %v) {
entry:
    %self.addr = alloca %class.main.Simple*
    %v.addr = alloca i64
    store %class.main.Simple* %self, %class.main.Simple** %self.addr
    store i64 %v, i64* %v.addr
    %tmp0 = load i64, i64* %v.addr
    %tmp1 = load %class.main.Simple*, %class.main.Simple** %self.addr
    %tmp2 = getelementptr %class.main.Simple, %class.main.Simple* %tmp1, i32 0, i32 0
    store i64 %tmp0, i64* %tmp2
    ret void
}

define void @"main.Simple.destroy"(%class.main.Simple* %self) {
entry:
    %self.addr = alloca %class.main.Simple*
    store %class.main.Simple* %self, %class.main.Simple** %self.addr
    ret void
}

define void @"main.CustomClone.init"(%class.main.CustomClone* %self, i64 %v) {
entry:
    %self.addr = alloca %class.main.CustomClone*
    %v.addr = alloca i64
    store %class.main.CustomClone* %self, %class.main.CustomClone** %self.addr
    store i64 %v, i64* %v.addr
    %tmp0 = load i64, i64* %v.addr
    %tmp1 = load %class.main.CustomClone*, %class.main.CustomClone** %self.addr
    %tmp2 = getelementptr %class.main.CustomClone, %class.main.CustomClone* %tmp1, i32 0, i32 0
    store i64 %tmp0, i64* %tmp2
    ret void
}

define %class.main.CustomClone @"main.CustomClone.clone"(%class.main.CustomClone* %self) {
entry:
    %self.addr = alloca %class.main.CustomClone*
    %copy.addr.0 = alloca %class.main.CustomClone
    %tmp0 = alloca %class.main.CustomClone
    store %class.main.CustomClone* %self, %class.main.CustomClone** %self.addr
    %tmp1 = load %class.main.CustomClone*, %class.main.CustomClone** %self.addr
    %tmp2 = getelementptr %class.main.CustomClone, %class.main.CustomClone* %tmp1, i32 0, i32 0
    %tmp3 = load i64, i64* %tmp2
    %tmp4 = add i64 %tmp3, 10
    call void @"main.CustomClone.init"(%class.main.CustomClone* %tmp0, i64 %tmp4)
    %tmp5 = load %class.main.CustomClone, %class.main.CustomClone* %tmp0
    store %class.main.CustomClone %tmp5, %class.main.CustomClone* %copy.addr.0
    %tmp6 = load %class.main.CustomClone, %class.main.CustomClone* %copy.addr.0
    ret %class.main.CustomClone %tmp6
}

define void @"main.CustomClone.destroy"(%class.main.CustomClone* %self) {
entry:
    %self.addr = alloca %class.main.CustomClone*
    store %class.main.CustomClone* %self, %class.main.CustomClone** %self.addr
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
    %s1.addr.1 = alloca %class.main.Simple
    %tmp0 = alloca %class.main.Simple
    %s2.addr.2 = alloca %class.main.Simple
    %clone.result.alloca.3 = alloca %class.main.Simple
    %res1.addr.4 = alloca i64
    %c1.addr.5 = alloca %class.main.CustomClone
    %tmp7 = alloca %class.main.CustomClone
    %c2.addr.6 = alloca %class.main.CustomClone
    %tmp10 = alloca %class.main.CustomClone
    %res2.addr.7 = alloca i64
    call void @"main.Simple.init"(%class.main.Simple* %tmp0, i64 10)
    %tmp1 = load %class.main.Simple, %class.main.Simple* %tmp0
    store %class.main.Simple %tmp1, %class.main.Simple* %s1.addr.1
    %tmp2 = load %class.main.Simple, %class.main.Simple* %s1.addr.1
    store %class.main.Simple %tmp2, %class.main.Simple* %clone.result.alloca.3
    %tmp3 = load %class.main.Simple, %class.main.Simple* %clone.result.alloca.3
    store %class.main.Simple %tmp3, %class.main.Simple* %s2.addr.2
    %tmp4 = getelementptr %class.main.Simple, %class.main.Simple* %s2.addr.2, i32 0, i32 0
    store i64 20, i64* %tmp4
    %tmp5 = getelementptr %class.main.Simple, %class.main.Simple* %s1.addr.1, i32 0, i32 0
    %tmp6 = load i64, i64* %tmp5
    store i64 %tmp6, i64* %res1.addr.4
    call void @"main.CustomClone.init"(%class.main.CustomClone* %tmp7, i64 22)
    %tmp8 = load %class.main.CustomClone, %class.main.CustomClone* %tmp7
    store %class.main.CustomClone %tmp8, %class.main.CustomClone* %c1.addr.5
    %tmp9 = call %class.main.CustomClone @"main.CustomClone.clone"(%class.main.CustomClone* %c1.addr.5)
    store %class.main.CustomClone %tmp9, %class.main.CustomClone* %tmp10
    %tmp11 = load %class.main.CustomClone, %class.main.CustomClone* %tmp10
    store %class.main.CustomClone %tmp11, %class.main.CustomClone* %c2.addr.6
    %tmp12 = getelementptr %class.main.CustomClone, %class.main.CustomClone* %c2.addr.6, i32 0, i32 0
    %tmp13 = load i64, i64* %tmp12
    store i64 %tmp13, i64* %res2.addr.7
    %tmp14 = load i64, i64* %res1.addr.4
    %tmp15 = load i64, i64* %res2.addr.7
    %tmp16 = add i64 %tmp14, %tmp15
    %tmp17 = icmp eq i64 %tmp16, 42
    br i1 %tmp17, label %if.then.0, label %if.end.0
if.then.0:
    call void @"main.print_char"(i32 52)
    call void @"main.print_char"(i32 50)
    call void @"main.print_char"(i32 10)
    call void @"main.CustomClone.destroy"(%class.main.CustomClone* %c2.addr.6)
    call void @"main.CustomClone.destroy"(%class.main.CustomClone* %c1.addr.5)
    call void @"main.Simple.destroy"(%class.main.Simple* %s2.addr.2)
    call void @"main.Simple.destroy"(%class.main.Simple* %s1.addr.1)
    ret i64 42
if.end.0:
    call void @"main.CustomClone.destroy"(%class.main.CustomClone* %c2.addr.6)
    call void @"main.CustomClone.destroy"(%class.main.CustomClone* %c1.addr.5)
    call void @"main.Simple.destroy"(%class.main.Simple* %s2.addr.2)
    call void @"main.Simple.destroy"(%class.main.Simple* %s1.addr.1)
    ret i64 0
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
