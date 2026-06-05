; Atlas compiler v0.1.0 — auto-generated LLVM IR
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.main.String = type { i8*, i64 }

@.str.0 = private unnamed_addr constant [6 x i8] c"hello\00", align 1

declare i8* @malloc(i64)
declare void @free(i8*)
define void @"main.String.init"(%class.main.String* %self) {
entry:
    %self.addr = alloca %class.main.String*
    store %class.main.String* %self, %class.main.String** %self.addr
    %tmp0 = call i8* @"malloc"(i64 1)
    %tmp1 = load %class.main.String*, %class.main.String** %self.addr
    %tmp2 = getelementptr %class.main.String, %class.main.String* %tmp1, i32 0, i32 0
    store i8* %tmp0, i8** %tmp2
    %tmp3 = load %class.main.String*, %class.main.String** %self.addr
    %tmp4 = getelementptr %class.main.String, %class.main.String* %tmp3, i32 0, i32 0
    %tmp5 = load i8*, i8** %tmp4
    %tmp6 = getelementptr i8, i8* %tmp5, i64 0
    store i8 0, i8* %tmp6
    %tmp7 = load %class.main.String*, %class.main.String** %self.addr
    %tmp8 = getelementptr %class.main.String, %class.main.String* %tmp7, i32 0, i32 1
    store i64 0, i64* %tmp8
    ret void
}

define void @"main.String.destroy"(%class.main.String* %self) {
entry:
    %self.addr = alloca %class.main.String*
    store %class.main.String* %self, %class.main.String** %self.addr
    %tmp0 = load %class.main.String*, %class.main.String** %self.addr
    %tmp1 = getelementptr %class.main.String, %class.main.String* %tmp0, i32 0, i32 0
    %tmp2 = load i8*, i8** %tmp1
    call void @"free"(i8* %tmp2)
    ret void
}

define i64 @"main.String.length"(%class.main.String* %self) {
entry:
    %self.addr = alloca %class.main.String*
    store %class.main.String* %self, %class.main.String** %self.addr
    %tmp0 = load %class.main.String*, %class.main.String** %self.addr
    %tmp1 = getelementptr %class.main.String, %class.main.String* %tmp0, i32 0, i32 1
    %tmp2 = load i64, i64* %tmp1
    ret i64 %tmp2
}

define i8* @"main.String.c_str"(%class.main.String* %self) {
entry:
    %self.addr = alloca %class.main.String*
    store %class.main.String* %self, %class.main.String** %self.addr
    %tmp0 = load %class.main.String*, %class.main.String** %self.addr
    %tmp1 = getelementptr %class.main.String, %class.main.String* %tmp0, i32 0, i32 0
    %tmp2 = load i8*, i8** %tmp1
    ret i8* %tmp2
}

define %class.main.String @"main.String.from"({ i8*, i64 } %chars) {
entry:
    %chars.addr = alloca { i8*, i64 }
    %s.addr.0 = alloca %class.main.String
    %tmp0 = alloca %class.main.String
    %n.addr.1 = alloca i64
    %i.addr.2 = alloca i64
    store { i8*, i64 } %chars, { i8*, i64 }* %chars.addr
    call void @"main.String.init"(%class.main.String* %tmp0)
    %tmp1 = load %class.main.String, %class.main.String* %tmp0
    store %class.main.String %tmp1, %class.main.String* %s.addr.0
    %tmp2 = getelementptr %class.main.String, %class.main.String* %s.addr.0, i32 0, i32 0
    %tmp3 = load i8*, i8** %tmp2
    call void @"free"(i8* %tmp3)
    %tmp4 = getelementptr { i8*, i64 }, { i8*, i64 }* %chars.addr, i32 0, i32 1
    %tmp5 = load i64, i64* %tmp4
    store i64 %tmp5, i64* %n.addr.1
    %tmp6 = load i64, i64* %n.addr.1
    %tmp7 = getelementptr %class.main.String, %class.main.String* %s.addr.0, i32 0, i32 1
    store i64 %tmp6, i64* %tmp7
    %tmp8 = load i64, i64* %n.addr.1
    %tmp9 = add i64 %tmp8, 1
    %tmp10 = call i8* @"malloc"(i64 %tmp9)
    %tmp11 = getelementptr %class.main.String, %class.main.String* %s.addr.0, i32 0, i32 0
    store i8* %tmp10, i8** %tmp11
    store i64 0, i64* %i.addr.2
    br label %while.cond.0
while.cond.0:
    %tmp12 = load i64, i64* %i.addr.2
    %tmp13 = load i64, i64* %n.addr.1
    %tmp14 = icmp slt i64 %tmp12, %tmp13
    br i1 %tmp14, label %while.body.0, label %while.end.0
while.body.0:
    %tmp15 = load i64, i64* %i.addr.2
    %tmp16 = getelementptr { i8*, i64 }, { i8*, i64 }* %chars.addr, i32 0, i32 0
    %tmp17 = load i8*, i8** %tmp16
    %tmp18 = getelementptr i8, i8* %tmp17, i64 %tmp15
    %tmp19 = load i8, i8* %tmp18
    %tmp20 = load i64, i64* %i.addr.2
    %tmp21 = getelementptr %class.main.String, %class.main.String* %s.addr.0, i32 0, i32 0
    %tmp22 = load i8*, i8** %tmp21
    %tmp23 = getelementptr i8, i8* %tmp22, i64 %tmp20
    store i8 %tmp19, i8* %tmp23
    %tmp24 = load i64, i64* %i.addr.2
    %tmp25 = add i64 %tmp24, 1
    store i64 %tmp25, i64* %i.addr.2
    br label %while.cond.0
while.end.0:
    %tmp26 = load i64, i64* %n.addr.1
    %tmp27 = getelementptr %class.main.String, %class.main.String* %s.addr.0, i32 0, i32 0
    %tmp28 = load i8*, i8** %tmp27
    %tmp29 = getelementptr i8, i8* %tmp28, i64 %tmp26
    store i8 0, i8* %tmp29
    %tmp30 = load %class.main.String, %class.main.String* %s.addr.0
    ret %class.main.String %tmp30
}

define i64 @main() {
entry:
    %s.addr.3 = alloca %class.main.String
    %slice.alloca.4 = alloca { i8*, i64 }
    %string.obj.5 = alloca %class.main.String
    %tmp0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i64 0, i64 0
    %tmp1 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.4, i32 0, i32 0
    store i8* %tmp0, i8** %tmp1
    %tmp2 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.4, i32 0, i32 1
    store i64 5, i64* %tmp2
    %tmp3 = load { i8*, i64 }, { i8*, i64 }* %slice.alloca.4
    %tmp4 = call %class.main.String @"main.String.from"({ i8*, i64 } %tmp3)
    store %class.main.String %tmp4, %class.main.String* %string.obj.5
    %tmp5 = load %class.main.String, %class.main.String* %string.obj.5
    store %class.main.String %tmp5, %class.main.String* %s.addr.3
    %tmp6 = call i64 @"main.String.length"(%class.main.String* %s.addr.3)
    %tmp7 = add i64 %tmp6, 2
    call void @"main.String.destroy"(%class.main.String* %s.addr.3)
    ret i64 %tmp7
}


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

