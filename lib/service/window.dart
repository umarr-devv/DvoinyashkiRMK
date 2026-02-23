import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:window_manager/window_manager.dart';

class WindowService {
  WindowController? window;

  Future _create() async {
    window = await WindowController.create(
      WindowConfiguration(hiddenAtLaunch: true, arguments: 'customer'),
    );
  }

  Future show() async {
    if (window == null) {
      await _create();
    }
    try {
      await window!.show();
    } catch (exc) {
      await _create();
      await window!.show();
    }
  }

  Future<void> sendData(String method, dynamic payload) async {
    if (window == null) return;
    try {
      final channel = WindowMethodChannel('channel');
      await channel.invokeMethod(method, payload);
    } catch (exc, st) {
      GetIt.I<Talker>().error(exc, st);
    }
  }

  static Future<List<Display>> getDisplays() async {
    return await screenRetriever.getAllDisplays();
  }

  static Future<void> moveToDisplay(Display display) async {
    Offset? targetOffset = display.visiblePosition;
    if (targetOffset != null) {
      await windowManager.setPosition(targetOffset, animate: true);
      await windowManager.setFullScreen(true);
    }
  }
}
