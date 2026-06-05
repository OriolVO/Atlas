; Atlas compiler v0.1.0 — auto-generated LLVM IR
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.array.Array_char = type { i8*, i64, i64 }
%class.io.File = type { i8*, i1 }
%class.string.String = type { i8*, i64 }

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
    %arr.addr.7 = alloca %class.array.Array_char
    %tmp0 = alloca %class.array.Array_char
    %b.addr.8 = alloca i8
    %a.addr.9 = alloca i8
    call void @"array.Array_char.init"(%class.array.Array_char* %tmp0)
    %tmp1 = load %class.array.Array_char, %class.array.Array_char* %tmp0
    store %class.array.Array_char %tmp1, %class.array.Array_char* %arr.addr.7
    call void @"array.Array_char.push"(%class.array.Array_char* %arr.addr.7, i8 65)
    call void @"array.Array_char.push"(%class.array.Array_char* %arr.addr.7, i8 66)
    %tmp2 = call i8 @array.Array_char.operator_index(%class.array.Array_char* %arr.addr.7, i64 0)
    %tmp3 = sext i8 %tmp2 to i32
    %tmp4 = call i32 @"putchar"(i32 %tmp3)
    %tmp5 = call i8 @array.Array_char.operator_index(%class.array.Array_char* %arr.addr.7, i64 1)
    %tmp6 = sext i8 %tmp5 to i32
    %tmp7 = call i32 @"putchar"(i32 %tmp6)
    %tmp8 = call i8 @"array.Array_char.pop"(%class.array.Array_char* %arr.addr.7)
    store i8 %tmp8, i8* %b.addr.8
    %tmp9 = call i8 @"array.Array_char.pop"(%class.array.Array_char* %arr.addr.7)
    store i8 %tmp9, i8* %a.addr.9
    %tmp10 = load i8, i8* %a.addr.9
    %tmp11 = sext i8 %tmp10 to i32
    %tmp12 = call i32 @"putchar"(i32 %tmp11)
    %tmp13 = load i8, i8* %b.addr.8
    %tmp14 = sext i8 %tmp13 to i32
    %tmp15 = call i32 @"putchar"(i32 %tmp14)
    call void @"array.Array_char.destroy"(%class.array.Array_char* %arr.addr.7)
    ret i64 0
}

define void @"array.Array_char.init"(%class.array.Array_char* %self) {
entry:
    %self.addr = alloca %class.array.Array_char*
    store %class.array.Array_char* %self, %class.array.Array_char** %self.addr
    %tmp0 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp1 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp0, i32 0, i32 1
    store i64 0, i64* %tmp1
    %tmp2 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp3 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp2, i32 0, i32 2
    store i64 0, i64* %tmp3
    %tmp4 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp5 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp4, i32 0, i32 0
    store i8* null, i8** %tmp5
    ret void
}

define i64 @"array.Array_char.length"(%class.array.Array_char* %self) {
entry:
    %self.addr = alloca %class.array.Array_char*
    store %class.array.Array_char* %self, %class.array.Array_char** %self.addr
    %tmp0 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp1 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp0, i32 0, i32 1
    %tmp2 = load i64, i64* %tmp1
    ret i64 %tmp2
}

define i64 @"array.Array_char.capacity"(%class.array.Array_char* %self) {
entry:
    %self.addr = alloca %class.array.Array_char*
    store %class.array.Array_char* %self, %class.array.Array_char** %self.addr
    %tmp0 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp1 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp0, i32 0, i32 2
    %tmp2 = load i64, i64* %tmp1
    ret i64 %tmp2
}

