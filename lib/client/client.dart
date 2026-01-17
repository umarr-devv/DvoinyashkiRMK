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

  @GET('/Catalog_Номенклатура')
  Future<NomenclatureListScheme> getNomenclatures({
    @Query('\$select')
    String select =
        'Ref_Key,Description,НаименованиеПолное,КатегорияНоменклатуры_Key,ИспользоватьХарактеристики',
    @Query('\$format') String format = 'json',
  });

  @GET('/Catalog_ХарактеристикиНоменклатуры')
  Future<CharacteristicListScheme> getCharacteristics({
    @Query('\$select')
    String select = 'Ref_Key,Description,Owner,НаименованиеДляПечати',
    @Query('\$format') String format = 'json',
  });

  @GET('/InformationRegister_ЦеныНоменклатуры')
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

  @GET('/Catalog_ТоварДляОбмена')
  Future<ProductImageListScheme> getProductImages({
    @Query('\$select')
    String select = 'Номенклатура_Key,Характеристика_Key,Фотография_Base64Data',
    @Query('\$format') String format = 'json',
  });

  @GET('/Catalog_КассыККМ')
  Future<CashRegisterListScheme> getCashRegisters({
    @Query('\$select') String select = 'Ref_Key,Description',
    @Query('\$format') String format = 'json',
  });
}
