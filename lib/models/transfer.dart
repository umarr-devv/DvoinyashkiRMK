import 'package:json_annotation/json_annotation.dart';

part 'transfer.g.dart';

@JsonSerializable(includeIfNull: false)
class TransferScheme {
  @JsonKey(name: 'Ref_Key')
  final String refKey;
  @JsonKey(name: 'DataVersion')
  final String? dataVersion;
  @JsonKey(name: 'DeletionMark')
  final bool? deletionMark;
  @JsonKey(name: 'Number')
  final String number;
  @JsonKey(name: 'Date')
  final DateTime date;
  @JsonKey(name: 'Posted')
  final bool? posted;
  @JsonKey(name: 'Автомобиль_Key')
  final String? carKey;
  @JsonKey(name: 'Автор_Key')
  final String? authorKey;
  @JsonKey(name: 'АдресДоставки')
  final String? deliveryAddress;
  @JsonKey(name: 'АдресДоставкиЗначение')
  final String? deliveryAddressValue;
  @JsonKey(name: 'АдресДоставкиЗначенияПолей')
  final String? deliveryAddressFieldsValues;
  @JsonKey(name: 'БанковскийСчетПеревозчика_Key')
  final String? carrierBankAccountKey;
  @JsonKey(name: 'Вес')
  final double? weight;
  @JsonKey(name: 'ВидОперации')
  final String? operationType;
  @JsonKey(name: 'ВидыЦен_Key')
  final String? priceTypesKey;
  @JsonKey(name: 'Водитель_Key')
  final String? driverKey;
  @JsonKey(name: 'Возврат')
  final bool? isReturn;
  @JsonKey(name: 'Грузоотправитель_Key')
  final String? senderKey;
  @JsonKey(name: 'Грузополучатель_Key')
  final String? receiverKey;
  @JsonKey(name: 'ДоверенностьВыдана')
  final String? powerOfAttorneyIssued;
  @JsonKey(name: 'ДоверенностьДата')
  final DateTime? powerOfAttorneyDate;
  @JsonKey(name: 'ДоверенностьЛицо_Key')
  final String? powerOfAttorneyPersonKey;
  @JsonKey(name: 'ДоверенностьНомер')
  final String? powerOfAttorneyNumber;
  @JsonKey(name: 'ДокументОснование')
  final String? baseDocument;
  @JsonKey(name: 'ДокументОснование_Type')
  final String? baseDocumentType;
  @JsonKey(name: 'ДокументОтгрузки_Key')
  final String? shipmentDocumentKey;
  @JsonKey(name: 'ДокументПоступления_Key')
  final String? receiptDocumentKey;
  @JsonKey(name: 'ДополнительнаяИнформацияПоДоставке')
  final String? additionalDeliveryInfo;
  @JsonKey(name: 'ЕстьСкидки')
  final bool? hasDiscounts;
  @JsonKey(name: 'Заказ')
  final String? order;
  @JsonKey(name: 'ЗаказНаПеремещение_Key')
  final String? transferOrderKey;
  @JsonKey(name: 'ЗаказПокупателя_Key')
  final String? customerOrderKey;
  @JsonKey(name: 'Закрыт')
  final DateTime? closedAt;
  @JsonKey(name: 'Итого')
  final double? total;
  @JsonKey(name: 'КодОперацииПрослеживаемости_Key')
  final String? traceabilityOpCodeKey;
  @JsonKey(name: 'Комментарий')
  final String? comment;
  @JsonKey(name: 'НаправлениеДеятельности_Key')
  final String? lineOfBusinessKey;
  @JsonKey(name: 'Объем')
  final double? volume;
  @JsonKey(name: 'Организация_Key')
  final String? organizationKey;
  @JsonKey(name: 'Оригинал')
  final bool? isOriginal;
  @JsonKey(name: 'ОснованиеПечати')
  final String? printBase;
  @JsonKey(name: 'ОснованиеПечатиСсылка')
  final String? printBaseRef;
  @JsonKey(name: 'ОснованиеПечатиСсылка_Type')
  final String? printBaseRefType;
  @JsonKey(name: 'Ответственный_Key')
  final String? responsibleKey;
  @JsonKey(name: 'Открыт')
  final DateTime? openedAt;
  @JsonKey(name: 'Отправлен')
  final bool? isSent;
  @JsonKey(name: 'Перевозчик_Key')
  final String? carrierKey;
  @JsonKey(name: 'ПодписьГлавногоБухгалтера_Key')
  final String? chiefAccountantSignatureKey;
  @JsonKey(name: 'ПодписьКладовщикаОтправил_Key')
  final String? senderStorekeeperSignatureKey;
  @JsonKey(name: 'ПодписьКладовщикаПолучил_Key')
  final String? receiverStorekeeperSignatureKey;
  @JsonKey(name: 'ПодписьКонтролера_Key')
  final String? controllerSignatureKey;
  @JsonKey(name: 'ПодписьРуководителя_Key')
  final String? directorSignatureKey;
  @JsonKey(name: 'ПоложениеЗаказаПокупателя')
  final String? customerOrderPosition;
  @JsonKey(name: 'ПоложениеНастроекНалоговогоУчета')
  final String? taxSettingsPosition;
  @JsonKey(name: 'ПоложениеПроекта')
  final String? projectPosition;
  @JsonKey(name: 'ПоложениеЯчейкиОтправителя')
  final String? senderCellPosition;
  @JsonKey(name: 'ПоложениеЯчейкиПолучателя')
  final String? receiverCellPosition;
  @JsonKey(name: 'Принят')
  final bool isAccepted;
  @JsonKey(name: 'Прицеп_Key')
  final String? trailerKey;
  @JsonKey(name: 'Проверено')
  final bool? isChecked;
  @JsonKey(name: 'Проект_Key')
  final String? projectKey;
  @JsonKey(name: 'СостояниеЗаказа_Key')
  final String? orderStatusKey;
  @JsonKey(name: 'Сотрудник_Key')
  final String? employeeKey;
  @JsonKey(name: 'СрокДоставки')
  final DateTime? deliveryDeadline;
  @JsonKey(name: 'СтруктурнаяЕдиница_Key')
  final String? senderUnitKey;
  @JsonKey(name: 'СтруктурнаяЕдиницаПолучатель_Key')
  final String? receiverUnitKey;
  @JsonKey(name: 'СуммаДокумента')
  final double? documentAmount;
  @JsonKey(name: 'СчетЗатрат_Key')
  final String? costAccountKey;
  @JsonKey(name: 'ТоварыПередаютсяВСоставеРабот')
  final bool? goodsTransferredInWorks;
  @JsonKey(name: 'УдалитьГлавныйБухгалтер_Key')
  final String? deleteChiefAccountantKey;
  @JsonKey(name: 'УдалитьОтпустил_Key')
  final String? deleteReleasedByKey;
  @JsonKey(name: 'УдалитьОтпустилДолжность_Key')
  final String? deleteReleasedByPositionKey;
  @JsonKey(name: 'УдалитьРуководитель_Key')
  final String? deleteDirectorKey;
  @JsonKey(name: 'УдалитьРуководительДолжность_Key')
  final String? deleteDirectorPositionKey;
  @JsonKey(name: 'УчитыватьВНУ')
  final bool? includeInTaxAccounting;
  @JsonKey(name: 'ХозяйственнаяОперация_Key')
  final String? businessOperationKey;
  @JsonKey(name: 'Ячейка_Key')
  final String? cellKey;
  @JsonKey(name: 'ЯчейкаПолучатель_Key')
  final String? receiverCellKey;
  @JsonKey(name: 'СкладСборки_Key')
  final String? assemblyWarehouseKey;
  @JsonKey(name: 'ВидЦен_Key')
  final String? priceTypeKey;
  @JsonKey(name: 'Заблокировано')
  final bool? isLocked;

