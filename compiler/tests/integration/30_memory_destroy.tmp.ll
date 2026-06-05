; Atlas compiler v0.1.0 — auto-generated LLVM IR
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.main.GlobalState = type { i64 }

%class.main.Resource = type { %struct.main.GlobalState* }
%class.main.PureClass = type { i64 }

declare i32 @putchar(i32)
define void @"main.Resource.init"(%class.main.Resource* %self, %struct.main.GlobalState* %state) {
entry:
    %self.addr = alloca %class.main.Resource*
    %state.addr = alloca %struct.main.GlobalState*
    store %class.main.Resource* %self, %class.main.Resource** %self.addr
    store %struct.main.GlobalState* %state, %struct.main.GlobalState** %state.addr
    %tmp0 = load %struct.main.GlobalState*, %struct.main.GlobalState** %state.addr
    %tmp1 = load %class.main.Resource*, %class.main.Resource** %self.addr
    %tmp2 = getelementptr %class.main.Resource, %class.main.Resource* %tmp1, i32 0, i32 0
    store %struct.main.GlobalState* %tmp0, %struct.main.GlobalState** %tmp2
    ret void
}

define void @"main.Resource.destroy"(%class.main.Resource* %self) {
entry:
    %self.addr = alloca %class.main.Resource*
    store %class.main.Resource* %self, %class.main.Resource** %self.addr
    %tmp0 = load %class.main.Resource*, %class.main.Resource** %self.addr
    %tmp1 = getelementptr %class.main.Resource, %class.main.Resource* %tmp0, i32 0, i32 0
    %tmp2 = load %struct.main.GlobalState*, %struct.main.GlobalState** %tmp1
    %tmp3 = getelementptr %struct.main.GlobalState, %struct.main.GlobalState* %tmp2, i32 0, i32 0
    store i64 42, i64* %tmp3
    ret void
}

define void @"main.PureClass.init"(%class.main.PureClass* %self) {
entry:
    %self.addr = alloca %class.main.PureClass*
    store %class.main.PureClass* %self, %class.main.PureClass** %self.addr
    %tmp0 = load %class.main.PureClass*, %class.main.PureClass** %self.addr
    %tmp1 = getelementptr %class.main.PureClass, %class.main.PureClass* %tmp0, i32 0, i32 0
    store i64 0, i64* %tmp1
    ret void
}

define void @"main.PureClass.destroy"(%class.main.PureClass* %self) {
entry:
    %self.addr = alloca %class.main.PureClass*
    store %class.main.PureClass* %self, %class.main.PureClass** %self.addr
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
    %state.addr.0 = alloca %struct.main.GlobalState
    %tmp0 = alloca %struct.main.GlobalState
    %r.addr.1 = alloca %class.main.Resource
    %tmp3 = alloca %class.main.Resource
    %x.addr.2 = alloca i64
    %s.addr.3 = alloca %struct.main.GlobalState
    %tmp9 = alloca %struct.main.GlobalState
    %p.addr.4 = alloca %class.main.PureClass
    %tmp12 = alloca %class.main.PureClass
    %tmp1 = getelementptr %struct.main.GlobalState, %struct.main.GlobalState* %tmp0, i32 0, i32 0
    store i64 0, i64* %tmp1
    %tmp2 = load %struct.main.GlobalState, %struct.main.GlobalState* %tmp0
    store %struct.main.GlobalState %tmp2, %struct.main.GlobalState* %state.addr.0
    call void @"main.Resource.init"(%class.main.Resource* %tmp3, %struct.main.GlobalState* %state.addr.0)
    %tmp4 = load %class.main.Resource, %class.main.Resource* %tmp3
    store %class.main.Resource %tmp4, %class.main.Resource* %r.addr.1
    call void @"main.Resource.destroy"(%class.main.Resource* %r.addr.1)
    %tmp5 = getelementptr %struct.main.GlobalState, %struct.main.GlobalState* %state.addr.0, i32 0, i32 0
    %tmp6 = load i64, i64* %tmp5
    %tmp7 = icmp ne i64 %tmp6, 42
    br i1 %tmp7, label %if.then.0, label %if.end.0
if.then.0:
    call void @"main.Resource.destroy"(%class.main.Resource* %r.addr.1)
    ret i64 1
if.end.0:
    store i64 100, i64* %x.addr.2
    %tmp8 = load i64, i64* %x.addr.2
    %tmp10 = getelementptr %struct.main.GlobalState, %struct.main.GlobalState* %tmp9, i32 0, i32 0
    store i64 1, i64* %tmp10
    %tmp11 = load %struct.main.GlobalState, %struct.main.GlobalState* %tmp9
    store %struct.main.GlobalState %tmp11, %struct.main.GlobalState* %s.addr.3
    call void @"main.PureClass.init"(%class.main.PureClass* %tmp12)
    %tmp13 = load %class.main.PureClass, %class.main.PureClass* %tmp12
    store %class.main.PureClass %tmp13, %class.main.PureClass* %p.addr.4
    call void @"main.PureClass.destroy"(%class.main.PureClass* %p.addr.4)
    call void @"main.print_char"(i32 52)
    call void @"main.print_char"(i32 50)
    call void @"main.print_char"(i32 10)
    call void @"main.PureClass.destroy"(%class.main.PureClass* %p.addr.4)
    call void @"main.Resource.destroy"(%class.main.Resource* %r.addr.1)
    ret i64 42
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

