; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.main.String = type { i8*, i64 }

declare i8* @malloc(i64)
declare void @free(i8*)

define void @main.String.init(%class.main.String* %self) {
entry:
    %tmp0 = alloca %class.main.String*
    store %class.main.String* %self, %class.main.String** %tmp0
    %tmp1 = load %class.main.String*, %class.main.String** %tmp0
    %tmp2 = getelementptr inbounds %class.main.String, %class.main.String* %tmp1, i32 0, i32 0
    %tmp3 = call i8* @malloc(i64 1)
    store i8* %tmp3, i8** %tmp2
    %tmp4 = load %class.main.String*, %class.main.String** %tmp0
    %tmp5 = getelementptr inbounds %class.main.String, %class.main.String* %tmp4, i32 0, i32 0
    %tmp6 = load %class.main.String*, %class.main.String** %tmp0
    %tmp7 = load %class.main.String, %class.main.String* %tmp6
    %tmp8 = load %class.main.String*, %class.main.String** %tmp0
    %tmp9 = getelementptr inbounds %class.main.String, %class.main.String* %tmp8, i32 0, i32 0
    %tmp10 = load i8*, i8** %tmp9
    %tmp11 = getelementptr inbounds i8, i8* %tmp10, i64 0
    store i8 0, i8* %tmp11
    %tmp12 = load %class.main.String*, %class.main.String** %tmp0
    %tmp13 = getelementptr inbounds %class.main.String, %class.main.String* %tmp12, i32 0, i32 1
    store i64 0, i64* %tmp13
    ret void
}

define void @main.String.destroy(%class.main.String* %self) {
entry:
    %tmp14 = alloca %class.main.String*
    store %class.main.String* %self, %class.main.String** %tmp14
    %tmp15 = load %class.main.String*, %class.main.String** %tmp14
    %tmp16 = load %class.main.String, %class.main.String* %tmp15
    %tmp17 = load %class.main.String*, %class.main.String** %tmp14
    %tmp18 = getelementptr inbounds %class.main.String, %class.main.String* %tmp17, i32 0, i32 0
    %tmp19 = load i8*, i8** %tmp18
    call void @free(i8* %tmp19)
    ret void
}

define i64 @main.String.length(%class.main.String* %self) {
entry:
    %tmp20 = alloca %class.main.String*
    store %class.main.String* %self, %class.main.String** %tmp20
    %tmp21 = load %class.main.String*, %class.main.String** %tmp20
    %tmp22 = load %class.main.String, %class.main.String* %tmp21
    %tmp23 = load %class.main.String*, %class.main.String** %tmp20
    %tmp24 = getelementptr inbounds %class.main.String, %class.main.String* %tmp23, i32 0, i32 1
    %tmp25 = load i64, i64* %tmp24
    ret i64 %tmp25
}

define i8* @main.String.c_str(%class.main.String* %self) {
entry:
    %tmp26 = alloca %class.main.String*
    store %class.main.String* %self, %class.main.String** %tmp26
    %tmp27 = load %class.main.String*, %class.main.String** %tmp26
    %tmp28 = load %class.main.String, %class.main.String* %tmp27
    %tmp29 = load %class.main.String*, %class.main.String** %tmp26
    %tmp30 = getelementptr inbounds %class.main.String, %class.main.String* %tmp29, i32 0, i32 0
    %tmp31 = load i8*, i8** %tmp30
    ret i8* %tmp31
}

