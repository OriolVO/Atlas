; Atlas compiler v0.1.0 — auto-generated LLVM IR
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.string.String = type { i8*, i64 }
%class.array.Array_string.String = type { %class.string.String*, i64, i64 }
%class.io.File = type { i8*, i1 }

@.str.0 = private unnamed_addr constant [6 x i8] c"Hello\00", align 1

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

declare i32 @putchar(i32)
declare i32 @puts(i8*)
declare i8* @fopen(i8*, i8*)
declare i32 @fclose(i8*)
declare i32 @fputs(i8*, i8*)
declare i32 @fgetc(i8*)
define void @"io.File.init"(%class.io.File* %self) {
entry:
    %self.addr = alloca %class.io.File*
    store %class.io.File* %self, %class.io.File** %self.addr
    %tmp0 = load %class.io.File*, %class.io.File** %self.addr
    %tmp1 = getelementptr %class.io.File, %class.io.File* %tmp0, i32 0, i32 0
    store i8* null, i8** %tmp1
    %tmp2 = load %class.io.File*, %class.io.File** %self.addr
    %tmp3 = getelementptr %class.io.File, %class.io.File* %tmp2, i32 0, i32 1
    store i1 0, i1* %tmp3
    ret void
}

define void @"io.File.destroy"(%class.io.File* %self) {
entry:
    %self.addr = alloca %class.io.File*
    store %class.io.File* %self, %class.io.File** %self.addr
    %tmp0 = load %class.io.File*, %class.io.File** %self.addr
    %tmp1 = getelementptr %class.io.File, %class.io.File* %tmp0, i32 0, i32 1
    %tmp2 = load i1, i1* %tmp1
    br i1 %tmp2, label %if.then.5, label %if.end.5
if.then.5:
    %tmp3 = load %class.io.File*, %class.io.File** %self.addr
    call void @"io.File.close"(%class.io.File* %tmp3)
    br label %if.end.5
if.end.5:
    ret void
}

define i1 @"io.File.open"(%class.io.File* %self, i8* %filename, i8* %mode) {
entry:
    %self.addr = alloca %class.io.File*
    %filename.addr = alloca i8*
    %mode.addr = alloca i8*
    store %class.io.File* %self, %class.io.File** %self.addr
    store i8* %filename, i8** %filename.addr
    store i8* %mode, i8** %mode.addr
    %tmp0 = load i8*, i8** %filename.addr
    %tmp1 = load i8*, i8** %mode.addr
    %tmp2 = call i8* @"fopen"(i8* %tmp0, i8* %tmp1)
    %tmp3 = load %class.io.File*, %class.io.File** %self.addr
    %tmp4 = getelementptr %class.io.File, %class.io.File* %tmp3, i32 0, i32 0
    store i8* %tmp2, i8** %tmp4
    %tmp5 = load %class.io.File*, %class.io.File** %self.addr
    %tmp6 = getelementptr %class.io.File, %class.io.File* %tmp5, i32 0, i32 0
    %tmp7 = load i8*, i8** %tmp6
    %tmp8 = icmp ne i8* %tmp7, null
    br i1 %tmp8, label %if.then.6, label %if.end.6
if.then.6:
    %tmp9 = load %class.io.File*, %class.io.File** %self.addr
    %tmp10 = getelementptr %class.io.File, %class.io.File* %tmp9, i32 0, i32 1
    store i1 1, i1* %tmp10
    ret i1 1
if.end.6:
    ret i1 0
}

define void @"io.File.close"(%class.io.File* %self) {
entry:
    %self.addr = alloca %class.io.File*
    store %class.io.File* %self, %class.io.File** %self.addr
    %tmp0 = load %class.io.File*, %class.io.File** %self.addr
    %tmp1 = getelementptr %class.io.File, %class.io.File* %tmp0, i32 0, i32 1
    %tmp2 = load i1, i1* %tmp1
    br i1 %tmp2, label %if.then.7, label %if.end.7
if.then.7:
    %tmp3 = load %class.io.File*, %class.io.File** %self.addr
    %tmp4 = getelementptr %class.io.File, %class.io.File* %tmp3, i32 0, i32 0
    %tmp5 = load i8*, i8** %tmp4
    %tmp6 = call i32 @"fclose"(i8* %tmp5)
    %tmp7 = load %class.io.File*, %class.io.File** %self.addr
    %tmp8 = getelementptr %class.io.File, %class.io.File* %tmp7, i32 0, i32 1
    store i1 0, i1* %tmp8
    %tmp9 = load %class.io.File*, %class.io.File** %self.addr
    %tmp10 = getelementptr %class.io.File, %class.io.File* %tmp9, i32 0, i32 0
    store i8* null, i8** %tmp10
    br label %if.end.7
if.end.7:
    ret void
}

