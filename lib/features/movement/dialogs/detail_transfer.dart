import 'package:app/blocs/blocs.dart';
import 'package:app/core/consts/consts.dart';
import 'package:app/features/movement/blocs/blocs.dart';
import 'package:app/models/models.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:talker_flutter/talker_flutter.dart';

class DetailTransferDialog {
  DetailTransferDialog({
    required this.transfer,
    required this.rootContext,
    required this.isFromTable,
  });

  final TransferScheme transfer;
  final BuildContext rootContext;
  final bool isFromTable;

  void show() {
    showFDialog(
      context: rootContext,
      builder: (context, style, animation) {
        return FDialog.raw(
          constraints: BoxConstraints(minWidth: 800, maxWidth: 1200),
          builder: (context, style) {
            return body();
          },
        );
      },
    );
  }

  Widget body() {
    return Material(
      type: MaterialType.transparency,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title(transfer),
            info(transfer),
            itemsList(transfer),
            footer(transfer),
          ],
        ),
      ),
    );
  }

  Widget title(TransferScheme transfer) {
    return FHeader.nested(
      prefixes: [Icon(FluentIcons.receipt_24_regular, size: 28)],
      title: Text(transfer.number),
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

  Widget itemsList(TransferScheme transfer) {
    final theme = Theme.of(rootContext);
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(rootContext),
      builder: (context, state) {
        return FAccordion(
          children: [
            FAccordionItem(
              title: Text('Запасы'),
              child: Material(
                type: MaterialType.transparency,
                child: SizedBox(
                  height: 400,
                  child: DataTable2(
                    dividerThickness: 0,
                    columns: [
                      DataColumn2(label: Text('Название'), fixedWidth: 320),
                      DataColumn2(label: Text('Тип')),
                      DataColumn2(label: Text('Цена'), numeric: true),
                      DataColumn2(label: Text('Кол-во'), numeric: true),
                      DataColumn2(label: Text('Сумма'), numeric: true),
                    ],
                    rows: transfer.inventory.map((i) {
                      final item = state.products.firstWhereLogTypeOrNull(
                        (k) =>
                            k.nomenclature.refKey == i.nomenclatureKey &&
                            (k.characteristic?.refKey == i.characteristicKey ||
                                i.characteristicKey == emptyRefKey),
                      );
                      final index = transfer.inventory.indexOf(i);
                      return DataRow2(
                        color: WidgetStatePropertyAll(
                          index.isOdd
                              ? theme.custom.rowOddColor
                              : theme.custom.rowEvenColor,
                        ),
                        cells: [
                          DataCell(Text(item?.nomenclature.name ?? '')),
                          DataCell(
                            Text(item?.characteristic?.description ?? ''),
                          ),
                          DataCell(Text(i.quantity.toStringAsFixed(2))),
                          DataCell(Text(i.price.toStringAsFixed(2))),
                          DataCell(Text(i.sum.toStringAsFixed(2))),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget info(TransferScheme transfer) {
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(rootContext),
      builder: (context, state) {
        final user = state.users.firstWhereLogTypeOrNull(
          (i) => i.refKey == transfer.employeeKey,
        );
        final reserve = state.structureUnits.firstWhereLogTypeOrNull(
          (i) => i.refKey == transfer.senderUnitKey,
        );
        final recipient = state.structureUnits.firstWhereLogTypeOrNull(
          (i) => i.refKey == transfer.receiverUnitKey,
        );
        return Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FLabel(
              axis: Axis.vertical,
              label: Text('Отправитель'),
              child: Text(reserve?.description ?? ''),
            ),
            FLabel(
              axis: Axis.vertical,
              label: Text('Получатель'),
              child: Text(recipient?.description ?? ''),
            ),

            FLabel(
              axis: Axis.vertical,
              label: Text('Сотрудник'),
              child: Text(user?.description ?? ''),
            ),
            FLabel(
              axis: Axis.vertical,
              label: Text('Дата создания'),
              child: Text(DateFormat('HH:mm dd.MM.yyyy').format(transfer.date)),
            ),
            FLabel(
              axis: Axis.vertical,
              label: Text('Дата получения'),
              child: Text(
                transfer.deliveryDeadline != null
                    ? DateFormat(
                        'HH:mm dd.MM.yyyy',
                      ).format(transfer.deliveryDeadline!)
                    : '',
              ),
            ),
          ],
        );
      },
    );
  }

  Widget footer(TransferScheme transfer) {
    final theme = Theme.of(rootContext);
    return BlocBuilder<TransferCubit, TransferState>(
      bloc: BlocProvider.of<TransferCubit>(rootContext),
      builder: (context, state) {
        return Row(
          spacing: 32,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FLabel(
              label: Text('Общая сумма'),
              axis: Axis.vertical,
              child: Text(
                NumberFormat().format(transfer.documentAmount),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
            FLabel(
              label: Text('Статус'),
              axis: Axis.vertical,
              child:
                  transfer.isAccepted ||
                      state is TransferUpdated ||
                      transfer.posted == true
                  ? Text(
                      'Принят',
                      style: TextStyle(
                        fontSize: 24,
                        color: theme.custom.success,
                      ),
                    )
                  : Text(
                      'Не принят',
                      style: TextStyle(
                        fontSize: 24,
                        color: theme.custom.destructiveTextForeground,
                      ),
                    ),
            ),
            Expanded(child: SizedBox()),
            if (!transfer.isAccepted &&
                state is! TransferUpdated &&
                !isFromTable)
              FButton(
                onPress: () {
                  showFDialog(
                    context: rootContext,
                    builder: (context, _, _) {
                      return FDialog(
                        title: Text('Принять перемещение?'),
                        direction: Axis.horizontal,
                        actions: [
                          FButton(
                            onPress: () {
                              AutoRouter.of(context).maybePop();
                            },
                            style: FButtonStyle.secondary(),
                            child: Text('Отмена'),
                          ),
                          FButton(
                            onPress: () {
                              BlocProvider.of<TransferCubit>(
                                rootContext,
                              ).accept();
                              AutoRouter.of(context).maybePop();
                            },
                            style: FButtonStyle.primary(),
                            child: Text('Принять'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Принять'),
              ),
          ],
        );
      },
    );
  }
}
