import 'package:app/blocs/blocs.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class ClearBasketDialog {
  ClearBasketDialog(this.rootContext);

  final BuildContext rootContext;

  void show() {
    final cubit = BlocProvider.of<OrderCubit>(rootContext);
    showFDialog(
      context: rootContext,
      builder: (context, style, animation) {
        return FDialog(
          title: Text('Очистить корзину?'),
          body: Text('Вы уверены что хотите очистить корзину?'),
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
                cubit.clearItems();
                AutoRouter.of(context).maybePop();
              },
              style: FButtonStyle.destructive(),
              child: Text('Очистить'),
            ),
          ],
        );
      },
    );
  }
}