define i1 @"io.File.write_string"(%class.io.File* %self, i8* %s) {
entry:
    %self.addr = alloca %class.io.File*
    %s.addr = alloca i8*
    store %class.io.File* %self, %class.io.File** %self.addr
    store i8* %s, i8** %s.addr
    %tmp0 = load %class.io.File*, %class.io.File** %self.addr
    %tmp1 = getelementptr %class.io.File, %class.io.File* %tmp0, i32 0, i32 1
    %tmp2 = load i1, i1* %tmp1
    br i1 %tmp2, label %if.then.8, label %if.end.8
if.then.8:
    %tmp3 = load i8*, i8** %s.addr
    %tmp4 = load %class.io.File*, %class.io.File** %self.addr
    %tmp5 = getelementptr %class.io.File, %class.io.File* %tmp4, i32 0, i32 0
    %tmp6 = load i8*, i8** %tmp5
    %tmp7 = call i32 @"fputs"(i8* %tmp3, i8* %tmp6)
    %tmp8 = icmp sge i32 %tmp7, 0
    ret i1 %tmp8
if.end.8:
    ret i1 0
}

define i64 @"io.File.read_char"(%class.io.File* %self) {
entry:
    %self.addr = alloca %class.io.File*
    store %class.io.File* %self, %class.io.File** %self.addr
    %tmp0 = load %class.io.File*, %class.io.File** %self.addr
    %tmp1 = getelementptr %class.io.File, %class.io.File* %tmp0, i32 0, i32 1
    %tmp2 = load i1, i1* %tmp1
    br i1 %tmp2, label %if.then.9, label %if.end.9
if.then.9:
    %tmp3 = load %class.io.File*, %class.io.File** %self.addr
    %tmp4 = getelementptr %class.io.File, %class.io.File* %tmp3, i32 0, i32 0
    %tmp5 = load i8*, i8** %tmp4
    %tmp6 = call i32 @"fgetc"(i8* %tmp5)
    %tmp7 = sext i32 %tmp6 to i64
    ret i64 %tmp7
if.end.9:
    %tmp8 = sub i64 0, 1
    ret i64 %tmp8
}

define void @"io.print_char"(i8 %c) {
entry:
    %c.addr = alloca i8
    store i8 %c, i8* %c.addr
    %tmp0 = load i8, i8* %c.addr
    %tmp1 = sext i8 %tmp0 to i32
    %tmp2 = call i32 @"putchar"(i32 %tmp1)
    ret void
}

define void @"io.print_str"(i8* %s) {
entry:
    %s.addr = alloca i8*
    %i.addr.6 = alloca i64
    store i8* %s, i8** %s.addr
    store i64 0, i64* %i.addr.6
    br label %while.cond.10
while.cond.10:
    %tmp0 = load i64, i64* %i.addr.6
    %tmp1 = load i8*, i8** %s.addr
    %tmp2 = getelementptr i8, i8* %tmp1, i64 %tmp0
    %tmp3 = load i8, i8* %tmp2
    %tmp4 = icmp ne i8 %tmp3, 0
    br i1 %tmp4, label %while.body.10, label %while.end.10
while.body.10:
    %tmp5 = load i64, i64* %i.addr.6
    %tmp6 = load i8*, i8** %s.addr
    %tmp7 = getelementptr i8, i8* %tmp6, i64 %tmp5
    %tmp8 = load i8, i8* %tmp7
    %tmp9 = sext i8 %tmp8 to i32
    %tmp10 = call i32 @"putchar"(i32 %tmp9)
    %tmp11 = load i64, i64* %i.addr.6
    %tmp12 = add i64 %tmp11, 1
    store i64 %tmp12, i64* %i.addr.6
    br label %while.cond.10
while.end.10:
    ret void
}

define void @"io.println_str"(i8* %s) {
entry:
    %s.addr = alloca i8*
    store i8* %s, i8** %s.addr
    %tmp0 = load i8*, i8** %s.addr
    %tmp1 = call i32 @"puts"(i8* %tmp0)
    ret void
}

declare void @exit(i32)
define i64 @main() {
entry:
    %arr.addr.7 = alloca %class.array.Array_string.String
    %tmp0 = alloca %class.array.Array_string.String
    %slice.alloca.8 = alloca { i8*, i64 }
    %tmp7 = alloca %class.string.String
    call void @"array.Array_string.String.init"(%class.array.Array_string.String* %tmp0)
    %tmp1 = load %class.array.Array_string.String, %class.array.Array_string.String* %tmp0
    store %class.array.Array_string.String %tmp1, %class.array.Array_string.String* %arr.addr.7
    %tmp2 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i64 0, i64 0
    %tmp3 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.8, i32 0, i32 0
    store i8* %tmp2, i8** %tmp3
    %tmp4 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.8, i32 0, i32 1
    store i64 5, i64* %tmp4
    %tmp5 = load { i8*, i64 }, { i8*, i64 }* %slice.alloca.8
    %tmp6 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp5)
    store %class.string.String %tmp6, %class.string.String* %tmp7
    %tmp8 = load %class.string.String, %class.string.String* %tmp7
    call void @"array.Array_string.String.push"(%class.array.Array_string.String* %arr.addr.7, %class.string.String %tmp8)
    call void @"array.Array_string.String.destroy"(%class.array.Array_string.String* %arr.addr.7)
    ret i64 0
}

