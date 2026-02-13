import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class CustomerWindowOperation extends StatefulWidget {
  const CustomerWindowOperation({super.key});

  @override
  State<CustomerWindowOperation> createState() =>
      _CustomerWindowOperationState();
}

class _CustomerWindowOperationState extends State<CustomerWindowOperation> {
  final channel = WindowMethodChannel('channel');

  final windowReady = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    channel.setMethodCallHandler((call) async {
      if (call.method == 'ready') {
        windowReady.value = true;
      }
    });
  }

  Future<void> sendData(String method, dynamic payload) async {
    if (!windowReady.value) return;
    await channel.invokeMethod(method, payload);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: windowReady,
      builder: (context, value, child) {
        if (value) {
          return FButton(onPress: () async {
            await sendData('update', []);
          }, child: Text('Обновить'));
        } else {
          return FButton(onPress: () {}, child: Text('Запустить'));
        }
      },
    );
  }
}