define void @"array.Array_char.push"(%class.array.Array_char* %self, i8 %item) {
entry:
    %self.addr = alloca %class.array.Array_char*
    %item.addr = alloca i8
    %new_cap.addr.10 = alloca i64
    %new_data.addr.11 = alloca i8*
    store %class.array.Array_char* %self, %class.array.Array_char** %self.addr
    store i8 %item, i8* %item.addr
    %tmp0 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp1 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp0, i32 0, i32 1
    %tmp2 = load i64, i64* %tmp1
    %tmp3 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp4 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp3, i32 0, i32 2
    %tmp5 = load i64, i64* %tmp4
    %tmp6 = icmp eq i64 %tmp2, %tmp5
    br i1 %tmp6, label %if.then.11, label %if.end.11
if.then.11:
    store i64 4, i64* %new_cap.addr.10
    %tmp7 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp8 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp7, i32 0, i32 2
    %tmp9 = load i64, i64* %tmp8
    %tmp10 = icmp sgt i64 %tmp9, 0
    br i1 %tmp10, label %if.then.12, label %if.end.12
if.then.12:
    %tmp11 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp12 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp11, i32 0, i32 2
    %tmp13 = load i64, i64* %tmp12
    %tmp14 = mul i64 %tmp13, 2
    store i64 %tmp14, i64* %new_cap.addr.10
    br label %if.end.12
if.end.12:
    %tmp15 = load i64, i64* %new_cap.addr.10
    %tmp16 = getelementptr i8, i8* null, i32 1
    %tmp17 = ptrtoint i8* %tmp16 to i64
    %tmp18 = mul i64 %tmp15, %tmp17
    %tmp19 = call i8* @"malloc"(i64 %tmp18)
    store i8* %tmp19, i8** %new_data.addr.11
    %tmp20 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp21 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp20, i32 0, i32 0
    %tmp22 = load i8*, i8** %tmp21
    %tmp23 = icmp ne i8* %tmp22, null
    br i1 %tmp23, label %if.then.13, label %if.end.13
if.then.13:
    %tmp24 = load i8*, i8** %new_data.addr.11
    %tmp25 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp26 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp25, i32 0, i32 0
    %tmp27 = load i8*, i8** %tmp26
    %tmp28 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp29 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp28, i32 0, i32 1
    %tmp30 = load i64, i64* %tmp29
    %tmp31 = getelementptr i8, i8* null, i32 1
    %tmp32 = ptrtoint i8* %tmp31 to i64
    %tmp33 = mul i64 %tmp30, %tmp32
    %tmp34 = call i8* @"memcpy"(i8* %tmp24, i8* %tmp27, i64 %tmp33)
    %tmp35 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp36 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp35, i32 0, i32 0
    %tmp37 = load i8*, i8** %tmp36
    call void @"free"(i8* %tmp37)
    br label %if.end.13
if.end.13:
    %tmp38 = load i64, i64* %new_cap.addr.10
    %tmp39 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp40 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp39, i32 0, i32 2
    store i64 %tmp38, i64* %tmp40
    %tmp41 = load i8*, i8** %new_data.addr.11
    %tmp42 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp43 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp42, i32 0, i32 0
    store i8* %tmp41, i8** %tmp43
    br label %if.end.11
if.end.11:
    %tmp44 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp45 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp44, i32 0, i32 1
    %tmp46 = load i64, i64* %tmp45
    %tmp47 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp48 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp47, i32 0, i32 0
    %tmp49 = load i8*, i8** %tmp48
    %tmp50 = getelementptr i8, i8* %tmp49, i64 %tmp46
    %tmp51 = getelementptr i8, i8* null, i32 1
    %tmp52 = ptrtoint i8* %tmp51 to i64
    %tmp53 = call i8* @"memcpy"(i8* %tmp50, i8* %item.addr, i64 %tmp52)
    %tmp54 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp55 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp54, i32 0, i32 1
    %tmp56 = load i64, i64* %tmp55
    %tmp57 = add i64 %tmp56, 1
    %tmp58 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp59 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp58, i32 0, i32 1
    store i64 %tmp57, i64* %tmp59
    ret void
}