define void @"array.Array_string.String.init"(%class.array.Array_string.String* %self) {
entry:
    %self.addr = alloca %class.array.Array_string.String*
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %self.addr
    %tmp0 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp1 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp0, i32 0, i32 1
    store i64 0, i64* %tmp1
    %tmp2 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp3 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp2, i32 0, i32 2
    store i64 0, i64* %tmp3
    %tmp4 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp5 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp4, i32 0, i32 0
    store %class.string.String* null, %class.string.String** %tmp5
    ret void
}

define i64 @"array.Array_string.String.length"(%class.array.Array_string.String* %self) {
entry:
    %self.addr = alloca %class.array.Array_string.String*
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %self.addr
    %tmp0 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp1 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp0, i32 0, i32 1
    %tmp2 = load i64, i64* %tmp1
    ret i64 %tmp2
}

define i64 @"array.Array_string.String.capacity"(%class.array.Array_string.String* %self) {
entry:
    %self.addr = alloca %class.array.Array_string.String*
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %self.addr
    %tmp0 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp1 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp0, i32 0, i32 2
    %tmp2 = load i64, i64* %tmp1
    ret i64 %tmp2
}

define void @"array.Array_string.String.push"(%class.array.Array_string.String* %self, %class.string.String %item) {
entry:
    %self.addr = alloca %class.array.Array_string.String*
    %item.addr = alloca %class.string.String
    %new_cap.addr.9 = alloca i64
    %new_data.addr.10 = alloca %class.string.String*
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %self.addr
    store %class.string.String %item, %class.string.String* %item.addr
    %tmp0 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp1 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp0, i32 0, i32 1
    %tmp2 = load i64, i64* %tmp1
    %tmp3 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp4 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp3, i32 0, i32 2
    %tmp5 = load i64, i64* %tmp4
    %tmp6 = icmp eq i64 %tmp2, %tmp5
    br i1 %tmp6, label %if.then.11, label %if.end.11
if.then.11:
    store i64 4, i64* %new_cap.addr.9
    %tmp7 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp8 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp7, i32 0, i32 2
    %tmp9 = load i64, i64* %tmp8
    %tmp10 = icmp sgt i64 %tmp9, 0
    br i1 %tmp10, label %if.then.12, label %if.end.12
if.then.12:
    %tmp11 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp12 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp11, i32 0, i32 2
    %tmp13 = load i64, i64* %tmp12
    %tmp14 = mul i64 %tmp13, 2
    store i64 %tmp14, i64* %new_cap.addr.9
    br label %if.end.12
if.end.12:
    %tmp15 = load i64, i64* %new_cap.addr.9
    %tmp16 = getelementptr %class.string.String, %class.string.String* null, i32 1
    %tmp17 = ptrtoint %class.string.String* %tmp16 to i64
    %tmp18 = mul i64 %tmp15, %tmp17
    %tmp19 = call i8* @"malloc"(i64 %tmp18)
    %tmp20 = bitcast i8* %tmp19 to %class.string.String*
    store %class.string.String* %tmp20, %class.string.String** %new_data.addr.10
    %tmp21 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp22 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp21, i32 0, i32 0
    %tmp23 = load %class.string.String*, %class.string.String** %tmp22
    %tmp24 = icmp ne %class.string.String* %tmp23, null
    br i1 %tmp24, label %if.then.13, label %if.end.13
if.then.13:
    %tmp25 = load %class.string.String*, %class.string.String** %new_data.addr.10
    %tmp26 = bitcast %class.string.String* %tmp25 to i8*
    %tmp27 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp28 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp27, i32 0, i32 0
    %tmp29 = load %class.string.String*, %class.string.String** %tmp28
    %tmp30 = bitcast %class.string.String* %tmp29 to i8*
    %tmp31 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp32 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp31, i32 0, i32 1
    %tmp33 = load i64, i64* %tmp32
    %tmp34 = getelementptr %class.string.String, %class.string.String* null, i32 1
    %tmp35 = ptrtoint %class.string.String* %tmp34 to i64
    %tmp36 = mul i64 %tmp33, %tmp35
    %tmp37 = call i8* @"memcpy"(i8* %tmp26, i8* %tmp30, i64 %tmp36)
    %tmp38 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp39 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp38, i32 0, i32 0
    %tmp40 = load %class.string.String*, %class.string.String** %tmp39
    %tmp41 = bitcast %class.string.String* %tmp40 to i8*
    call void @"free"(i8* %tmp41)
    br label %if.end.13
if.end.13:
    %tmp42 = load i64, i64* %new_cap.addr.9
    %tmp43 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp44 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp43, i32 0, i32 2
    store i64 %tmp42, i64* %tmp44
    %tmp45 = load %class.string.String*, %class.string.String** %new_data.addr.10
    %tmp46 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp47 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp46, i32 0, i32 0
    store %class.string.String* %tmp45, %class.string.String** %tmp47
    br label %if.end.11
if.end.11:
    %tmp48 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp49 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp48, i32 0, i32 1
    %tmp50 = load i64, i64* %tmp49
    %tmp51 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp52 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp51, i32 0, i32 0
    %tmp53 = load %class.string.String*, %class.string.String** %tmp52
    %tmp54 = getelementptr %class.string.String, %class.string.String* %tmp53, i64 %tmp50
    %tmp55 = bitcast %class.string.String* %tmp54 to i8*
    %tmp56 = bitcast %class.string.String* %item.addr to i8*
    %tmp57 = getelementptr %class.string.String, %class.string.String* null, i32 1
    %tmp58 = ptrtoint %class.string.String* %tmp57 to i64
    %tmp59 = call i8* @"memcpy"(i8* %tmp55, i8* %tmp56, i64 %tmp58)
    %tmp60 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp61 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp60, i32 0, i32 1
    %tmp62 = load i64, i64* %tmp61
    %tmp63 = add i64 %tmp62, 1
    %tmp64 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp65 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp64, i32 0, i32 1
    store i64 %tmp63, i64* %tmp65
    ret void
}

