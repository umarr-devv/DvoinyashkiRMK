// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_check_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTypeData _$PaymentTypeDataFromJson(Map<String, dynamic> json) =>
    PaymentTypeData(
      label: json['label'] as String,
      isCash: json['isCash'] as bool,
      isDebt: json['isDebt'] as bool? ?? false,
    );

Map<String, dynamic> _$PaymentTypeDataToJson(PaymentTypeData instance) =>
    <String, dynamic>{
      'label': instance.label,
      'isCash': instance.isCash,
      'isDebt': instance.isDebt,
    };

CreateCheckState _$CreateCheckStateFromJson(Map<String, dynamic> json) =>
    CreateCheckState(
      paymentType: PaymentTypeData.fromJson(
        json['paymentType'] as Map<String, dynamic>,
      ),
      totalSum: (json['totalSum'] as num?)?.toDouble() ?? 0,
      udsPoints: (json['udsPoints'] as num?)?.toDouble() ?? 0,
      customerPay: (json['customerPay'] as num?)?.toDouble() ?? 0,
      debtUser: json['debtUser'] == null
          ? null
          : UserScheme.fromJson(json['debtUser'] as Map<String, dynamic>),
      check: json['check'] == null
          ? null
          : DetailCheckScheme.fromJson(json['check'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateCheckStateToJson(CreateCheckState instance) =>
    <String, dynamic>{
      'paymentType': instance.paymentType,
      'totalSum': instance.totalSum,
      'customerPay': instance.customerPay,
      'udsPoints': instance.udsPoints,
      'debtUser': instance.debtUser,
      'check': instance.check,
    };
