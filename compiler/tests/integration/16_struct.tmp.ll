; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.main.Point = type { i64, i64 }
%struct.main.Rect = type { %struct.main.Point, %struct.main.Point }


define i32 @main() {
entry:
    %tmp0 = insertvalue %struct.main.Point undef, i64 10, 0
    %tmp1 = insertvalue %struct.main.Point %tmp0, i64 20, 1
    %tmp2 = alloca %struct.main.Point
    store %struct.main.Point %tmp1, %struct.main.Point* %tmp2
    %tmp3 = insertvalue %struct.main.Point undef, i64 30, 0
    %tmp4 = insertvalue %struct.main.Point %tmp3, i64 40, 1
    %tmp5 = alloca %struct.main.Point
    store %struct.main.Point %tmp4, %struct.main.Point* %tmp5
    %tmp6 = load %struct.main.Point, %struct.main.Point* %tmp2
    %tmp7 = insertvalue %struct.main.Rect undef, %struct.main.Point %tmp6, 0
    %tmp8 = load %struct.main.Point, %struct.main.Point* %tmp5
    %tmp9 = insertvalue %struct.main.Rect %tmp7, %struct.main.Point %tmp8, 1
    %tmp10 = alloca %struct.main.Rect
    store %struct.main.Rect %tmp9, %struct.main.Rect* %tmp10
    %tmp11 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 1
    %tmp12 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp11, i32 0, i32 1
    store i64 40, i64* %tmp12
    %tmp13 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp14 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp13, i32 0, i32 0
    %tmp15 = load i64, i64* %tmp14
    %tmp16 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp17 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp16, i32 0, i32 1
    %tmp18 = load i64, i64* %tmp17
    %tmp19 = add i64 %tmp15, %tmp18
    %tmp20 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 1
    %tmp21 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp20, i32 0, i32 0
    %tmp22 = load i64, i64* %tmp21
    %tmp23 = add i64 %tmp19, %tmp22
    %tmp24 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 1
    %tmp25 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp24, i32 0, i32 1
    %tmp26 = load i64, i64* %tmp25
    %tmp27 = add i64 %tmp23, %tmp26
    %tmp28 = trunc i64 %tmp27 to i32
    ret i32 %tmp28
}