define i8 @"array.Array_char.pop"(%class.array.Array_char* %self) {
entry:
    %self.addr = alloca %class.array.Array_char*
    store %class.array.Array_char* %self, %class.array.Array_char** %self.addr
    %tmp0 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp1 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp0, i32 0, i32 1
    %tmp2 = load i64, i64* %tmp1
    %tmp3 = icmp eq i64 %tmp2, 0
    br i1 %tmp3, label %if.then.14, label %if.end.14
if.then.14:
    %tmp4 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp4)
    br label %if.end.14
if.end.14:
    %tmp5 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp6 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp5, i32 0, i32 1
    %tmp7 = load i64, i64* %tmp6
    %tmp8 = sub i64 %tmp7, 1
    %tmp9 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp10 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp9, i32 0, i32 1
    store i64 %tmp8, i64* %tmp10
    %tmp11 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp12 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp11, i32 0, i32 1
    %tmp13 = load i64, i64* %tmp12
    %tmp14 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp15 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp14, i32 0, i32 0
    %tmp16 = load i8*, i8** %tmp15
    %tmp17 = getelementptr i8, i8* %tmp16, i64 %tmp13
    %tmp18 = load i8, i8* %tmp17
    ret i8 %tmp18
}

define i8 @"array.Array_char.operator_index"(%class.array.Array_char* %self, i64 %index) {
entry:
    %self.addr = alloca %class.array.Array_char*
    %index.addr = alloca i64
    store %class.array.Array_char* %self, %class.array.Array_char** %self.addr
    store i64 %index, i64* %index.addr
    %tmp0 = load i64, i64* %index.addr
    %tmp1 = icmp slt i64 %tmp0, 0
    %tmp2 = load i64, i64* %index.addr
    %tmp3 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp4 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp3, i32 0, i32 1
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
    %tmp10 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp11 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp10, i32 0, i32 0
    %tmp12 = load i8*, i8** %tmp11
    %tmp13 = getelementptr i8, i8* %tmp12, i64 %tmp9
    %tmp14 = load i8, i8* %tmp13
    ret i8 %tmp14
}

define void @"array.Array_char.operator_index_set"(%class.array.Array_char* %self, i64 %index, i8 %item) {
entry:
    %self.addr = alloca %class.array.Array_char*
    %index.addr = alloca i64
    %item.addr = alloca i8
    store %class.array.Array_char* %self, %class.array.Array_char** %self.addr
    store i64 %index, i64* %index.addr
    store i8 %item, i8* %item.addr
    %tmp0 = load i64, i64* %index.addr
    %tmp1 = icmp slt i64 %tmp0, 0
    %tmp2 = load i64, i64* %index.addr
    %tmp3 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp4 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp3, i32 0, i32 1
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
    %tmp10 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp11 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp10, i32 0, i32 0
    %tmp12 = load i8*, i8** %tmp11
    %tmp13 = getelementptr i8, i8* %tmp12, i64 %tmp9
    %tmp14 = load i8, i8* %tmp13
    %tmp15 = load i64, i64* %index.addr
    %tmp16 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp17 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp16, i32 0, i32 0
    %tmp18 = load i8*, i8** %tmp17
    %tmp19 = getelementptr i8, i8* %tmp18, i64 %tmp15
    %tmp20 = getelementptr i8, i8* null, i32 1
    %tmp21 = ptrtoint i8* %tmp20 to i64
    %tmp22 = call i8* @"memcpy"(i8* %tmp19, i8* %item.addr, i64 %tmp21)
    ret void
}

