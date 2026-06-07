; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

%class.main.ConsolePrinter = type {  }
%class.memory.Box_int = type { i64* }

declare i8* @"malloc"(i64)
declare void @"free"(i8*)
declare i8* @"memcpy"(i8*, i8*, i64)
declare i32 @"putchar"(i32)

define void @"main.ConsolePrinter.print_val"(%class.main.ConsolePrinter* %self, i64 %val) {
entry:
    %tmp0 = alloca %class.main.ConsolePrinter*
    store %class.main.ConsolePrinter* %self, %class.main.ConsolePrinter** %tmp0
    %tmp1 = alloca i64
    store i64 %val, i64* %tmp1
    call void @"main.print_char"(i32 52)
    call void @"main.print_char"(i32 50)
    call void @"main.print_char"(i32 10)
    ret void
}

define void @"main.ConsolePrinter.init"(%class.main.ConsolePrinter* %self) {
entry:
    ret void
}

define void @"main.ConsolePrinter.destroy"(%class.main.ConsolePrinter* %self) {
entry:
    ret void
}

define %class.main.ConsolePrinter @"main.ConsolePrinter.clone"(%class.main.ConsolePrinter* %self) {
entry:
    %tmp0 = load %class.main.ConsolePrinter, %class.main.ConsolePrinter* %self
    ret %class.main.ConsolePrinter %tmp0
}

define void @"memory.Box_int.destroy"(%class.memory.Box_int* %self) {
entry:
    %tmp2 = alloca %class.memory.Box_int*
    store %class.memory.Box_int* %self, %class.memory.Box_int** %tmp2
    %tmp3 = load %class.memory.Box_int*, %class.memory.Box_int** %tmp2
    %tmp4 = load %class.memory.Box_int, %class.memory.Box_int* %tmp3
    %tmp5 = load %class.memory.Box_int*, %class.memory.Box_int** %tmp2
    %tmp6 = getelementptr inbounds %class.memory.Box_int, %class.memory.Box_int* %tmp5, i32 0, i32 0
    %tmp7 = load i64*, i64** %tmp6
    %tmp8 = load %class.memory.Box_int*, %class.memory.Box_int** %tmp2
    %tmp9 = load %class.memory.Box_int, %class.memory.Box_int* %tmp8
    %tmp10 = load %class.memory.Box_int*, %class.memory.Box_int** %tmp2
    %tmp11 = getelementptr inbounds %class.memory.Box_int, %class.memory.Box_int* %tmp10, i32 0, i32 0
    %tmp12 = load i64*, i64** %tmp11
    %tmp13 = bitcast i64* %tmp12 to i8*
    call void @"free"(i8* %tmp13)
    ret void
}

define i64 @"memory.Box_int.get_val"(%class.memory.Box_int* %self) {
entry:
    %tmp14 = alloca %class.memory.Box_int*
    store %class.memory.Box_int* %self, %class.memory.Box_int** %tmp14
    %tmp15 = load %class.memory.Box_int*, %class.memory.Box_int** %tmp14
    %tmp16 = load %class.memory.Box_int, %class.memory.Box_int* %tmp15
    %tmp17 = load %class.memory.Box_int*, %class.memory.Box_int** %tmp14
    %tmp18 = getelementptr inbounds %class.memory.Box_int, %class.memory.Box_int* %tmp17, i32 0, i32 0
    %tmp19 = load i64*, i64** %tmp18
    %tmp20 = load i64, i64* %tmp19
    ret i64 %tmp20
}

define void @"memory.Box_int.init"(%class.memory.Box_int* %self) {
entry:
    ret void
}

define %class.memory.Box_int @"memory.Box_int.clone"(%class.memory.Box_int* %self) {
entry:
    %tmp0 = load %class.memory.Box_int, %class.memory.Box_int* %self
    ret %class.memory.Box_int %tmp0
}

define void @"main.print_char"(i32 %c) {
entry:
    %tmp21 = alloca i32
    store i32 %c, i32* %tmp21
    %tmp22 = load i32, i32* %tmp21
    %tmp23 = call i32 @"putchar"(i32 %tmp22)
    ret void
}

