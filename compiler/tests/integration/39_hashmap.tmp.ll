; Atlas compiler v0.1.0 — auto-generated LLVM IR
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.io.File = type { i8*, i1 }
%class.array.Array_hashmap.HashMapEntry_string.String_int = type { %class.hashmap.HashMapEntry_string.String_int*, i64, i64 }
%class.string.String = type { i8*, i64 }
%class.hashmap.HashMap_string.String_int = type { %class.array.Array_hashmap.HashMapEntry_string.String_int, i64, i64 }
%class.hashmap.HashMapEntry_string.String_int = type { %class.string.String, i64, i1 }

@.str.0 = private unnamed_addr constant [6 x i8] c"hello\00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"world\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"atlas\00", align 1
@.str.3 = private unnamed_addr constant [6 x i8] c"hello\00", align 1
@.str.4 = private unnamed_addr constant [6 x i8] c"world\00", align 1
@.str.5 = private unnamed_addr constant [6 x i8] c"atlas\00", align 1

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
    %map.addr.7 = alloca %class.hashmap.HashMap_string.String_int
    %tmp0 = alloca %class.hashmap.HashMap_string.String_int
    %slice.alloca.8 = alloca { i8*, i64 }
    %tmp7 = alloca %class.string.String
    %slice.alloca.9 = alloca { i8*, i64 }
    %tmp14 = alloca %class.string.String
    %slice.alloca.10 = alloca { i8*, i64 }
    %tmp21 = alloca %class.string.String
    %k1.addr.11 = alloca %class.string.String
    %slice.alloca.12 = alloca { i8*, i64 }
    %tmp30 = alloca %class.string.String
    %ptr1.addr.13 = alloca i64*
    %k2.addr.14 = alloca %class.string.String
    %slice.alloca.15 = alloca { i8*, i64 }
    %tmp43 = alloca %class.string.String
    %ptr2.addr.16 = alloca i64*
    %k3.addr.17 = alloca %class.string.String
    %slice.alloca.18 = alloca { i8*, i64 }
    %tmp56 = alloca %class.string.String
    %removed.addr.19 = alloca i1
    call void @"hashmap.HashMap_string.String_int.init"(%class.hashmap.HashMap_string.String_int* %tmp0)
    %tmp1 = load %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp0
    store %class.hashmap.HashMap_string.String_int %tmp1, %class.hashmap.HashMap_string.String_int* %map.addr.7
    %tmp2 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i64 0, i64 0
    %tmp3 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.8, i32 0, i32 0
    store i8* %tmp2, i8** %tmp3
    %tmp4 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.8, i32 0, i32 1
    store i64 5, i64* %tmp4
    %tmp5 = load { i8*, i64 }, { i8*, i64 }* %slice.alloca.8
    %tmp6 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp5)
    store %class.string.String %tmp6, %class.string.String* %tmp7
    %tmp8 = load %class.string.String, %class.string.String* %tmp7
    call void @hashmap.HashMap_string.String_int.operator_index_set(%class.hashmap.HashMap_string.String_int* %map.addr.7, %class.string.String %tmp8, i64 42)
    %tmp9 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1, i64 0, i64 0
    %tmp10 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.9, i32 0, i32 0
    store i8* %tmp9, i8** %tmp10
    %tmp11 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.9, i32 0, i32 1
    store i64 5, i64* %tmp11
    %tmp12 = load { i8*, i64 }, { i8*, i64 }* %slice.alloca.9
    %tmp13 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp12)
    store %class.string.String %tmp13, %class.string.String* %tmp14
    %tmp15 = load %class.string.String, %class.string.String* %tmp14
    call void @hashmap.HashMap_string.String_int.operator_index_set(%class.hashmap.HashMap_string.String_int* %map.addr.7, %class.string.String %tmp15, i64 100)
    %tmp16 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.2, i64 0, i64 0
    %tmp17 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.10, i32 0, i32 0
    store i8* %tmp16, i8** %tmp17
    %tmp18 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.10, i32 0, i32 1
    store i64 5, i64* %tmp18
    %tmp19 = load { i8*, i64 }, { i8*, i64 }* %slice.alloca.10
    %tmp20 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp19)
    store %class.string.String %tmp20, %class.string.String* %tmp21
    %tmp22 = load %class.string.String, %class.string.String* %tmp21
    call void @hashmap.HashMap_string.String_int.operator_index_set(%class.hashmap.HashMap_string.String_int* %map.addr.7, %class.string.String %tmp22, i64 999)
    %tmp23 = call i64 @"hashmap.HashMap_string.String_int.length"(%class.hashmap.HashMap_string.String_int* %map.addr.7)
    %tmp24 = icmp ne i64 %tmp23, 3
    br i1 %tmp24, label %if.then.11, label %if.end.11
if.then.11:
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %map.addr.7)
    ret i64 1
if.end.11:
    %tmp25 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.3, i64 0, i64 0
    %tmp26 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.12, i32 0, i32 0
    store i8* %tmp25, i8** %tmp26
    %tmp27 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.12, i32 0, i32 1
    store i64 5, i64* %tmp27
    %tmp28 = load { i8*, i64 }, { i8*, i64 }* %slice.alloca.12
    %tmp29 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp28)
    store %class.string.String %tmp29, %class.string.String* %tmp30
    %tmp31 = load %class.string.String, %class.string.String* %tmp30
    store %class.string.String %tmp31, %class.string.String* %k1.addr.11
    %tmp32 = call i64* @"hashmap.HashMap_string.String_int.get"(%class.hashmap.HashMap_string.String_int* %map.addr.7, %class.string.String* %k1.addr.11)
    store i64* %tmp32, i64** %ptr1.addr.13
    %tmp33 = load i64*, i64** %ptr1.addr.13
    %tmp34 = icmp ne i64* %tmp33, null
    br i1 %tmp34, label %if.then.12, label %if.else.12
if.then.12:
    %tmp35 = load i64*, i64** %ptr1.addr.13
    %tmp36 = load i64, i64* %tmp35
    %tmp37 = icmp ne i64 %tmp36, 42
    br i1 %tmp37, label %if.then.13, label %if.end.13
if.then.13:
    call void @"string.String.destroy"(%class.string.String* %k1.addr.11)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %map.addr.7)
    ret i64 3
if.end.13:
    br label %if.end.12
if.else.12:
    call void @"string.String.destroy"(%class.string.String* %k1.addr.11)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %map.addr.7)
    ret i64 2
if.end.12:
    %tmp38 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.4, i64 0, i64 0
    %tmp39 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.15, i32 0, i32 0
    store i8* %tmp38, i8** %tmp39
    %tmp40 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.15, i32 0, i32 1
    store i64 5, i64* %tmp40
    %tmp41 = load { i8*, i64 }, { i8*, i64 }* %slice.alloca.15
    %tmp42 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp41)
    store %class.string.String %tmp42, %class.string.String* %tmp43
    %tmp44 = load %class.string.String, %class.string.String* %tmp43
    store %class.string.String %tmp44, %class.string.String* %k2.addr.14
    %tmp45 = call i64* @"hashmap.HashMap_string.String_int.get"(%class.hashmap.HashMap_string.String_int* %map.addr.7, %class.string.String* %k2.addr.14)
    store i64* %tmp45, i64** %ptr2.addr.16
    %tmp46 = load i64*, i64** %ptr2.addr.16
    %tmp47 = icmp ne i64* %tmp46, null
    br i1 %tmp47, label %if.then.14, label %if.else.14
if.then.14:
    %tmp48 = load i64*, i64** %ptr2.addr.16
    %tmp49 = load i64, i64* %tmp48
    %tmp50 = icmp ne i64 %tmp49, 100
    br i1 %tmp50, label %if.then.15, label %if.end.15
if.then.15:
    call void @"string.String.destroy"(%class.string.String* %k2.addr.14)
    call void @"string.String.destroy"(%class.string.String* %k1.addr.11)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %map.addr.7)
    ret i64 4
if.end.15:
    br label %if.end.14
if.else.14:
    call void @"string.String.destroy"(%class.string.String* %k2.addr.14)
    call void @"string.String.destroy"(%class.string.String* %k1.addr.11)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %map.addr.7)
    ret i64 4
