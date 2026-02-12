import 'package:json_annotation/json_annotation.dart';

part 'uds_transaction.g.dart';

@JsonSerializable()
class UDSTransactionScheme {
  UDSTransactionScheme({
    required this.code,
    required this.cashier,
    required this.receipt,
  });
  final String code;
  final UDSTransactionCashierScheme cashier;
  final UDSTransactionReceiptScheme receipt;

  factory UDSTransactionScheme.fromJson(Map<String, dynamic> json) =>
      _$UDSTransactionSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$UDSTransactionSchemeToJson(this);
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
  final double total;
  @JsonKey(name: 'cash')
  final double cash;
  @JsonKey(name: 'points')
  final double points;

  factory UDSTransactionReceiptScheme.fromJson(Map<String, dynamic> json) =>
      _$UDSTransactionReceiptSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$UDSTransactionReceiptSchemeToJson(this);
}
