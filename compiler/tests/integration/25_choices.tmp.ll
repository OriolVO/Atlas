; Atlas compiler v0.1.0 — auto-generated LLVM IR
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%choice.main.OptionInt = type { i32, [8 x i8] }

define i64 @"main.get_val"(%choice.main.OptionInt %o) {
entry:
    %o.addr = alloca %choice.main.OptionInt
    %bind.alloca.0 = alloca i64
    store %choice.main.OptionInt %o, %choice.main.OptionInt* %o.addr
    %tmp0 = getelementptr %choice.main.OptionInt, %choice.main.OptionInt* %o.addr, i32 0, i32 0
    %tmp1 = load i32, i32* %tmp0
    %tmp2 = icmp eq i32 %tmp1, 0
    br i1 %tmp2, label %match.case.0.body.2, label %match.case.0.next.1
    
match.case.0.body.2:
    %tmp3 = getelementptr %choice.main.OptionInt, %choice.main.OptionInt* %o.addr, i32 0, i32 1
    %tmp4 = bitcast [8 x i8]* %tmp3 to i64*
    %tmp5 = load i64, i64* %tmp4
    store i64 %tmp5, i64* %bind.alloca.0
    %tmp6 = load i64, i64* %bind.alloca.0
    ret i64 %tmp6
    
match.case.0.next.1:
    %tmp7 = icmp eq i32 %tmp1, 1
    br i1 %tmp7, label %match.case.1.body.4, label %match.case.1.next.3
    
match.case.1.body.4:
    ret i64 0
    
match.case.1.next.3:
    br label %match.end.0
    
match.end.0:
    ret i64 0
}

define i64 @main() {
entry:
    %o.addr.1 = alloca %choice.main.OptionInt
    %choice.alloca.2 = alloca %choice.main.OptionInt
    %tmp0 = getelementptr %choice.main.OptionInt, %choice.main.OptionInt* %choice.alloca.2, i32 0, i32 0
    store i32 0, i32* %tmp0
    %tmp1 = getelementptr %choice.main.OptionInt, %choice.main.OptionInt* %choice.alloca.2, i32 0, i32 1
    %tmp2 = bitcast [8 x i8]* %tmp1 to i64*
    store i64 42, i64* %tmp2
    %tmp3 = load %choice.main.OptionInt, %choice.main.OptionInt* %choice.alloca.2
    store %choice.main.OptionInt %tmp3, %choice.main.OptionInt* %o.addr.1
    %tmp4 = load %choice.main.OptionInt, %choice.main.OptionInt* %o.addr.1
    %tmp5 = call i64 @"main.get_val"(%choice.main.OptionInt %tmp4)
    ret i64 %tmp5
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