  @JsonKey(name: 'Запасы')
  final List<InventoryItem> inventory;

  @JsonKey(name: 'Спецоснастка')
  final List<dynamic>? specialEquipment;
  @JsonKey(name: 'ИнвентарьИХозяйственныеПринадлежности')
  final List<dynamic>? inventoryAndSupplies;
  @JsonKey(name: 'СерииНоменклатуры')
  final List<dynamic>? nomenclatureSeries;
  @JsonKey(name: 'ДополнительныеРеквизиты')
  final List<dynamic>? additionalAttributes;
  @JsonKey(name: 'СведенияПрослеживаемости')
  final List<dynamic>? traceabilityInfo;
  @JsonKey(name: 'ГруппыТоваров')
  final List<dynamic>? productGroups;
  @JsonKey(name: 'Упоковки')
  final List<dynamic>? packages;

  @JsonKey(name: 'Заказ_Type', includeFromJson: false, includeToJson: true)
  final String orderType;

  TransferScheme({
    required this.refKey,
    required this.dataVersion,
    required this.deletionMark,
    required this.number,
    required this.date,
    required this.posted,
    required this.carKey,
    required this.authorKey,
    required this.deliveryAddress,
    required this.deliveryAddressValue,
    required this.deliveryAddressFieldsValues,
    required this.carrierBankAccountKey,
    required this.weight,
    required this.operationType,
    required this.priceTypesKey,
    required this.driverKey,
    required this.isReturn,
    required this.senderKey,
    required this.receiverKey,
    required this.powerOfAttorneyIssued,
    required this.powerOfAttorneyDate,
    required this.powerOfAttorneyPersonKey,
    required this.powerOfAttorneyNumber,
    required this.baseDocument,
    required this.baseDocumentType,
    required this.shipmentDocumentKey,
    required this.receiptDocumentKey,
    required this.additionalDeliveryInfo,
    required this.hasDiscounts,
    required this.order,
    required this.transferOrderKey,
    required this.customerOrderKey,
    required this.closedAt,
    required this.total,
    required this.traceabilityOpCodeKey,
    required this.comment,
    required this.lineOfBusinessKey,
    required this.volume,
    required this.organizationKey,
    required this.isOriginal,
    required this.printBase,
    required this.printBaseRef,
    required this.printBaseRefType,
    required this.responsibleKey,
    required this.openedAt,
    required this.isSent,
    this.orderType = "StandardODATA.Undefined",
    required this.carrierKey,
    required this.chiefAccountantSignatureKey,
    required this.senderStorekeeperSignatureKey,
    required this.receiverStorekeeperSignatureKey,
    required this.controllerSignatureKey,
    required this.directorSignatureKey,
    required this.customerOrderPosition,
    required this.taxSettingsPosition,
    required this.projectPosition,
    required this.senderCellPosition,
    required this.receiverCellPosition,
    required this.isAccepted,
    required this.trailerKey,
    required this.isChecked,
    required this.projectKey,
    required this.orderStatusKey,
    required this.employeeKey,
    required this.deliveryDeadline,
    required this.senderUnitKey,
    required this.receiverUnitKey,
    required this.documentAmount,
    required this.costAccountKey,
    required this.goodsTransferredInWorks,
    required this.deleteChiefAccountantKey,
    required this.deleteReleasedByKey,
    required this.deleteReleasedByPositionKey,
    required this.deleteDirectorKey,
    required this.deleteDirectorPositionKey,
    required this.includeInTaxAccounting,
    required this.businessOperationKey,
    required this.cellKey,
    required this.receiverCellKey,
    required this.assemblyWarehouseKey,
    required this.priceTypeKey,
    required this.isLocked,
    required this.inventory,
    required this.specialEquipment,
    required this.inventoryAndSupplies,
    required this.nomenclatureSeries,
    required this.additionalAttributes,
    required this.traceabilityInfo,
    required this.productGroups,
    required this.packages,
  });

