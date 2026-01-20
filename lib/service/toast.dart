import 'package:app/shared/theme/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class ToastService {
  static FToastAlignment toastAlignment = FToastAlignment.bottomRight;

  static void showSuccesToast(
    BuildContext context, {
    IconData? icon,
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);
    showFToast(
      context: context,
      alignment: toastAlignment,
      icon: Icon(
        icon ?? FluentIcons.check_24_regular,
        color: theme.custom.success,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: theme.custom.success,
        ),
      ),
      description: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 400),
        child: Text(description),
      ),
      suffixBuilder: (context, entry) {
        return FButton.icon(
          onPress: entry.dismiss,
          style: FButtonStyle.ghost(),
          child: Icon(Icons.close, size: 20),
        );
      },
    );
  }

  static void showErrorToast(
    BuildContext context, {
    IconData? icon,
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);
    showFToast(
      context: context,
      alignment: toastAlignment,
      icon: Icon(
        icon ?? Icons.error_outline_rounded,
        color: theme.custom.destructiveTextForeground,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: theme.custom.destructiveTextForeground,
        ),
      ),
      description: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 400),
        child: Text(description),
      ),
      suffixBuilder: (context, entry) {
        return FButton.icon(
          onPress: entry.dismiss,
          style: FButtonStyle.ghost(),
          child: Icon(Icons.close, size: 20),
        );
      },
    );
  }

  static void showInfoToast(
    BuildContext context, {
    IconData? icon,
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);
    showFToast(
      context: context,
      alignment: toastAlignment,
      icon: Icon(icon ?? Icons.info_outline_rounded, color: theme.custom.info),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: theme.custom.info,
        ),
      ),
      description: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 400),
        child: Text(description),
      ),
      suffixBuilder: (context, entry) {
        return FButton.icon(
          onPress: entry.dismiss,
          style: FButtonStyle.ghost(),
          child: Icon(Icons.close, size: 20),
        );
      },
    );
  }
}