define %class.string.String @"array.Array_string.String.pop"(%class.array.Array_string.String* %self) {
entry:
    %self.addr = alloca %class.array.Array_string.String*
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %self.addr
    %tmp0 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp1 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp0, i32 0, i32 1
    %tmp2 = load i64, i64* %tmp1
    %tmp3 = icmp eq i64 %tmp2, 0
    br i1 %tmp3, label %if.then.14, label %if.end.14
if.then.14:
    %tmp4 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp4)
    br label %if.end.14
if.end.14:
    %tmp5 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp6 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp5, i32 0, i32 1
    %tmp7 = load i64, i64* %tmp6
    %tmp8 = sub i64 %tmp7, 1
    %tmp9 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp10 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp9, i32 0, i32 1
    store i64 %tmp8, i64* %tmp10
    %tmp11 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp12 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp11, i32 0, i32 1
    %tmp13 = load i64, i64* %tmp12
    %tmp14 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp15 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp14, i32 0, i32 0
    %tmp16 = load %class.string.String*, %class.string.String** %tmp15
    %tmp17 = getelementptr %class.string.String, %class.string.String* %tmp16, i64 %tmp13
    %tmp18 = load %class.string.String, %class.string.String* %tmp17
    ret %class.string.String %tmp18
}

define %class.string.String @"array.Array_string.String.operator_index"(%class.array.Array_string.String* %self, i64 %index) {
entry:
    %self.addr = alloca %class.array.Array_string.String*
    %index.addr = alloca i64
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %self.addr
    store i64 %index, i64* %index.addr
    %tmp0 = load i64, i64* %index.addr
    %tmp1 = icmp slt i64 %tmp0, 0
    %tmp2 = load i64, i64* %index.addr
    %tmp3 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp4 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp3, i32 0, i32 1
    %tmp5 = load i64, i64* %tmp4
    %tmp6 = icmp sge i64 %tmp2, %tmp5
    %tmp7 = or i1 %tmp1, %tmp6
    br i1 %tmp7, label %if.then.15, label %if.end.15
if.then.15:
    %tmp8 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp8)
    br label %if.end.15
if.end.15:
    %tmp9 = load i64, i64* %index.addr
    %tmp10 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp11 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp10, i32 0, i32 0
    %tmp12 = load %class.string.String*, %class.string.String** %tmp11
    %tmp13 = getelementptr %class.string.String, %class.string.String* %tmp12, i64 %tmp9
    %tmp14 = load %class.string.String, %class.string.String* %tmp13
    ret %class.string.String %tmp14
}

define void @"array.Array_string.String.operator_index_set"(%class.array.Array_string.String* %self, i64 %index, %class.string.String %item) {
entry:
    %self.addr = alloca %class.array.Array_string.String*
    %index.addr = alloca i64
    %item.addr = alloca %class.string.String
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %self.addr
    store i64 %index, i64* %index.addr
    store %class.string.String %item, %class.string.String* %item.addr
    %tmp0 = load i64, i64* %index.addr
    %tmp1 = icmp slt i64 %tmp0, 0
    %tmp2 = load i64, i64* %index.addr
    %tmp3 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp4 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp3, i32 0, i32 1
    %tmp5 = load i64, i64* %tmp4
    %tmp6 = icmp sge i64 %tmp2, %tmp5
    %tmp7 = or i1 %tmp1, %tmp6
    br i1 %tmp7, label %if.then.16, label %if.end.16
if.then.16:
    %tmp8 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp8)
    br label %if.end.16
