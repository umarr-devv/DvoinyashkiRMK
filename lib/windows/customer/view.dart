import 'package:app/service/service.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:scaled_app/scaled_app.dart';

class CustomerWindow extends StatefulWidget {
  const CustomerWindow({super.key});

  @override
  State<CustomerWindow> createState() => _CustomerWindowState();
}

class _CustomerWindowState extends State<CustomerWindow> {
  String text = 'default';

  final channel = WindowMethodChannel('my_channel');

  @override
  void initState() {
    super.initState();

    channel.setMethodCallHandler((call) async {
      setState(() {
        text = call.method;
      });
    });
    print('ready');
    channel.invokeMethod('ready');
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).scale(),
      child: MaterialApp(
        theme: lightTheme.toTheme(),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Scaffold(body: Text(text));
        },
      ),
    );
  }
}
