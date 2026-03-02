import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class GroupScheme extends Equatable {
  const GroupScheme({
    required this.refKey,
    required this.name,
    required this.groupKey,
  });

  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Description')
  final String name;

  @JsonKey(name: 'Parent_Key')
  final String? groupKey;

  factory GroupScheme.fromJson(Map<String, dynamic> json) =>
      _$GroupSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$GroupSchemeToJson(this);

  @override
  List<Object?> get props => [refKey];
}

@JsonSerializable()
class GroupListScheme {
  GroupListScheme({required this.value});

  @JsonKey(name: 'value')
  final List<GroupScheme> value;

  factory GroupListScheme.fromJson(Map<String, dynamic> json) =>
      _$GroupListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$GroupListSchemeToJson(this);
}