if.end.16:
    %tmp9 = load i64, i64* %index.addr
    %tmp10 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp11 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp10, i32 0, i32 0
    %tmp12 = load %class.string.String*, %class.string.String** %tmp11
    %tmp13 = getelementptr %class.string.String, %class.string.String* %tmp12, i64 %tmp9
    call void @"string.String.destroy"(%class.string.String* %tmp13)
    %tmp14 = load i64, i64* %index.addr
    %tmp15 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp16 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp15, i32 0, i32 0
    %tmp17 = load %class.string.String*, %class.string.String** %tmp16
    %tmp18 = getelementptr %class.string.String, %class.string.String* %tmp17, i64 %tmp14
    %tmp19 = bitcast %class.string.String* %tmp18 to i8*
    %tmp20 = bitcast %class.string.String* %item.addr to i8*
    %tmp21 = getelementptr %class.string.String, %class.string.String* null, i32 1
    %tmp22 = ptrtoint %class.string.String* %tmp21 to i64
    %tmp23 = call i8* @"memcpy"(i8* %tmp19, i8* %tmp20, i64 %tmp22)
    ret void
}

define void @"array.Array_string.String.insert"(%class.array.Array_string.String* %self, i64 %index, %class.string.String %item) {
entry:
    %self.addr = alloca %class.array.Array_string.String*
    %index.addr = alloca i64
    %item.addr = alloca %class.string.String
    %new_cap.addr.11 = alloca i64
    %new_data.addr.12 = alloca %class.string.String*
    %i.addr.13 = alloca i64
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %self.addr
    store i64 %index, i64* %index.addr
    store %class.string.String %item, %class.string.String* %item.addr
    %tmp0 = load i64, i64* %index.addr
    %tmp1 = icmp slt i64 %tmp0, 0
    %tmp2 = load i64, i64* %index.addr
    %tmp3 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp4 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp3, i32 0, i32 1
    %tmp5 = load i64, i64* %tmp4
    %tmp6 = icmp sgt i64 %tmp2, %tmp5
    %tmp7 = or i1 %tmp1, %tmp6
    br i1 %tmp7, label %if.then.17, label %if.end.17
if.then.17:
    %tmp8 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp8)
    br label %if.end.17
if.end.17:
    %tmp9 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp10 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp9, i32 0, i32 1
    %tmp11 = load i64, i64* %tmp10
    %tmp12 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp13 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp12, i32 0, i32 2
    %tmp14 = load i64, i64* %tmp13
    %tmp15 = icmp eq i64 %tmp11, %tmp14
    br i1 %tmp15, label %if.then.18, label %if.else.18
if.then.18:
    store i64 4, i64* %new_cap.addr.11
    %tmp16 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp17 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp16, i32 0, i32 2
    %tmp18 = load i64, i64* %tmp17
    %tmp19 = icmp sgt i64 %tmp18, 0
    br i1 %tmp19, label %if.then.19, label %if.end.19
if.then.19:
    %tmp20 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp21 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp20, i32 0, i32 2
    %tmp22 = load i64, i64* %tmp21
    %tmp23 = mul i64 %tmp22, 2
    store i64 %tmp23, i64* %new_cap.addr.11
    br label %if.end.19
if.end.19:
    %tmp24 = load i64, i64* %new_cap.addr.11
    %tmp25 = getelementptr %class.string.String, %class.string.String* null, i32 1
    %tmp26 = ptrtoint %class.string.String* %tmp25 to i64
    %tmp27 = mul i64 %tmp24, %tmp26
    %tmp28 = call i8* @"malloc"(i64 %tmp27)
    %tmp29 = bitcast i8* %tmp28 to %class.string.String*
    store %class.string.String* %tmp29, %class.string.String** %new_data.addr.12
    %tmp30 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp31 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp30, i32 0, i32 0
    %tmp32 = load %class.string.String*, %class.string.String** %tmp31
    %tmp33 = icmp ne %class.string.String* %tmp32, null
    br i1 %tmp33, label %if.then.20, label %if.end.20
if.then.20:
    %tmp34 = load i64, i64* %index.addr
    %tmp35 = icmp sgt i64 %tmp34, 0
    br i1 %tmp35, label %if.then.21, label %if.end.21
if.then.21:
    %tmp36 = load %class.string.String*, %class.string.String** %new_data.addr.12
    %tmp37 = bitcast %class.string.String* %tmp36 to i8*
    %tmp38 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp39 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp38, i32 0, i32 0
    %tmp40 = load %class.string.String*, %class.string.String** %tmp39
    %tmp41 = bitcast %class.string.String* %tmp40 to i8*
    %tmp42 = load i64, i64* %index.addr
    %tmp43 = getelementptr %class.string.String, %class.string.String* null, i32 1
    %tmp44 = ptrtoint %class.string.String* %tmp43 to i64
    %tmp45 = mul i64 %tmp42, %tmp44
    %tmp46 = call i8* @"memcpy"(i8* %tmp37, i8* %tmp41, i64 %tmp45)
    br label %if.end.21
