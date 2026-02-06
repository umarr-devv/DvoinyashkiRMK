import 'package:app/models/models.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

class DetailWithdrawDialog {
  DetailWithdrawDialog(this.rootContext, {required this.withdraw});

  final BuildContext rootContext;
  final WithdrawScheme withdraw;

  void show() {
    showFDialog(
      context: rootContext,
      builder: (context, style, animation) {
        return FDialog.raw(
          builder: (context, style) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24,
                children: [title(), body(), footer()],
              ),
            );
          },
        );
      },
    );
  }

  Widget title() {
    return FHeader.nested(
      prefixes: [Icon(FluentIcons.money_24_regular, size: 28)],
      title: Text(withdraw.number),
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

  Widget body() {
    return FLabel(
      label: Text('Сумма выемки'),
      axis: Axis.vertical,
      child: Text(
        NumberFormat.currency(
          symbol: '',
          decimalDigits: 0,
        ).format(withdraw.documentSum),
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget footer() {
    return Row(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FLabel(
          axis: Axis.vertical,
          label: Text('Статус'),
          child: Text(withdraw.posted ? 'Проведен' : 'Не проведен'),
        ),
        FLabel(
          axis: Axis.vertical,
          label: Text('Дата'),
          child: Text(DateFormat('HH:mm dd.MM.yyyy').format(withdraw.date)),
        ),
      ],
    );
  }
}
