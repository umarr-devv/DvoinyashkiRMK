// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uds_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UDSTransactionScheme _$UDSTransactionSchemeFromJson(
  Map<String, dynamic> json,
) => UDSTransactionScheme(
  code: json['code'] as String,
  cashier: UDSTransactionCashierScheme.fromJson(
    json['cashier'] as Map<String, dynamic>,
  ),
  receipt: UDSTransactionReceiptScheme.fromJson(
    json['receipt'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$UDSTransactionSchemeToJson(
  UDSTransactionScheme instance,
) => <String, dynamic>{
  'code': instance.code,
  'cashier': instance.cashier,
  'receipt': instance.receipt,
};

UDSTransactionCashierScheme _$UDSTransactionCashierSchemeFromJson(
  Map<String, dynamic> json,
) => UDSTransactionCashierScheme(
  externalId: json['externalId'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$UDSTransactionCashierSchemeToJson(
  UDSTransactionCashierScheme instance,
) => <String, dynamic>{
  'externalId': instance.externalId,
  'name': instance.name,
};

UDSTransactionReceiptScheme _$UDSTransactionReceiptSchemeFromJson(
  Map<String, dynamic> json,
) => UDSTransactionReceiptScheme(
  total: (json['total'] as num).toDouble(),
  cash: (json['cash'] as num).toDouble(),
  points: (json['points'] as num).toDouble(),
);

Map<String, dynamic> _$UDSTransactionReceiptSchemeToJson(
  UDSTransactionReceiptScheme instance,
) => <String, dynamic>{
  'total': instance.total,
  'cash': instance.cash,
  'points': instance.points,
};
