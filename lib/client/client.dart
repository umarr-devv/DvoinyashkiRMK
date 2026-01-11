import 'package:app/models/models.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET('/Catalog_Сотрудники')
  Future<UserListSceheme> getUsers({
    @Query('\$select') String select = 'Ref_Key,Description,ИНН,ШтрихКод',
    @Query('\$format') String format = 'json',
  });
}
