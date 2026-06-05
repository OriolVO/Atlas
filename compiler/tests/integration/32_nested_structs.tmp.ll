; Atlas compiler v0.1.0 — auto-generated LLVM IR
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.main.Parser.State = type { i64, i64 }
%struct.LocalPoint = type { i64, i64 }

%class.main.Parser = type { %struct.main.Parser.State* }

declare i8* @malloc(i64)
declare void @free(i8*)
define void @"main.Parser.init"(%class.main.Parser* %self) {
entry:
    %self.addr = alloca %class.main.Parser*
    store %class.main.Parser* %self, %class.main.Parser** %self.addr
    %tmp0 = call i8* @"malloc"(i64 16)
    %tmp1 = bitcast i8* %tmp0 to %struct.main.Parser.State*
    %tmp2 = load %class.main.Parser*, %class.main.Parser** %self.addr
    %tmp3 = getelementptr %class.main.Parser, %class.main.Parser* %tmp2, i32 0, i32 0
    store %struct.main.Parser.State* %tmp1, %struct.main.Parser.State** %tmp3
    %tmp4 = load %class.main.Parser*, %class.main.Parser** %self.addr
    %tmp5 = getelementptr %class.main.Parser, %class.main.Parser* %tmp4, i32 0, i32 0
    %tmp6 = load %struct.main.Parser.State*, %struct.main.Parser.State** %tmp5
    %tmp7 = getelementptr %struct.main.Parser.State, %struct.main.Parser.State* %tmp6, i32 0, i32 0
    store i64 0, i64* %tmp7
    %tmp8 = load %class.main.Parser*, %class.main.Parser** %self.addr
    %tmp9 = getelementptr %class.main.Parser, %class.main.Parser* %tmp8, i32 0, i32 0
    %tmp10 = load %struct.main.Parser.State*, %struct.main.Parser.State** %tmp9
    %tmp11 = getelementptr %struct.main.Parser.State, %struct.main.Parser.State* %tmp10, i32 0, i32 1
    store i64 0, i64* %tmp11
    ret void
}

define void @"main.Parser.advance"(%class.main.Parser* %self) {
entry:
    %self.addr = alloca %class.main.Parser*
    store %class.main.Parser* %self, %class.main.Parser** %self.addr
    %tmp0 = load %class.main.Parser*, %class.main.Parser** %self.addr
    %tmp1 = getelementptr %class.main.Parser, %class.main.Parser* %tmp0, i32 0, i32 0
    %tmp2 = load %struct.main.Parser.State*, %struct.main.Parser.State** %tmp1
    %tmp3 = getelementptr %struct.main.Parser.State, %struct.main.Parser.State* %tmp2, i32 0, i32 0
    %tmp4 = load i64, i64* %tmp3
    %tmp5 = add i64 %tmp4, 1
    %tmp6 = load %class.main.Parser*, %class.main.Parser** %self.addr
    %tmp7 = getelementptr %class.main.Parser, %class.main.Parser* %tmp6, i32 0, i32 0
    %tmp8 = load %struct.main.Parser.State*, %struct.main.Parser.State** %tmp7
    %tmp9 = getelementptr %struct.main.Parser.State, %struct.main.Parser.State* %tmp8, i32 0, i32 0
    store i64 %tmp5, i64* %tmp9
    ret void
}

define i64 @"main.Parser.get_index"(%class.main.Parser* %self) {
entry:
    %self.addr = alloca %class.main.Parser*
    store %class.main.Parser* %self, %class.main.Parser** %self.addr
    %tmp0 = load %class.main.Parser*, %class.main.Parser** %self.addr
    %tmp1 = getelementptr %class.main.Parser, %class.main.Parser* %tmp0, i32 0, i32 0
    %tmp2 = load %struct.main.Parser.State*, %struct.main.Parser.State** %tmp1
    %tmp3 = getelementptr %struct.main.Parser.State, %struct.main.Parser.State* %tmp2, i32 0, i32 0
    %tmp4 = load i64, i64* %tmp3
    ret i64 %tmp4
}

define void @"main.Parser.destroy"(%class.main.Parser* %self) {
entry:
    %self.addr = alloca %class.main.Parser*
    store %class.main.Parser* %self, %class.main.Parser** %self.addr
    ret void
}

define i64 @"main.local_struct_test"() {
entry:
    %pt.addr.0 = alloca %struct.LocalPoint
    %tmp0 = alloca %struct.LocalPoint
    %tmp1 = getelementptr %struct.LocalPoint, %struct.LocalPoint* %tmp0, i32 0, i32 0
    store i64 10, i64* %tmp1
    %tmp2 = getelementptr %struct.LocalPoint, %struct.LocalPoint* %tmp0, i32 0, i32 1
    store i64 20, i64* %tmp2
    %tmp3 = load %struct.LocalPoint, %struct.LocalPoint* %tmp0
    store %struct.LocalPoint %tmp3, %struct.LocalPoint* %pt.addr.0
    %tmp4 = getelementptr %struct.LocalPoint, %struct.LocalPoint* %pt.addr.0, i32 0, i32 0
    %tmp5 = load i64, i64* %tmp4
    %tmp6 = getelementptr %struct.LocalPoint, %struct.LocalPoint* %pt.addr.0, i32 0, i32 1
    %tmp7 = load i64, i64* %tmp6
    %tmp8 = add i64 %tmp5, %tmp7
    ret i64 %tmp8
}

define i64 @main() {
entry:
    %p.addr.1 = alloca %class.main.Parser
    %tmp0 = alloca %class.main.Parser
    %index.addr.2 = alloca i64
    %local_sum.addr.3 = alloca i64
    call void @"main.Parser.init"(%class.main.Parser* %tmp0)
    %tmp1 = load %class.main.Parser, %class.main.Parser* %tmp0
    store %class.main.Parser %tmp1, %class.main.Parser* %p.addr.1
    call void @"main.Parser.advance"(%class.main.Parser* %p.addr.1)
    call void @"main.Parser.advance"(%class.main.Parser* %p.addr.1)
    %tmp2 = call i64 @"main.Parser.get_index"(%class.main.Parser* %p.addr.1)
    store i64 %tmp2, i64* %index.addr.2
    %tmp3 = call i64 @"main.local_struct_test"()
    store i64 %tmp3, i64* %local_sum.addr.3
    %tmp4 = load i64, i64* %index.addr.2
    %tmp5 = icmp eq i64 %tmp4, 2
    br i1 %tmp5, label %if.then.0, label %if.end.0
if.then.0:
    %tmp6 = load i64, i64* %local_sum.addr.3
    %tmp7 = icmp eq i64 %tmp6, 30
    br i1 %tmp7, label %if.then.1, label %if.end.1
if.then.1:
    call void @"main.Parser.destroy"(%class.main.Parser* %p.addr.1)
    ret i64 0
if.end.1:
    br label %if.end.0
if.end.0:
    call void @"main.Parser.destroy"(%class.main.Parser* %p.addr.1)
    ret i64 1
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