define void @"array.Array_char.insert"(%class.array.Array_char* %self, i64 %index, i8 %item) {
entry:
    %self.addr = alloca %class.array.Array_char*
    %index.addr = alloca i64
    %item.addr = alloca i8
    %new_cap.addr.12 = alloca i64
    %new_data.addr.13 = alloca i8*
    %i.addr.14 = alloca i64
    store %class.array.Array_char* %self, %class.array.Array_char** %self.addr
    store i64 %index, i64* %index.addr
    store i8 %item, i8* %item.addr
    %tmp0 = load i64, i64* %index.addr
    %tmp1 = icmp slt i64 %tmp0, 0
    %tmp2 = load i64, i64* %index.addr
    %tmp3 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp4 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp3, i32 0, i32 1
    %tmp5 = load i64, i64* %tmp4
    %tmp6 = icmp sgt i64 %tmp2, %tmp5
    %tmp7 = or i1 %tmp1, %tmp6
    br i1 %tmp7, label %if.then.17, label %if.end.17
if.then.17:
    %tmp8 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp8)
    br label %if.end.17
if.end.17:
    %tmp9 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp10 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp9, i32 0, i32 1
    %tmp11 = load i64, i64* %tmp10
    %tmp12 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp13 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp12, i32 0, i32 2
    %tmp14 = load i64, i64* %tmp13
    %tmp15 = icmp eq i64 %tmp11, %tmp14
    br i1 %tmp15, label %if.then.18, label %if.else.18
if.then.18:
    store i64 4, i64* %new_cap.addr.12
    %tmp16 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp17 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp16, i32 0, i32 2
    %tmp18 = load i64, i64* %tmp17
    %tmp19 = icmp sgt i64 %tmp18, 0
    br i1 %tmp19, label %if.then.19, label %if.end.19
if.then.19:
    %tmp20 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp21 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp20, i32 0, i32 2
    %tmp22 = load i64, i64* %tmp21
    %tmp23 = mul i64 %tmp22, 2
    store i64 %tmp23, i64* %new_cap.addr.12
    br label %if.end.19
if.end.19:
    %tmp24 = load i64, i64* %new_cap.addr.12
    %tmp25 = getelementptr i8, i8* null, i32 1
    %tmp26 = ptrtoint i8* %tmp25 to i64
    %tmp27 = mul i64 %tmp24, %tmp26
    %tmp28 = call i8* @"malloc"(i64 %tmp27)
    store i8* %tmp28, i8** %new_data.addr.13
    %tmp29 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp30 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp29, i32 0, i32 0
    %tmp31 = load i8*, i8** %tmp30
    %tmp32 = icmp ne i8* %tmp31, null
    br i1 %tmp32, label %if.then.20, label %if.end.20
if.then.20:
    %tmp33 = load i64, i64* %index.addr
    %tmp34 = icmp sgt i64 %tmp33, 0
    br i1 %tmp34, label %if.then.21, label %if.end.21
if.then.21:
    %tmp35 = load i8*, i8** %new_data.addr.13
    %tmp36 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp37 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp36, i32 0, i32 0
    %tmp38 = load i8*, i8** %tmp37
    %tmp39 = load i64, i64* %index.addr
    %tmp40 = getelementptr i8, i8* null, i32 1
    %tmp41 = ptrtoint i8* %tmp40 to i64
    %tmp42 = mul i64 %tmp39, %tmp41
    %tmp43 = call i8* @"memcpy"(i8* %tmp35, i8* %tmp38, i64 %tmp42)
    br label %if.end.21
if.end.21:
    %tmp44 = load i64, i64* %index.addr
    %tmp45 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp46 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp45, i32 0, i32 1
    %tmp47 = load i64, i64* %tmp46
    %tmp48 = icmp slt i64 %tmp44, %tmp47
    br i1 %tmp48, label %if.then.22, label %if.end.22
if.then.22:
    %tmp49 = load i64, i64* %index.addr
    %tmp50 = add i64 %tmp49, 1
    %tmp51 = load i8*, i8** %new_data.addr.13
    %tmp52 = getelementptr i8, i8* %tmp51, i64 %tmp50
    %tmp53 = load i64, i64* %index.addr
    %tmp54 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp55 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp54, i32 0, i32 0
    %tmp56 = load i8*, i8** %tmp55
    %tmp57 = getelementptr i8, i8* %tmp56, i64 %tmp53
    %tmp58 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp59 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp58, i32 0, i32 1
    %tmp60 = load i64, i64* %tmp59
    %tmp61 = load i64, i64* %index.addr
    %tmp62 = sub i64 %tmp60, %tmp61
    %tmp63 = getelementptr i8, i8* null, i32 1
    %tmp64 = ptrtoint i8* %tmp63 to i64
    %tmp65 = mul i64 %tmp62, %tmp64
    %tmp66 = call i8* @"memcpy"(i8* %tmp52, i8* %tmp57, i64 %tmp65)
    br label %if.end.22