if.end.14:
    %tmp51 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.5, i64 0, i64 0
    %tmp52 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.18, i32 0, i32 0
    store i8* %tmp51, i8** %tmp52
    %tmp53 = getelementptr { i8*, i64 }, { i8*, i64 }* %slice.alloca.18, i32 0, i32 1
    store i64 5, i64* %tmp53
    %tmp54 = load { i8*, i64 }, { i8*, i64 }* %slice.alloca.18
    %tmp55 = call %class.string.String @"string.String.from"({ i8*, i64 } %tmp54)
    store %class.string.String %tmp55, %class.string.String* %tmp56
    %tmp57 = load %class.string.String, %class.string.String* %tmp56
    store %class.string.String %tmp57, %class.string.String* %k3.addr.17
    %tmp58 = call i1 @"hashmap.HashMap_string.String_int.contains"(%class.hashmap.HashMap_string.String_int* %map.addr.7, %class.string.String* %k3.addr.17)
    %tmp59 = xor i1 %tmp58, 1
    br i1 %tmp59, label %if.then.16, label %if.end.16
if.then.16:
    call void @"string.String.destroy"(%class.string.String* %k3.addr.17)
    call void @"string.String.destroy"(%class.string.String* %k2.addr.14)
    call void @"string.String.destroy"(%class.string.String* %k1.addr.11)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %map.addr.7)
    ret i64 5
if.end.16:
    %tmp60 = call i1 @"hashmap.HashMap_string.String_int.remove"(%class.hashmap.HashMap_string.String_int* %map.addr.7, %class.string.String* %k2.addr.14)
    store i1 %tmp60, i1* %removed.addr.19
    %tmp61 = load i1, i1* %removed.addr.19
    %tmp62 = xor i1 %tmp61, 1
    br i1 %tmp62, label %if.then.17, label %if.end.17
if.then.17:
    call void @"string.String.destroy"(%class.string.String* %k3.addr.17)
    call void @"string.String.destroy"(%class.string.String* %k2.addr.14)
    call void @"string.String.destroy"(%class.string.String* %k1.addr.11)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %map.addr.7)
    ret i64 6
if.end.17:
    %tmp63 = call i64 @"hashmap.HashMap_string.String_int.length"(%class.hashmap.HashMap_string.String_int* %map.addr.7)
    %tmp64 = icmp ne i64 %tmp63, 2
    br i1 %tmp64, label %if.then.18, label %if.end.18
if.then.18:
    call void @"string.String.destroy"(%class.string.String* %k3.addr.17)
    call void @"string.String.destroy"(%class.string.String* %k2.addr.14)
    call void @"string.String.destroy"(%class.string.String* %k1.addr.11)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %map.addr.7)
    ret i64 7
if.end.18:
    %tmp65 = call i1 @"hashmap.HashMap_string.String_int.contains"(%class.hashmap.HashMap_string.String_int* %map.addr.7, %class.string.String* %k2.addr.14)
    br i1 %tmp65, label %if.then.19, label %if.end.19
if.then.19:
    call void @"string.String.destroy"(%class.string.String* %k3.addr.17)
    call void @"string.String.destroy"(%class.string.String* %k2.addr.14)
    call void @"string.String.destroy"(%class.string.String* %k1.addr.11)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %map.addr.7)
    ret i64 8
if.end.19:
    call void @"string.String.destroy"(%class.string.String* %k3.addr.17)
    call void @"string.String.destroy"(%class.string.String* %k2.addr.14)
    call void @"string.String.destroy"(%class.string.String* %k1.addr.11)
    call void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %map.addr.7)
    ret i64 0
}

define void @"hashmap.HashMapEntry_string.String_int.init"(%class.hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %self.addr = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %self, %class.hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp0 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp1 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp0, i32 0, i32 2
    store i1 0, i1* %tmp1
    ret void
}

define void @"hashmap.HashMapEntry_string.String_int.destroy"(%class.hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %self.addr = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %self, %class.hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp0 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp1 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp0, i32 0, i32 0
    call void @"string.String.destroy"(%class.string.String* %tmp1)
    ret void
}

define void @"array.Array_hashmap.HashMapEntry_string.String_int.init"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %self.addr = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp0 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp1 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp0, i32 0, i32 1
    store i64 0, i64* %tmp1
    %tmp2 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp3 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp2, i32 0, i32 2
    store i64 0, i64* %tmp3
    %tmp4 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp5 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp4, i32 0, i32 0
    store %class.hashmap.HashMapEntry_string.String_int* null, %class.hashmap.HashMapEntry_string.String_int** %tmp5
    ret void
}

define i64 @"array.Array_hashmap.HashMapEntry_string.String_int.length"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %self.addr = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp0 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp1 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp0, i32 0, i32 1
    %tmp2 = load i64, i64* %tmp1
    ret i64 %tmp2
}

define i64 @"array.Array_hashmap.HashMapEntry_string.String_int.capacity"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %self.addr = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp0 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp1 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp0, i32 0, i32 2
    %tmp2 = load i64, i64* %tmp1
    ret i64 %tmp2
}

define void @"array.Array_hashmap.HashMapEntry_string.String_int.push"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.hashmap.HashMapEntry_string.String_int %item) {
entry:
    %self.addr = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    %item.addr = alloca %class.hashmap.HashMapEntry_string.String_int
    %new_cap.addr.20 = alloca i64
    %new_data.addr.21 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    store %class.hashmap.HashMapEntry_string.String_int %item, %class.hashmap.HashMapEntry_string.String_int* %item.addr
    %tmp0 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp1 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp0, i32 0, i32 1
    %tmp2 = load i64, i64* %tmp1
    %tmp3 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp4 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp3, i32 0, i32 2
    %tmp5 = load i64, i64* %tmp4
    %tmp6 = icmp eq i64 %tmp2, %tmp5
    br i1 %tmp6, label %if.then.20, label %if.end.20
if.then.20:
    store i64 4, i64* %new_cap.addr.20
    %tmp7 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp8 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp7, i32 0, i32 2
    %tmp9 = load i64, i64* %tmp8
    %tmp10 = icmp sgt i64 %tmp9, 0
    br i1 %tmp10, label %if.then.21, label %if.end.21
if.then.21:
    %tmp11 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp12 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp11, i32 0, i32 2
    %tmp13 = load i64, i64* %tmp12
    %tmp14 = mul i64 %tmp13, 2
    store i64 %tmp14, i64* %new_cap.addr.20
    br label %if.end.21
if.end.21:
    %tmp15 = load i64, i64* %new_cap.addr.20
    %tmp16 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* null, i32 1
    %tmp17 = ptrtoint %class.hashmap.HashMapEntry_string.String_int* %tmp16 to i64
    %tmp18 = mul i64 %tmp15, %tmp17
    %tmp19 = call i8* @"malloc"(i64 %tmp18)
    %tmp20 = bitcast i8* %tmp19 to %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp20, %class.hashmap.HashMapEntry_string.String_int** %new_data.addr.21
    %tmp21 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp22 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp21, i32 0, i32 0
    %tmp23 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp22
    %tmp24 = icmp ne %class.hashmap.HashMapEntry_string.String_int* %tmp23, null
    br i1 %tmp24, label %if.then.22, label %if.end.22
if.then.22:
    %tmp25 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %new_data.addr.21
    %tmp26 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp25 to i8*
    %tmp27 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp28 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp27, i32 0, i32 0
    %tmp29 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp28
    %tmp30 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp29 to i8*
    %tmp31 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp32 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp31, i32 0, i32 1
    %tmp33 = load i64, i64* %tmp32
    %tmp34 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* null, i32 1
    %tmp35 = ptrtoint %class.hashmap.HashMapEntry_string.String_int* %tmp34 to i64
    %tmp36 = mul i64 %tmp33, %tmp35
    %tmp37 = call i8* @"memcpy"(i8* %tmp26, i8* %tmp30, i64 %tmp36)
    %tmp38 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp39 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp38, i32 0, i32 0
    %tmp40 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp39
    %tmp41 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp40 to i8*
    call void @"free"(i8* %tmp41)
    br label %if.end.22
if.end.22:
    %tmp42 = load i64, i64* %new_cap.addr.20
    %tmp43 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp44 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp43, i32 0, i32 2
    store i64 %tmp42, i64* %tmp44
    %tmp45 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %new_data.addr.21
    %tmp46 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp47 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp46, i32 0, i32 0
    store %class.hashmap.HashMapEntry_string.String_int* %tmp45, %class.hashmap.HashMapEntry_string.String_int** %tmp47
    br label %if.end.20
if.end.20:
    %tmp48 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp49 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp48, i32 0, i32 1
    %tmp50 = load i64, i64* %tmp49
    %tmp51 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp52 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp51, i32 0, i32 0
    %tmp53 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp52
    %tmp54 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp53, i64 %tmp50
    %tmp55 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp54 to i8*
    %tmp56 = bitcast %class.hashmap.HashMapEntry_string.String_int* %item.addr to i8*
    %tmp57 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* null, i32 1
    %tmp58 = ptrtoint %class.hashmap.HashMapEntry_string.String_int* %tmp57 to i64
    %tmp59 = call i8* @"memcpy"(i8* %tmp55, i8* %tmp56, i64 %tmp58)
    %tmp60 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp61 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp60, i32 0, i32 1
    %tmp62 = load i64, i64* %tmp61
    %tmp63 = add i64 %tmp62, 1
    %tmp64 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp65 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp64, i32 0, i32 1
    store i64 %tmp63, i64* %tmp65
    ret void
}

