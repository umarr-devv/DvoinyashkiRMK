import 'package:app/blocs/blocs.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

class ToastService {
  static FToastAlignment toastAlignment = FToastAlignment.bottomLeft;
  static Duration toastDuration = Duration(seconds: 3);

  static IconData getDefaultIcon(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return Icons.check;
      case NotificationType.info:
        return FluentIcons.info_24_regular;
      case NotificationType.error:
        return FluentIcons.info_24_regular;
    }
  }

  static Color getColor(NotificationType type, ThemeData theme) {
    switch (type) {
      case NotificationType.success:
        return theme.custom.success;
      case NotificationType.info:
        return theme.custom.info;
      case NotificationType.error:
        return theme.custom.destructiveTextForeground;
    }
  }

  static void showToast(
    BuildContext context, {
    required NotificationData notification,
  }) {
    final cubit = BlocProvider.of<NotificationCubit>(context);
    showRawFToast(
      context: context,
      alignment: toastAlignment,
      duration: toastDuration,
      builder: (context, entry) {
        return getToast(context, notification: notification, entry: entry);
      },
    );
    cubit.add(notification);
  }

  static FToast getToast(
    BuildContext context, {
    required NotificationData notification,
    FToasterEntry? entry,
  }) {
    final theme = Theme.of(context);
    final defaultIcon = getDefaultIcon(notification.type);
    final color = getColor(notification.type, theme);
    return FToast(
      icon: Icon(notification.icon ?? defaultIcon, color: color, size: 32),
      title: Text(notification.title, style: TextStyle(color: color)),
      description: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 400),
        child: Text(notification.description),
      ),
      suffix: entry != null
          ? FButton.icon(
              onPress: entry.dismiss,
              style: FButtonStyle.ghost(),
              child: Icon(Icons.close, size: 20),
            )
          : Text(
              DateFormat('HH:mm:ss').format(notification.date),
              style: TextStyle(
                fontSize: 13,
                color: theme.custom.mutedForeground,
              ),
            ),
    );
  }
}
