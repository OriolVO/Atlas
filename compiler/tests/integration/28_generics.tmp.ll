; Atlas compiler v0.1.0 — auto-generated LLVM IR
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.main.ConsolePrinter = type {  }
%class.memory.Box_int = type { i64* }

declare i8* @malloc(i64)
declare void @free(i8*)
declare i8* @memcpy(i8*, i8*, i64)
declare i32 @putchar(i32)
define void @"main.print_char"(i32 %c) {
entry:
    %c.addr = alloca i32
    store i32 %c, i32* %c.addr
    %tmp0 = load i32, i32* %c.addr
    %tmp1 = call i32 @"putchar"(i32 %tmp0)
    ret void
}

define void @"main.ConsolePrinter.print_val"(%class.main.ConsolePrinter* %self, i64 %val) {
entry:
    %self.addr = alloca %class.main.ConsolePrinter*
    %val.addr = alloca i64
    store %class.main.ConsolePrinter* %self, %class.main.ConsolePrinter** %self.addr
    store i64 %val, i64* %val.addr
    call void @"main.print_char"(i32 52)
    call void @"main.print_char"(i32 50)
    call void @"main.print_char"(i32 10)
    ret void
}

define void @"main.ConsolePrinter.init"(%class.main.ConsolePrinter* %self) {
entry:
    %self.addr = alloca %class.main.ConsolePrinter*
    store %class.main.ConsolePrinter* %self, %class.main.ConsolePrinter** %self.addr
    ret void
}

define void @"main.ConsolePrinter.destroy"(%class.main.ConsolePrinter* %self) {
entry:
    %self.addr = alloca %class.main.ConsolePrinter*
    store %class.main.ConsolePrinter* %self, %class.main.ConsolePrinter** %self.addr
    ret void
}

define i64 @main() {
entry:
    %a.addr.0 = alloca i64
    %thirty_two.addr.1 = alloca i64
    %b.addr.2 = alloca %class.memory.Box_int
    %tmp2 = alloca %class.memory.Box_int
    %p.addr.3 = alloca %class.main.ConsolePrinter
    %tmp4 = alloca %class.main.ConsolePrinter
    %inner_val.addr.4 = alloca i64
    %tmp0 = call i64 @"main.identity_int"(i64 10)
    store i64 %tmp0, i64* %a.addr.0
    store i64 32, i64* %thirty_two.addr.1
    %tmp1 = call %class.memory.Box_int @"memory.new_box_int"(i64* %thirty_two.addr.1)
    store %class.memory.Box_int %tmp1, %class.memory.Box_int* %tmp2
    %tmp3 = load %class.memory.Box_int, %class.memory.Box_int* %tmp2
    store %class.memory.Box_int %tmp3, %class.memory.Box_int* %b.addr.2
    call void @"main.ConsolePrinter.init"(%class.main.ConsolePrinter* %tmp4)
    %tmp5 = load %class.main.ConsolePrinter, %class.main.ConsolePrinter* %tmp4
    store %class.main.ConsolePrinter %tmp5, %class.main.ConsolePrinter* %p.addr.3
    call void @"main.call_print_main.ConsolePrinter"(%class.main.ConsolePrinter* %p.addr.3, i64 42)
    %tmp6 = getelementptr %class.memory.Box_int, %class.memory.Box_int* %b.addr.2, i32 0, i32 0
    %tmp7 = load i64*, i64** %tmp6
    %tmp8 = load i64, i64* %tmp7
    store i64 %tmp8, i64* %inner_val.addr.4
    %tmp9 = load i64, i64* %a.addr.0
    %tmp10 = load i64, i64* %inner_val.addr.4
    %tmp11 = add i64 %tmp9, %tmp10
    call void @"main.ConsolePrinter.destroy"(%class.main.ConsolePrinter* %p.addr.3)
    call void @"memory.Box_int.destroy"(%class.memory.Box_int* %b.addr.2)
    ret i64 %tmp11
}

define i64 @"main.identity_int"(i64 %x) {
entry:
    %x.addr = alloca i64
    store i64 %x, i64* %x.addr
    %tmp0 = load i64, i64* %x.addr
    ret i64 %tmp0
}

