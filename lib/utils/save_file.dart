import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<String> saveImageToCache(Uint8List bytes, String fileName) async {
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}\\$fileName.png');

  if (!await file.exists()) {
    await file.writeAsBytes(bytes, flush: true);
  }

  return file.path;
}
