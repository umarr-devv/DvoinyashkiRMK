// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraws_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawsState _$WithdrawsStateFromJson(Map<String, dynamic> json) =>
    WithdrawsState(
      withdraws:
          (json['withdraws'] as List<dynamic>?)
              ?.map((e) => WithdrawScheme.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      pageNum: (json['pageNum'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$WithdrawsStateToJson(WithdrawsState instance) =>
    <String, dynamic>{
      'withdraws': instance.withdraws,
      'pageNum': instance.pageNum,
    };
