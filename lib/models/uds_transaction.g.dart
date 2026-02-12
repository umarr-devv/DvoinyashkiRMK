// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uds_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UDSTransactionScheme _$UDSTransactionSchemeFromJson(
  Map<String, dynamic> json,
) => UDSTransactionScheme(
  participant: UDSTransactionParticipantScheme.fromJson(
    json['participant'] as Map<String, dynamic>,
  ),
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
  'participant': instance.participant,
  'cashier': instance.cashier,
  'receipt': instance.receipt,
};

UDSTransactionParticipantScheme _$UDSTransactionParticipantSchemeFromJson(
  Map<String, dynamic> json,
) => UDSTransactionParticipantScheme(uid: json['uid'] as String);

Map<String, dynamic> _$UDSTransactionParticipantSchemeToJson(
  UDSTransactionParticipantScheme instance,
) => <String, dynamic>{'uid': instance.uid};

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
  total: json['total'] as String,
  cash: json['cash'] as String,
  points: json['points'] as String,
);

Map<String, dynamic> _$UDSTransactionReceiptSchemeToJson(
  UDSTransactionReceiptScheme instance,
) => <String, dynamic>{
  'total': instance.total,
  'cash': instance.cash,
  'points': instance.points,
};
