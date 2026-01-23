// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_shifts_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkShiftsState _$WorkShiftsStateFromJson(Map<String, dynamic> json) =>
    WorkShiftsState(
      workShifts:
          (json['work_shifts'] as List<dynamic>?)
              ?.map((e) => WorkShiftScheme.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      pageNum: (json['page_num'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$WorkShiftsStateToJson(WorkShiftsState instance) =>
    <String, dynamic>{
      'work_shifts': instance.workShifts,
      'page_num': instance.pageNum,
    };