define %class.hashmap.HashMapEntry_string.String_int @"array.Array_hashmap.HashMapEntry_string.String_int.pop"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %self.addr = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp0 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp1 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp0, i32 0, i32 1
    %tmp2 = load i64, i64* %tmp1
    %tmp3 = icmp eq i64 %tmp2, 0
    br i1 %tmp3, label %if.then.23, label %if.end.23
if.then.23:
    %tmp4 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp4)
    br label %if.end.23
if.end.23:
    %tmp5 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp6 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp5, i32 0, i32 1
    %tmp7 = load i64, i64* %tmp6
    %tmp8 = sub i64 %tmp7, 1
    %tmp9 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp10 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp9, i32 0, i32 1
    store i64 %tmp8, i64* %tmp10
    %tmp11 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp12 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp11, i32 0, i32 1
    %tmp13 = load i64, i64* %tmp12
    %tmp14 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp15 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp14, i32 0, i32 0
    %tmp16 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp15
    %tmp17 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp16, i64 %tmp13
    %tmp18 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp17
    ret %class.hashmap.HashMapEntry_string.String_int %tmp18
}

define %class.hashmap.HashMapEntry_string.String_int @"array.Array_hashmap.HashMapEntry_string.String_int.operator_index"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self, i64 %index) {
entry:
    %self.addr = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    %index.addr = alloca i64
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    store i64 %index, i64* %index.addr
    %tmp0 = load i64, i64* %index.addr
    %tmp1 = icmp slt i64 %tmp0, 0
    %tmp2 = load i64, i64* %index.addr
    %tmp3 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp4 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp3, i32 0, i32 1
    %tmp5 = load i64, i64* %tmp4
    %tmp6 = icmp sge i64 %tmp2, %tmp5
    %tmp7 = or i1 %tmp1, %tmp6
    br i1 %tmp7, label %if.then.24, label %if.end.24
if.then.24:
    %tmp8 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp8)
    br label %if.end.24
if.end.24:
    %tmp9 = load i64, i64* %index.addr
    %tmp10 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp11 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp10, i32 0, i32 0
    %tmp12 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp11
    %tmp13 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp12, i64 %tmp9
    %tmp14 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp13
    ret %class.hashmap.HashMapEntry_string.String_int %tmp14
}

define void @"array.Array_hashmap.HashMapEntry_string.String_int.operator_index_set"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self, i64 %index, %class.hashmap.HashMapEntry_string.String_int %item) {
entry:
    %self.addr = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    %index.addr = alloca i64
    %item.addr = alloca %class.hashmap.HashMapEntry_string.String_int
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    store i64 %index, i64* %index.addr
    store %class.hashmap.HashMapEntry_string.String_int %item, %class.hashmap.HashMapEntry_string.String_int* %item.addr
    %tmp0 = load i64, i64* %index.addr
    %tmp1 = icmp slt i64 %tmp0, 0
    %tmp2 = load i64, i64* %index.addr
    %tmp3 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp4 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp3, i32 0, i32 1
    %tmp5 = load i64, i64* %tmp4
    %tmp6 = icmp sge i64 %tmp2, %tmp5
    %tmp7 = or i1 %tmp1, %tmp6
    br i1 %tmp7, label %if.then.25, label %if.end.25
if.then.25:
    %tmp8 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp8)
    br label %if.end.25
if.end.25:
    %tmp9 = load i64, i64* %index.addr
    %tmp10 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp11 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp10, i32 0, i32 0
    %tmp12 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp11
    %tmp13 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp12, i64 %tmp9
    %tmp14 = load i64, i64* %index.addr
    %tmp15 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp16 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp15, i32 0, i32 0
    %tmp17 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp16
    %tmp18 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp17, i64 %tmp14
    %tmp19 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp18 to i8*
    %tmp20 = bitcast %class.hashmap.HashMapEntry_string.String_int* %item.addr to i8*
    %tmp21 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* null, i32 1
    %tmp22 = ptrtoint %class.hashmap.HashMapEntry_string.String_int* %tmp21 to i64
    %tmp23 = call i8* @"memcpy"(i8* %tmp19, i8* %tmp20, i64 %tmp22)
    ret void
}

define void @"array.Array_hashmap.HashMapEntry_string.String_int.insert"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self, i64 %index, %class.hashmap.HashMapEntry_string.String_int %item) {
entry:
    %self.addr = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    %index.addr = alloca i64
    %item.addr = alloca %class.hashmap.HashMapEntry_string.String_int
    %new_cap.addr.22 = alloca i64
    %new_data.addr.23 = alloca %class.hashmap.HashMapEntry_string.String_int*
    %i.addr.24 = alloca i64
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    store i64 %index, i64* %index.addr
    store %class.hashmap.HashMapEntry_string.String_int %item, %class.hashmap.HashMapEntry_string.String_int* %item.addr
    %tmp0 = load i64, i64* %index.addr
    %tmp1 = icmp slt i64 %tmp0, 0
    %tmp2 = load i64, i64* %index.addr
    %tmp3 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp4 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp3, i32 0, i32 1
    %tmp5 = load i64, i64* %tmp4
    %tmp6 = icmp sgt i64 %tmp2, %tmp5
    %tmp7 = or i1 %tmp1, %tmp6
    br i1 %tmp7, label %if.then.26, label %if.end.26
if.then.26:
    %tmp8 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp8)
    br label %if.end.26
if.end.26:
    %tmp9 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp10 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp9, i32 0, i32 1
    %tmp11 = load i64, i64* %tmp10
    %tmp12 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp13 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp12, i32 0, i32 2
    %tmp14 = load i64, i64* %tmp13
    %tmp15 = icmp eq i64 %tmp11, %tmp14
    br i1 %tmp15, label %if.then.27, label %if.else.27
if.then.27:
    store i64 4, i64* %new_cap.addr.22
    %tmp16 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp17 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp16, i32 0, i32 2
    %tmp18 = load i64, i64* %tmp17
    %tmp19 = icmp sgt i64 %tmp18, 0
    br i1 %tmp19, label %if.then.28, label %if.end.28
if.then.28:
    %tmp20 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp21 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp20, i32 0, i32 2
    %tmp22 = load i64, i64* %tmp21
    %tmp23 = mul i64 %tmp22, 2
    store i64 %tmp23, i64* %new_cap.addr.22
    br label %if.end.28
