; Atlas compiler v0.1.0 — auto-generated LLVM IR
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.string.String = type { i8*, i64 }

@.str.0 = private unnamed_addr constant [12 x i8] c"Hello World\00", align 1

declare i8* @malloc(i64)
declare void @free(i8*)
declare i8* @memcpy(i8*, i8*, i64)
define void @"string.String.init"(%class.string.String* %self) {
entry:
    %self.addr = alloca %class.string.String*
    store %class.string.String* %self, %class.string.String** %self.addr
    %tmp0 = call i8* @"malloc"(i64 1)
    %tmp1 = load %class.string.String*, %class.string.String** %self.addr
    %tmp2 = getelementptr %class.string.String, %class.string.String* %tmp1, i32 0, i32 0
    store i8* %tmp0, i8** %tmp2
    %tmp3 = load %class.string.String*, %class.string.String** %self.addr
    %tmp4 = getelementptr %class.string.String, %class.string.String* %tmp3, i32 0, i32 0
    %tmp5 = load i8*, i8** %tmp4
    %tmp6 = getelementptr i8, i8* %tmp5, i64 0
    store i8 0, i8* %tmp6
    %tmp7 = load %class.string.String*, %class.string.String** %self.addr
    %tmp8 = getelementptr %class.string.String, %class.string.String* %tmp7, i32 0, i32 1
    store i64 0, i64* %tmp8
    ret void
}

define void @"string.String.destroy"(%class.string.String* %self) {
entry:
    %self.addr = alloca %class.string.String*
    store %class.string.String* %self, %class.string.String** %self.addr
    %tmp0 = load %class.string.String*, %class.string.String** %self.addr
    %tmp1 = getelementptr %class.string.String, %class.string.String* %tmp0, i32 0, i32 0
    %tmp2 = load i8*, i8** %tmp1
    call void @"free"(i8* %tmp2)
    ret void
}

define i64 @"string.String.length"(%class.string.String* %self) {
entry:
    %self.addr = alloca %class.string.String*
    store %class.string.String* %self, %class.string.String** %self.addr
    %tmp0 = load %class.string.String*, %class.string.String** %self.addr
    %tmp1 = getelementptr %class.string.String, %class.string.String* %tmp0, i32 0, i32 1
    %tmp2 = load i64, i64* %tmp1
    ret i64 %tmp2
}

define i8* @"string.String.c_str"(%class.string.String* %self) {
entry:
    %self.addr = alloca %class.string.String*
    store %class.string.String* %self, %class.string.String** %self.addr
    %tmp0 = load %class.string.String*, %class.string.String** %self.addr
    %tmp1 = getelementptr %class.string.String, %class.string.String* %tmp0, i32 0, i32 0
    %tmp2 = load i8*, i8** %tmp1
    ret i8* %tmp2
}

define %class.string.String @"string.String.from"({ i8*, i64 } %chars) {
entry:
    %chars.addr = alloca { i8*, i64 }
    %s.addr.0 = alloca %class.string.String
    %tmp0 = alloca %class.string.String
    %n.addr.1 = alloca i64
    %i.addr.2 = alloca i64
    store { i8*, i64 } %chars, { i8*, i64 }* %chars.addr
    call void @"string.String.init"(%class.string.String* %tmp0)
    %tmp1 = load %class.string.String, %class.string.String* %tmp0
    store %class.string.String %tmp1, %class.string.String* %s.addr.0
    %tmp2 = getelementptr %class.string.String, %class.string.String* %s.addr.0, i32 0, i32 0
    %tmp3 = load i8*, i8** %tmp2
    call void @"free"(i8* %tmp3)
    %tmp4 = getelementptr { i8*, i64 }, { i8*, i64 }* %chars.addr, i32 0, i32 1
    %tmp5 = load i64, i64* %tmp4
    store i64 %tmp5, i64* %n.addr.1
    %tmp6 = load i64, i64* %n.addr.1
    %tmp7 = getelementptr %class.string.String, %class.string.String* %s.addr.0, i32 0, i32 1
    store i64 %tmp6, i64* %tmp7
    %tmp8 = load i64, i64* %n.addr.1
    %tmp9 = add i64 %tmp8, 1
    %tmp10 = call i8* @"malloc"(i64 %tmp9)
    %tmp11 = getelementptr %class.string.String, %class.string.String* %s.addr.0, i32 0, i32 0
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
    %tmp21 = getelementptr %class.string.String, %class.string.String* %s.addr.0, i32 0, i32 0
    %tmp22 = load i8*, i8** %tmp21
    %tmp23 = getelementptr i8, i8* %tmp22, i64 %tmp20
    store i8 %tmp19, i8* %tmp23
    %tmp24 = load i64, i64* %i.addr.2
    %tmp25 = add i64 %tmp24, 1
    store i64 %tmp25, i64* %i.addr.2
    br label %while.cond.0
while.end.0:
    %tmp26 = load i64, i64* %n.addr.1
    %tmp27 = getelementptr %class.string.String, %class.string.String* %s.addr.0, i32 0, i32 0
    %tmp28 = load i8*, i8** %tmp27
    %tmp29 = getelementptr i8, i8* %tmp28, i64 %tmp26
    store i8 0, i8* %tmp29
    %tmp30 = load %class.string.String, %class.string.String* %s.addr.0
    ret %class.string.String %tmp30
}

