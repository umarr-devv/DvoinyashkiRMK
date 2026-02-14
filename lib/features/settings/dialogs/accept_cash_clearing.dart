import 'package:app/blocs/blocs.dart';
import 'package:app/core/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class AcceptUpdateDialog {
  AcceptUpdateDialog(this.rootContext);

  final BuildContext rootContext;

  void show() {
    showFDialog(
      context: rootContext,
      builder: (context, style, animation) {
        return FDialog(
          title: Text('Обновить данные?'),
          body: Text(
            'После подтверждения данные загрузятся с сервера и обновятся',
          ),
          direction: Axis.horizontal,
          actions: [
            FButton(
              onPress: () {
                AutoRouter.of(context).maybePop();
              },
              style: FButtonStyle.outline(),
              child: Text('Отмена'),
            ),
            FButton(
              onPress: () {
                BlocProvider.of<DataCubit>(context).forceUpdate();
                BlocProvider.of<DataCubit>(context).forceUpdateImages();
                AutoRouter.of(context).replace(InitRoute());
              },
              style: FButtonStyle.primary(),
              child: Text('Обновить'),
            ),
          ],
        );
      },
    );
  }
}
