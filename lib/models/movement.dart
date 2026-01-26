import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movement.g.dart';

@JsonSerializable()
class MovementScheme extends Equatable {
  const MovementScheme({
    required this.refKey,
    required this.number,
    required this.date,
    required this.posted,
    required this.authorKey,
    required this.userKey,
    required this.statusKey,
    required this.recipientStructureUnitKey,
    required this.movementDate,
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

  @JsonKey(name: 'СостояниеЗаказа_Key')
  final String statusKey;

  @JsonKey(name: 'СтруктурнаяЕдиницаПолучатель_Key')
  final String recipientStructureUnitKey;

  @JsonKey(name: 'ДатаПеремещения')
  final DateTime movementDate;

  @JsonKey(name: 'СуммаДокумента')
  final double documentSum;

  factory MovementScheme.fromJson(Map<String, dynamic> json) =>
      _$MovementSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$MovementSchemeToJson(this);

  @override
  List<Object?> get props => [refKey];
}

@JsonSerializable()
class MovementItemScheme {
  MovementItemScheme({
    required this.refKey,
    required this.nomenclatureKey,
    required this.characteristicKey,
    required this.quantity,
    required this.price,
    required this.totalSum,
  });

  @JsonKey(name: 'Ref_Key')
  final String refKey;

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

  factory MovementItemScheme.fromJson(Map<String, dynamic> json) =>
      _$MovementItemSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$MovementItemSchemeToJson(this);
}

@JsonSerializable()
class DetailMovementScheme extends MovementScheme {
  const DetailMovementScheme({
    required super.refKey,
    required super.number,
    required super.date,
    required super.posted,
    required super.authorKey,
    required super.userKey,
    required super.statusKey,
    required super.recipientStructureUnitKey,
    required super.movementDate,
    required super.documentSum,
    required this.items,
  });

  @JsonKey(name: 'Запасы')
  final List<MovementItemScheme> items;

  factory DetailMovementScheme.fromJson(Map<String, dynamic> json) =>
      _$DetailMovementSchemeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DetailMovementSchemeToJson(this);

  @override
  List<Object?> get props => [refKey];
}

@JsonSerializable()
class MovementListScheme {
  const MovementListScheme({required this.movements});

  @JsonKey(name: 'value')
  final List<MovementScheme> movements;

  factory MovementListScheme.fromJson(Map<String, dynamic> json) =>
      _$MovementListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$MovementListSchemeToJson(this);
}

@JsonSerializable()
class MovementStatusScheme extends Equatable {
  const MovementStatusScheme({required this.refKey, required this.description});

  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Description')
  final String description;

  factory MovementStatusScheme.fromJson(Map<String, dynamic> json) =>
      _$MovementStatusSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$MovementStatusSchemeToJson(this);

  @override
  List<Object?> get props => [refKey];
}
