; Atlas compiler v0.1.0 — native backend slice
source_filename = "input.atl"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @"snprintf"(i8*, i64, i8*, ...)

%struct.main.Point = type { i64, i64 }
%struct.main.Rect = type { %struct.main.Point, %struct.main.Point }


define i32 @"main"() {
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
    %tmp15 = load %struct.main.Rect, %struct.main.Rect* %tmp10
    %tmp16 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp17 = load %struct.main.Point, %struct.main.Point* %tmp16
    %tmp18 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp19 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp18, i32 0, i32 0
    %tmp20 = load i64, i64* %tmp19
    %tmp21 = load %struct.main.Rect, %struct.main.Rect* %tmp10
    %tmp22 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp23 = load %struct.main.Point, %struct.main.Point* %tmp22
    %tmp24 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp25 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp24, i32 0, i32 0
    %tmp26 = load i64, i64* %tmp25
    %tmp27 = load %struct.main.Rect, %struct.main.Rect* %tmp10
    %tmp28 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp29 = load %struct.main.Point, %struct.main.Point* %tmp28
    %tmp30 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp31 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp30, i32 0, i32 1
    %tmp32 = load i64, i64* %tmp31
    %tmp33 = add i64 %tmp26, %tmp32
    %tmp34 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp35 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp34, i32 0, i32 0
    %tmp36 = load %struct.main.Rect, %struct.main.Rect* %tmp10
    %tmp37 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp38 = load %struct.main.Point, %struct.main.Point* %tmp37
    %tmp39 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp40 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp39, i32 0, i32 0
    %tmp41 = load i64, i64* %tmp40
    %tmp42 = load %struct.main.Rect, %struct.main.Rect* %tmp10
    %tmp43 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp44 = load %struct.main.Point, %struct.main.Point* %tmp43
    %tmp45 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp46 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp45, i32 0, i32 0
    %tmp47 = load i64, i64* %tmp46
    %tmp48 = load %struct.main.Rect, %struct.main.Rect* %tmp10
    %tmp49 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp50 = load %struct.main.Point, %struct.main.Point* %tmp49
    %tmp51 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp52 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp51, i32 0, i32 1
    %tmp53 = load i64, i64* %tmp52
    %tmp54 = add i64 %tmp47, %tmp53
    %tmp55 = load %struct.main.Rect, %struct.main.Rect* %tmp10
    %tmp56 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 1
    %tmp57 = load %struct.main.Point, %struct.main.Point* %tmp56
    %tmp58 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 1
    %tmp59 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp58, i32 0, i32 0
    %tmp60 = load i64, i64* %tmp59
    %tmp61 = add i64 %tmp54, %tmp60
    %tmp62 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp63 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp62, i32 0, i32 0
    %tmp64 = load %struct.main.Rect, %struct.main.Rect* %tmp10
    %tmp65 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp66 = load %struct.main.Point, %struct.main.Point* %tmp65
    %tmp67 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp68 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp67, i32 0, i32 0
    %tmp69 = load i64, i64* %tmp68
    %tmp70 = load %struct.main.Rect, %struct.main.Rect* %tmp10
    %tmp71 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp72 = load %struct.main.Point, %struct.main.Point* %tmp71
    %tmp73 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp74 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp73, i32 0, i32 0
    %tmp75 = load i64, i64* %tmp74
    %tmp76 = load %struct.main.Rect, %struct.main.Rect* %tmp10
    %tmp77 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp78 = load %struct.main.Point, %struct.main.Point* %tmp77
    %tmp79 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp80 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp79, i32 0, i32 1
    %tmp81 = load i64, i64* %tmp80
    %tmp82 = add i64 %tmp75, %tmp81
    %tmp83 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp84 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp83, i32 0, i32 0
    %tmp85 = load %struct.main.Rect, %struct.main.Rect* %tmp10
    %tmp86 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp87 = load %struct.main.Point, %struct.main.Point* %tmp86
    %tmp88 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp89 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp88, i32 0, i32 0
    %tmp90 = load i64, i64* %tmp89
    %tmp91 = load %struct.main.Rect, %struct.main.Rect* %tmp10
    %tmp92 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp93 = load %struct.main.Point, %struct.main.Point* %tmp92
    %tmp94 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp95 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp94, i32 0, i32 0
    %tmp96 = load i64, i64* %tmp95
    %tmp97 = load %struct.main.Rect, %struct.main.Rect* %tmp10
    %tmp98 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp99 = load %struct.main.Point, %struct.main.Point* %tmp98
    %tmp100 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 0
    %tmp101 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp100, i32 0, i32 1
    %tmp102 = load i64, i64* %tmp101
    %tmp103 = add i64 %tmp96, %tmp102
    %tmp104 = load %struct.main.Rect, %struct.main.Rect* %tmp10
    %tmp105 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 1
    %tmp106 = load %struct.main.Point, %struct.main.Point* %tmp105
    %tmp107 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 1
    %tmp108 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp107, i32 0, i32 0
    %tmp109 = load i64, i64* %tmp108
    %tmp110 = add i64 %tmp103, %tmp109
    %tmp111 = load %struct.main.Rect, %struct.main.Rect* %tmp10
    %tmp112 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 1
    %tmp113 = load %struct.main.Point, %struct.main.Point* %tmp112
    %tmp114 = getelementptr inbounds %struct.main.Rect, %struct.main.Rect* %tmp10, i32 0, i32 1
    %tmp115 = getelementptr inbounds %struct.main.Point, %struct.main.Point* %tmp114, i32 0, i32 1
    %tmp116 = load i64, i64* %tmp115
    %tmp117 = add i64 %tmp110, %tmp116
    %tmp118 = trunc i64 %tmp117 to i32
    ret i32 %tmp118
}

