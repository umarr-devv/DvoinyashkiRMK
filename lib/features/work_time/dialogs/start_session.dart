import 'package:app/blocs/blocs.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class StartSessionDialog {
  StartSessionDialog(this.rootContext);

  final BuildContext rootContext;

  void show() {
    showFDialog(
      context: rootContext,
      builder: (context, style, animation) {
        return FDialog(
          title: Text('Начать смену'),
          direction: Axis.horizontal,
          body: Text('Нажмитне кнопку "Начать", чтобы начать смену'),
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
                BlocProvider.of<SessionCubit>(context).start();
                BlocProvider.of<WorkShiftsCubit>(context).update();
                AutoRouter.of(context).maybePop();
              },
              style: FButtonStyle.primary(),
              child: Text('Начать'),
            ),
          ],
        );
      },
    );
  }
}
