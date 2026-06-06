; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.main.Node = type { i64 }


define i32 @main() {
entry:
    %tmp0 = alloca i64
    store i64 10, i64* %tmp0
    %tmp1 = alloca i64*
    store i64* %tmp0, i64** %tmp1
    %tmp2 = load i64*, i64** %tmp1
    store i64 42, i64* %tmp2
    %tmp3 = insertvalue %struct.main.Node undef, i64 100, 0
    %tmp4 = alloca %struct.main.Node
    store %struct.main.Node %tmp3, %struct.main.Node* %tmp4
    %tmp5 = alloca %struct.main.Node*
    store %struct.main.Node* %tmp4, %struct.main.Node** %tmp5
    %tmp6 = load %struct.main.Node*, %struct.main.Node** %tmp5
    %tmp7 = getelementptr inbounds %struct.main.Node, %struct.main.Node* %tmp6, i32 0, i32 0
    %tmp8 = load i64, i64* %tmp0
    store i64 %tmp8, i64* %tmp7
    %tmp9 = getelementptr inbounds %struct.main.Node, %struct.main.Node* %tmp4, i32 0, i32 0
    %tmp10 = load i64, i64* %tmp9
    %tmp11 = trunc i64 %tmp10 to i32
    ret i32 %tmp11
}

