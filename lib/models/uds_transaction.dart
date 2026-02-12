import 'package:json_annotation/json_annotation.dart';

part 'uds_transaction.g.dart';

@JsonSerializable()
class UDSTransactionScheme {
  UDSTransactionScheme({
    required this.participant,
    required this.cashier,
    required this.receipt,
  });
  final UDSTransactionParticipantScheme participant;
  final UDSTransactionCashierScheme cashier;
  final UDSTransactionReceiptScheme receipt;

  factory UDSTransactionScheme.fromJson(Map<String, dynamic> json) =>
      _$UDSTransactionSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$UDSTransactionSchemeToJson(this);
}

@JsonSerializable()
class UDSTransactionParticipantScheme {
  UDSTransactionParticipantScheme({required this.uid});

  @JsonKey(name: 'uid')
  final String uid;

  factory UDSTransactionParticipantScheme.fromJson(Map<String, dynamic> json) =>
      _$UDSTransactionParticipantSchemeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UDSTransactionParticipantSchemeToJson(this);
}

@JsonSerializable()
class UDSTransactionCashierScheme {
  UDSTransactionCashierScheme({required this.externalId, required this.name});

  @JsonKey(name: 'externalId')
  final String externalId;
  @JsonKey(name: 'name')
  final String name;

  factory UDSTransactionCashierScheme.fromJson(Map<String, dynamic> json) =>
      _$UDSTransactionCashierSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$UDSTransactionCashierSchemeToJson(this);
}

@JsonSerializable()
class UDSTransactionReceiptScheme {
  UDSTransactionReceiptScheme({
    required this.total,
    required this.cash,
    required this.points,
  });

  @JsonKey(name: 'total')
  final String total;
  @JsonKey(name: 'cash')
  final String cash;
  @JsonKey(name: 'points')
  final String points;

  factory UDSTransactionReceiptScheme.fromJson(Map<String, dynamic> json) =>
      _$UDSTransactionReceiptSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$UDSTransactionReceiptSchemeToJson(this);
}
