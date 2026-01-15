import 'package:app/blocs/blocs.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class SaveOrderDialog {
  const SaveOrderDialog(this.rootContext);

  final BuildContext rootContext;

  void show() {
    final theme = Theme.of(rootContext);
    final cubit = BlocProvider.of<OrderCubit>(rootContext);
    showFDialog(
      context: rootContext,
      builder: (context, style, animation) {
        return FDialog(
          direction: Axis.horizontal,
          title: Text('Отложить чек'),
          body: Text(
            'Вы сможете в любой момент опять загрузить чек и продолжить с ним работать',
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
              onPress: () {
                cubit.saveOrder();
                AutoRouter.of(context).maybePop();
              },
              style: (style) => style.copyWith(
                decoration: FWidgetStateMap.all(
                  BoxDecoration(
                    color: theme.custom.info,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              child: Text(
                'Отложить',
                style: TextStyle(color: theme.custom.actionForeground),
              ),
            ),
          ],
        );
      },
    );
  }
}
