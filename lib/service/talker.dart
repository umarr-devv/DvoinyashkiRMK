import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerConfigure {
  static Future<Talker> init() async {
    final directory = await getApplicationDocumentsDirectory();
    final logFile = File('${directory.path}/rmk_logs.txt');

    if (await logFile.exists() && await logFile.length() > 5 * 1024 * 1024) {
      await logFile.delete();
    }

    return Talker(
      settings: TalkerSettings(
        enabled: true,
        useHistory: true,
        useConsoleLogs: true,
      ),
      observer: FileTalkerObserver(logFile),
    );
  }
}

class FileTalkerObserver extends TalkerObserver {
  FileTalkerObserver(this.file);
  final File file;

  @override
  void onLog(TalkerData log) => _save(log.generateTextMessage());

  @override
  void onError(TalkerError err) => _save(err.generateTextMessage());

  @override
  void onException(TalkerException exc) => _save(exc.generateTextMessage());

  void _save(String message) {
    final timestamp = DateTime.now().toIso8601String();
    file.writeAsStringSync(
      '[$timestamp] $message\n',
      mode: FileMode.append,
      flush: true,
    );
  }
}
