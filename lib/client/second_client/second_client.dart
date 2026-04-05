import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'second_client.g.dart';

@RestApi()
abstract class SecondRestClient {
  factory SecondRestClient(Dio dio, {String? baseUrl}) = _SecondRestClient;

}