if.end.28:
    %tmp24 = load i64, i64* %new_cap.addr.22
    %tmp25 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* null, i32 1
    %tmp26 = ptrtoint %class.hashmap.HashMapEntry_string.String_int* %tmp25 to i64
    %tmp27 = mul i64 %tmp24, %tmp26
    %tmp28 = call i8* @"malloc"(i64 %tmp27)
    %tmp29 = bitcast i8* %tmp28 to %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp29, %class.hashmap.HashMapEntry_string.String_int** %new_data.addr.23
    %tmp30 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp31 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp30, i32 0, i32 0
    %tmp32 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp31
    %tmp33 = icmp ne %class.hashmap.HashMapEntry_string.String_int* %tmp32, null
    br i1 %tmp33, label %if.then.29, label %if.end.29
if.then.29:
    %tmp34 = load i64, i64* %index.addr
    %tmp35 = icmp sgt i64 %tmp34, 0
    br i1 %tmp35, label %if.then.30, label %if.end.30
if.then.30:
    %tmp36 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %new_data.addr.23
    %tmp37 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp36 to i8*
    %tmp38 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp39 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp38, i32 0, i32 0
    %tmp40 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp39
    %tmp41 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp40 to i8*
    %tmp42 = load i64, i64* %index.addr
    %tmp43 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* null, i32 1
    %tmp44 = ptrtoint %class.hashmap.HashMapEntry_string.String_int* %tmp43 to i64
    %tmp45 = mul i64 %tmp42, %tmp44
    %tmp46 = call i8* @"memcpy"(i8* %tmp37, i8* %tmp41, i64 %tmp45)
    br label %if.end.30
if.end.30:
    %tmp47 = load i64, i64* %index.addr
    %tmp48 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp49 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp48, i32 0, i32 1
    %tmp50 = load i64, i64* %tmp49
    %tmp51 = icmp slt i64 %tmp47, %tmp50
    br i1 %tmp51, label %if.then.31, label %if.end.31
if.then.31:
    %tmp52 = load i64, i64* %index.addr
    %tmp53 = add i64 %tmp52, 1
    %tmp54 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %new_data.addr.23
    %tmp55 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp54, i64 %tmp53
    %tmp56 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp55 to i8*
    %tmp57 = load i64, i64* %index.addr
    %tmp58 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp59 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp58, i32 0, i32 0
    %tmp60 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp59
    %tmp61 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp60, i64 %tmp57
    %tmp62 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp61 to i8*
    %tmp63 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp64 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp63, i32 0, i32 1
    %tmp65 = load i64, i64* %tmp64
    %tmp66 = load i64, i64* %index.addr
    %tmp67 = sub i64 %tmp65, %tmp66
    %tmp68 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* null, i32 1
    %tmp69 = ptrtoint %class.hashmap.HashMapEntry_string.String_int* %tmp68 to i64
    %tmp70 = mul i64 %tmp67, %tmp69
    %tmp71 = call i8* @"memcpy"(i8* %tmp56, i8* %tmp62, i64 %tmp70)
    br label %if.end.31
if.end.31:
    %tmp72 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp73 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp72, i32 0, i32 0
    %tmp74 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp73
    %tmp75 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp74 to i8*
    call void @"free"(i8* %tmp75)
    br label %if.end.29
if.end.29:
    %tmp76 = load i64, i64* %new_cap.addr.22
    %tmp77 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp78 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp77, i32 0, i32 2
    store i64 %tmp76, i64* %tmp78
    %tmp79 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %new_data.addr.23
    %tmp80 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp81 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp80, i32 0, i32 0
    store %class.hashmap.HashMapEntry_string.String_int* %tmp79, %class.hashmap.HashMapEntry_string.String_int** %tmp81
    br label %if.end.27
if.else.27:
    %tmp82 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp83 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp82, i32 0, i32 1
    %tmp84 = load i64, i64* %tmp83
    store i64 %tmp84, i64* %i.addr.24
    br label %while.cond.32
while.cond.32:
    %tmp85 = load i64, i64* %i.addr.24
    %tmp86 = load i64, i64* %index.addr
    %tmp87 = icmp sgt i64 %tmp85, %tmp86
    br i1 %tmp87, label %while.body.32, label %while.end.32
while.body.32:
    %tmp88 = load i64, i64* %i.addr.24
    %tmp89 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp90 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp89, i32 0, i32 0
    %tmp91 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp90
    %tmp92 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp91, i64 %tmp88
    %tmp93 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp92 to i8*
    %tmp94 = load i64, i64* %i.addr.24
    %tmp95 = sub i64 %tmp94, 1
    %tmp96 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp97 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp96, i32 0, i32 0
    %tmp98 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp97
    %tmp99 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp98, i64 %tmp95
    %tmp100 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp99 to i8*
    %tmp101 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* null, i32 1
    %tmp102 = ptrtoint %class.hashmap.HashMapEntry_string.String_int* %tmp101 to i64
    %tmp103 = call i8* @"memcpy"(i8* %tmp93, i8* %tmp100, i64 %tmp102)
    %tmp104 = load i64, i64* %i.addr.24
    %tmp105 = sub i64 %tmp104, 1
    store i64 %tmp105, i64* %i.addr.24
    br label %while.cond.32
while.end.32:
    br label %if.end.27
if.end.27:
    %tmp106 = load i64, i64* %index.addr
    %tmp107 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp108 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp107, i32 0, i32 0
    %tmp109 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp108
    %tmp110 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp109, i64 %tmp106
    %tmp111 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp110 to i8*
    %tmp112 = bitcast %class.hashmap.HashMapEntry_string.String_int* %item.addr to i8*
    %tmp113 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* null, i32 1
    %tmp114 = ptrtoint %class.hashmap.HashMapEntry_string.String_int* %tmp113 to i64
    %tmp115 = call i8* @"memcpy"(i8* %tmp111, i8* %tmp112, i64 %tmp114)
    %tmp116 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp117 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp116, i32 0, i32 1
    %tmp118 = load i64, i64* %tmp117
    %tmp119 = add i64 %tmp118, 1
    %tmp120 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp121 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp120, i32 0, i32 1
    store i64 %tmp119, i64* %tmp121
    ret void
}

