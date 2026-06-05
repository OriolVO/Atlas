; Atlas compiler v0.1.0 — auto-generated LLVM IR
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.main.Rect = type { %struct.main.Point, %struct.main.Point }
%struct.main.Point = type { i64, i64 }

define i64 @main() {
entry:
    %p1.addr.0 = alloca %struct.main.Point
    %tmp0 = alloca %struct.main.Point
    %p2.addr.1 = alloca %struct.main.Point
    %tmp4 = alloca %struct.main.Point
    %r.addr.2 = alloca %struct.main.Rect
    %tmp8 = alloca %struct.main.Rect
    %tmp1 = getelementptr %struct.main.Point, %struct.main.Point* %tmp0, i32 0, i32 0
    store i64 10, i64* %tmp1
    %tmp2 = getelementptr %struct.main.Point, %struct.main.Point* %tmp0, i32 0, i32 1
    store i64 20, i64* %tmp2
    %tmp3 = load %struct.main.Point, %struct.main.Point* %tmp0
    store %struct.main.Point %tmp3, %struct.main.Point* %p1.addr.0
    %tmp5 = getelementptr %struct.main.Point, %struct.main.Point* %tmp4, i32 0, i32 0
    store i64 30, i64* %tmp5
    %tmp6 = getelementptr %struct.main.Point, %struct.main.Point* %tmp4, i32 0, i32 1
    store i64 40, i64* %tmp6
    %tmp7 = load %struct.main.Point, %struct.main.Point* %tmp4
    store %struct.main.Point %tmp7, %struct.main.Point* %p2.addr.1
    %tmp9 = getelementptr %struct.main.Rect, %struct.main.Rect* %tmp8, i32 0, i32 0
    %tmp10 = load %struct.main.Point, %struct.main.Point* %p1.addr.0
    store %struct.main.Point %tmp10, %struct.main.Point* %tmp9
    %tmp11 = getelementptr %struct.main.Rect, %struct.main.Rect* %tmp8, i32 0, i32 1
    %tmp12 = load %struct.main.Point, %struct.main.Point* %p2.addr.1
    store %struct.main.Point %tmp12, %struct.main.Point* %tmp11
    %tmp13 = load %struct.main.Rect, %struct.main.Rect* %tmp8
    store %struct.main.Rect %tmp13, %struct.main.Rect* %r.addr.2
    %tmp14 = getelementptr %struct.main.Rect, %struct.main.Rect* %r.addr.2, i32 0, i32 1
    %tmp15 = getelementptr %struct.main.Point, %struct.main.Point* %tmp14, i32 0, i32 1
    store i64 40, i64* %tmp15
    %tmp16 = getelementptr %struct.main.Rect, %struct.main.Rect* %r.addr.2, i32 0, i32 0
    %tmp17 = getelementptr %struct.main.Point, %struct.main.Point* %tmp16, i32 0, i32 0
    %tmp18 = load i64, i64* %tmp17
    %tmp19 = getelementptr %struct.main.Rect, %struct.main.Rect* %r.addr.2, i32 0, i32 0
    %tmp20 = getelementptr %struct.main.Point, %struct.main.Point* %tmp19, i32 0, i32 1
    %tmp21 = load i64, i64* %tmp20
    %tmp22 = add i64 %tmp18, %tmp21
    %tmp23 = getelementptr %struct.main.Rect, %struct.main.Rect* %r.addr.2, i32 0, i32 1
    %tmp24 = getelementptr %struct.main.Point, %struct.main.Point* %tmp23, i32 0, i32 0
    %tmp25 = load i64, i64* %tmp24
    %tmp26 = add i64 %tmp22, %tmp25
    %tmp27 = getelementptr %struct.main.Rect, %struct.main.Rect* %r.addr.2, i32 0, i32 1
    %tmp28 = getelementptr %struct.main.Point, %struct.main.Point* %tmp27, i32 0, i32 1
    %tmp29 = load i64, i64* %tmp28
    %tmp30 = add i64 %tmp26, %tmp29
    ret i64 %tmp30
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
