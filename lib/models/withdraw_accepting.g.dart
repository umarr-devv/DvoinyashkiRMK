// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_accepting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawAcceptScheme _$WithdrawAcceptSchemeFromJson(
  Map<String, dynamic> json,
) => WithdrawAcceptScheme(
  refKey: json['Ref_Key'] as String,
  posted: json['Posted'] as bool?,
  withdrawKey: json['ДокументОснование'] as String?,
);

Map<String, dynamic> _$WithdrawAcceptSchemeToJson(
  WithdrawAcceptScheme instance,
) => <String, dynamic>{
  'Ref_Key': instance.refKey,
  'Posted': instance.posted,
  'ДокументОснование': instance.withdrawKey,
};

WithdrawAcceptListScheme _$WithdrawAcceptListSchemeFromJson(
  Map<String, dynamic> json,
) => WithdrawAcceptListScheme(
  value: (json['value'] as List<dynamic>)
      .map((e) => WithdrawAcceptScheme.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WithdrawAcceptListSchemeToJson(
  WithdrawAcceptListScheme instance,
) => <String, dynamic>{'value': instance.value};
