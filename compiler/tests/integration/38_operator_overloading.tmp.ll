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
    %tmp6 = alloca %class.main.Vec2
    call void @"main.Vec2.init"(%class.main.Vec2* %tmp0, i64 10, i64 20)
    %tmp1 = load %class.main.Vec2, %class.main.Vec2* %tmp0
    store %class.main.Vec2 %tmp1, %class.main.Vec2* %a.addr.1
    call void @"main.Vec2.init"(%class.main.Vec2* %tmp2, i64 5, i64 5)
    %tmp3 = load %class.main.Vec2, %class.main.Vec2* %tmp2
    store %class.main.Vec2 %tmp3, %class.main.Vec2* %b.addr.2
    %tmp5 = call %class.main.Vec2 @"main.Vec2.operator_add"(%class.main.Vec2* %a.addr.1, %class.main.Vec2* %b.addr.2)
    store %class.main.Vec2 %tmp5, %class.main.Vec2* %tmp6
    %tmp7 = load %class.main.Vec2, %class.main.Vec2* %tmp6
    store %class.main.Vec2 %tmp7, %class.main.Vec2* %c.addr.3
    %tmp8 = getelementptr %class.main.Vec2, %class.main.Vec2* %c.addr.3, i32 0, i32 0
    %tmp9 = load i64, i64* %tmp8
    %tmp10 = getelementptr %class.main.Vec2, %class.main.Vec2* %c.addr.3, i32 0, i32 1
    %tmp11 = load i64, i64* %tmp10
    %tmp12 = add i64 %tmp9, %tmp11
    call void @"main.Vec2.destroy"(%class.main.Vec2* %c.addr.3)
    call void @"main.Vec2.destroy"(%class.main.Vec2* %b.addr.2)
    call void @"main.Vec2.destroy"(%class.main.Vec2* %a.addr.1)
    ret i64 %tmp12
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

