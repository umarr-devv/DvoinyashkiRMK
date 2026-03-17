// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_checks_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfflineChecksState _$OfflineChecksStateFromJson(Map<String, dynamic> json) =>
    OfflineChecksState(
      checks:
          (json['checks'] as List<dynamic>?)
              ?.map(
                (e) => CreateCheckScheme.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$OfflineChecksStateToJson(OfflineChecksState instance) =>
    <String, dynamic>{'checks': instance.checks};