if.end.22:
    %tmp67 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp68 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp67, i32 0, i32 0
    %tmp69 = load i8*, i8** %tmp68
    call void @"free"(i8* %tmp69)
    br label %if.end.20
if.end.20:
    %tmp70 = load i64, i64* %new_cap.addr.12
    %tmp71 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp72 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp71, i32 0, i32 2
    store i64 %tmp70, i64* %tmp72
    %tmp73 = load i8*, i8** %new_data.addr.13
    %tmp74 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp75 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp74, i32 0, i32 0
    store i8* %tmp73, i8** %tmp75
    br label %if.end.18
if.else.18:
    %tmp76 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp77 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp76, i32 0, i32 1
    %tmp78 = load i64, i64* %tmp77
    store i64 %tmp78, i64* %i.addr.14
    br label %while.cond.23
while.cond.23:
    %tmp79 = load i64, i64* %i.addr.14
    %tmp80 = load i64, i64* %index.addr
    %tmp81 = icmp sgt i64 %tmp79, %tmp80
    br i1 %tmp81, label %while.body.23, label %while.end.23
while.body.23:
    %tmp82 = load i64, i64* %i.addr.14
    %tmp83 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp84 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp83, i32 0, i32 0
    %tmp85 = load i8*, i8** %tmp84
    %tmp86 = getelementptr i8, i8* %tmp85, i64 %tmp82
    %tmp87 = load i64, i64* %i.addr.14
    %tmp88 = sub i64 %tmp87, 1
    %tmp89 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp90 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp89, i32 0, i32 0
    %tmp91 = load i8*, i8** %tmp90
    %tmp92 = getelementptr i8, i8* %tmp91, i64 %tmp88
    %tmp93 = getelementptr i8, i8* null, i32 1
    %tmp94 = ptrtoint i8* %tmp93 to i64
    %tmp95 = call i8* @"memcpy"(i8* %tmp86, i8* %tmp92, i64 %tmp94)
    %tmp96 = load i64, i64* %i.addr.14
    %tmp97 = sub i64 %tmp96, 1
    store i64 %tmp97, i64* %i.addr.14
    br label %while.cond.23
while.end.23:
    br label %if.end.18
if.end.18:
    %tmp98 = load i64, i64* %index.addr
    %tmp99 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp100 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp99, i32 0, i32 0
    %tmp101 = load i8*, i8** %tmp100
    %tmp102 = getelementptr i8, i8* %tmp101, i64 %tmp98
    %tmp103 = getelementptr i8, i8* null, i32 1
    %tmp104 = ptrtoint i8* %tmp103 to i64
    %tmp105 = call i8* @"memcpy"(i8* %tmp102, i8* %item.addr, i64 %tmp104)
    %tmp106 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp107 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp106, i32 0, i32 1
    %tmp108 = load i64, i64* %tmp107
    %tmp109 = add i64 %tmp108, 1
    %tmp110 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp111 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp110, i32 0, i32 1
    store i64 %tmp109, i64* %tmp111
    ret void
}

