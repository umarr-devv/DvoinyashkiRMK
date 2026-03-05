import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transfer.g.dart';

@JsonSerializable()
class TransferScheme extends Equatable {
  const TransferScheme({
    required this.refKey,
    required this.number,
    required this.date,
    required this.posted,
    required this.authorKey,
    required this.userKey,
    required this.recipientStructureUnitKey,
    required this.reserveStructureUnitKey,
    required this.transferDate,
    required this.documentSum,
  });
  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Number')
  final String number;

  @JsonKey(name: 'Date')
  final DateTime date;

  @JsonKey(name: 'Posted')
  final bool posted;

  @JsonKey(name: 'Автор_Key')
  final String authorKey;

  @JsonKey(name: 'Ответственный_Key')
  final String userKey;


  @JsonKey(name: 'СтруктурнаяЕдиница_Key')
  final String reserveStructureUnitKey;

  @JsonKey(name: 'СтруктурнаяЕдиницаПолучатель_Key')
  final String recipientStructureUnitKey;

  @JsonKey(name: 'ДатаПриемки')
  final DateTime transferDate;

  @JsonKey(name: 'СуммаДокумента')
  final double documentSum;

  factory TransferScheme.fromJson(Map<String, dynamic> json) =>
      _$TransferSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$TransferSchemeToJson(this);

  @override
  List<Object?> get props => [refKey];
}

@JsonSerializable()
class TransferItemScheme {
  TransferItemScheme({
    required this.refKey,
    required this.nomenclatureKey,
    required this.characteristicKey,
    required this.quantity,
    required this.price,
    required this.totalSum,
  });

  @JsonKey(name: 'Ref_Key')
  final String? refKey;

  @JsonKey(name: 'Номенклатура_Key')
  final String nomenclatureKey;

  @JsonKey(name: 'Характеристика_Key')
  final String characteristicKey;

  @JsonKey(name: 'Количество')
  final double quantity;

  @JsonKey(name: 'Цена')
  final double price;

  @JsonKey(name: 'Сумма')
  final double totalSum;

  factory TransferItemScheme.fromJson(Map<String, dynamic> json) =>
      _$TransferItemSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$TransferItemSchemeToJson(this);
}

@JsonSerializable()
class DetailTransferScheme extends TransferScheme {
  const DetailTransferScheme({
    required super.refKey,
    required super.number,
    required super.date,
    required super.posted,
    required super.authorKey,
    required super.userKey,
    required super.recipientStructureUnitKey,
    required super.reserveStructureUnitKey,
    required super.transferDate,
    required super.documentSum,
    required this.items,
  });

  @JsonKey(name: 'Запасы')
  final List<TransferItemScheme> items;

  factory DetailTransferScheme.fromJson(Map<String, dynamic> json) =>
      _$DetailTransferSchemeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DetailTransferSchemeToJson(this);

  @override
  List<Object?> get props => [refKey];
}

@JsonSerializable()
class TransferListScheme {
  const TransferListScheme({required this.value});

  @JsonKey(name: 'value')
  final List<TransferScheme> value;

  factory TransferListScheme.fromJson(Map<String, dynamic> json) =>
      _$TransferListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$TransferListSchemeToJson(this);
}
