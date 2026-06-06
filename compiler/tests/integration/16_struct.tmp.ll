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
    %tmp13 = load %struct.main.Rect, %struct.main.Rect* %tmp10
    %tmp14 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp15 = load %struct.main.Point, %struct.main.Point* %tmp14
    %tmp16 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp17 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp16, i32 0, i32 0
    %tmp18 = load i64, i64* %tmp17
    %tmp19 = load %struct.main.Rect, %struct.main.Rect* %tmp10
    %tmp20 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp21 = load %struct.main.Point, %struct.main.Point* %tmp20
    %tmp22 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp23 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp22, i32 0, i32 1
    %tmp24 = load i64, i64* %tmp23
    %tmp25 = add i64 %tmp18, %tmp24
    %tmp26 = load %struct.main.Rect, %struct.main.Rect* %tmp10
    %tmp27 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 1
    %tmp28 = load %struct.main.Point, %struct.main.Point* %tmp27
    %tmp29 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 1
    %tmp30 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp29, i32 0, i32 0
    %tmp31 = load i64, i64* %tmp30
    %tmp32 = add i64 %tmp25, %tmp31
    %tmp33 = load %struct.main.Rect, %struct.main.Rect* %tmp10
    %tmp34 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 1
    %tmp35 = load %struct.main.Point, %struct.main.Point* %tmp34
    %tmp36 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 1
    %tmp37 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp36, i32 0, i32 1
    %tmp38 = load i64, i64* %tmp37
    %tmp39 = add i64 %tmp32, %tmp38
    %tmp40 = trunc i64 %tmp39 to i32
    ret i32 %tmp40
}

