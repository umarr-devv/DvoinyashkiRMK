// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckScheme _$CheckSchemeFromJson(Map<String, dynamic> json) => CheckScheme(
  refKey: json['Ref_Key'] as String,
  number: json['Number'] as String,
  date: DateTime.parse(json['Date'] as String),
  cashRegisterKey: json['КассаККМ_Key'] as String,
  structureUnitKey: json['СтруктурнаяЕдиница_Key'] as String,
  userKey: json['Кассир_Key'] as String,
  cashRegisterSessionKey: json['КассоваяСмена_Key'] as String,
  udsClient: json['КлиентUDS'] as String,
  udsDiscountCode: json['КодСкидкиUDS'] as String,
  udsDiscount: json['СкидкаUDS'] as String,
  udsSumPayment: json['СуммаОплатUDS'] as String,
  cash: (json['Наличные'] as num).toDouble(),
  userInn: json['ОбменИННКассира'] as String,
  shop: json['ОбменМагазин'] as String,
  cashPayment: (json['ПолученоНаличными'] as num).toDouble(),
  cashlessPayment: (json['ПолученоЭлектронно'] as num).toDouble(),
  change: json['Сдача'],
  status: json['Статус'] as String,
  includeNDS: json['СуммаВключаетНДС'] as bool,
  documentSum: (json['СуммаДокумента'] as num).toDouble(),
  paymentType: json['ФормаОплаты'] as String,
  itemsAsString: json['Состав'] as String?,
);

Map<String, dynamic> _$CheckSchemeToJson(CheckScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.refKey,
      'Number': instance.number,
      'Date': instance.date.toIso8601String(),
      'КассаККМ_Key': instance.cashRegisterKey,
      'СтруктурнаяЕдиница_Key': instance.structureUnitKey,
      'Кассир_Key': instance.userKey,
      'КассоваяСмена_Key': instance.cashRegisterSessionKey,
      'КлиентUDS': instance.udsClient,
      'КодСкидкиUDS': instance.udsDiscountCode,
      'СкидкаUDS': instance.udsDiscount,
      'СуммаОплатUDS': instance.udsSumPayment,
      'Наличные': instance.cash,
      'ОбменИННКассира': instance.userInn,
      'ОбменМагазин': instance.shop,
      'ПолученоНаличными': instance.cashPayment,
      'ПолученоЭлектронно': instance.cashlessPayment,
      'Сдача': instance.change,
      'Статус': instance.status,
      'СуммаВключаетНДС': instance.includeNDS,
      'СуммаДокумента': instance.documentSum,
      'ФормаОплаты': instance.paymentType,
      'Состав': instance.itemsAsString,
    };

CheckItemScheme _$CheckItemSchemeFromJson(Map<String, dynamic> json) =>
    CheckItemScheme(
      nomenclatureKey: json['Номенклатура_Key'] as String,
      characteriticKey: json['Характеристика_Key'] as String?,
      quantity: (json['Количество'] as num).toDouble(),
      price: (json['Цена'] as num).toDouble(),
      itemSum: (json['Сумма'] as num).toDouble(),
    );

Map<String, dynamic> _$CheckItemSchemeToJson(CheckItemScheme instance) =>
    <String, dynamic>{
      'Номенклатура_Key': instance.nomenclatureKey,
      'Характеристика_Key': instance.characteriticKey,
      'Количество': instance.quantity,
      'Цена': instance.price,
      'Сумма': instance.itemSum,
    };

DetailCheckScheme _$DetailCheckSchemeFromJson(Map<String, dynamic> json) =>
    DetailCheckScheme(
      items: (json['Запасы'] as List<dynamic>)
          .map((e) => CheckItemScheme.fromJson(e as Map<String, dynamic>))
          .toList(),
      refKey: json['Ref_Key'] as String,
      number: json['Number'] as String,
      date: DateTime.parse(json['Date'] as String),
      cashRegisterKey: json['КассаККМ_Key'] as String,
      userKey: json['Кассир_Key'] as String,
      cashRegisterSessionKey: json['КассоваяСмена_Key'] as String,
      udsClient: json['КлиентUDS'] as String,
      udsDiscountCode: json['КодСкидкиUDS'] as String,
      udsDiscount: json['СкидкаUDS'] as String,
      udsSumPayment: json['СуммаОплатUDS'] as String,
      cash: (json['Наличные'] as num).toDouble(),
      userInn: json['ОбменИННКассира'] as String,
      shop: json['ОбменМагазин'] as String,
      cashPayment: (json['ПолученоНаличными'] as num).toDouble(),
      cashlessPayment: (json['ПолученоЭлектронно'] as num).toDouble(),
      change: json['Сдача'],
      status: json['Статус'] as String,
      includeNDS: json['СуммаВключаетНДС'] as bool,
      documentSum: (json['СуммаДокумента'] as num).toDouble(),
      paymentType: json['ФормаОплаты'] as String,
      itemsAsString: json['Состав'] as String?,
      structureUnitKey: json['СтруктурнаяЕдиница_Key'] as String,
    );

Map<String, dynamic> _$DetailCheckSchemeToJson(DetailCheckScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.refKey,
      'Number': instance.number,
      'Date': instance.date.toIso8601String(),
      'КассаККМ_Key': instance.cashRegisterKey,
      'СтруктурнаяЕдиница_Key': instance.structureUnitKey,
      'Кассир_Key': instance.userKey,
      'КассоваяСмена_Key': instance.cashRegisterSessionKey,
      'КлиентUDS': instance.udsClient,
      'КодСкидкиUDS': instance.udsDiscountCode,
      'СкидкаUDS': instance.udsDiscount,
      'СуммаОплатUDS': instance.udsSumPayment,
      'Наличные': instance.cash,
      'ОбменИННКассира': instance.userInn,
      'ОбменМагазин': instance.shop,
      'ПолученоНаличными': instance.cashPayment,
      'ПолученоЭлектронно': instance.cashlessPayment,
      'Сдача': instance.change,
      'Статус': instance.status,
      'СуммаВключаетНДС': instance.includeNDS,
      'СуммаДокумента': instance.documentSum,
      'ФормаОплаты': instance.paymentType,
      'Состав': instance.itemsAsString,
      'Запасы': instance.items,
    };

CheckListScheme _$CheckListSchemeFromJson(Map<String, dynamic> json) =>
    CheckListScheme(
      checks: (json['value'] as List<dynamic>)
          .map((e) => CheckScheme.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckListSchemeToJson(CheckListScheme instance) =>
    <String, dynamic>{'value': instance.checks};

OnlyCheckItemsScheme _$OnlyCheckItemsSchemeFromJson(
  Map<String, dynamic> json,
) => OnlyCheckItemsScheme(
  items: (json['Запасы'] as List<dynamic>)
      .map((e) => CheckItemScheme.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$OnlyCheckItemsSchemeToJson(
  OnlyCheckItemsScheme instance,
) => <String, dynamic>{'Запасы': instance.items};

OnlyCheckItemsListScheme _$OnlyCheckItemsListSchemeFromJson(
  Map<String, dynamic> json,
) => OnlyCheckItemsListScheme(
  items: (json['value'] as List<dynamic>)
      .map((e) => OnlyCheckItemsScheme.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$OnlyCheckItemsListSchemeToJson(
  OnlyCheckItemsListScheme instance,
) => <String, dynamic>{'value': instance.items};
