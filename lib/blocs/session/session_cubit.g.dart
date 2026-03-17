// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionState _$SessionStateFromJson(Map<String, dynamic> json) => SessionState(
  currentWorkShift: json['currentWorkShift'] == null
      ? null
      : WorkShiftScheme.fromJson(
          json['currentWorkShift'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$SessionStateToJson(SessionState instance) =>
    <String, dynamic>{'currentWorkShift': instance.currentWorkShift};