if.end.21:
    %tmp47 = load i64, i64* %index.addr
    %tmp48 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp49 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp48, i32 0, i32 1
    %tmp50 = load i64, i64* %tmp49
    %tmp51 = icmp slt i64 %tmp47, %tmp50
    br i1 %tmp51, label %if.then.22, label %if.end.22
if.then.22:
    %tmp52 = load i64, i64* %index.addr
    %tmp53 = add i64 %tmp52, 1
    %tmp54 = load %class.string.String*, %class.string.String** %new_data.addr.12
    %tmp55 = getelementptr %class.string.String, %class.string.String* %tmp54, i64 %tmp53
    %tmp56 = bitcast %class.string.String* %tmp55 to i8*
    %tmp57 = load i64, i64* %index.addr
    %tmp58 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp59 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp58, i32 0, i32 0
    %tmp60 = load %class.string.String*, %class.string.String** %tmp59
    %tmp61 = getelementptr %class.string.String, %class.string.String* %tmp60, i64 %tmp57
    %tmp62 = bitcast %class.string.String* %tmp61 to i8*
    %tmp63 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp64 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp63, i32 0, i32 1
    %tmp65 = load i64, i64* %tmp64
    %tmp66 = load i64, i64* %index.addr
    %tmp67 = sub i64 %tmp65, %tmp66
    %tmp68 = getelementptr %class.string.String, %class.string.String* null, i32 1
    %tmp69 = ptrtoint %class.string.String* %tmp68 to i64
    %tmp70 = mul i64 %tmp67, %tmp69
    %tmp71 = call i8* @"memcpy"(i8* %tmp56, i8* %tmp62, i64 %tmp70)
    br label %if.end.22
if.end.22:
    %tmp72 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp73 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp72, i32 0, i32 0
    %tmp74 = load %class.string.String*, %class.string.String** %tmp73
    %tmp75 = bitcast %class.string.String* %tmp74 to i8*
    call void @"free"(i8* %tmp75)
    br label %if.end.20
if.end.20:
    %tmp76 = load i64, i64* %new_cap.addr.11
    %tmp77 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp78 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp77, i32 0, i32 2
    store i64 %tmp76, i64* %tmp78
    %tmp79 = load %class.string.String*, %class.string.String** %new_data.addr.12
    %tmp80 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp81 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp80, i32 0, i32 0
    store %class.string.String* %tmp79, %class.string.String** %tmp81
    br label %if.end.18
if.else.18:
    %tmp82 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp83 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp82, i32 0, i32 1
    %tmp84 = load i64, i64* %tmp83
    store i64 %tmp84, i64* %i.addr.13
    br label %while.cond.23
while.cond.23:
    %tmp85 = load i64, i64* %i.addr.13
    %tmp86 = load i64, i64* %index.addr
    %tmp87 = icmp sgt i64 %tmp85, %tmp86
    br i1 %tmp87, label %while.body.23, label %while.end.23
while.body.23:
    %tmp88 = load i64, i64* %i.addr.13
    %tmp89 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp90 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp89, i32 0, i32 0
    %tmp91 = load %class.string.String*, %class.string.String** %tmp90
    %tmp92 = getelementptr %class.string.String, %class.string.String* %tmp91, i64 %tmp88
    %tmp93 = bitcast %class.string.String* %tmp92 to i8*
    %tmp94 = load i64, i64* %i.addr.13
    %tmp95 = sub i64 %tmp94, 1
    %tmp96 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp97 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp96, i32 0, i32 0
    %tmp98 = load %class.string.String*, %class.string.String** %tmp97
    %tmp99 = getelementptr %class.string.String, %class.string.String* %tmp98, i64 %tmp95
    %tmp100 = bitcast %class.string.String* %tmp99 to i8*
    %tmp101 = getelementptr %class.string.String, %class.string.String* null, i32 1
    %tmp102 = ptrtoint %class.string.String* %tmp101 to i64
    %tmp103 = call i8* @"memcpy"(i8* %tmp93, i8* %tmp100, i64 %tmp102)
    %tmp104 = load i64, i64* %i.addr.13
    %tmp105 = sub i64 %tmp104, 1
    store i64 %tmp105, i64* %i.addr.13
    br label %while.cond.23
while.end.23:
    br label %if.end.18
if.end.18:
    %tmp106 = load i64, i64* %index.addr
    %tmp107 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp108 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp107, i32 0, i32 0
    %tmp109 = load %class.string.String*, %class.string.String** %tmp108
    %tmp110 = getelementptr %class.string.String, %class.string.String* %tmp109, i64 %tmp106
    %tmp111 = bitcast %class.string.String* %tmp110 to i8*
    %tmp112 = bitcast %class.string.String* %item.addr to i8*
    %tmp113 = getelementptr %class.string.String, %class.string.String* null, i32 1
    %tmp114 = ptrtoint %class.string.String* %tmp113 to i64
    %tmp115 = call i8* @"memcpy"(i8* %tmp111, i8* %tmp112, i64 %tmp114)
    %tmp116 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp117 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp116, i32 0, i32 1
    %tmp118 = load i64, i64* %tmp117
    %tmp119 = add i64 %tmp118, 1
    %tmp120 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp121 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp120, i32 0, i32 1
    store i64 %tmp119, i64* %tmp121
    ret void
}

