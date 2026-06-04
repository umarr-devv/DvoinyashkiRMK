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
      sessionWithdraws:
          (json['sessionWithdraws'] as List<dynamic>?)
              ?.map((e) => WithdrawScheme.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      cash: json['cash'] == null
          ? null
          : CashScheme.fromJson(json['cash'] as Map<String, dynamic>),
      pageNum: (json['pageNum'] as num?)?.toInt() ?? 0,
      accepting:
          (json['accepting'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          const {},
    );

Map<String, dynamic> _$WithdrawsStateToJson(WithdrawsState instance) =>
    <String, dynamic>{
      'withdraws': instance.withdraws,
      'sessionWithdraws': instance.sessionWithdraws,
      'cash': instance.cash,
      'accepting': instance.accepting,
      'pageNum': instance.pageNum,
    };