define %class.hashmap.HashMapEntry_string.String_int @"array.Array_hashmap.HashMapEntry_string.String_int.remove"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self, i64 %index) {
entry:
    %self.addr = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    %index.addr = alloca i64
    %temp.addr.25 = alloca %class.hashmap.HashMapEntry_string.String_int*
    %i.addr.26 = alloca i64
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    store i64 %index, i64* %index.addr
    %tmp0 = load i64, i64* %index.addr
    %tmp1 = icmp slt i64 %tmp0, 0
    %tmp2 = load i64, i64* %index.addr
    %tmp3 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp4 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp3, i32 0, i32 1
    %tmp5 = load i64, i64* %tmp4
    %tmp6 = icmp sge i64 %tmp2, %tmp5
    %tmp7 = or i1 %tmp1, %tmp6
    br i1 %tmp7, label %if.then.33, label %if.end.33
if.then.33:
    %tmp8 = trunc i64 1 to i32
    call void @"exit"(i32 %tmp8)
    br label %if.end.33
if.end.33:
    %tmp9 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* null, i32 1
    %tmp10 = ptrtoint %class.hashmap.HashMapEntry_string.String_int* %tmp9 to i64
    %tmp11 = call i8* @"malloc"(i64 %tmp10)
    %tmp12 = bitcast i8* %tmp11 to %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMapEntry_string.String_int* %tmp12, %class.hashmap.HashMapEntry_string.String_int** %temp.addr.25
    %tmp13 = load i64, i64* %index.addr
    store i64 %tmp13, i64* %i.addr.26
    br label %while.cond.34
while.cond.34:
    %tmp14 = load i64, i64* %i.addr.26
    %tmp15 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp16 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp15, i32 0, i32 1
    %tmp17 = load i64, i64* %tmp16
    %tmp18 = sub i64 %tmp17, 1
    %tmp19 = icmp slt i64 %tmp14, %tmp18
    br i1 %tmp19, label %while.body.34, label %while.end.34
while.body.34:
    %tmp20 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %temp.addr.25
    %tmp21 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp20 to i8*
    %tmp22 = load i64, i64* %i.addr.26
    %tmp23 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp24 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp23, i32 0, i32 0
    %tmp25 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp24
    %tmp26 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp25, i64 %tmp22
    %tmp27 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp26 to i8*
    %tmp28 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* null, i32 1
    %tmp29 = ptrtoint %class.hashmap.HashMapEntry_string.String_int* %tmp28 to i64
    %tmp30 = call i8* @"memcpy"(i8* %tmp21, i8* %tmp27, i64 %tmp29)
    %tmp31 = load i64, i64* %i.addr.26
    %tmp32 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp33 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp32, i32 0, i32 0
    %tmp34 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp33
    %tmp35 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp34, i64 %tmp31
    %tmp36 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp35 to i8*
    %tmp37 = load i64, i64* %i.addr.26
    %tmp38 = add i64 %tmp37, 1
    %tmp39 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp40 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp39, i32 0, i32 0
    %tmp41 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp40
    %tmp42 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp41, i64 %tmp38
    %tmp43 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp42 to i8*
    %tmp44 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* null, i32 1
    %tmp45 = ptrtoint %class.hashmap.HashMapEntry_string.String_int* %tmp44 to i64
    %tmp46 = call i8* @"memcpy"(i8* %tmp36, i8* %tmp43, i64 %tmp45)
    %tmp47 = load i64, i64* %i.addr.26
    %tmp48 = add i64 %tmp47, 1
    %tmp49 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp50 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp49, i32 0, i32 0
    %tmp51 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp50
    %tmp52 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp51, i64 %tmp48
    %tmp53 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp52 to i8*
    %tmp54 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %temp.addr.25
    %tmp55 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp54 to i8*
    %tmp56 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* null, i32 1
    %tmp57 = ptrtoint %class.hashmap.HashMapEntry_string.String_int* %tmp56 to i64
    %tmp58 = call i8* @"memcpy"(i8* %tmp53, i8* %tmp55, i64 %tmp57)
    %tmp59 = load i64, i64* %i.addr.26
    %tmp60 = add i64 %tmp59, 1
    store i64 %tmp60, i64* %i.addr.26
    br label %while.cond.34
while.end.34:
    %tmp61 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %temp.addr.25
    %tmp62 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp61 to i8*
    call void @"free"(i8* %tmp62)
    %tmp63 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp64 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp63, i32 0, i32 1
    %tmp65 = load i64, i64* %tmp64
    %tmp66 = sub i64 %tmp65, 1
    %tmp67 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp68 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp67, i32 0, i32 1
    store i64 %tmp66, i64* %tmp68
    %tmp69 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp70 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp69, i32 0, i32 1
    %tmp71 = load i64, i64* %tmp70
    %tmp72 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp73 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp72, i32 0, i32 0
    %tmp74 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp73
    %tmp75 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp74, i64 %tmp71
    %tmp76 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp75
    ret %class.hashmap.HashMapEntry_string.String_int %tmp76
}

define void @"array.Array_hashmap.HashMapEntry_string.String_int.clear"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %self.addr = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    %i.addr.27 = alloca i64
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    store i64 0, i64* %i.addr.27
    br label %while.cond.35
while.cond.35:
    %tmp0 = load i64, i64* %i.addr.27
    %tmp1 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp2 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1, i32 0, i32 1
    %tmp3 = load i64, i64* %tmp2
    %tmp4 = icmp slt i64 %tmp0, %tmp3
    br i1 %tmp4, label %while.body.35, label %while.end.35
while.body.35:
    %tmp5 = load i64, i64* %i.addr.27
    %tmp6 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp7 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp6, i32 0, i32 0
    %tmp8 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp7
    %tmp9 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp8, i64 %tmp5
    %tmp10 = load i64, i64* %i.addr.27
    %tmp11 = add i64 %tmp10, 1
    store i64 %tmp11, i64* %i.addr.27
    br label %while.cond.35
while.end.35:
    %tmp12 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp13 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp12, i32 0, i32 1
    store i64 0, i64* %tmp13
    ret void
}

define void @"array.Array_hashmap.HashMapEntry_string.String_int.destroy"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %self) {
entry:
    %self.addr = alloca %class.array.Array_hashmap.HashMapEntry_string.String_int*
    %i.addr.28 = alloca i64
    store %class.array.Array_hashmap.HashMapEntry_string.String_int* %self, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp0 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp1 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp0, i32 0, i32 0
    %tmp2 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp1
    %tmp3 = icmp ne %class.hashmap.HashMapEntry_string.String_int* %tmp2, null
    br i1 %tmp3, label %if.then.36, label %if.end.36
if.then.36:
    store i64 0, i64* %i.addr.28
    br label %while.cond.37
while.cond.37:
    %tmp4 = load i64, i64* %i.addr.28
    %tmp5 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp6 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp5, i32 0, i32 1
    %tmp7 = load i64, i64* %tmp6
    %tmp8 = icmp slt i64 %tmp4, %tmp7
    br i1 %tmp8, label %while.body.37, label %while.end.37
while.body.37:
    %tmp9 = load i64, i64* %i.addr.28
    %tmp10 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp11 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp10, i32 0, i32 0
    %tmp12 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp11
    %tmp13 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp12, i64 %tmp9
    %tmp14 = load i64, i64* %i.addr.28
    %tmp15 = add i64 %tmp14, 1
    store i64 %tmp15, i64* %i.addr.28
    br label %while.cond.37
while.end.37:
    %tmp16 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp17 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp16, i32 0, i32 0
    %tmp18 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp17
    %tmp19 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp18 to i8*
    call void @"free"(i8* %tmp19)
    %tmp20 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp21 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp20, i32 0, i32 0
    store %class.hashmap.HashMapEntry_string.String_int* null, %class.hashmap.HashMapEntry_string.String_int** %tmp21
    br label %if.end.36
if.end.36:
    %tmp22 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp23 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp22, i32 0, i32 2
    store i64 0, i64* %tmp23
    %tmp24 = load %class.array.Array_hashmap.HashMapEntry_string.String_int*, %class.array.Array_hashmap.HashMapEntry_string.String_int** %self.addr
    %tmp25 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp24, i32 0, i32 1
    store i64 0, i64* %tmp25
    ret void
}

define void @"hashmap.HashMap_string.String_int.init"(%class.hashmap.HashMap_string.String_int* %self) {
entry:
    %self.addr = alloca %class.hashmap.HashMap_string.String_int*
    %i.addr.29 = alloca i64
    %tmp13 = alloca %class.hashmap.HashMapEntry_string.String_int
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp0 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp1 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp0, i32 0, i32 1
    store i64 0, i64* %tmp1
    %tmp2 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp3 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp2, i32 0, i32 2
    store i64 16, i64* %tmp3
    %tmp4 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp5 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp4, i32 0, i32 0
    call void @"array.Array_hashmap.HashMapEntry_string.String_int.init"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp5)
    store i64 0, i64* %i.addr.29
    br label %while.cond.38
while.cond.38:
    %tmp6 = load i64, i64* %i.addr.29
    %tmp7 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp8 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp7, i32 0, i32 2
    %tmp9 = load i64, i64* %tmp8
    %tmp10 = icmp slt i64 %tmp6, %tmp9
    br i1 %tmp10, label %while.body.38, label %while.end.38
while.body.38:
    %tmp11 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp12 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp11, i32 0, i32 0
    call void @"hashmap.HashMapEntry_string.String_int.init"(%class.hashmap.HashMapEntry_string.String_int* %tmp13)
    %tmp14 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp13
    call void @"array.Array_hashmap.HashMapEntry_string.String_int.push"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp12, %class.hashmap.HashMapEntry_string.String_int %tmp14)
    %tmp15 = load i64, i64* %i.addr.29
    %tmp16 = add i64 %tmp15, 1
    store i64 %tmp16, i64* %i.addr.29
    br label %while.cond.38
while.end.38:
    ret void
}

define i64 @"hashmap.HashMap_string.String_int.length"(%class.hashmap.HashMap_string.String_int* %self) {
entry:
    %self.addr = alloca %class.hashmap.HashMap_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp0 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp1 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp0, i32 0, i32 1
    %tmp2 = load i64, i64* %tmp1
    ret i64 %tmp2
}

