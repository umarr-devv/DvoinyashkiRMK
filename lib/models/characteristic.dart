import 'package:json_annotation/json_annotation.dart';

part 'characteristic.g.dart';

@JsonSerializable()
class CharacteristicScheme {
  CharacteristicScheme({
    required this.refKey,
    required this.description,
    required this.printName,
  });

  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Description')
  final String description;

  @JsonKey(name: 'НаименованиеДляПечати')
  final String printName;

  factory CharacteristicScheme.fromJson(Map<String, dynamic> json) =>
      _$CharacteristicSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CharacteristicSchemeToJson(this);
}

@JsonSerializable()
class CharacteristicListScheme {
  CharacteristicListScheme({required this.characteristics});

  @JsonKey(name: 'value')
  final List<CharacteristicScheme> characteristics;

  factory CharacteristicListScheme.fromJson(Map<String, dynamic> json) =>
      _$CharacteristicListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CharacteristicListSchemeToJson(this);
}
