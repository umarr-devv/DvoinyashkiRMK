import 'package:app/features/settings/dialogs/accept_cash_clearing.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class SettingsFooter extends StatelessWidget {
  const SettingsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FButton(
            onPress: () {
              AcceptUpdateDialog(context).show();
            },
            style: FButtonStyle.outline(),
            prefix: Icon(Icons.sync),
            child: Text('Обновить данные'),
          ),
        ],
      ),
    );
  }
}
