import 'package:app/models/models.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET('/Catalog_Сотрудники')
  Future<UserListScheme> getUsers({
    @Query('\$select') String select = 'Ref_Key,Description,ИНН,ШтрихКод',
    @Query('\$format') String format = 'json',
  });

  @GET('/Catalog_Сотрудники(guid\'{ref_key}\')')
  Future<DetailUserScheme> getUser({
    @Path('ref_key') required String refKey,
    @Query('\$select')
    String select =
        'Ref_Key,Description,ИНН,ШтрихКод,ДолжностьОбмен,ПодразделениеОбмен,Фотография_Base64Data',
    @Query('\$format') String format = 'json',
  });

  @GET('/Catalog_КатегорииНоменклатуры')
  Future<CategoryListScheme> getCategories({
    @Query('\$select') String select = 'Ref_Key,Description',
    @Query('\$format') String format = 'json',
  });

  @GET('/Catalog_Номенклатура{full_path}')
  Future<NomenclatureListScheme> getNomenclaturesByPath({
    @Path('full_path') required String fullPath,
  });

  @GET('/Catalog_Номенклатура')
  Future<NomenclatureListScheme> getNomenclatures({
    @Query('\$select')
    String select =
        'Ref_Key,Description,НаименованиеПолное,КатегорияНоменклатуры_Key,ЕдиницаИзмерения_Key,ИспользоватьХарактеристики',
    @Query('\$format') String format = 'json',
  });

  @GET('/Catalog_ХарактеристикиНоменклатуры')
  Future<CharacteristicListScheme> getCharacteristics({
    @Query('\$select')
    String select = 'Ref_Key,Description,Owner,НаименованиеДляПечати',
    @Query('\$format') String format = 'json',
  });

  @GET('/InformationRegister_ЦеныНоменклатуры/SliceLast()')
  Future<PriceListScheme> getPrices({
    @Query('\$select')
    String select =
        'Period,ВидЦен_Key,Номенклатура_Key,Характеристика_Key,Цена',
    @Query('\$format') String format = 'json',
  });

  @GET('/Catalog_ВидыЦен')
  Future<PriceTypeListScheme> getPriceTypes({
    @Query('\$select') String select = 'Ref_Key,Description',
    @Query('\$format') String format = 'json',
  });

  @GET('/InformationRegister_ШтрихкодыНоменклатуры')
  Future<BarcodeListScheme> getBarcodes({
    @Query('\$select')
    String select = 'Штрихкод,Номенклатура_Key,Характеристика_Key',
    @Query('\$format') String format = 'json',
  });

  @GET('/Catalog_Номенклатура')
  Future<ProductImageListScheme> getProductImages({
    @Query('\$select') String select = 'Ref_Key,ФотоДляОбмена_Base64Data',
    @Query('\$format') String format = 'json',
  });

  @GET('/Catalog_КассыККМ')
  Future<CashRegisterListScheme> getCashRegisters({
    @Query('\$select') String select = 'Ref_Key,Description',
    @Query('\$format') String format = 'json',
  });

  @GET('/Document_ЧекККМ{fullPath}')
  Future<CheckListScheme> getChecks({
    @Path('fullPath') required String fullPath,
  });

  @GET('/Document_ЧекККМ{fullPath}')
  Future<OnlyCheckItemsListScheme> getChecksItems({
    @Path('fullPath') required String fullPath,
  });

  @GET('/Document_ЧекККМ(guid\'{ref_key}\')')
  Future<DetailCheckScheme> getCheck({
    @Path('ref_key') required String refKey,
    @Query('\$format') String format = 'json',
  });

  @GET('/Catalog_СтруктурныеЕдиницы')
  Future<StructureUnitListScheme> getStructureUnits({
    @Query('\$select')
    String select =
        'Ref_Key,Description,UDS_UID,Code,Тип,Подразделение_Key,ТипСтруктурнойЕдиницы',
    @Query('\$format') String format = 'json',
  });

  @GET('/Catalog_Пользователи')
  Future<AuthorListScheme> getAuthors({
    @Query('\$select') String select = 'Ref_Key,Description',
    @Query('\$format') String format = 'json',
  });

  @GET('/Document_ВыемкаНаличных{fullPath}')
  Future<WithdrawListScheme> getWithdraws({
    @Path('fullPath') required String fullPath,
  });

  @GET('/Document_ОтчетОРозничныхПродажах{fullPath}')
  Future<WorkShiftListScheme> getWorkShifts({
    @Path('fullPath') required String fullPath,
  });

  @GET('/Document_ЧекККМ{fullPath}')
  Future<StatisticCheckListScheme> getCheckStatistics({
    @Path('fullPath') required String fullPath,
  });

  @GET('/Document_ЗаказНаПеремещение{fullPath}')
  Future<MovementListScheme> getMovements({
    @Path('fullPath') required String fullPath,
  });

  @GET('/Document_ЗаказНаПеремещение(guid\'{ref_key}\')')
  Future<DetailMovementScheme> getMovement({
    @Path('ref_key') required String refKey,
    @Query('\$format') String format = 'json',
  });

  @GET('/Catalog_СостоянияЗаказовНаПеремещение')
  Future<MovementStatusListScheme> getMovementsStatuses({
    @Query('\$select') String select = 'Ref_Key,Description',
    @Query('\$format') String format = 'json',
  });

  @POST('/Document_КассоваяСмена')
  Future<SessionScheme> createSession({
    @Body() required CreateSessionScheme data,
  });

  @POST('/Document_КассоваяСмена(guid\'{refKey}\')/Post')
  Future postSession({@Path('refKey') required String refKey});

  @PATCH('/Document_ОтчетОРозничныхПродажах(guid\'{refKey}\')')
  Future patchWorkShift({
    @Path('refKey') required String refKey,
    @Body() required UpdateWorkShiftScheme data,
  });

  @POST('/Document_ОтчетОРозничныхПродажах(guid\'{refKey}\')/Post')
  Future postWorkShift({@Path('refKey') required String refKey});

  @POST('/Document_ЧекККМ')
  Future<DetailCheckScheme> createCheck({
    @Body() required CreateCheckScheme data,
  });

  @POST('/Document_ЧекККМВозврат')
  Future<CheckReturnScheme> createCheckReturn({
    @Body() required CreateReturnCheckScheme data,
  });

  @POST('/Document_ЧекККМ(guid\'{refKey}\')/Post')
  Future postCheck({@Path('refKey') required String refKey});

  @POST('/Document_ЧекККМВозврат(guid\'{refKey}\')/Post')
  Future postCheckReturn({@Path('refKey') required String refKey});

  @POST('/Document_ВыемкаНаличных')
  Future<WithdrawScheme> createWithdraw({
    @Body() required CreateWithdrawScheme data,
  });

  @POST('/Document_ВыемкаНаличных(guid\'{refKey}\')/Post')
  Future postWithdraw({@Path('refKey') required String refKey});

  @GET('/AccumulationRegister_Запасы/Balance(){full_path}')
  Future<WarehouseItemListScheme> getWarehouseItems({
    @Path('full_path') required String fullPath,
  });

  @GET('/AccumulationRegister_Запасы/Balance(Period=\'{period}\'){full_path}')
  Future<WarehouseItemListScheme> getWarehouseItemsWithPeriod({
    @Path('period') required DateTime period,
    @Path('full_path') required String fullPath,
  });

  @GET('/AccumulationRegister_ДенежныеСредстваВКассахККМ/Balance(){full_path}')
  Future<CashListScheme> getCash({@Path('full_path') required String fullPath});

  @GET(
    '/AccumulationRegister_ДенежныеСредстваВКассахККМ/Balance(Period=\'{period}\'){full_path}',
  )
  Future<CashListScheme> getCashWithPeriod({
    @Path('period') required DateTime period,
    @Path('full_path') required String fullPath,
  });

  @GET('/Document_ОтчетОРозничныхПродажах(guid\'{ref_key}\')')
  Future<DetailWorkShiftScheme> getWorkShift({
    @Path('ref_key') required String refKey,
  });

  @DELETE('/Document_ЧекККМ(guid\'{ref_key}\')')
  Future deleteCheck({@Path('ref_key') required String refKey});

  @POST('/Document_ЗаказНаПеремещение')
  Future<MovementScheme> createMovement({
    @Body() required CreateMovementScheme data,
  });

  @POST('/Document_ЗаказНаПеремещение(guid\'{ref_key}\')/Post()')
  Future postMovement();

  @GET('/Catalog_Спецификации')
  Future<SpecificationListScheme> getSpecifications({
    @Query('\$select')
    String select =
        'Ref_Key,Owner_Key,ХарактеристикаПродукции_Key,Code,ВидЦены_Key,СуммаМатериал,ЗаЕдиницу,Сумма,'
        'КоличествоПродукции,Ответственный_Key,ЦенаПродажи,Состав',
    @Query('\$format') String format = 'json',
  });

  @POST('/Document_СборкаЗапасов')
  Future<RefKeyScheme> createProduction({
    @Body() required CreateProductionScheme data,
  });

  @POST('/Document_СборкаЗапасов(guid\'{ref_key}\')/Post()')
  Future postProduction({@Path('ref_key') required String refKey});
}
