import 'package:app/blocs/blocs.dart';
import 'package:app/service/service.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class NotificationSheetDialog {
  NotificationSheetDialog({required this.rootContext});

  final BuildContext rootContext;

  void show() {
    showFSheet(
      context: rootContext,
      side: FLayout.ltr,
      builder: (context) => body(),
    );
  }

  Widget body() {
    final theme = Theme.of(rootContext);
    return Container(
      padding: const EdgeInsets.all(8),
      height: double.infinity,
      width: 360,
      decoration: BoxDecoration(color: theme.custom.background),
      child: Column(
        children: [
          header(),
          Expanded(child: notifications()),
        ],
      ),
    );
  }

  Widget header() {
    final cubit = BlocProvider.of<NotificationCubit>(rootContext);
    return FHeader.nested(
      prefixes: [Icon(FluentIcons.alert_24_regular)],
      title: Text('Уведомления', style: TextStyle(fontSize: 18)),
      titleAlignment: Alignment.centerLeft,
      suffixes: [
        FButton.icon(
          onPress: () {
            cubit.clear();
          },
          style: FButtonStyle.destructive(),
          child: Icon(FIcons.trash),
        ),
        FButton.icon(
          onPress: () {
            AutoRouter.of(rootContext).maybePop();
          },
          child: Icon(Icons.close),
        ),
      ],
    );
  }

  Widget notifications() {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) {
            final toast = state.notifications[index];
            return ToastService.getToast(context, notification: toast);
          },
          separatorBuilder: (context, index) => SizedBox(height: 12),
          itemCount: state.notifications.length,
        );
      },
    );
  }
}