define i8 @"array.Array_char.remove"(%class.array.Array_char* %self, i64 %index) {
entry:
    %self.addr = alloca %class.array.Array_char*
    %index.addr = alloca i64
    %temp.addr.15 = alloca i8*
    %i.addr.16 = alloca i64
    store %class.array.Array_char* %self, %class.array.Array_char** %self.addr
    store i64 %index, i64* %index.addr
    %tmp0 = load i64, i64* %index.addr
    %tmp1 = icmp slt i64 %tmp0, 0
    %tmp2 = load i64, i64* %index.addr
    %tmp3 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp4 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp3, i32 0, i32 1
    %tmp5 = load i64, i64* %tmp4
    %tmp6 = icmp sge i64 %tmp2, %tmp5
    %tmp7 = or i1 %tmp1, %tmp6
    br i1 %tmp7, label %if.then.24, label %if.end.24
if.then.24:
    %tmp8 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp8)
    br label %if.end.24
if.end.24:
    %tmp9 = getelementptr i8, i8* null, i32 1
    %tmp10 = ptrtoint i8* %tmp9 to i64
    %tmp11 = call i8* @"malloc"(i64 %tmp10)
    store i8* %tmp11, i8** %temp.addr.15
    %tmp12 = load i64, i64* %index.addr
    store i64 %tmp12, i64* %i.addr.16
    br label %while.cond.25
while.cond.25:
    %tmp13 = load i64, i64* %i.addr.16
    %tmp14 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp15 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp14, i32 0, i32 1
    %tmp16 = load i64, i64* %tmp15
    %tmp17 = sub i64 %tmp16, 1
    %tmp18 = icmp slt i64 %tmp13, %tmp17
    br i1 %tmp18, label %while.body.25, label %while.end.25
while.body.25:
    %tmp19 = load i8*, i8** %temp.addr.15
    %tmp20 = load i64, i64* %i.addr.16
    %tmp21 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp22 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp21, i32 0, i32 0
    %tmp23 = load i8*, i8** %tmp22
    %tmp24 = getelementptr i8, i8* %tmp23, i64 %tmp20
    %tmp25 = getelementptr i8, i8* null, i32 1
    %tmp26 = ptrtoint i8* %tmp25 to i64
    %tmp27 = call i8* @"memcpy"(i8* %tmp19, i8* %tmp24, i64 %tmp26)
    %tmp28 = load i64, i64* %i.addr.16
    %tmp29 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp30 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp29, i32 0, i32 0
    %tmp31 = load i8*, i8** %tmp30
    %tmp32 = getelementptr i8, i8* %tmp31, i64 %tmp28
    %tmp33 = load i64, i64* %i.addr.16
    %tmp34 = add i64 %tmp33, 1
    %tmp35 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp36 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp35, i32 0, i32 0
    %tmp37 = load i8*, i8** %tmp36
    %tmp38 = getelementptr i8, i8* %tmp37, i64 %tmp34
    %tmp39 = getelementptr i8, i8* null, i32 1
    %tmp40 = ptrtoint i8* %tmp39 to i64
    %tmp41 = call i8* @"memcpy"(i8* %tmp32, i8* %tmp38, i64 %tmp40)
    %tmp42 = load i64, i64* %i.addr.16
    %tmp43 = add i64 %tmp42, 1
    %tmp44 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp45 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp44, i32 0, i32 0
    %tmp46 = load i8*, i8** %tmp45
    %tmp47 = getelementptr i8, i8* %tmp46, i64 %tmp43
    %tmp48 = load i8*, i8** %temp.addr.15
    %tmp49 = getelementptr i8, i8* null, i32 1
    %tmp50 = ptrtoint i8* %tmp49 to i64
    %tmp51 = call i8* @"memcpy"(i8* %tmp47, i8* %tmp48, i64 %tmp50)
    %tmp52 = load i64, i64* %i.addr.16
    %tmp53 = add i64 %tmp52, 1
    store i64 %tmp53, i64* %i.addr.16
    br label %while.cond.25
