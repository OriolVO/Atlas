; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

%struct.main.Node = type { %struct.main.Node* }


define i32 @"main"() {
entry:
    %tmp0 = alloca %struct.main.Node
    store %struct.main.Node zeroinitializer, %struct.main.Node* %tmp0
    %tmp1 = getelementptr inbounds %struct.main.Node, %struct.main.Node* %tmp0, i32 0, i32 0
    %tmp2 = load %struct.main.Node, %struct.main.Node* %tmp0
    %tmp3 = getelementptr inbounds %struct.main.Node, %struct.main.Node* %tmp0, i32 0, i32 0
    %tmp4 = load %struct.main.Node*, %struct.main.Node** %tmp3
    %tmp5 = load %struct.main.Node, %struct.main.Node* %tmp0
    %tmp6 = getelementptr inbounds %struct.main.Node, %struct.main.Node* %tmp0, i32 0, i32 0
    %tmp7 = load %struct.main.Node*, %struct.main.Node** %tmp6
    %tmp8 = icmp ne %struct.main.Node* %tmp7, null
    br i1 %tmp8, label %if_then.0, label %if_else.1
if_then.0:
    %tmp9 = trunc i64 1 to i32
    ret i32 %tmp9
if_else.1:
    br label %if_end.2
if_end.2:
    %tmp10 = trunc i64 0 to i32
    ret i32 %tmp10
}

