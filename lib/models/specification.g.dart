// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecificationItemScheme _$SpecificationItemSchemeFromJson(
  Map<String, dynamic> json,
) => SpecificationItemScheme(
  nomenclatureKey: json['Номенклатура_Key'] as String,
  characteristicKey: json['Характеристика_Key'] as String?,
  unitKey: json['ЕдиницаИзмерения'] as String,
  quantity: (json['Количество'] as num).toDouble(),
  sum: (json['Сумма'] as num).toDouble(),
  price: (json['Цена'] as num).toDouble(),
);

Map<String, dynamic> _$SpecificationItemSchemeToJson(
  SpecificationItemScheme instance,
) => <String, dynamic>{
  'Номенклатура_Key': instance.nomenclatureKey,
  'Характеристика_Key': instance.characteristicKey,
  'ЕдиницаИзмерения': instance.unitKey,
  'Количество': instance.quantity,
  'Сумма': instance.sum,
  'Цена': instance.price,
};

SpecificationScheme _$SpecificationSchemeFromJson(Map<String, dynamic> json) =>
    SpecificationScheme(
      refKey: json['Ref_Key'] as String,
      nomenclatureKey: json['Owner_Key'] as String,
      characteristicKey: json['ХарактеристикаПродукции_Key'] as String,
      code: json['Code'] as String,
      priceKey: json['ВидЦены_Key'] as String,
      materialSum: (json['СуммаМатериал'] as num).toDouble(),
      unitPrice: (json['ЗаЕдиницу'] as num).toDouble(),
      totalPrice: (json['Сумма'] as num).toDouble(),
      outputCount: (json['КоличествоПродукции'] as num).toDouble(),
      userKey: json['Ответственный_Key'] as String,
      sellPrice: json['ЦенаПродажи'] as String,
      items: (json['Состав'] as List<dynamic>)
          .map(
            (e) => SpecificationItemScheme.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$SpecificationSchemeToJson(
  SpecificationScheme instance,
) => <String, dynamic>{
  'Ref_Key': instance.refKey,
  'Owner_Key': instance.nomenclatureKey,
  'ХарактеристикаПродукции_Key': instance.characteristicKey,
  'Code': instance.code,
  'ВидЦены_Key': instance.priceKey,
  'СуммаМатериал': instance.materialSum,
  'ЗаЕдиницу': instance.unitPrice,
  'Сумма': instance.totalPrice,
  'КоличествоПродукции': instance.outputCount,
  'Ответственный_Key': instance.userKey,
  'ЦенаПродажи': instance.sellPrice,
  'Состав': instance.items,
};

SpecificationListScheme _$SpecificationListSchemeFromJson(
  Map<String, dynamic> json,
) => SpecificationListScheme(
  value: (json['value'] as List<dynamic>)
      .map((e) => SpecificationItemScheme.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SpecificationListSchemeToJson(
  SpecificationListScheme instance,
) => <String, dynamic>{'value': instance.value};
