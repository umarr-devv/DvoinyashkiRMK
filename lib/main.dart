import 'dart:async';

import 'package:app/app.dart';
import 'package:app/client/client.dart';
import 'package:app/data/repositories/repositories.dart';
import 'package:app/service/service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      await initDependencies();
      runApp(AppScreen());
    },
    (exc, st) {
      GetIt.I<Talker>().error(exc, st);
    },
  );
}

Future initDependencies() async {
  final talker = TalkerConfigure.init();
  GetIt.I.registerSingleton<Talker>(talker);

  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  final dio = DioConfigure.init(talker: talker);
  GetIt.I.registerSingleton<Dio>(dio);

  final secureStorage = SecureStorage();
  final generalStorage = GeneralStorage();

  secureStorage.init();
  await generalStorage.init();

  GetIt.I.registerSingleton<SecureStorage>(secureStorage);
  GetIt.I.registerSingleton<GeneralStorage>(generalStorage);

  final client = RestClient(dio);
  GetIt.I.registerSingleton<RestClient>(client);

  await HyratedStorageService.init();

  await windowManager.ensureInitialized();

  final windowsOptions = const WindowOptions(
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );

  windowManager.waitUntilReadyToShow(windowsOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.maximize();
  });
}
