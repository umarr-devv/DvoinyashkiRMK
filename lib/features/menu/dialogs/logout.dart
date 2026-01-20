import 'package:app/blocs/auth/auth_cubit.dart';
import 'package:app/blocs/notification/notification_cubit.dart';
import 'package:app/service/toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class LogoutDialog {
  void show(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    showFDialog(
      context: context,
      builder: (context, style, animation) {
        return FDialog(
          direction: Axis.horizontal,
          title: Text('Вы хотите выйти из своей учетной записи?'),
          body: Text(
            'Некоторые действия могут быть прерваны из-за выхода из учетной системы',
          ),
          actions: [
            FButton(
              onPress: () {
                AutoRouter.of(context).maybePop();
              },
              style: FButtonStyle.outline(),
              child: Text('Отмена'),
            ),
            FButton(
              onPress: () async {
                ToastService.showToast(
                  context,
                  notification: NotificationData(
                    type: NotificationType.error,
                    icon: FIcons.logOut,
                    title: 'Выход',
                    description: 'Выход из учетной записи',
                  ),
                );
                await cubit.logout();
              },
              style: FButtonStyle.destructive(),
              child: Text('Выйти'),
            ),
          ],
        );
      },
    );
  }
}