define void @"hashmap.HashMap_string.String_int.operator_index_set"(%class.hashmap.HashMap_string.String_int* %self, %class.string.String %key, i64 %value) {
entry:
    %self.addr = alloca %class.hashmap.HashMap_string.String_int*
    %key.addr = alloca %class.string.String
    %value.addr = alloca i64
    %idx.addr.30 = alloca i64
    %entry_ptr.addr.31 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %self.addr
    store %class.string.String %key, %class.string.String* %key.addr
    store i64 %value, i64* %value.addr
    %tmp0 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp1 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp0, i32 0, i32 1
    %tmp2 = load i64, i64* %tmp1
    %tmp3 = mul i64 %tmp2, 100
    %tmp4 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp5 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp4, i32 0, i32 2
    %tmp6 = load i64, i64* %tmp5
    %tmp7 = mul i64 %tmp6, 70
    %tmp8 = icmp sgt i64 %tmp3, %tmp7
    br i1 %tmp8, label %if.then.39, label %if.end.39
if.then.39:
    %tmp9 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    call void @"hashmap.HashMap_string.String_int.resize"(%class.hashmap.HashMap_string.String_int* %tmp9)
    br label %if.end.39
if.end.39:
    %tmp10 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp11 = call i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %tmp10, %class.string.String* %key.addr)
    store i64 %tmp11, i64* %idx.addr.30
    %tmp12 = load i64, i64* %idx.addr.30
    %tmp13 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp14 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp13, i32 0, i32 0
    %tmp15 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp14, i32 0, i32 0
    %tmp16 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp15
    %tmp17 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp16, i64 %tmp12
    store %class.hashmap.HashMapEntry_string.String_int* %tmp17, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.31
    %tmp18 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.31
    %tmp19 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp18, i32 0, i32 2
    %tmp20 = load i1, i1* %tmp19
    %tmp21 = xor i1 %tmp20, 1
    br i1 %tmp21, label %if.then.40, label %if.else.40
if.then.40:
    %tmp22 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp23 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp22, i32 0, i32 1
    %tmp24 = load i64, i64* %tmp23
    %tmp25 = add i64 %tmp24, 1
    %tmp26 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp27 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp26, i32 0, i32 1
    store i64 %tmp25, i64* %tmp27
    br label %if.end.40
if.else.40:
    %tmp28 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.31
    %tmp29 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp28, i32 0, i32 0
    call void @"string.String.destroy"(%class.string.String* %tmp29)
    %tmp30 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.31
    %tmp31 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp30, i32 0, i32 1
    %tmp32 = load i64, i64* %tmp31
    br label %if.end.40
if.end.40:
    %tmp33 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.31
    %tmp34 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp33, i32 0, i32 0
    %tmp35 = bitcast %class.string.String* %tmp34 to i8*
    %tmp36 = bitcast %class.string.String* %key.addr to i8*
    %tmp37 = getelementptr %class.string.String, %class.string.String* null, i32 1
    %tmp38 = ptrtoint %class.string.String* %tmp37 to i64
    %tmp39 = call i8* @"memcpy"(i8* %tmp35, i8* %tmp36, i64 %tmp38)
    %tmp40 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.31
    %tmp41 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp40, i32 0, i32 1
    %tmp42 = bitcast i64* %tmp41 to i8*
    %tmp43 = bitcast i64* %value.addr to i8*
    %tmp44 = getelementptr i64, i64* null, i32 1
    %tmp45 = ptrtoint i64* %tmp44 to i64
    %tmp46 = call i8* @"memcpy"(i8* %tmp42, i8* %tmp43, i64 %tmp45)
    %tmp47 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.31
    %tmp48 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp47, i32 0, i32 2
    store i1 1, i1* %tmp48
    ret void
}

define i64* @"hashmap.HashMap_string.String_int.get"(%class.hashmap.HashMap_string.String_int* %self, %class.string.String* %key) {
entry:
    %self.addr = alloca %class.hashmap.HashMap_string.String_int*
    %key.addr = alloca %class.string.String*
    %idx.addr.32 = alloca i64
    %entry_ptr.addr.33 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %self.addr
    store %class.string.String* %key, %class.string.String** %key.addr
    %tmp0 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp1 = load %class.string.String*, %class.string.String** %key.addr
    %tmp2 = call i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %tmp0, %class.string.String* %tmp1)
    store i64 %tmp2, i64* %idx.addr.32
    %tmp3 = load i64, i64* %idx.addr.32
    %tmp4 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp5 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp4, i32 0, i32 0
    %tmp6 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp5, i32 0, i32 0
    %tmp7 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp6
    %tmp8 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp7, i64 %tmp3
    store %class.hashmap.HashMapEntry_string.String_int* %tmp8, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.33
    %tmp9 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.33
    %tmp10 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp9, i32 0, i32 2
    %tmp11 = load i1, i1* %tmp10
    br i1 %tmp11, label %if.then.41, label %if.end.41
if.then.41:
    %tmp12 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.33
    %tmp13 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp12, i32 0, i32 1
    ret i64* %tmp13
if.end.41:
    ret i64* null
}

define i1 @"hashmap.HashMap_string.String_int.contains"(%class.hashmap.HashMap_string.String_int* %self, %class.string.String* %key) {
entry:
    %self.addr = alloca %class.hashmap.HashMap_string.String_int*
    %key.addr = alloca %class.string.String*
    %idx.addr.34 = alloca i64
    %entry_ptr.addr.35 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %self.addr
    store %class.string.String* %key, %class.string.String** %key.addr
    %tmp0 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp1 = load %class.string.String*, %class.string.String** %key.addr
    %tmp2 = call i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %tmp0, %class.string.String* %tmp1)
    store i64 %tmp2, i64* %idx.addr.34
    %tmp3 = load i64, i64* %idx.addr.34
    %tmp4 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp5 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp4, i32 0, i32 0
    %tmp6 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp5, i32 0, i32 0
    %tmp7 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp6
    %tmp8 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp7, i64 %tmp3
    store %class.hashmap.HashMapEntry_string.String_int* %tmp8, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.35
    %tmp9 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.35
    %tmp10 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp9, i32 0, i32 2
    %tmp11 = load i1, i1* %tmp10
    ret i1 %tmp11
}

define i1 @"hashmap.HashMap_string.String_int.remove"(%class.hashmap.HashMap_string.String_int* %self, %class.string.String* %key) {
entry:
    %self.addr = alloca %class.hashmap.HashMap_string.String_int*
    %key.addr = alloca %class.string.String*
    %idx.addr.36 = alloca i64
    %entry_ptr.addr.37 = alloca %class.hashmap.HashMapEntry_string.String_int*
    %i.addr.38 = alloca i64
    %temp_ptr.addr.39 = alloca %class.hashmap.HashMapEntry_string.String_int*
    %new_idx.addr.40 = alloca i64
    %new_entry_ptr.addr.41 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %self.addr
    store %class.string.String* %key, %class.string.String** %key.addr
    %tmp0 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp1 = load %class.string.String*, %class.string.String** %key.addr
    %tmp2 = call i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %tmp0, %class.string.String* %tmp1)
    store i64 %tmp2, i64* %idx.addr.36
    %tmp3 = load i64, i64* %idx.addr.36
    %tmp4 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp5 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp4, i32 0, i32 0
    %tmp6 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp5, i32 0, i32 0
    %tmp7 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp6
    %tmp8 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp7, i64 %tmp3
    store %class.hashmap.HashMapEntry_string.String_int* %tmp8, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.37
    %tmp9 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.37
    %tmp10 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp9, i32 0, i32 2
    %tmp11 = load i1, i1* %tmp10
    br i1 %tmp11, label %if.then.42, label %if.end.42
