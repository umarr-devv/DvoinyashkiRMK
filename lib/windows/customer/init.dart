import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';

Future<void> customerWindowInit() async {
  await windowManager.ensureInitialized();

  final windowsOptions = const WindowOptions(title: 'Двойняшкм РМК');

  windowManager.waitUntilReadyToShow(windowsOptions, () async {
    final screens = await screenRetriever.getAllDisplays();
    if (screens.length > 1) {
      final second = screens[1];
      await windowManager.setPosition(second.visiblePosition!);
      await windowManager.setSize(second.visibleSize!);
    }
    await windowManager.maximize();
    await windowManager.show();
  });
}
