import 'dart:async';

import 'package:app/app.dart';
import 'package:app/client/clients.dart';
import 'package:app/data/repositories/repositories.dart';
import 'package:app/service/service.dart';
import 'package:app/windows/windows.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:scaled_app/scaled_app.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main(List<String> args) async {
  final talker = await initTalker();

  runZonedGuarded(
    () async {
      initScale();
      final windowController = await WindowController.fromCurrentEngine();
      if (windowController.arguments == 'customer') {
        await customerWindowInit();
        runApp(CustomerWindow());
        return;
      }

      await initDependencies(talker);
      await initWindow();
      runApp(AppScreen());
    },
    (exc, st) {
      talker.error(exc, st);
    },
  );
}

void initScale() {
  ScaledWidgetsFlutterBinding.ensureInitialized(
    scaleFactor: (deviceSize) {
      if (GetIt.I.isRegistered<GeneralStorage>()) {
        final storage = GetIt.I<GeneralStorage>();
        return storage.getValue(GeneralStorageKey.scale) ?? 1;
      } else {
        return 1;
      }
    },
  );
}

Future<Talker> initTalker() async {
  final talker = await TalkerConfigure.init();
  GetIt.I.registerSingleton<Talker>(talker);
  return talker;
}

Future initDependencies(Talker talker) async {
  await dotenv.load(fileName: ".env");

  final dio = DioConfigure.init(talker: talker);

  final secureStorage = SecureStorage();
  final generalStorage = GeneralStorage();

  secureStorage.init();
  await generalStorage.init();

  GetIt.I.registerSingleton<SecureStorage>(secureStorage);
  GetIt.I.registerSingleton<GeneralStorage>(generalStorage);

  final client = RestClient(dio);
  GetIt.I.registerSingleton<RestClient>(client);

  final udsClient = UDSClient(DioConfigure.initUDS());
  GetIt.I.registerSingleton<UDSClient>(udsClient);

  final window = WindowService();
  GetIt.I.registerSingleton<WindowService>(window);

  await HyratedStorageService.init();
}

Future initWindow() async {
  await windowManager.ensureInitialized();
  final windowsOptions = const WindowOptions(
    title: 'Двойняшкм РМК',
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );

  windowManager.waitUntilReadyToShow(windowsOptions, () async {
    await windowManager.maximize();
    await windowManager.show();
    await windowManager.focus();
  });
}