  factory TransferScheme.fromJson(Map<String, dynamic> json) =>
      _$TransferSchemeFromJson(json);
  Map<String, dynamic> toJson() => _$TransferSchemeToJson(this);
}

@JsonSerializable(includeIfNull: false)
class InventoryItem {
  @JsonKey(name: 'Ref_Key')
  final String refKey;
  @JsonKey(name: 'LineNumber')
  final String lineNumber;
  @JsonKey(name: 'Номенклатура_Key')
  final String nomenclatureKey;
  @JsonKey(name: 'Характеристика_Key')
  final String? characteristicKey;
  @JsonKey(name: 'Партия_Key')
  final String? batchKey;
  @JsonKey(name: 'СерииНоменклатуры')
  final String? nomenclatureSeries;
  @JsonKey(name: 'Количество')
  final double quantity;
  @JsonKey(name: 'Резерв')
  final double? reserve;
  @JsonKey(name: 'ЕдиницаИзмерения')
  final String? unitOfMeasureKey;
  @JsonKey(name: 'ЕдиницаИзмерения_Type')
  final String? unitOfMeasureType;
  @JsonKey(name: 'ЗаказПокупателя_Key')
  final String? customerOrderKey;
  @JsonKey(name: 'Себестоимость')
  final double? cost;
  @JsonKey(name: 'КлючСвязи')
  final String? connectionKey;
  @JsonKey(name: 'СтранаПроисхождения_Key')
  final String? countryOfOriginKey;
  @JsonKey(name: 'НомерГТД_Key')
  final String? gtdNumberKey;
  @JsonKey(name: 'Проект_Key')
  final String? projectKey;
  @JsonKey(name: 'ИдентификаторСтроки')
  final String? rowIdentifier;
  @JsonKey(name: 'ПрослеживаемыйТовар')
  final bool? isTraceableItem;
  @JsonKey(name: 'ПрослеживаемыйКомплект')
  final bool? isTraceableKit;
  @JsonKey(name: 'Цена')
  final double price;
  @JsonKey(name: 'УчитыватьВНУ')
  final bool? includeInTaxAccounting;
  @JsonKey(name: 'Ячейка_Key')
  final String? cellKey;
  @JsonKey(name: 'ЯчейкаПолучатель_Key')
  final String? receiverCellKey;
  @JsonKey(name: 'Вес')
  final double? weight;
  @JsonKey(name: 'Объем')
  final double? volume;
  @JsonKey(name: 'Сумма')
  final double sum;
  @JsonKey(name: 'Группа_Key')
  final String? groupKey;
  @JsonKey(name: 'Заказано')
  final double? ordered;
  @JsonKey(name: 'Остаток')
  final double? balance;
  @JsonKey(name: 'Скидка')
  final String? discount;

