import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_return.g.dart';

@JsonSerializable()
class CheckReturnScheme extends Equatable {
  const CheckReturnScheme({
    required this.refKey,
    required this.number,
    required this.date,
    required this.cashRegisterKey,
    required this.structureUnitKey,
    required this.userKey,
    required this.cashRegisterSessionKey,
    required this.documentSum,
  });
  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Number')
  final String number;

  @JsonKey(name: 'Date')
  final DateTime date;

  @JsonKey(name: 'КассаККМ_Key')
  final String cashRegisterKey;

  @JsonKey(name: 'СтруктурнаяЕдиница_Key')
  final String structureUnitKey;

  @JsonKey(name: 'Ответственный_Key')
  final String userKey;

  @JsonKey(name: 'КассоваяСмена_Key')
  final String cashRegisterSessionKey;

  @JsonKey(name: 'СуммаДокумента')
  final double documentSum;

  factory CheckReturnScheme.fromJson(Map<String, dynamic> json) =>
      _$CheckReturnSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CheckReturnSchemeToJson(this);

  @override
  List<Object?> get props => [refKey];
}
