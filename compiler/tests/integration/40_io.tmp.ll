; Atlas compiler v0.1.0 — auto-generated LLVM IR
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.io.File = type { i8*, i1 }
%class.string.String = type { i8*, i64 }

@.str.0 = private unnamed_addr constant [16 x i8] c"test_output.txt\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"Hello File IO!\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"r\00", align 1

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
    %f.addr.7 = alloca %class.io.File
    %tmp0 = alloca %class.io.File
    %file_name.addr.8 = alloca %class.string.String
    %slice.alloca.9 = alloca { i8*, i64 }
    %tmp7 = alloca %class.string.String
    %write_mode.addr.10 = alloca %class.string.String
    %slice.alloca.11 = alloca { i8*, i64 }
    %tmp14 = alloca %class.string.String
    %content.addr.12 = alloca %class.string.String
    %slice.alloca.13 = alloca { i8*, i64 }
    %tmp26 = alloca %class.string.String
    %read_mode.addr.14 = alloca %class.string.String
    %slice.alloca.15 = alloca { i8*, i64 }
    %tmp37 = alloca %class.string.String
    %c1.addr.16 = alloca i64
    call void @"io.File.init"(%class.io.File* %tmp0)
    %tmp1 = load %class.io.File, %class.io.File* %tmp0
    store %class.io.File %tmp1, %class.io.File* %f.addr.7
    %tmp2 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.0, i64 0, i64 0
    %tmp3 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.9, i32 0, i32 0
    store i8* %tmp2, i8** %tmp3
    %tmp4 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.9, i32 0, i32 1
    store i64 15, i64* %tmp4
    %tmp5 = load { i8*, i64 }, { i8*, i64 }* %slice.alloca.9
    %tmp6 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp5)
    store %class.string.String %tmp6, %class.string.String* %tmp7
    %tmp8 = load %class.string.String, %class.string.String* %tmp7
    store %class.string.String %tmp8, %class.string.String* %file_name.addr.8
    %tmp9 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.1, i64 0, i64 0
    %tmp10 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.11, i32 0, i32 0
    store i8* %tmp9, i8** %tmp10
    %tmp11 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.11, i32 0, i32 1
    store i64 1, i64* %tmp11
    %tmp12 = load { i8*, i64 }, { i8*, i64 }* %slice.alloca.11
    %tmp13 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp12)
    store %class.string.String %tmp13, %class.string.String* %tmp14
    %tmp15 = load %class.string.String, %class.string.String* %tmp14
    store %class.string.String %tmp15, %class.string.String* %write_mode.addr.10
    %tmp16 = call i8* @"string.String.c_str"(%class.string.String* %file_name.addr.8)
    %tmp17 = call i8* @"string.String.c_str"(%class.string.String* %write_mode.addr.10)
    %tmp18 = call i1 @"io.File.open"(%class.io.File* %f.addr.7, i8* %tmp16, i8* %tmp17)
    %tmp19 = xor i1 %tmp18, 1
    br i1 %tmp19, label %if.then.11, label %if.end.11
if.then.11:
    %tmp20 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp20)
    br label %if.end.11
if.end.11:
    %tmp21 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.2, i64 0, i64 0
    %tmp22 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.13, i32 0, i32 0
    store i8* %tmp21, i8** %tmp22
    %tmp23 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.13, i32 0, i32 1
    store i64 14, i64* %tmp23
    %tmp24 = load { i8*, i64 }, { i8*, i64 }* %slice.alloca.13
    %tmp25 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp24)
    store %class.string.String %tmp25, %class.string.String* %tmp26
    %tmp27 = load %class.string.String, %class.string.String* %tmp26
    store %class.string.String %tmp27, %class.string.String* %content.addr.12
    %tmp28 = call i8* @"string.String.c_str"(%class.string.String* %content.addr.12)
    %tmp29 = call i1 @"io.File.write_string"(%class.io.File* %f.addr.7, i8* %tmp28)
    %tmp30 = xor i1 %tmp29, 1
    br i1 %tmp30, label %if.then.12, label %if.end.12
if.then.12:
    %tmp31 = trunc i64 2 to i32
    call void @"exit"(i32 %tmp31)
    br label %if.end.12
if.end.12:
    call void @"io.File.close"(%class.io.File* %f.addr.7)
    %tmp32 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i64 0, i64 0
    %tmp33 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.15, i32 0, i32 0
    store i8* %tmp32, i8** %tmp33
    %tmp34 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.15, i32 0, i32 1
    store i64 1, i64* %tmp34
    %tmp35 = load { i8*, i64 }, { i8*, i64 }* %slice.alloca.15
    %tmp36 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp35)
    store %class.string.String %tmp36, %class.string.String* %tmp37
    %tmp38 = load %class.string.String, %class.string.String* %tmp37
    store %class.string.String %tmp38, %class.string.String* %read_mode.addr.14
    %tmp39 = call i8* @"string.String.c_str"(%class.string.String* %file_name.addr.8)
    %tmp40 = call i8* @"string.String.c_str"(%class.string.String* %read_mode.addr.14)
    %tmp41 = call i1 @"io.File.open"(%class.io.File* %f.addr.7, i8* %tmp39, i8* %tmp40)
    %tmp42 = xor i1 %tmp41, 1
    br i1 %tmp42, label %if.then.13, label %if.end.13
if.then.13:
    %tmp43 = trunc i64 3 to i32
    call void @"exit"(i32 %tmp43)
    br label %if.end.13
if.end.13:
    %tmp44 = call i64 @"io.File.read_char"(%class.io.File* %f.addr.7)
    store i64 %tmp44, i64* %c1.addr.16
    %tmp45 = load i64, i64* %c1.addr.16
    %tmp46 = sext i8 72 to i64
    %tmp47 = icmp ne i64 %tmp45, %tmp46
    br i1 %tmp47, label %if.then.14, label %if.end.14
if.then.14:
    %tmp48 = trunc i64 4 to i32
    call void @"exit"(i32 %tmp48)
    br label %if.end.14
if.end.14:
    call void @"io.File.close"(%class.io.File* %f.addr.7)
    call void @"string.String.destroy"(%class.string.String* %read_mode.addr.14)
    call void @"string.String.destroy"(%class.string.String* %content.addr.12)
    call void @"string.String.destroy"(%class.string.String* %write_mode.addr.10)
    call void @"string.String.destroy"(%class.string.String* %file_name.addr.8)
    call void @"io.File.destroy"(%class.io.File* %f.addr.7)
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

