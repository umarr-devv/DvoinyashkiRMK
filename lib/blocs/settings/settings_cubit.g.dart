// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) =>
    SettingsState(
      isDarkTheme: json['is_dark_theme'] as bool? ?? false,
      scale: (json['scale'] as num?)?.toDouble() ?? 1,
      cashRegister: json['cash_register'] == null
          ? null
          : CashRegisterScheme.fromJson(
              json['cash_register'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$SettingsStateToJson(SettingsState instance) =>
    <String, dynamic>{
      'is_dark_theme': instance.isDarkTheme,
      'scale': instance.scale,
      'cash_register': instance.cashRegister,
    };
