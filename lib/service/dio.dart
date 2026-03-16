import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:dio/io.dart';

class DioConfigure {
  static String url = dotenv.env['EXTERNAL_API_URL']!;
  static String authorization = dotenv.env['authorization']!;

  static String udsUrl = dotenv.env['UDS_API']!;
  static String udsAuthorization = dotenv.env['uds_authorization']!;

  static Future<Dio> init({Talker? talker}) async {
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
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      },
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
