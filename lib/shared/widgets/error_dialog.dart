import 'package:app/shared/theme/theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class ErrorDialog {
  ErrorDialog(
    this.rootContext, {
    required this.label,
    required this.description,
  });

  final BuildContext rootContext;
  final String label;
  final String description;

  void show() async {
    final theme = Theme.of(rootContext);
    showFDialog(
      context: rootContext,
      builder: (context, _, _) {
        return FDialog(
          title: Row(
            spacing: 6,
            children: [
              Icon(
                FluentIcons.error_circle_24_regular,
                color: theme.custom.destructiveTextForeground,
                size: 20,
              ),
              Text(
                label,
                style: TextStyle(color: theme.custom.destructiveTextForeground),
              ),
            ],
          ),
          body: Text(description),
          direction: Axis.horizontal,
          actions: [
            FButton(
              onPress: () {
                AutoRouter.of(context).maybePop();
              },
              style: FButtonStyle.outline(),
              child: Text('Назад'),
            ),
          ],
        );
      },
    );
  }
}
