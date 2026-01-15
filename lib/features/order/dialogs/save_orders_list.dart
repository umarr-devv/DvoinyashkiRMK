import 'package:app/blocs/blocs.dart';
import 'package:app/shared/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

class SaveOrderListDialog {
  const SaveOrderListDialog(this.rootContext);

  final BuildContext rootContext;

  void show() {
    showFDialog(
      context: rootContext,
      builder: (context, style, animation) {
        return BlocBuilder<OrderCubit, OrderState>(
          bloc: BlocProvider.of<OrderCubit>(rootContext),
          builder: (context, state) {
            return FDialog.raw(
              builder: (context, style) {
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      title(),
                      Expanded(child: saveOrdersList(state.saveOrders)),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget title() {
    return FHeader.nested(
      prefixes: [Icon(FIcons.save)],
      title: Text('Отложенные чеки'),
      titleAlignment: Alignment.centerLeft,
      suffixes: [
        FButton.icon(
          onPress: () {
            AutoRouter.of(rootContext).maybePop();
          },
          child: Icon(Icons.close),
        ),
      ],
    );
  }

  Widget saveOrdersList(List<OrderData> orders) {
    final cubit = BlocProvider.of<OrderCubit>(rootContext);
    return SingleChildScrollView(
      child: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        children: orders.map((i) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${DateFormat('HH:mm - dd.MM.yyyy').format(i.createAt)} - ${i.totalSum.toStringAsFixed(2)} с',
              ),
              Expanded(child: CustomDottedLine()),
              Row(
                spacing: 8,
                children: [
                  FButton.icon(
                    onPress: () {
                      cubit.setCurrentOrder(i);
                    },
                    style: FButtonStyle.outline(),
                    child: Icon(FIcons.download),
                  ),
                  FButton.icon(
                    onPress: () {
                      cubit.deleteSaveOrder(i);
                    },
                    style: FButtonStyle.destructive(),
                    child: Icon(FIcons.trash),
                  ),
                ],
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
