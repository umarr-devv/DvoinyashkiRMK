import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

class DioConfigure {
  static String url = dotenv.env['API']!;
  static String authorization = dotenv.env['authorization']!;

  static String udsUrl = dotenv.env['UDS_API']!;
  static String udsAuthorization = dotenv.env['uds_authorization']!;

  static Dio init({Talker? talker}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: url,
        headers: {
          'Authorization': authorization,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
    dio.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(printResponseData: false),
        talker: talker,
      ),
    );
    return dio;
  }

  static Dio initUDS({Talker? talker}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: udsUrl,
        headers: {'Authorization': udsAuthorization},
      ),
    );
    dio.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(printResponseData: false),
        talker: talker,
      ),
    );
    return dio;
  }
}
