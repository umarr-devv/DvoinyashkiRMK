import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

class DioConfigure {
  static String url = dotenv.env['API']!;

  static Dio init({Talker? talker}) {
    final dio = Dio();
    dio.options.baseUrl = url;
    dio.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(printResponseData: false),
        talker: talker,
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) async {}),
    );
    return dio;
  }
}
