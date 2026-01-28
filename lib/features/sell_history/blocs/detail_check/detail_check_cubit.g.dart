// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_check_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailCheckState _$DetailCheckStateFromJson(Map<String, dynamic> json) =>
    DetailCheckState(
      refKey: json['refKey'] as String,
      check: json['check'] == null
          ? null
          : DetailCheckScheme.fromJson(json['check'] as Map<String, dynamic>),
      update: json['update'] == null
          ? null
          : DateTime.parse(json['update'] as String),
    );

Map<String, dynamic> _$DetailCheckStateToJson(DetailCheckState instance) =>
    <String, dynamic>{
      'refKey': instance.refKey,
      'check': instance.check,
      'update': instance.update?.toIso8601String(),
    };