if.then.42:
    %tmp12 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.37
    %tmp13 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp12, i32 0, i32 0
    call void @"string.String.destroy"(%class.string.String* %tmp13)
    %tmp14 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.37
    %tmp15 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp14, i32 0, i32 1
    %tmp16 = load i64, i64* %tmp15
    %tmp17 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.37
    %tmp18 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp17, i32 0, i32 2
    store i1 0, i1* %tmp18
    %tmp19 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp20 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp19, i32 0, i32 1
    %tmp21 = load i64, i64* %tmp20
    %tmp22 = sub i64 %tmp21, 1
    %tmp23 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp24 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp23, i32 0, i32 1
    store i64 %tmp22, i64* %tmp24
    %tmp25 = load i64, i64* %idx.addr.36
    %tmp26 = add i64 %tmp25, 1
    %tmp27 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp28 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp27, i32 0, i32 2
    %tmp29 = load i64, i64* %tmp28
    %tmp30 = srem i64 %tmp26, %tmp29
    store i64 %tmp30, i64* %i.addr.38
    br label %while.cond.43
while.cond.43:
    %tmp31 = load i64, i64* %i.addr.38
    %tmp32 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp33 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp32, i32 0, i32 0
    %tmp34 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp33, i32 0, i32 0
    %tmp35 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp34
    %tmp36 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp35, i64 %tmp31
    %tmp37 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp36, i32 0, i32 2
    %tmp38 = load i1, i1* %tmp37
    br i1 %tmp38, label %while.body.43, label %while.end.43
while.body.43:
    %tmp39 = load i64, i64* %i.addr.38
    %tmp40 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp41 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp40, i32 0, i32 0
    %tmp42 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp41, i32 0, i32 0
    %tmp43 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp42
    %tmp44 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp43, i64 %tmp39
    store %class.hashmap.HashMapEntry_string.String_int* %tmp44, %class.hashmap.HashMapEntry_string.String_int** %temp_ptr.addr.39
    %tmp45 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %temp_ptr.addr.39
    %tmp46 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp45, i32 0, i32 2
    store i1 0, i1* %tmp46
    %tmp47 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp48 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp47, i32 0, i32 1
    %tmp49 = load i64, i64* %tmp48
    %tmp50 = sub i64 %tmp49, 1
    %tmp51 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp52 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp51, i32 0, i32 1
    store i64 %tmp50, i64* %tmp52
    %tmp53 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp54 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %temp_ptr.addr.39
    %tmp55 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp54, i32 0, i32 0
    %tmp56 = call i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %tmp53, %class.string.String* %tmp55)
    store i64 %tmp56, i64* %new_idx.addr.40
    %tmp57 = load i64, i64* %new_idx.addr.40
    %tmp58 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp59 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp58, i32 0, i32 0
    %tmp60 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp59, i32 0, i32 0
    %tmp61 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp60
    %tmp62 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp61, i64 %tmp57
    store %class.hashmap.HashMapEntry_string.String_int* %tmp62, %class.hashmap.HashMapEntry_string.String_int** %new_entry_ptr.addr.41
    %tmp63 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %new_entry_ptr.addr.41
    %tmp64 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp63, i32 0, i32 0
    %tmp65 = bitcast %class.string.String* %tmp64 to i8*
    %tmp66 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %temp_ptr.addr.39
    %tmp67 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp66, i32 0, i32 0
    %tmp68 = bitcast %class.string.String* %tmp67 to i8*
    %tmp69 = getelementptr %class.string.String, %class.string.String* null, i32 1
    %tmp70 = ptrtoint %class.string.String* %tmp69 to i64
    %tmp71 = call i8* @"memcpy"(i8* %tmp65, i8* %tmp68, i64 %tmp70)
    %tmp72 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %new_entry_ptr.addr.41
    %tmp73 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp72, i32 0, i32 1
    %tmp74 = bitcast i64* %tmp73 to i8*
    %tmp75 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %temp_ptr.addr.39
    %tmp76 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp75, i32 0, i32 1
    %tmp77 = bitcast i64* %tmp76 to i8*
    %tmp78 = getelementptr i64, i64* null, i32 1
    %tmp79 = ptrtoint i64* %tmp78 to i64
    %tmp80 = call i8* @"memcpy"(i8* %tmp74, i8* %tmp77, i64 %tmp79)
    %tmp81 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %new_entry_ptr.addr.41
    %tmp82 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp81, i32 0, i32 2
    store i1 1, i1* %tmp82
    %tmp83 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp84 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp83, i32 0, i32 1
    %tmp85 = load i64, i64* %tmp84
    %tmp86 = add i64 %tmp85, 1
    %tmp87 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp88 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp87, i32 0, i32 1
    store i64 %tmp86, i64* %tmp88
    %tmp89 = load i64, i64* %i.addr.38
    %tmp90 = add i64 %tmp89, 1
    %tmp91 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp92 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp91, i32 0, i32 2
    %tmp93 = load i64, i64* %tmp92
    %tmp94 = srem i64 %tmp90, %tmp93
    store i64 %tmp94, i64* %i.addr.38
    br label %while.cond.43
while.end.43:
    ret i1 1
if.end.42:
    ret i1 0
}

define i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %self, %class.string.String* %key) {
entry:
    %self.addr = alloca %class.hashmap.HashMap_string.String_int*
    %key.addr = alloca %class.string.String*
    %h.addr.42 = alloca i64
    %idx.addr.43 = alloca i64
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %self.addr
    store %class.string.String* %key, %class.string.String** %key.addr
    %tmp0 = load %class.string.String*, %class.string.String** %key.addr
    %tmp1 = call i64 @"string.String.hash"(%class.string.String* %tmp0)
    store i64 %tmp1, i64* %h.addr.42
    %tmp2 = load i64, i64* %h.addr.42
    %tmp3 = icmp slt i64 %tmp2, 0
    br i1 %tmp3, label %if.then.44, label %if.end.44
if.then.44:
    %tmp4 = load i64, i64* %h.addr.42
    %tmp5 = sub i64 0, 1
    %tmp6 = mul i64 %tmp4, %tmp5
    store i64 %tmp6, i64* %h.addr.42
    br label %if.end.44
if.end.44:
    %tmp7 = load i64, i64* %h.addr.42
    %tmp8 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp9 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp8, i32 0, i32 2
    %tmp10 = load i64, i64* %tmp9
    %tmp11 = srem i64 %tmp7, %tmp10
    store i64 %tmp11, i64* %idx.addr.43
    br label %while.cond.45
while.cond.45:
    %tmp12 = load i64, i64* %idx.addr.43
    %tmp13 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp14 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp13, i32 0, i32 0
    %tmp15 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp14, i32 0, i32 0
    %tmp16 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp15
    %tmp17 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp16, i64 %tmp12
    %tmp18 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp17, i32 0, i32 2
    %tmp19 = load i1, i1* %tmp18
    br i1 %tmp19, label %while.body.45, label %while.end.45
while.body.45:
    %tmp20 = load i64, i64* %idx.addr.43
    %tmp21 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp22 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp21, i32 0, i32 0
    %tmp23 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp22, i32 0, i32 0
    %tmp24 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp23
    %tmp25 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp24, i64 %tmp20
    %tmp26 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp25, i32 0, i32 0
    %tmp27 = load %class.string.String*, %class.string.String** %key.addr
    %tmp28 = call i1 @"string.String.equals"(%class.string.String* %tmp26, %class.string.String* %tmp27)
    br i1 %tmp28, label %if.then.46, label %if.end.46
if.then.46:
    %tmp29 = load i64, i64* %idx.addr.43
    ret i64 %tmp29
if.end.46:
    %tmp30 = load i64, i64* %idx.addr.43
    %tmp31 = add i64 %tmp30, 1
    %tmp32 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp33 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp32, i32 0, i32 2
    %tmp34 = load i64, i64* %tmp33
    %tmp35 = srem i64 %tmp31, %tmp34
    store i64 %tmp35, i64* %idx.addr.43
    br label %while.cond.45
while.end.45:
    %tmp36 = load i64, i64* %idx.addr.43
    ret i64 %tmp36
}

