// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCheckScheme _$CreateCheckSchemeFromJson(Map<String, dynamic> json) =>
    CreateCheckScheme(
      date: DateTime.parse(json['Date'] as String),
      authorKey: json['Автор_Key'] as String,
      posted: json['Posted'] as bool? ?? false,
      cashRegisterKey: json['КассаККМ_Key'] as String,
      userKey: json['Кассир_Key'] as String,
      sessionKey: json['КассоваяСмена_Key'] as String,
      sessionNumber: (json['НомерСменыККМ'] as num).toInt(),
      udsCustomer: json['КлиентUDS'] as String?,
      udsDiscountCode: json['КодСкидкиUDS'] as String?,
      udsDiscount: (json['СкидкаUDS'] as num?)?.toDouble(),
      comment: json['Комментарий'] as String?,
      responsibleKey: json['Ответственный_Key'] as String,
      subdivisionKey: json['Подразделение_Key'] as String,
      customer: json['Покупатель'] as String?,
      employeersDebtKey: json['СотрудникДолг_Key'] as String?,
      cash: (json['Наличные'] as num).toDouble(),
      getCash: (json['ПолученоНаличными'] as num).toDouble(),
      getCashless: (json['ПолученоЭлектронно'] as num).toDouble(),
      cashless: (json['СуммаБезналичнойОплаты'] as num).toDouble(),
      udsPayment: (json['СуммаОплатUDS'] as num?)?.toDouble(),
      paymentForm: json['ФормаОплаты'] as String,
      change: (json['Сдача'] as num).toDouble(),
      storeKey: json['СтруктурнаяЕдиница_Key'] as String,
      items: (json['Запасы'] as List<dynamic>)
          .map((e) => CreateCheckItemScheme.fromJson(e as Map<String, dynamic>))
          .toList(),
      documentSum: (json['СуммаДокумента'] as num).toDouble(),
      debt: (json['Долг'] as num).toDouble(),
      isCashlessPayment: json['БезналичныйРасчет'] as bool,
      currencyKey:
          json['ВалютаДокумента_Key'] as String? ??
          '02e351c0-7e12-11ed-a847-18d6c704b66b',
      priceTypeKey:
          json['ВидЦен_Key'] as String? ??
          '021f4fa7-3377-11ed-91a8-a068f8f3337c',
      orgKey:
          json['Организация_Key'] as String? ??
          '021f4fa6-3377-11ed-91a8-a068f8f3337c',
      operationKey:
          json['ХозяйственнаяОперация_Key'] as String? ??
          '43f6fc97-4a0d-11ed-a839-18d6c704b66b',
      status: json['Статус'] as String? ?? 'Пробит',
    );

Map<String, dynamic> _$CreateCheckSchemeToJson(CreateCheckScheme instance) =>
    <String, dynamic>{
      'Date': instance.date.toIso8601String(),
      'Posted': instance.posted,
      'Автор_Key': instance.authorKey,
      'ВалютаДокумента_Key': instance.currencyKey,
      'ВидЦен_Key': instance.priceTypeKey,
      'КассаККМ_Key': instance.cashRegisterKey,
      'Кассир_Key': instance.userKey,
      'КассоваяСмена_Key': instance.sessionKey,
      'НомерСменыККМ': instance.sessionNumber,
      'КлиентUDS': instance.udsCustomer,
      'КодСкидкиUDS': instance.udsDiscountCode,
      'СкидкаUDS': instance.udsDiscount,
      'Комментарий': instance.comment,
      'Организация_Key': instance.orgKey,
      'Ответственный_Key': instance.responsibleKey,
      'Подразделение_Key': instance.subdivisionKey,
      'Покупатель': instance.customer,
      'СотрудникДолг_Key': instance.employeersDebtKey,
      'Долг': instance.debt,
      'БезналичныйРасчет': instance.isCashlessPayment,
      'Наличные': instance.cash,
      'ПолученоНаличными': instance.getCash,
      'ПолученоЭлектронно': instance.getCashless,
      'СуммаБезналичнойОплаты': instance.cashless,
      'СуммаОплатUDS': instance.udsPayment,
      'ФормаОплаты': instance.paymentForm,
      'Сдача': instance.change,
      'Статус': instance.status,
      'СтруктурнаяЕдиница_Key': instance.storeKey,
      'ХозяйственнаяОперация_Key': instance.operationKey,
      'Запасы': instance.items,
      'СуммаДокумента': instance.documentSum,
    };

CreateCheckItemScheme _$CreateCheckItemSchemeFromJson(
  Map<String, dynamic> json,
) => CreateCheckItemScheme(
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

Map<String, dynamic> _$CreateCheckItemSchemeToJson(
  CreateCheckItemScheme instance,
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