  InventoryItem({
    required this.refKey,
    required this.lineNumber,
    required this.nomenclatureKey,
    required this.characteristicKey,
    required this.batchKey,
    required this.nomenclatureSeries,
    required this.quantity,
    required this.reserve,
    required this.unitOfMeasureKey,
    required this.unitOfMeasureType,
    required this.customerOrderKey,
    required this.cost,
    required this.connectionKey,
    required this.countryOfOriginKey,
    required this.gtdNumberKey,
    required this.projectKey,
    required this.rowIdentifier,
    required this.isTraceableItem,
    required this.isTraceableKit,
    required this.price,
    required this.includeInTaxAccounting,
    required this.cellKey,
    required this.receiverCellKey,
    required this.weight,
    required this.volume,
    required this.sum,
    required this.groupKey,
    required this.ordered,
    required this.balance,
    required this.discount,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryItemFromJson(json);
  Map<String, dynamic> toJson() => _$InventoryItemToJson(this);
}

@JsonSerializable()
class TransferListScheme {
  TransferListScheme({required this.value});

  @JsonKey(name: 'value')
  final List<TransferScheme> value;
  factory TransferListScheme.fromJson(Map<String, dynamic> json) =>
      _$TransferListSchemeFromJson(json);
  Map<String, dynamic> toJson() => _$TransferListSchemeToJson(this);
}

@JsonSerializable()
class TransferUpdateScheme {
  TransferUpdateScheme({required this.transferDate, required this.isAccepted});

  @JsonKey(name: 'ДатаПриемки')
  final DateTime transferDate;

  @JsonKey(name: 'Принят')
  final bool isAccepted;

  factory TransferUpdateScheme.fromJson(Map<String, dynamic> json) =>
      _$TransferUpdateSchemeFromJson(json);
  Map<String, dynamic> toJson() => _$TransferUpdateSchemeToJson(this);
}