define void @"hashmap.HashMap_string.String_int.resize"(%class.hashmap.HashMap_string.String_int* %self) {
entry:
    %self.addr = alloca %class.hashmap.HashMap_string.String_int*
    %old_data.addr.44 = alloca %class.hashmap.HashMapEntry_string.String_int*
    %old_cap.addr.45 = alloca i64
    %i.addr.46 = alloca i64
    %tmp40 = alloca %class.hashmap.HashMapEntry_string.String_int
    %entry_ptr.addr.47 = alloca %class.hashmap.HashMapEntry_string.String_int*
    %new_idx.addr.48 = alloca i64
    %new_entry_ptr.addr.49 = alloca %class.hashmap.HashMapEntry_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp0 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp1 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp0, i32 0, i32 0
    %tmp2 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1, i32 0, i32 0
    %tmp3 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp2
    store %class.hashmap.HashMapEntry_string.String_int* %tmp3, %class.hashmap.HashMapEntry_string.String_int** %old_data.addr.44
    %tmp4 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp5 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp4, i32 0, i32 2
    %tmp6 = load i64, i64* %tmp5
    store i64 %tmp6, i64* %old_cap.addr.45
    %tmp7 = load i64, i64* %old_cap.addr.45
    %tmp8 = mul i64 %tmp7, 2
    %tmp9 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp10 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp9, i32 0, i32 2
    store i64 %tmp8, i64* %tmp10
    %tmp11 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp12 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp11, i32 0, i32 1
    store i64 0, i64* %tmp12
    %tmp13 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp14 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp13, i32 0, i32 2
    %tmp15 = load i64, i64* %tmp14
    %tmp16 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* null, i32 1
    %tmp17 = ptrtoint %class.hashmap.HashMapEntry_string.String_int* %tmp16 to i64
    %tmp18 = mul i64 %tmp15, %tmp17
    %tmp19 = call i8* @"malloc"(i64 %tmp18)
    %tmp20 = bitcast i8* %tmp19 to %class.hashmap.HashMapEntry_string.String_int*
    %tmp21 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp22 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp21, i32 0, i32 0
    %tmp23 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp22, i32 0, i32 0
    store %class.hashmap.HashMapEntry_string.String_int* %tmp20, %class.hashmap.HashMapEntry_string.String_int** %tmp23
    %tmp24 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp25 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp24, i32 0, i32 2
    %tmp26 = load i64, i64* %tmp25
    %tmp27 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp28 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp27, i32 0, i32 0
    %tmp29 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp28, i32 0, i32 2
    store i64 %tmp26, i64* %tmp29
    %tmp30 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp31 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp30, i32 0, i32 0
    %tmp32 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp31, i32 0, i32 1
    store i64 0, i64* %tmp32
    store i64 0, i64* %i.addr.46
    br label %while.cond.47
while.cond.47:
    %tmp33 = load i64, i64* %i.addr.46
    %tmp34 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp35 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp34, i32 0, i32 2
    %tmp36 = load i64, i64* %tmp35
    %tmp37 = icmp slt i64 %tmp33, %tmp36
    br i1 %tmp37, label %while.body.47, label %while.end.47
while.body.47:
    %tmp38 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp39 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp38, i32 0, i32 0
    call void @"hashmap.HashMapEntry_string.String_int.init"(%class.hashmap.HashMapEntry_string.String_int* %tmp40)
    %tmp41 = load %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp40
    call void @"array.Array_hashmap.HashMapEntry_string.String_int.push"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp39, %class.hashmap.HashMapEntry_string.String_int %tmp41)
    %tmp42 = load i64, i64* %i.addr.46
    %tmp43 = add i64 %tmp42, 1
    store i64 %tmp43, i64* %i.addr.46
    br label %while.cond.47
while.end.47:
    store i64 0, i64* %i.addr.46
    br label %while.cond.48
while.cond.48:
    %tmp44 = load i64, i64* %i.addr.46
    %tmp45 = load i64, i64* %old_cap.addr.45
    %tmp46 = icmp slt i64 %tmp44, %tmp45
    br i1 %tmp46, label %while.body.48, label %while.end.48
while.body.48:
    %tmp47 = load i64, i64* %i.addr.46
    %tmp48 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %old_data.addr.44
    %tmp49 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp48, i64 %tmp47
    store %class.hashmap.HashMapEntry_string.String_int* %tmp49, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.47
    %tmp50 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.47
    %tmp51 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp50, i32 0, i32 2
    %tmp52 = load i1, i1* %tmp51
    br i1 %tmp52, label %if.then.49, label %if.end.49
if.then.49:
    %tmp53 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp54 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.47
    %tmp55 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp54, i32 0, i32 0
    %tmp56 = call i64 @"hashmap.HashMap_string.String_int.find_slot"(%class.hashmap.HashMap_string.String_int* %tmp53, %class.string.String* %tmp55)
    store i64 %tmp56, i64* %new_idx.addr.48
    %tmp57 = load i64, i64* %new_idx.addr.48
    %tmp58 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp59 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp58, i32 0, i32 0
    %tmp60 = getelementptr %class.array.Array_hashmap.HashMapEntry_string.String_int, %class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp59, i32 0, i32 0
    %tmp61 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %tmp60
    %tmp62 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp61, i64 %tmp57
    store %class.hashmap.HashMapEntry_string.String_int* %tmp62, %class.hashmap.HashMapEntry_string.String_int** %new_entry_ptr.addr.49
    %tmp63 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %new_entry_ptr.addr.49
    %tmp64 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp63, i32 0, i32 0
    %tmp65 = bitcast %class.string.String* %tmp64 to i8*
    %tmp66 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.47
    %tmp67 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp66, i32 0, i32 0
    %tmp68 = bitcast %class.string.String* %tmp67 to i8*
    %tmp69 = getelementptr %class.string.String, %class.string.String* null, i32 1
    %tmp70 = ptrtoint %class.string.String* %tmp69 to i64
    %tmp71 = call i8* @"memcpy"(i8* %tmp65, i8* %tmp68, i64 %tmp70)
    %tmp72 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %new_entry_ptr.addr.49
    %tmp73 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp72, i32 0, i32 1
    %tmp74 = bitcast i64* %tmp73 to i8*
    %tmp75 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %entry_ptr.addr.47
    %tmp76 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp75, i32 0, i32 1
    %tmp77 = bitcast i64* %tmp76 to i8*
    %tmp78 = getelementptr i64, i64* null, i32 1
    %tmp79 = ptrtoint i64* %tmp78 to i64
    %tmp80 = call i8* @"memcpy"(i8* %tmp74, i8* %tmp77, i64 %tmp79)
    %tmp81 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %new_entry_ptr.addr.49
    %tmp82 = getelementptr %class.hashmap.HashMapEntry_string.String_int, %class.hashmap.HashMapEntry_string.String_int* %tmp81, i32 0, i32 2
    store i1 1, i1* %tmp82
    %tmp83 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp84 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp83, i32 0, i32 1
    %tmp85 = load i64, i64* %tmp84
    %tmp86 = add i64 %tmp85, 1
    %tmp87 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp88 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp87, i32 0, i32 1
    store i64 %tmp86, i64* %tmp88
    br label %if.end.49
if.end.49:
    %tmp89 = load i64, i64* %i.addr.46
    %tmp90 = add i64 %tmp89, 1
    store i64 %tmp90, i64* %i.addr.46
    br label %while.cond.48
while.end.48:
    %tmp91 = load %class.hashmap.HashMapEntry_string.String_int*, %class.hashmap.HashMapEntry_string.String_int** %old_data.addr.44
    %tmp92 = bitcast %class.hashmap.HashMapEntry_string.String_int* %tmp91 to i8*
    call void @"free"(i8* %tmp92)
    ret void
}

define void @"hashmap.HashMap_string.String_int.destroy"(%class.hashmap.HashMap_string.String_int* %self) {
entry:
    %self.addr = alloca %class.hashmap.HashMap_string.String_int*
    store %class.hashmap.HashMap_string.String_int* %self, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp0 = load %class.hashmap.HashMap_string.String_int*, %class.hashmap.HashMap_string.String_int** %self.addr
    %tmp1 = getelementptr %class.hashmap.HashMap_string.String_int, %class.hashmap.HashMap_string.String_int* %tmp0, i32 0, i32 0
    call void @"array.Array_hashmap.HashMapEntry_string.String_int.destroy"(%class.array.Array_hashmap.HashMapEntry_string.String_int* %tmp1)
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
