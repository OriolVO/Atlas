; Atlas compiler v0.1.0 — auto-generated LLVM IR
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%choice.result.Result_int_int = type { i32, [8 x i8] }

define %choice.result.Result_int_int @"main.compute"(i64 %val) {
entry:
    %val.addr = alloca i64
    %choice.alloca.0 = alloca %choice.result.Result_int_int
    %choice.alloca.1 = alloca %choice.result.Result_int_int
    store i64 %val, i64* %val.addr
    %tmp0 = load i64, i64* %val.addr
    %tmp1 = icmp slt i64 %tmp0, 0
    br i1 %tmp1, label %if.then.0, label %if.end.0
if.then.0:
    %tmp2 = getelementptr %choice.result.Result_int_int, %choice.result.Result_int_int* %choice.alloca.0, i32 0, i32 0
    store i32 1, i32* %tmp2
    %tmp3 = getelementptr %choice.result.Result_int_int, %choice.result.Result_int_int* %choice.alloca.0, i32 0, i32 1
    %tmp4 = bitcast [8 x i8]* %tmp3 to i64*
    store i64 10, i64* %tmp4
    %tmp5 = load %choice.result.Result_int_int, %choice.result.Result_int_int* %choice.alloca.0
    ret %choice.result.Result_int_int %tmp5
if.end.0:
    %tmp6 = getelementptr %choice.result.Result_int_int, %choice.result.Result_int_int* %choice.alloca.1, i32 0, i32 0
    store i32 0, i32* %tmp6
    %tmp7 = load i64, i64* %val.addr
    %tmp8 = getelementptr %choice.result.Result_int_int, %choice.result.Result_int_int* %choice.alloca.1, i32 0, i32 1
    %tmp9 = bitcast [8 x i8]* %tmp8 to i64*
    store i64 %tmp7, i64* %tmp9
    %tmp10 = load %choice.result.Result_int_int, %choice.result.Result_int_int* %choice.alloca.1
    ret %choice.result.Result_int_int %tmp10
}

define %choice.result.Result_int_int @"main.try_propagate"(i64 %val) {
entry:
    %val.addr = alloca i64
    %x.addr.2 = alloca i64
    %tmp2 = alloca %choice.result.Result_int_int
    %ret.choice.alloca.3 = alloca %choice.result.Result_int_int
    %choice.alloca.4 = alloca %choice.result.Result_int_int
    store i64 %val, i64* %val.addr
    %tmp0 = load i64, i64* %val.addr
    %tmp1 = call %choice.result.Result_int_int @"main.compute"(i64 %tmp0)
    store %choice.result.Result_int_int %tmp1, %choice.result.Result_int_int* %tmp2
    %tmp3 = getelementptr %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp2, i32 0, i32 0
    %tmp4 = load i32, i32* %tmp3
    %tmp5 = icmp eq i32 %tmp4, 1
    br i1 %tmp5, label %err_prop.err.2, label %err_prop.ok.1
    
err_prop.err.2:
    %tmp6 = getelementptr %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp2, i32 0, i32 1
    %tmp7 = bitcast [8 x i8]* %tmp6 to i64*
    %tmp8 = load i64, i64* %tmp7
    %tmp9 = getelementptr %choice.result.Result_int_int, %choice.result.Result_int_int* %ret.choice.alloca.3, i32 0, i32 0
    store i32 1, i32* %tmp9
    %tmp10 = getelementptr %choice.result.Result_int_int, %choice.result.Result_int_int* %ret.choice.alloca.3, i32 0, i32 1
    %tmp11 = bitcast [8 x i8]* %tmp10 to i64*
    store i64 %tmp8, i64* %tmp11
    %tmp12 = load %choice.result.Result_int_int, %choice.result.Result_int_int* %ret.choice.alloca.3
    ret %choice.result.Result_int_int %tmp12
    
err_prop.ok.1:
    %tmp13 = getelementptr %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp2, i32 0, i32 1
    %tmp14 = bitcast [8 x i8]* %tmp13 to i64*
    %tmp15 = load i64, i64* %tmp14
    store i64 %tmp15, i64* %x.addr.2
    %tmp16 = getelementptr %choice.result.Result_int_int, %choice.result.Result_int_int* %choice.alloca.4, i32 0, i32 0
    store i32 0, i32* %tmp16
    %tmp17 = load i64, i64* %x.addr.2
    %tmp18 = add i64 %tmp17, 2
    %tmp19 = getelementptr %choice.result.Result_int_int, %choice.result.Result_int_int* %choice.alloca.4, i32 0, i32 1
    %tmp20 = bitcast [8 x i8]* %tmp19 to i64*
    store i64 %tmp18, i64* %tmp20
    %tmp21 = load %choice.result.Result_int_int, %choice.result.Result_int_int* %choice.alloca.4
    ret %choice.result.Result_int_int %tmp21
}

