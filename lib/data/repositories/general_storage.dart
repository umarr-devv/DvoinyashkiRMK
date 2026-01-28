import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

enum GeneralStorageKey { scale }

class GeneralStorage {
  late final Box box;

  final String storageName = 'dvoinyashki_rmk';

  Future init() async {
    Directory? dir;

    if (!kIsWeb && (Platform.isWindows || Platform.isMacOS)) {
      dir = await getTemporaryDirectory();
    }
    await Hive.initFlutter(dir?.path);
    box = await Hive.openBox(storageName);
  }

  Future setValue(GeneralStorageKey key, dynamic value) async {
    await box.put(key.name, value);
  }

  dynamic getValue(GeneralStorageKey key) {
    return box.get(key.name);
  }

  Future write(String key, value) async {
    await box.put(key, value.toJson());
  }

  Map<String, dynamic>? read(String key) {
    return box.get(key) as Map<String, dynamic>?;
  }
}
