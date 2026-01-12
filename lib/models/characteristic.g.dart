// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characteristic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacteristicScheme _$CharacteristicSchemeFromJson(
  Map<String, dynamic> json,
) => CharacteristicScheme(
  refKey: json['Ref_Key'] as String,
  description: json['Description'] as String,
  nomenclatureKey: json['Owner'] as String?,
  printName: json['НаименованиеДляПечати'] as String,
);

Map<String, dynamic> _$CharacteristicSchemeToJson(
  CharacteristicScheme instance,
) => <String, dynamic>{
  'Ref_Key': instance.refKey,
  'Description': instance.description,
  'Owner': instance.nomenclatureKey,
  'НаименованиеДляПечати': instance.printName,
};

CharacteristicListScheme _$CharacteristicListSchemeFromJson(
  Map<String, dynamic> json,
) => CharacteristicListScheme(
  characteristics: (json['value'] as List<dynamic>)
      .map((e) => CharacteristicScheme.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CharacteristicListSchemeToJson(
  CharacteristicListScheme instance,
) => <String, dynamic>{'value': instance.characteristics};
