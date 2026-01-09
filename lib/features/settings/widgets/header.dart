import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return FHeader.nested(
                prefixes: [
                  FButton.icon(
                    onPress: () {
                      AutoRouter.of(context).maybePop();
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                ],
                titleAlignment: Alignment.centerLeft,
                title: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    spacing: 8,
                    children: [Icon(FIcons.settings), Text('Настройки')],
                  ),
                ),
              );
  }
}