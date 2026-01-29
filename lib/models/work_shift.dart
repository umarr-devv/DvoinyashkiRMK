import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_shift.g.dart';

@JsonSerializable()
class WorkShiftScheme extends Equatable {
  const WorkShiftScheme({
    required this.refKey,
    required this.number,
    required this.date,
    required this.posted,
    required this.userKey,
    required this.authorKey,
    required this.cashRegisterKey,
    required this.cashRegisterShiftKey,
    required this.commentary,
    required this.workShiftStart,
    required this.workShiftEnd,
    required this.status,
    required this.articleKey,
    required this.structureUnitKey,
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

  @JsonKey(name: 'Ответственный_Key')
  final String userKey;

  @JsonKey(name: 'Автор_Key')
  final String authorKey;

  @JsonKey(name: 'КассаККМ_Key')
  final String cashRegisterKey;

  @JsonKey(name: 'КассоваяСмена_Key')
  final String cashRegisterShiftKey;

  @JsonKey(name: 'Комментарий')
  final String commentary;

  @JsonKey(name: 'НачалоКассовойСмены')
  final DateTime workShiftStart;

  @JsonKey(name: 'ОкончаниеКассовойСмены')
  final DateTime? workShiftEnd;

  @JsonKey(name: 'СтатусКассовойСмены')
  final String status;

  @JsonKey(name: 'Статья_Key')
  final String articleKey;

  @JsonKey(name: 'СтруктурнаяЕдиница_Key')
  final String structureUnitKey;

  @JsonKey(name: 'СуммаДокумента')
  final double documentSum;

  static String get openStatus => 'Открыта';

  static String get closeStatus => 'Закрыто';

  factory WorkShiftScheme.fromJson(Map<String, dynamic> json) =>
      _$WorkShiftSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$WorkShiftSchemeToJson(this);

  @override
  List<Object?> get props => [refKey];
}

@JsonSerializable()
class WorkShiftListScheme {
  WorkShiftListScheme({required this.workShifts});

  @JsonKey(name: 'value')
  final List<WorkShiftScheme> workShifts;

  factory WorkShiftListScheme.fromJson(Map<String, dynamic> json) =>
      _$WorkShiftListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$WorkShiftListSchemeToJson(this);
}