define i64 @main() {
entry:
    %r1.addr.5 = alloca %choice.result.Result_int_int
    %tmp1 = alloca %choice.result.Result_int_int
    %r2.addr.6 = alloca %choice.result.Result_int_int
    %tmp5 = alloca %choice.result.Result_int_int
    %res.addr.7 = alloca i64
    %bind.alloca.8 = alloca i64
    %bind.alloca.9 = alloca i64
    %bind.alloca.10 = alloca i64
    %bind.alloca.11 = alloca i64
    %tmp0 = call %choice.result.Result_int_int @"main.try_propagate"(i64 40)
    store %choice.result.Result_int_int %tmp0, %choice.result.Result_int_int* %tmp1
    %tmp2 = load %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp1
    store %choice.result.Result_int_int %tmp2, %choice.result.Result_int_int* %r1.addr.5
    %tmp3 = sub i64 0, 1
    %tmp4 = call %choice.result.Result_int_int @"main.try_propagate"(i64 %tmp3)
    store %choice.result.Result_int_int %tmp4, %choice.result.Result_int_int* %tmp5
    %tmp6 = load %choice.result.Result_int_int, %choice.result.Result_int_int* %tmp5
    store %choice.result.Result_int_int %tmp6, %choice.result.Result_int_int* %r2.addr.6
    store i64 0, i64* %res.addr.7
    %tmp7 = getelementptr %choice.result.Result_int_int, %choice.result.Result_int_int* %r1.addr.5, i32 0, i32 0
    %tmp8 = load i32, i32* %tmp7
    %tmp9 = icmp eq i32 %tmp8, 0
    br i1 %tmp9, label %match.case.0.body.5, label %match.case.0.next.4
    
match.case.0.body.5:
    %tmp10 = getelementptr %choice.result.Result_int_int, %choice.result.Result_int_int* %r1.addr.5, i32 0, i32 1
    %tmp11 = bitcast [8 x i8]* %tmp10 to i64*
    %tmp12 = load i64, i64* %tmp11
    store i64 %tmp12, i64* %bind.alloca.8
    %tmp13 = load i64, i64* %res.addr.7
    %tmp14 = load i64, i64* %bind.alloca.8
    %tmp15 = add i64 %tmp13, %tmp14
    store i64 %tmp15, i64* %res.addr.7
    br label %match.end.3
    
match.case.0.next.4:
    %tmp16 = icmp eq i32 %tmp8, 1
    br i1 %tmp16, label %match.case.1.body.7, label %match.case.1.next.6
    
match.case.1.body.7:
    %tmp17 = getelementptr %choice.result.Result_int_int, %choice.result.Result_int_int* %r1.addr.5, i32 0, i32 1
    %tmp18 = bitcast [8 x i8]* %tmp17 to i64*
    %tmp19 = load i64, i64* %tmp18
    store i64 %tmp19, i64* %bind.alloca.9
    %tmp20 = load i64, i64* %res.addr.7
    %tmp21 = load i64, i64* %bind.alloca.9
    %tmp22 = add i64 %tmp20, %tmp21
    store i64 %tmp22, i64* %res.addr.7
    br label %match.end.3
    
match.case.1.next.6:
    br label %match.end.3
    
match.end.3:
    %tmp23 = getelementptr %choice.result.Result_int_int, %choice.result.Result_int_int* %r2.addr.6, i32 0, i32 0
    %tmp24 = load i32, i32* %tmp23
    %tmp25 = icmp eq i32 %tmp24, 0
    br i1 %tmp25, label %match.case.0.body.10, label %match.case.0.next.9
    
match.case.0.body.10:
    %tmp26 = getelementptr %choice.result.Result_int_int, %choice.result.Result_int_int* %r2.addr.6, i32 0, i32 1
    %tmp27 = bitcast [8 x i8]* %tmp26 to i64*
    %tmp28 = load i64, i64* %tmp27
    store i64 %tmp28, i64* %bind.alloca.10
    %tmp29 = load i64, i64* %res.addr.7
    %tmp30 = load i64, i64* %bind.alloca.10
    %tmp31 = add i64 %tmp29, %tmp30
    store i64 %tmp31, i64* %res.addr.7
    br label %match.end.8
    
match.case.0.next.9:
    %tmp32 = icmp eq i32 %tmp24, 1
    br i1 %tmp32, label %match.case.1.body.12, label %match.case.1.next.11
    
match.case.1.body.12:
    %tmp33 = getelementptr %choice.result.Result_int_int, %choice.result.Result_int_int* %r2.addr.6, i32 0, i32 1
    %tmp34 = bitcast [8 x i8]* %tmp33 to i64*
    %tmp35 = load i64, i64* %tmp34
    store i64 %tmp35, i64* %bind.alloca.11
    %tmp36 = load i64, i64* %res.addr.7
    %tmp37 = load i64, i64* %bind.alloca.11
    %tmp38 = add i64 %tmp36, %tmp37
    store i64 %tmp38, i64* %res.addr.7
    br label %match.end.8
    
match.case.1.next.11:
    br label %match.end.8
    
match.end.8:
    %tmp39 = load i64, i64* %res.addr.7
    ret i64 %tmp39
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
