import 'package:app/features/settings/dialogs/accept_cash_clearing.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TalkerScreen(talker: GetIt.I<Talker>()),
                ),
              );
            },
            style: FButtonStyle.secondary(),
            prefix: Icon(FluentIcons.folder_document_24_regular),
            child: Text('Логи'),
          ),
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
