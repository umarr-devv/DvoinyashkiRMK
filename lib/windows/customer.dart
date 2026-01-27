import 'package:app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:scaled_app/scaled_app.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';

class CustomerWindow extends StatelessWidget {
  const CustomerWindow({super.key});

  static Future<void> initWindow() async {
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

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).scale(),
      child: MaterialApp(
        theme: lightTheme.toTheme(),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Scaffold(body: Column(children: [
              

            ],
          ));
        },
      ),
    );
  }
}
