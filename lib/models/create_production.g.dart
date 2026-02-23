// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_production.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateProductionItemScheme _$CreateProductionItemSchemeFromJson(
  Map<String, dynamic> json,
) => CreateProductionItemScheme(
  lineNumber: (json['LineNumber'] as num).toInt(),
  nomenclatureKey: json['Номенклатура_Key'] as String,
  characteristicKey: json['Характеристика_Key'] as String?,
  quantity: (json['Количество'] as num).toDouble(),
  unitKey: json['ЕдиницаИзмерения'] as String?,
  unitType:
      json['ЕдиницаИзмерения_Type'] as String? ??
      'StandardODATA.Catalog_КлассификаторЕдиницИзмерения',
  key: (json['КлючСвязи'] as num).toInt(),
  specificationKey: json['Спецификация_Key'] as String,
);

Map<String, dynamic> _$CreateProductionItemSchemeToJson(
  CreateProductionItemScheme instance,
) => <String, dynamic>{
  'LineNumber': instance.lineNumber,
  'Номенклатура_Key': instance.nomenclatureKey,
  'Характеристика_Key': instance.characteristicKey,
  'Количество': instance.quantity,
  'ЕдиницаИзмерения': instance.unitKey,
  'ЕдиницаИзмерения_Type': instance.unitType,
  'КлючСвязи': instance.key,
  'Спецификация_Key': instance.specificationKey,
};

CreateProductionResourceScheme _$CreateProductionResourceSchemeFromJson(
  Map<String, dynamic> json,
) => CreateProductionResourceScheme(
  lineNumber: (json['LineNumber'] as num).toInt(),
  nomenclatureKey: json['Номенклатура_Key'] as String,
  characteristicKey: json['Характеристика_Key'] as String?,
  quantity: (json['Количество'] as num).toDouble(),
  unitKey: json['ЕдиницаИзмерения'] as String,
  unitType:
      json['ЕдиницаИзмерения_Type'] as String? ??
      'StandardODATA.Catalog_КлассификаторЕдиницИзмерения',
  key: (json['КлючСвязи'] as num).toInt(),
);

Map<String, dynamic> _$CreateProductionResourceSchemeToJson(
  CreateProductionResourceScheme instance,
) => <String, dynamic>{
  'LineNumber': instance.lineNumber,
  'Номенклатура_Key': instance.nomenclatureKey,
  'Характеристика_Key': instance.characteristicKey,
  'Количество': instance.quantity,
  'ЕдиницаИзмерения': instance.unitKey,
  'ЕдиницаИзмерения_Type': instance.unitType,
  'КлючСвязи': instance.key,
};

CreateProductionScheme _$CreateProductionSchemeFromJson(
  Map<String, dynamic> json,
) => CreateProductionScheme(
  date: json['Date'] == null ? null : DateTime.parse(json['Date'] as String),
  orgKey:
      json['Организация_Key'] as String? ??
      '021f4fa6-3377-11ed-91a8-a068f8f3337c',
  structureUnitKey: json['СтруктурнаяЕдиница_Key'] as String,
  fromStructureUnitKey: json['СтруктурнаяЕдиницаЗапасов_Key'] as String,
  toStructureUnitKey: json['СтруктурнаяЕдиницаПродукции_Key'] as String,
  operationKey:
      json['ХозяйственнаяОперация_Key'] as String? ??
      '43f6fc87-4a0d-11ed-a839-18d6c704b66b',
  operationType: json['ВидОперации'] as String? ?? 'Сборка',
  items: (json['Продукция'] as List<dynamic>)
      .map(
        (e) => CreateProductionItemScheme.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  resources: (json['Запасы'] as List<dynamic>)
      .map(
        (e) =>
            CreateProductionResourceScheme.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$CreateProductionSchemeToJson(
  CreateProductionScheme instance,
) => <String, dynamic>{
  'Date': instance.date?.toIso8601String(),
  'Организация_Key': instance.orgKey,
  'СтруктурнаяЕдиница_Key': instance.structureUnitKey,
  'СтруктурнаяЕдиницаЗапасов_Key': instance.fromStructureUnitKey,
  'СтруктурнаяЕдиницаПродукции_Key': instance.toStructureUnitKey,
  'ХозяйственнаяОперация_Key': instance.operationKey,
  'ВидОперации': instance.operationType,
  'Продукция': instance.items,
  'Запасы': instance.resources,
};