define i32 @"main"() {
entry:
    %tmp24 = call i64 @"main.identity_int"(i64 10)
    %tmp25 = alloca i64
    store i64 %tmp24, i64* %tmp25
    %tmp26 = alloca i64
    store i64 32, i64* %tmp26
    %tmp27 = call %class.memory.Box_int @"memory.new_box_int"(i64* %tmp26)
    %tmp28 = alloca %class.memory.Box_int
    store %class.memory.Box_int %tmp27, %class.memory.Box_int* %tmp28
    %tmp29 = alloca %class.main.ConsolePrinter
    store %class.main.ConsolePrinter zeroinitializer, %class.main.ConsolePrinter* %tmp29
    call void @"main.ConsolePrinter.init"(%class.main.ConsolePrinter* %tmp29)
    %tmp30 = load %class.main.ConsolePrinter, %class.main.ConsolePrinter* %tmp29
    %tmp31 = alloca %class.main.ConsolePrinter
    store %class.main.ConsolePrinter %tmp30, %class.main.ConsolePrinter* %tmp31
    call void @"main.call_print_main.ConsolePrinter"(%class.main.ConsolePrinter* %tmp31, i64 42)
    %tmp32 = load %class.memory.Box_int, %class.memory.Box_int* %tmp28
    %tmp33 = getelementptr inbounds %class.memory.Box_int, %class.memory.Box_int* %tmp28, i32 0, i32 0
    %tmp34 = load i64*, i64** %tmp33
    %tmp35 = load i64, i64* %tmp34
    %tmp36 = alloca i64
    store i64 %tmp35, i64* %tmp36
    %tmp37 = load i64, i64* %tmp25
    %tmp38 = load i64, i64* %tmp25
    %tmp39 = load i64, i64* %tmp36
    %tmp40 = add i64 %tmp38, %tmp39
    %tmp41 = trunc i64 %tmp40 to i32
    call void @"main.ConsolePrinter.destroy"(%class.main.ConsolePrinter* %tmp31)
    call void @"memory.Box_int.destroy"(%class.memory.Box_int* %tmp28)
    ret i32 %tmp41
}

define i64 @"main.identity_int"(i64 %x) {
entry:
    %tmp42 = alloca i64
    store i64 %x, i64* %tmp42
    %tmp43 = load i64, i64* %tmp42
    ret i64 %tmp43
}

define %class.memory.Box_int @"memory.new_box_int"(i64* %val) {
entry:
    %tmp44 = alloca i64*
    store i64* %val, i64** %tmp44
    %tmp45 = alloca %class.memory.Box_int
    store %class.memory.Box_int zeroinitializer, %class.memory.Box_int* %tmp45
    call void @"memory.Box_int.init"(%class.memory.Box_int* %tmp45)
    %tmp46 = load %class.memory.Box_int, %class.memory.Box_int* %tmp45
    %tmp47 = alloca %class.memory.Box_int
    store %class.memory.Box_int %tmp46, %class.memory.Box_int* %tmp47
    %tmp48 = call i8* @"malloc"(i64 8)
    %tmp49 = alloca i8*
    store i8* %tmp48, i8** %tmp49
    %tmp50 = getelementptr inbounds %class.memory.Box_int, %class.memory.Box_int* %tmp47, i32 0, i32 0
    %tmp51 = load i8*, i8** %tmp49
    %tmp52 = bitcast i8* %tmp51 to i64*
    store i64* %tmp52, i64** %tmp50
    %tmp53 = load %class.memory.Box_int, %class.memory.Box_int* %tmp47
    %tmp54 = getelementptr inbounds %class.memory.Box_int, %class.memory.Box_int* %tmp47, i32 0, i32 0
    %tmp55 = load i64*, i64** %tmp54
    %tmp56 = bitcast i64* %tmp55 to i8*
    %tmp57 = load i64*, i64** %tmp44
    %tmp58 = bitcast i64* %tmp57 to i8*
    %tmp59 = call i8* @"memcpy"(i8* %tmp56, i8* %tmp58, i64 8)
    %tmp60 = alloca i64
    store i64 0, i64* %tmp60
    br label %while_cond.0
while_cond.0:
    %tmp61 = load i64, i64* %tmp60
    %tmp62 = load i64, i64* %tmp60
    %tmp63 = icmp slt i64 %tmp62, 8
    br i1 %tmp63, label %while_body.1, label %while_end.2
while_body.1:
    %tmp64 = load i64*, i64** %tmp44
    %tmp65 = bitcast i64* %tmp64 to i8*
    %tmp66 = load i64, i64* %tmp60
    %tmp67 = load i64*, i64** %tmp44
    %tmp68 = bitcast i64* %tmp67 to i8*
    %tmp69 = getelementptr inbounds i8, i8* %tmp68, i64 %tmp66
    store i8 0, i8* %tmp69
    %tmp70 = load i64, i64* %tmp60
    %tmp71 = load i64, i64* %tmp60
    %tmp72 = add i64 %tmp71, 1
    store i64 %tmp72, i64* %tmp60
    br label %while_cond.0
while_end.2:
    %tmp73 = load %class.memory.Box_int, %class.memory.Box_int* %tmp47
    ret %class.memory.Box_int %tmp73
}

define void @"main.call_print_main.ConsolePrinter"(%class.main.ConsolePrinter* %printer, i64 %val) {
entry:
    %tmp74 = alloca %class.main.ConsolePrinter*
    store %class.main.ConsolePrinter* %printer, %class.main.ConsolePrinter** %tmp74
    %tmp75 = alloca i64
    store i64 %val, i64* %tmp75
    %tmp76 = load %class.main.ConsolePrinter*, %class.main.ConsolePrinter** %tmp74
    %tmp77 = load %class.main.ConsolePrinter*, %class.main.ConsolePrinter** %tmp74
    %tmp78 = load i64, i64* %tmp75
    call void @"main.ConsolePrinter.print_val"(%class.main.ConsolePrinter* %tmp77, i64 %tmp78)
    ret void
}

