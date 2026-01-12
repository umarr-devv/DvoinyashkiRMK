// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nomenclature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NomenclatureScheme _$NomenclatureSchemeFromJson(Map<String, dynamic> json) =>
    NomenclatureScheme(
      refKey: json['Ref_Key'] as String,
      description: json['Description'] as String,
      name: json['НаименованиеПолное'] as String,
      useCharacteristic: json['ИспользоватьХарактеристики'] as bool,
    );

Map<String, dynamic> _$NomenclatureSchemeToJson(NomenclatureScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.refKey,
      'Description': instance.description,
      'НаименованиеПолное': instance.name,
      'ИспользоватьХарактеристики': instance.useCharacteristic,
    };

NomenclatureListScheme _$NomenclatureListSchemeFromJson(
  Map<String, dynamic> json,
) => NomenclatureListScheme(
  nomenclatures: (json['value'] as List<dynamic>)
      .map((e) => NomenclatureScheme.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$NomenclatureListSchemeToJson(
  NomenclatureListScheme instance,
) => <String, dynamic>{'value': instance.nomenclatures};
