import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'uds_client.g.dart';

@RestApi()
abstract class UDSClient {
  factory UDSClient(Dio dio, {String? baseUrl}) = _UDSClient;
}
