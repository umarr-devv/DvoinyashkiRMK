import 'package:desktop_multi_window/desktop_multi_window.dart';

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
}