while.end.25:
    %tmp54 = load i8*, i8** %temp.addr.15
    call void @"free"(i8* %tmp54)
    %tmp55 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp56 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp55, i32 0, i32 1
    %tmp57 = load i64, i64* %tmp56
    %tmp58 = sub i64 %tmp57, 1
    %tmp59 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp60 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp59, i32 0, i32 1
    store i64 %tmp58, i64* %tmp60
    %tmp61 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp62 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp61, i32 0, i32 1
    %tmp63 = load i64, i64* %tmp62
    %tmp64 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp65 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp64, i32 0, i32 0
    %tmp66 = load i8*, i8** %tmp65
    %tmp67 = getelementptr i8, i8* %tmp66, i64 %tmp63
    %tmp68 = load i8, i8* %tmp67
    ret i8 %tmp68
}

define void @"array.Array_char.clear"(%class.array.Array_char* %self) {
entry:
    %self.addr = alloca %class.array.Array_char*
    %i.addr.17 = alloca i64
    store %class.array.Array_char* %self, %class.array.Array_char** %self.addr
    store i64 0, i64* %i.addr.17
    br label %while.cond.26
while.cond.26:
    %tmp0 = load i64, i64* %i.addr.17
    %tmp1 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp2 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp1, i32 0, i32 1
    %tmp3 = load i64, i64* %tmp2
    %tmp4 = icmp slt i64 %tmp0, %tmp3
    br i1 %tmp4, label %while.body.26, label %while.end.26
while.body.26:
    %tmp5 = load i64, i64* %i.addr.17
    %tmp6 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp7 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp6, i32 0, i32 0
    %tmp8 = load i8*, i8** %tmp7
    %tmp9 = getelementptr i8, i8* %tmp8, i64 %tmp5
    %tmp10 = load i8, i8* %tmp9
    %tmp11 = load i64, i64* %i.addr.17
    %tmp12 = add i64 %tmp11, 1
    store i64 %tmp12, i64* %i.addr.17
    br label %while.cond.26
while.end.26:
    %tmp13 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp14 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp13, i32 0, i32 1
    store i64 0, i64* %tmp14
    ret void
}

define void @"array.Array_char.destroy"(%class.array.Array_char* %self) {
entry:
    %self.addr = alloca %class.array.Array_char*
    %i.addr.18 = alloca i64
    store %class.array.Array_char* %self, %class.array.Array_char** %self.addr
    %tmp0 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp1 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp0, i32 0, i32 0
    %tmp2 = load i8*, i8** %tmp1
    %tmp3 = icmp ne i8* %tmp2, null
    br i1 %tmp3, label %if.then.27, label %if.end.27
if.then.27:
    store i64 0, i64* %i.addr.18
    br label %while.cond.28
while.cond.28:
    %tmp4 = load i64, i64* %i.addr.18
    %tmp5 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp6 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp5, i32 0, i32 1
    %tmp7 = load i64, i64* %tmp6
    %tmp8 = icmp slt i64 %tmp4, %tmp7
    br i1 %tmp8, label %while.body.28, label %while.end.28
while.body.28:
    %tmp9 = load i64, i64* %i.addr.18
    %tmp10 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp11 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp10, i32 0, i32 0
    %tmp12 = load i8*, i8** %tmp11
    %tmp13 = getelementptr i8, i8* %tmp12, i64 %tmp9
    %tmp14 = load i8, i8* %tmp13
    %tmp15 = load i64, i64* %i.addr.18
    %tmp16 = add i64 %tmp15, 1
    store i64 %tmp16, i64* %i.addr.18
    br label %while.cond.28
while.end.28:
    %tmp17 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp18 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp17, i32 0, i32 0
    %tmp19 = load i8*, i8** %tmp18
    call void @"free"(i8* %tmp19)
    %tmp20 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp21 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp20, i32 0, i32 0
    store i8* null, i8** %tmp21
    br label %if.end.27
if.end.27:
    %tmp22 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp23 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp22, i32 0, i32 2
    store i64 0, i64* %tmp23
    %tmp24 = load %class.array.Array_char*, %class.array.Array_char** %self.addr
    %tmp25 = getelementptr %class.array.Array_char, %class.array.Array_char* %tmp24, i32 0, i32 1
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

