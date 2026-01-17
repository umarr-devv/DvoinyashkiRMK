// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_registers_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashRegistersState _$CashRegistersStateFromJson(Map<String, dynamic> json) =>
    CashRegistersState(
      cashRegisters:
          (json['cash_registers'] as List<dynamic>?)
              ?.map(
                (e) => CashRegisterScheme.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      update: json['update'] == null
          ? null
          : DateTime.parse(json['update'] as String),
    );

Map<String, dynamic> _$CashRegistersStateToJson(CashRegistersState instance) =>
    <String, dynamic>{
      'cash_registers': instance.cashRegisters,
      'update': instance.update?.toIso8601String(),
    };