define %class.string.String @"array.Array_string.String.remove"(%class.array.Array_string.String* %self, i64 %index) {
entry:
    %self.addr = alloca %class.array.Array_string.String*
    %index.addr = alloca i64
    %temp.addr.14 = alloca %class.string.String*
    %i.addr.15 = alloca i64
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %self.addr
    store i64 %index, i64* %index.addr
    %tmp0 = load i64, i64* %index.addr
    %tmp1 = icmp slt i64 %tmp0, 0
    %tmp2 = load i64, i64* %index.addr
    %tmp3 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp4 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp3, i32 0, i32 1
    %tmp5 = load i64, i64* %tmp4
    %tmp6 = icmp sge i64 %tmp2, %tmp5
    %tmp7 = or i1 %tmp1, %tmp6
    br i1 %tmp7, label %if.then.24, label %if.end.24
if.then.24:
    %tmp8 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp8)
    br label %if.end.24
if.end.24:
    %tmp9 = getelementptr %class.string.String, %class.string.String* null, i32 1
    %tmp10 = ptrtoint %class.string.String* %tmp9 to i64
    %tmp11 = call i8* @"malloc"(i64 %tmp10)
    %tmp12 = bitcast i8* %tmp11 to %class.string.String*
    store %class.string.String* %tmp12, %class.string.String** %temp.addr.14
    %tmp13 = load i64, i64* %index.addr
    store i64 %tmp13, i64* %i.addr.15
    br label %while.cond.25
while.cond.25:
    %tmp14 = load i64, i64* %i.addr.15
    %tmp15 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp16 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp15, i32 0, i32 1
    %tmp17 = load i64, i64* %tmp16
    %tmp18 = sub i64 %tmp17, 1
    %tmp19 = icmp slt i64 %tmp14, %tmp18
    br i1 %tmp19, label %while.body.25, label %while.end.25
while.body.25:
    %tmp20 = load %class.string.String*, %class.string.String** %temp.addr.14
    %tmp21 = bitcast %class.string.String* %tmp20 to i8*
    %tmp22 = load i64, i64* %i.addr.15
    %tmp23 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp24 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp23, i32 0, i32 0
    %tmp25 = load %class.string.String*, %class.string.String** %tmp24
    %tmp26 = getelementptr %class.string.String, %class.string.String* %tmp25, i64 %tmp22
    %tmp27 = bitcast %class.string.String* %tmp26 to i8*
    %tmp28 = getelementptr %class.string.String, %class.string.String* null, i32 1
    %tmp29 = ptrtoint %class.string.String* %tmp28 to i64
    %tmp30 = call i8* @"memcpy"(i8* %tmp21, i8* %tmp27, i64 %tmp29)
    %tmp31 = load i64, i64* %i.addr.15
    %tmp32 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp33 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp32, i32 0, i32 0
    %tmp34 = load %class.string.String*, %class.string.String** %tmp33
    %tmp35 = getelementptr %class.string.String, %class.string.String* %tmp34, i64 %tmp31
    %tmp36 = bitcast %class.string.String* %tmp35 to i8*
    %tmp37 = load i64, i64* %i.addr.15
    %tmp38 = add i64 %tmp37, 1
    %tmp39 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp40 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp39, i32 0, i32 0
    %tmp41 = load %class.string.String*, %class.string.String** %tmp40
    %tmp42 = getelementptr %class.string.String, %class.string.String* %tmp41, i64 %tmp38
    %tmp43 = bitcast %class.string.String* %tmp42 to i8*
    %tmp44 = getelementptr %class.string.String, %class.string.String* null, i32 1
    %tmp45 = ptrtoint %class.string.String* %tmp44 to i64
    %tmp46 = call i8* @"memcpy"(i8* %tmp36, i8* %tmp43, i64 %tmp45)
    %tmp47 = load i64, i64* %i.addr.15
    %tmp48 = add i64 %tmp47, 1
    %tmp49 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp50 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp49, i32 0, i32 0
    %tmp51 = load %class.string.String*, %class.string.String** %tmp50
    %tmp52 = getelementptr %class.string.String, %class.string.String* %tmp51, i64 %tmp48
    %tmp53 = bitcast %class.string.String* %tmp52 to i8*
    %tmp54 = load %class.string.String*, %class.string.String** %temp.addr.14
    %tmp55 = bitcast %class.string.String* %tmp54 to i8*
    %tmp56 = getelementptr %class.string.String, %class.string.String* null, i32 1
    %tmp57 = ptrtoint %class.string.String* %tmp56 to i64
    %tmp58 = call i8* @"memcpy"(i8* %tmp53, i8* %tmp55, i64 %tmp57)
    %tmp59 = load i64, i64* %i.addr.15
    %tmp60 = add i64 %tmp59, 1
    store i64 %tmp60, i64* %i.addr.15
    br label %while.cond.25
