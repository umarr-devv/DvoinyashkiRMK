// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_return_check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateReturnCheckScheme _$CreateReturnCheckSchemeFromJson(
  Map<String, dynamic> json,
) => CreateReturnCheckScheme(
  date: DateTime.parse(json['Date'] as String),
  authorKey: json['Автор_Key'] as String,
  checkKey: json['ЧекККМ_Key'] as String?,
  cashRegisterKey: json['КассаККМ_Key'] as String,
  sessionKey: json['КассоваяСмена_Key'] as String,
  subdivisionKey: json['Подразделение_Key'] as String,
  storeKey: json['СтруктурнаяЕдиница_Key'] as String,
  totalSum: (json['СуммаДокумента'] as num).toDouble(),
  items: (json['Запасы'] as List<dynamic>)
      .map(
        (e) => CreateReturnCheckItemScheme.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  userKey: json['Ответственный_Key'] as String,
  cashPayment: (json['ПолученоНаличными'] as num).toDouble(),
  movementDelete: json['ДвиженияПоЗапасамУдалять'] as bool? ?? false,
  includeNds: json['НДСВключатьВСтоимость'] as bool? ?? true,
  sessionNumber: (json['НомерСменыККМ'] as num?)?.toInt() ?? 1,
  priceKey:
      json['ВидЦен_Key'] as String? ?? '021f4fa7-3377-11ed-91a8-a068f8f3337c',
  specialMode: json['СпециальныйНалоговыйРежим'] as String? ?? 'НеПрименяется',
  prepayment: json['СпособЗачетаПредоплаты'] as String? ?? 'Вручную',
  checkOrderId: json['ИдентификаторЧекаВОчереди'] as String,
);

Map<String, dynamic> _$CreateReturnCheckSchemeToJson(
  CreateReturnCheckScheme instance,
) => <String, dynamic>{
  'Date': instance.date.toIso8601String(),
  'Автор_Key': instance.authorKey,
  'ЧекККМ_Key': instance.checkKey,
  'КассаККМ_Key': instance.cashRegisterKey,
  'КассоваяСмена_Key': instance.sessionKey,
  'Подразделение_Key': instance.subdivisionKey,
  'СтруктурнаяЕдиница_Key': instance.storeKey,
  'Ответственный_Key': instance.userKey,
  'СуммаДокумента': instance.totalSum,
  'Запасы': instance.items,
  'ДвиженияПоЗапасамУдалять': instance.movementDelete,
  'НДСВключатьВСтоимость': instance.includeNds,
  'НомерСменыККМ': instance.sessionNumber,
  'ПолученоНаличными': instance.cashPayment,
  'ВидЦен_Key': instance.priceKey,
  'СпециальныйНалоговыйРежим': instance.specialMode,
  'СпособЗачетаПредоплаты': instance.prepayment,
  'ИдентификаторЧекаВОчереди': instance.checkOrderId,
};

CreateReturnCheckItemScheme _$CreateReturnCheckItemSchemeFromJson(
  Map<String, dynamic> json,
) => CreateReturnCheckItemScheme(
  lineNumber: (json['LineNumber'] as num).toInt(),
  key: (json['КлючСвязи'] as num).toInt(),
  nomenclatureKey: json['Номенклатура_Key'] as String,
  characteristicKey: json['Характеристика_Key'] as String?,
  quantity: (json['Количество'] as num).toDouble(),
  price: (json['Цена'] as num).toDouble(),
  totalSum: (json['Сумма'] as num).toDouble(),
  allSum: (json['Всего'] as num).toDouble(),
  unitKey: json['ЕдиницаИзмерения'] as String?,
  ndsKey:
      json['СтавкаНДС_Key'] as String? ??
      '436b4216-3377-11ed-91a8-a068f8f3337c',
  unitType:
      json['ЕдиницаИзмерения_Type'] as String? ??
      'StandardODATA.Catalog_КлассификаторЕдиницИзмерения',
);

Map<String, dynamic> _$CreateReturnCheckItemSchemeToJson(
  CreateReturnCheckItemScheme instance,
) => <String, dynamic>{
  'LineNumber': instance.lineNumber,
  'КлючСвязи': instance.key,
  'Номенклатура_Key': instance.nomenclatureKey,
  'Характеристика_Key': instance.characteristicKey,
  'Количество': instance.quantity,
  'Цена': instance.price,
  'Сумма': instance.totalSum,
  'Всего': instance.allSum,
  'СтавкаНДС_Key': instance.ndsKey,
  'ЕдиницаИзмерения': instance.unitKey,
  'ЕдиницаИзмерения_Type': instance.unitType,
};
