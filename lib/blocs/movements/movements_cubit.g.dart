// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movements_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovementsState _$MovementsStateFromJson(Map<String, dynamic> json) =>
    MovementsState(
      movements:
          (json['movements'] as List<dynamic>?)
              ?.map((e) => MovementScheme.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      statuses:
          (json['statuses'] as List<dynamic>?)
              ?.map(
                (e) => MovementStatusScheme.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      pageNum: (json['page_num'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MovementsStateToJson(MovementsState instance) =>
    <String, dynamic>{
      'movements': instance.movements,
      'statuses': instance.statuses,
      'page_num': instance.pageNum,
    };
