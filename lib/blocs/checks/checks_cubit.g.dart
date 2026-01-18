// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checks_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChecksState _$ChecksStateFromJson(Map<String, dynamic> json) => ChecksState(
  checks:
      (json['checks'] as List<dynamic>?)
          ?.map((e) => CheckScheme.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  pageNum: (json['page_num'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ChecksStateToJson(ChecksState instance) =>
    <String, dynamic>{'checks': instance.checks, 'page_num': instance.pageNum};