while.end.25:
    %tmp61 = load %class.string.String*, %class.string.String** %temp.addr.14
    %tmp62 = bitcast %class.string.String* %tmp61 to i8*
    call void @"free"(i8* %tmp62)
    %tmp63 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp64 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp63, i32 0, i32 1
    %tmp65 = load i64, i64* %tmp64
    %tmp66 = sub i64 %tmp65, 1
    %tmp67 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp68 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp67, i32 0, i32 1
    store i64 %tmp66, i64* %tmp68
    %tmp69 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp70 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp69, i32 0, i32 1
    %tmp71 = load i64, i64* %tmp70
    %tmp72 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp73 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp72, i32 0, i32 0
    %tmp74 = load %class.string.String*, %class.string.String** %tmp73
    %tmp75 = getelementptr %class.string.String, %class.string.String* %tmp74, i64 %tmp71
    %tmp76 = load %class.string.String, %class.string.String* %tmp75
    ret %class.string.String %tmp76
}

define void @"array.Array_string.String.clear"(%class.array.Array_string.String* %self) {
entry:
    %self.addr = alloca %class.array.Array_string.String*
    %i.addr.16 = alloca i64
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %self.addr
    store i64 0, i64* %i.addr.16
    br label %while.cond.26
while.cond.26:
    %tmp0 = load i64, i64* %i.addr.16
    %tmp1 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp2 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp1, i32 0, i32 1
    %tmp3 = load i64, i64* %tmp2
    %tmp4 = icmp slt i64 %tmp0, %tmp3
    br i1 %tmp4, label %while.body.26, label %while.end.26
while.body.26:
    %tmp5 = load i64, i64* %i.addr.16
    %tmp6 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp7 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp6, i32 0, i32 0
    %tmp8 = load %class.string.String*, %class.string.String** %tmp7
    %tmp9 = getelementptr %class.string.String, %class.string.String* %tmp8, i64 %tmp5
    call void @"string.String.destroy"(%class.string.String* %tmp9)
    %tmp10 = load i64, i64* %i.addr.16
    %tmp11 = add i64 %tmp10, 1
    store i64 %tmp11, i64* %i.addr.16
    br label %while.cond.26
while.end.26:
    %tmp12 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp13 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp12, i32 0, i32 1
    store i64 0, i64* %tmp13
    ret void
}

define void @"array.Array_string.String.destroy"(%class.array.Array_string.String* %self) {
entry:
    %self.addr = alloca %class.array.Array_string.String*
    %i.addr.17 = alloca i64
    store %class.array.Array_string.String* %self, %class.array.Array_string.String** %self.addr
    %tmp0 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp1 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp0, i32 0, i32 0
    %tmp2 = load %class.string.String*, %class.string.String** %tmp1
    %tmp3 = icmp ne %class.string.String* %tmp2, null
    br i1 %tmp3, label %if.then.27, label %if.end.27
if.then.27:
    store i64 0, i64* %i.addr.17
    br label %while.cond.28
while.cond.28:
    %tmp4 = load i64, i64* %i.addr.17
    %tmp5 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp6 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp5, i32 0, i32 1
    %tmp7 = load i64, i64* %tmp6
    %tmp8 = icmp slt i64 %tmp4, %tmp7
    br i1 %tmp8, label %while.body.28, label %while.end.28
while.body.28:
    %tmp9 = load i64, i64* %i.addr.17
    %tmp10 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp11 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp10, i32 0, i32 0
    %tmp12 = load %class.string.String*, %class.string.String** %tmp11
    %tmp13 = getelementptr %class.string.String, %class.string.String* %tmp12, i64 %tmp9
    call void @"string.String.destroy"(%class.string.String* %tmp13)
    %tmp14 = load i64, i64* %i.addr.17
    %tmp15 = add i64 %tmp14, 1
    store i64 %tmp15, i64* %i.addr.17
    br label %while.cond.28
while.end.28:
    %tmp16 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp17 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp16, i32 0, i32 0
    %tmp18 = load %class.string.String*, %class.string.String** %tmp17
    %tmp19 = bitcast %class.string.String* %tmp18 to i8*
    call void @"free"(i8* %tmp19)
    %tmp20 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp21 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp20, i32 0, i32 0
    store %class.string.String* null, %class.string.String** %tmp21
    br label %if.end.27
if.end.27:
    %tmp22 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp23 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp22, i32 0, i32 2
    store i64 0, i64* %tmp23
    %tmp24 = load %class.array.Array_string.String*, %class.array.Array_string.String** %self.addr
    %tmp25 = getelementptr %class.array.Array_string.String, %class.array.Array_string.String* %tmp24, i32 0, i32 1
    store i64 0, i64* %tmp25
    ret void
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