define %class.main.String @main.String.from({ i8*, i64 } %chars) {
entry:
    %tmp32 = alloca { i8*, i64 }
    store { i8*, i64 } %chars, { i8*, i64 }* %tmp32
    %tmp33 = alloca %class.main.String
    call void @main.String.init(%class.main.String* %tmp33)
    %tmp34 = load %class.main.String, %class.main.String* %tmp33
    %tmp35 = alloca %class.main.String
    store %class.main.String %tmp34, %class.main.String* %tmp35
    %tmp36 = load %class.main.String, %class.main.String* %tmp35
    %tmp37 = getelementptr inbounds %class.main.String, %class.main.String* %tmp35, i32 0, i32 0
    %tmp38 = load i8*, i8** %tmp37
    call void @free(i8* %tmp38)
    %tmp39 = load { i8*, i64 }, { i8*, i64 }* %tmp32
    %tmp40 = extractvalue { i8*, i64 } %tmp39, 1
    %tmp41 = alloca i64
    store i64 %tmp40, i64* %tmp41
    %tmp42 = getelementptr inbounds %class.main.String, %class.main.String* %tmp35, i32 0, i32 1
    %tmp43 = load i64, i64* %tmp41
    store i64 %tmp43, i64* %tmp42
    %tmp44 = getelementptr inbounds %class.main.String, %class.main.String* %tmp35, i32 0, i32 0
    %tmp45 = load i64, i64* %tmp41
    %tmp46 = add i64 %tmp45, 1
    %tmp47 = call i8* @malloc(i64 %tmp46)
    store i8* %tmp47, i8** %tmp44
    %tmp48 = alloca i64
    store i64 0, i64* %tmp48
    br label %while_cond.0
while_cond.0:
    %tmp49 = load i64, i64* %tmp48
    %tmp50 = load i64, i64* %tmp41
    %tmp51 = icmp slt i64 %tmp49, %tmp50
    br i1 %tmp51, label %while_body.1, label %while_end.2
while_body.1:
    %tmp52 = load i64, i64* %tmp48
    %tmp53 = getelementptr inbounds %class.main.String, %class.main.String* %tmp35, i32 0, i32 0
    %tmp54 = load %class.main.String, %class.main.String* %tmp35
    %tmp55 = getelementptr inbounds %class.main.String, %class.main.String* %tmp35, i32 0, i32 0
    %tmp56 = load i8*, i8** %tmp55
    %tmp57 = getelementptr inbounds i8, i8* %tmp56, i64 %tmp52
    %tmp58 = load i64, i64* %tmp48
    %tmp59 = load { i8*, i64 }, { i8*, i64 }* %tmp32
    %tmp60 = load { i8*, i64 }, { i8*, i64 }* %tmp32
    %tmp61 = extractvalue { i8*, i64 } %tmp60, 0
    %tmp62 = getelementptr inbounds i8, i8* %tmp61, i64 %tmp58
    %tmp63 = load i8, i8* %tmp62
    store i8 %tmp63, i8* %tmp57
    %tmp64 = load i64, i64* %tmp48
    %tmp65 = add i64 %tmp64, 1
    store i64 %tmp65, i64* %tmp48
    br label %while_cond.0
while_end.2:
    %tmp66 = load i64, i64* %tmp41
    %tmp67 = getelementptr inbounds %class.main.String, %class.main.String* %tmp35, i32 0, i32 0
    %tmp68 = load %class.main.String, %class.main.String* %tmp35
    %tmp69 = getelementptr inbounds %class.main.String, %class.main.String* %tmp35, i32 0, i32 0
    %tmp70 = load i8*, i8** %tmp69
    %tmp71 = getelementptr inbounds i8, i8* %tmp70, i64 %tmp66
    store i8 0, i8* %tmp71
    %tmp72 = load %class.main.String, %class.main.String* %tmp35
    ret %class.main.String %tmp72
}

define %class.main.String @main.String.clone(%class.main.String* %self) {
entry:
    %tmp0 = load %class.main.String, %class.main.String* %self
    ret %class.main.String %tmp0
}

define i32 @main() {
entry:
    %tmp73 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i64 0, i64 0
    %tmp74 = insertvalue { i8*, i64 } undef, i8* %tmp73, 0
    %tmp75 = insertvalue { i8*, i64 } %tmp74, i64 5, 1
    %tmp76 = call %class.main.String @main.String.from({ i8*, i64 } %tmp75)
    %tmp77 = alloca %class.main.String
    store %class.main.String %tmp76, %class.main.String* %tmp77
    %tmp78 = call i64 @main.String.length(%class.main.String* %tmp77)
    %tmp79 = add i64 %tmp78, 2
    %tmp80 = trunc i64 %tmp79 to i32
    call void @main.String.destroy(%class.main.String* %tmp77)
    ret i32 %tmp80
}


@.str.0 = private unnamed_addr constant [6 x i8] c"hello\00"