define i64 @"string.String.hash"(%class.string.String* %self) {
entry:
    %self.addr = alloca %class.string.String*
    %h.addr.3 = alloca i64
    %i.addr.4 = alloca i64
    store %class.string.String* %self, %class.string.String** %self.addr
    store i64 0, i64* %h.addr.3
    store i64 0, i64* %i.addr.4
    br label %while.cond.1
while.cond.1:
    %tmp0 = load i64, i64* %i.addr.4
    %tmp1 = load %class.string.String*, %class.string.String** %self.addr
    %tmp2 = getelementptr %class.string.String, %class.string.String* %tmp1, i32 0, i32 1
    %tmp3 = load i64, i64* %tmp2
    %tmp4 = icmp slt i64 %tmp0, %tmp3
    br i1 %tmp4, label %while.body.1, label %while.end.1
while.body.1:
    %tmp5 = load i64, i64* %h.addr.3
    %tmp6 = mul i64 %tmp5, 31
    %tmp7 = load i64, i64* %i.addr.4
    %tmp8 = load %class.string.String*, %class.string.String** %self.addr
    %tmp9 = getelementptr %class.string.String, %class.string.String* %tmp8, i32 0, i32 0
    %tmp10 = load i8*, i8** %tmp9
    %tmp11 = getelementptr i8, i8* %tmp10, i64 %tmp7
    %tmp12 = load i8, i8* %tmp11
    %tmp13 = sext i8 %tmp12 to i64
    %tmp14 = add i64 %tmp6, %tmp13
    store i64 %tmp14, i64* %h.addr.3
    %tmp15 = load i64, i64* %i.addr.4
    %tmp16 = add i64 %tmp15, 1
    store i64 %tmp16, i64* %i.addr.4
    br label %while.cond.1
while.end.1:
    %tmp17 = load i64, i64* %h.addr.3
    ret i64 %tmp17
}

define i1 @"string.String.equals"(%class.string.String* %self, %class.string.String* %other) {
entry:
    %self.addr = alloca %class.string.String*
    %other.addr = alloca %class.string.String*
    %i.addr.5 = alloca i64
    store %class.string.String* %self, %class.string.String** %self.addr
    store %class.string.String* %other, %class.string.String** %other.addr
    %tmp0 = load %class.string.String*, %class.string.String** %self.addr
    %tmp1 = getelementptr %class.string.String, %class.string.String* %tmp0, i32 0, i32 1
    %tmp2 = load i64, i64* %tmp1
    %tmp3 = load %class.string.String*, %class.string.String** %other.addr
    %tmp4 = getelementptr %class.string.String, %class.string.String* %tmp3, i32 0, i32 1
    %tmp5 = load i64, i64* %tmp4
    %tmp6 = icmp ne i64 %tmp2, %tmp5
    br i1 %tmp6, label %if.then.2, label %if.end.2
if.then.2:
    ret i1 0
if.end.2:
    store i64 0, i64* %i.addr.5
    br label %while.cond.3
while.cond.3:
    %tmp7 = load i64, i64* %i.addr.5
    %tmp8 = load %class.string.String*, %class.string.String** %self.addr
    %tmp9 = getelementptr %class.string.String, %class.string.String* %tmp8, i32 0, i32 1
    %tmp10 = load i64, i64* %tmp9
    %tmp11 = icmp slt i64 %tmp7, %tmp10
    br i1 %tmp11, label %while.body.3, label %while.end.3
while.body.3:
    %tmp12 = load i64, i64* %i.addr.5
    %tmp13 = load %class.string.String*, %class.string.String** %self.addr
    %tmp14 = getelementptr %class.string.String, %class.string.String* %tmp13, i32 0, i32 0
    %tmp15 = load i8*, i8** %tmp14
    %tmp16 = getelementptr i8, i8* %tmp15, i64 %tmp12
    %tmp17 = load i8, i8* %tmp16
    %tmp18 = load i64, i64* %i.addr.5
    %tmp19 = load %class.string.String*, %class.string.String** %other.addr
    %tmp20 = getelementptr %class.string.String, %class.string.String* %tmp19, i32 0, i32 0
    %tmp21 = load i8*, i8** %tmp20
    %tmp22 = getelementptr i8, i8* %tmp21, i64 %tmp18
    %tmp23 = load i8, i8* %tmp22
    %tmp24 = icmp ne i8 %tmp17, %tmp23
    br i1 %tmp24, label %if.then.4, label %if.end.4
if.then.4:
    ret i1 0
if.end.4:
    %tmp25 = load i64, i64* %i.addr.5
    %tmp26 = add i64 %tmp25, 1
    store i64 %tmp26, i64* %i.addr.5
    br label %while.cond.3
while.end.3:
    ret i1 1
}

declare i64 @puts(i8*)
define i64 @main() {
entry:
    %s.addr.6 = alloca %class.string.String
    %slice.alloca.7 = alloca { i8*, i64 }
    %tmp5 = alloca %class.string.String
    %tmp0 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.0, i64 0, i64 0
    %tmp1 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.7, i32 0, i32 0
    store i8* %tmp0, i8** %tmp1
    %tmp2 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.7, i32 0, i32 1
    store i64 11, i64* %tmp2
    %tmp3 = load { i8*, i64 }, { i8*, i64 }* %slice.alloca.7
    %tmp4 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp3)
    store %class.string.String %tmp4, %class.string.String* %tmp5
    %tmp6 = load %class.string.String, %class.string.String* %tmp5
    store %class.string.String %tmp6, %class.string.String* %s.addr.6
    %tmp7 = call i8* @"string.String.c_str"(%class.string.String* %s.addr.6)
    %tmp8 = call i64 @"puts"(i8* %tmp7)
    call void @"string.String.destroy"(%class.string.String* %s.addr.6)
    ret i64 0
}


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
