import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'price_type.g.dart';

@JsonSerializable()
class PriceTypeScheme extends Equatable {
  const PriceTypeScheme({required this.refKey, required this.description});

  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Description')
  final String description;

  factory PriceTypeScheme.fromJson(Map<String, dynamic> json) =>
      _$PriceTypeSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$PriceTypeSchemeToJson(this);

  @override
  List<Object?> get props => [refKey];
}

@JsonSerializable()
class PriceTypeListScheme {
  PriceTypeListScheme({required this.value});

  @JsonKey(name: 'value')
  final List<PriceTypeScheme> value;

  factory PriceTypeListScheme.fromJson(Map<String, dynamic> json) =>
      _$PriceTypeListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$PriceTypeListSchemeToJson(this);
}