define void @"memory.Box_int.destroy"(%class.memory.Box_int* %self) {
entry:
    %self.addr = alloca %class.memory.Box_int*
    store %class.memory.Box_int* %self, %class.memory.Box_int** %self.addr
    %tmp0 = load %class.memory.Box_int*, %class.memory.Box_int** %self.addr
    %tmp1 = getelementptr %class.memory.Box_int, %class.memory.Box_int* %tmp0, i32 0, i32 0
    %tmp2 = load i64*, i64** %tmp1
    %tmp3 = load i64, i64* %tmp2
    %tmp4 = load %class.memory.Box_int*, %class.memory.Box_int** %self.addr
    %tmp5 = getelementptr %class.memory.Box_int, %class.memory.Box_int* %tmp4, i32 0, i32 0
    %tmp6 = load i64*, i64** %tmp5
    %tmp7 = bitcast i64* %tmp6 to i8*
    call void @"free"(i8* %tmp7)
    ret void
}

define i64 @"memory.Box_int.get_val"(%class.memory.Box_int* %self) {
entry:
    %self.addr = alloca %class.memory.Box_int*
    store %class.memory.Box_int* %self, %class.memory.Box_int** %self.addr
    %tmp0 = load %class.memory.Box_int*, %class.memory.Box_int** %self.addr
    %tmp1 = getelementptr %class.memory.Box_int, %class.memory.Box_int* %tmp0, i32 0, i32 0
    %tmp2 = load i64*, i64** %tmp1
    %tmp3 = load i64, i64* %tmp2
    ret i64 %tmp3
}

define %class.memory.Box_int @"memory.new_box_int"(i64* %val) {
entry:
    %val.addr = alloca i64*
    %b.addr.5 = alloca %class.memory.Box_int
    %tmp0 = alloca %class.memory.Box_int
    %raw.addr.6 = alloca i8*
    %i.addr.7 = alloca i64
    store i64* %val, i64** %val.addr
    %tmp1 = load %class.memory.Box_int, %class.memory.Box_int* %tmp0
    store %class.memory.Box_int %tmp1, %class.memory.Box_int* %b.addr.5
    %tmp2 = getelementptr i64, i64* null, i32 1
    %tmp3 = ptrtoint i64* %tmp2 to i64
    %tmp4 = call i8* @"malloc"(i64 %tmp3)
    store i8* %tmp4, i8** %raw.addr.6
    %tmp5 = load i8*, i8** %raw.addr.6
    %tmp6 = bitcast i8* %tmp5 to i64*
    %tmp7 = getelementptr %class.memory.Box_int, %class.memory.Box_int* %b.addr.5, i32 0, i32 0
    store i64* %tmp6, i64** %tmp7
    %tmp8 = getelementptr %class.memory.Box_int, %class.memory.Box_int* %b.addr.5, i32 0, i32 0
    %tmp9 = load i64*, i64** %tmp8
    %tmp10 = bitcast i64* %tmp9 to i8*
    %tmp11 = load i64*, i64** %val.addr
    %tmp12 = bitcast i64* %tmp11 to i8*
    %tmp13 = getelementptr i64, i64* null, i32 1
    %tmp14 = ptrtoint i64* %tmp13 to i64
    %tmp15 = call i8* @"memcpy"(i8* %tmp10, i8* %tmp12, i64 %tmp14)
    store i64 0, i64* %i.addr.7
    br label %while.cond.0
while.cond.0:
    %tmp16 = load i64, i64* %i.addr.7
    %tmp17 = getelementptr i64, i64* null, i32 1
    %tmp18 = ptrtoint i64* %tmp17 to i64
    %tmp19 = icmp slt i64 %tmp16, %tmp18
    br i1 %tmp19, label %while.body.0, label %while.end.0
while.body.0:
    %tmp20 = load i64, i64* %i.addr.7
    %tmp21 = load i64*, i64** %val.addr
    %tmp22 = bitcast i64* %tmp21 to i8*
    %tmp23 = getelementptr i8, i8* %tmp22, i64 %tmp20
    store i8 0, i8* %tmp23
    %tmp24 = load i64, i64* %i.addr.7
    %tmp25 = add i64 %tmp24, 1
    store i64 %tmp25, i64* %i.addr.7
    br label %while.cond.0
while.end.0:
    %tmp26 = load %class.memory.Box_int, %class.memory.Box_int* %b.addr.5
    ret %class.memory.Box_int %tmp26
}

define void @"main.call_print_main.ConsolePrinter"(%class.main.ConsolePrinter* %printer, i64 %val) {
entry:
    %printer.addr = alloca %class.main.ConsolePrinter*
    %val.addr = alloca i64
    store %class.main.ConsolePrinter* %printer, %class.main.ConsolePrinter** %printer.addr
    store i64 %val, i64* %val.addr
    %tmp0 = load %class.main.ConsolePrinter*, %class.main.ConsolePrinter** %printer.addr
    %tmp1 = load i64, i64* %val.addr
    call void @"main.ConsolePrinter.print_val"(%class.main.ConsolePrinter* %tmp0, i64 %tmp1)
    ret void
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
