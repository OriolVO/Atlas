; Atlas compiler v0.1.0 — auto-generated LLVM IR
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.main.State = type { i64 }

%class.main.Tracker = type { %struct.main.State* }

declare i8* @malloc(i64)
declare void @free(i8*)
declare i8* @memcpy(i8*, i8*, i64)
define void @"main.Tracker.init"(%class.main.Tracker* %self, %struct.main.State* %st) {
entry:
    %self.addr = alloca %class.main.Tracker*
    %st.addr = alloca %struct.main.State*
    store %class.main.Tracker* %self, %class.main.Tracker** %self.addr
    store %struct.main.State* %st, %struct.main.State** %st.addr
    %tmp0 = load %struct.main.State*, %struct.main.State** %st.addr
    %tmp1 = load %class.main.Tracker*, %class.main.Tracker** %self.addr
    %tmp2 = getelementptr %class.main.Tracker, %class.main.Tracker* %tmp1, i32 0, i32 0
    store %struct.main.State* %tmp0, %struct.main.State** %tmp2
    ret void
}

define void @"main.Tracker.destroy"(%class.main.Tracker* %self) {
entry:
    %self.addr = alloca %class.main.Tracker*
    store %class.main.Tracker* %self, %class.main.Tracker** %self.addr
    %tmp0 = load %class.main.Tracker*, %class.main.Tracker** %self.addr
    %tmp1 = getelementptr %class.main.Tracker, %class.main.Tracker* %tmp0, i32 0, i32 0
    %tmp2 = load %struct.main.State*, %struct.main.State** %tmp1
    %tmp3 = getelementptr %struct.main.State, %struct.main.State* %tmp2, i32 0, i32 0
    %tmp4 = load i64, i64* %tmp3
    %tmp5 = add i64 %tmp4, 1
    %tmp6 = load %class.main.Tracker*, %class.main.Tracker** %self.addr
    %tmp7 = getelementptr %class.main.Tracker, %class.main.Tracker* %tmp6, i32 0, i32 0
    %tmp8 = load %struct.main.State*, %struct.main.State** %tmp7
    %tmp9 = getelementptr %struct.main.State, %struct.main.State* %tmp8, i32 0, i32 0
    store i64 %tmp5, i64* %tmp9
    ret void
}

define void @"main.test_heap"(%struct.main.State* %st) {
entry:
    %st.addr = alloca %struct.main.State*
    %raw.addr.0 = alloca i8*
    %t.addr.1 = alloca %class.main.Tracker*
    store %struct.main.State* %st, %struct.main.State** %st.addr
    %tmp0 = getelementptr %class.main.Tracker, %class.main.Tracker* null, i32 1
    %tmp1 = ptrtoint %class.main.Tracker* %tmp0 to i64
    %tmp2 = call i8* @"malloc"(i64 %tmp1)
    store i8* %tmp2, i8** %raw.addr.0
    %tmp3 = load i8*, i8** %raw.addr.0
    %tmp4 = bitcast i8* %tmp3 to %class.main.Tracker*
    store %class.main.Tracker* %tmp4, %class.main.Tracker** %t.addr.1
    %tmp5 = load %struct.main.State*, %struct.main.State** %st.addr
    %tmp6 = load %class.main.Tracker*, %class.main.Tracker** %t.addr.1
    %tmp7 = getelementptr %class.main.Tracker, %class.main.Tracker* %tmp6, i32 0, i32 0
    store %struct.main.State* %tmp5, %struct.main.State** %tmp7
    %tmp8 = load %class.main.Tracker*, %class.main.Tracker** %t.addr.1
    call void @"main.Tracker.destroy"(%class.main.Tracker* %tmp8)
    %tmp9 = load i8*, i8** %raw.addr.0
    call void @"free"(i8* %tmp9)
    ret void
}

define i64 @main() {
entry:
    %st.addr.2 = alloca %struct.main.State
    %tmp0 = alloca %struct.main.State
    %tmp1 = getelementptr %struct.main.State, %struct.main.State* %tmp0, i32 0, i32 0
    store i64 0, i64* %tmp1
    %tmp2 = load %struct.main.State, %struct.main.State* %tmp0
    store %struct.main.State %tmp2, %struct.main.State* %st.addr.2
    call void @"main.test_heap"(%struct.main.State* %st.addr.2)
    %tmp3 = getelementptr %struct.main.State, %struct.main.State* %st.addr.2, i32 0, i32 0
    %tmp4 = load i64, i64* %tmp3
    %tmp5 = add i64 %tmp4, 41
    ret i64 %tmp5
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
