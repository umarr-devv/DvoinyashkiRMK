import 'package:json_annotation/json_annotation.dart';

part 'update_work_shift.g.dart';

@JsonSerializable(includeIfNull: false)
class UpdateWorkShiftScheme {
  UpdateWorkShiftScheme({
    this.authorKey,
    this.userKey,
    this.subdivisionKey,
    this.storeKey,
    this.status,
    this.workShiftEnd,
    this.articleKey = '436b4222-3377-11ed-91a8-a068f8f3337c',
    this.operationKey = '43f6fc4d-4a0d-11ed-a839-18d6c704b66b',
  });

  @JsonKey(name: 'Автор_Key')
  final String? authorKey;

  @JsonKey(name: 'Ответственный_Key')
  final String? userKey;

  @JsonKey(name: 'Подразделение_Key')
  final String? subdivisionKey;

  @JsonKey(name: 'Статья_Key')
  final String? articleKey;

  @JsonKey(name: 'СтруктурнаяЕдиница_Key')
  final String? storeKey;

  @JsonKey(name: 'ХозяйственнаяОперация_Key')
  final String? operationKey;

  @JsonKey(name: 'СтатусКассовойСмены')
  final String? status;

  @JsonKey(name: 'ОкончаниеКассовойСмены')
  final DateTime? workShiftEnd;

  factory UpdateWorkShiftScheme.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkShiftSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateWorkShiftSchemeToJson(this);
}
