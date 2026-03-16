import 'package:app/blocs/blocs.dart';
import 'package:app/features/work_time/blocs/blocs.dart';
import 'package:app/models/models.dart';
import 'package:app/service/print.dart';
import 'package:app/service/print_schemes/session.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:talker/talker.dart';

class DetailSessionDialog {
  DetailSessionDialog(this.rootContext, String refKey)
    : cubit = DetailSessionCubit(refKey);

  final BuildContext rootContext;
  final DetailSessionCubit cubit;

  void show() {
    cubit.update();
    showFDialog(
      context: rootContext,
      builder: (context, _, _) {
        return FDialog.raw(
          constraints: BoxConstraints(maxWidth: 1000),
          builder: (context, _) {
            return BlocBuilder<DetailSessionCubit, DetailSessionState>(
              bloc: cubit,
              builder: (context, state) {
                if (state is DetailSessionLoading) {
                  return SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: FCircularProgress(),
                  );
                } else if (state.workShift != null) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title(state.workShift!),
                        info(state),
                        items(state),
                        actions(),
                      ],
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            );
          },
        );
      },
    );
  }

  Widget title(DetailWorkShiftScheme workShift) {
    return FHeader.nested(
      prefixes: [Icon(FluentIcons.clock_24_regular, size: 28)],
      title: Text(workShift.number),
      titleAlignment: Alignment.centerLeft,
      suffixes: [
        FButton.icon(
          onPress: () {
            AutoRouter.of(rootContext).pop();
          },
          child: Icon(Icons.close),
        ),
      ],
    );
  }

  Widget info(DetailSessionState sessionState) {
    final workShift = sessionState.workShift!;
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(rootContext),
      builder: (context, state) {
        final user = state.users.firstWhereLogTypeOrNull(
          (i) => i.refKey == workShift.userKey,
        );
        final cashRegsiter = state.cashRegisters.firstWhereLogTypeOrNull(
          (i) => i.refKey == workShift.cashRegisterKey,
        );
        final store = state.structureUnits.firstWhereLogTypeOrNull(
          (i) => i.refKey == workShift.structureUnitKey,
        );
        return Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(),
            FLabel(
              label: Text('Начало смены'),
              axis: Axis.vertical,
              child: Text(
                DateFormat('HH:mm dd.mm.yyyy').format(workShift.workShiftStart),
              ),
            ),
            FLabel(
              label: Text('Конец смены'),
              axis: Axis.vertical,
              child: Text(
                workShift.workShiftEnd != null
                    ? DateFormat(
                        'HH:mm dd.mm.yyyy',
                      ).format(workShift.workShiftEnd!)
                    : '',
              ),
            ),
            FLabel(
              label: Text('Сотрудник'),
              axis: Axis.vertical,
              child: Text(user?.description ?? ''),
            ),
            FLabel(
              label: Text('Касса'),
              axis: Axis.vertical,
              child: Text(cashRegsiter?.description ?? ''),
            ),
            FLabel(
              label: Text('Магазин'),
              axis: Axis.vertical,
              child: Text(store?.description ?? ''),
            ),
            FLabel(
              label: Text('Статус'),
              axis: Axis.vertical,
              child: Text(workShift.status),
            ),
            FLabel(
              label: Text('Выручка'),
              axis: Axis.vertical,
              child: Text(NumberFormat().format(sessionState.revenue)),
            ),
            FLabel(
              label: Text('Наличная выручка'),
              axis: Axis.vertical,
              child: Text(NumberFormat().format(sessionState.cashRevenue)),
            ),
            FLabel(
              label: Text('Безналичная выручка'),
              axis: Axis.vertical,
              child: Text(NumberFormat().format(sessionState.cashlessRevenue)),
            ),
          ],
        );
      },
    );
  }

  Widget items(DetailSessionState state) {
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(rootContext),
      builder: (context, dataState) {
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _sectionButton(
              label: 'Выемки',
              icon: FluentIcons.money_24_regular,
              onTap: () => _showWithdrawsDialog(state.withdraws, dataState),
            ),
            _sectionButton(
              label: 'Начальный остаток денег',
              icon: FluentIcons.money_24_regular,
              onTap: () => _showCashInfoDialog(
                'Начальный остаток денег',
                state.startCashes,
                dataState,
              ),
            ),
            _sectionButton(
              label: 'Конечный остаток денег',
              icon: FluentIcons.money_24_regular,
              onTap: () => _showCashInfoDialog(
                'Конечный остаток денег',
                state.endCashes,
                dataState,
              ),
            ),
            _sectionButton(
              label: 'Проданные товары',
              icon: FluentIcons.cart_24_regular,
              onTap: () =>
                  _showSelledItemsDialog(state.workShift!, dataState),
            ),
            _sectionButton(
              label: 'Чеки',
              icon: FluentIcons.receipt_24_regular,
              onTap: () => _showChecksDialog(state.checks, dataState),
            ),
            _sectionButton(
              label: 'Начальные остатки',
              icon: FluentIcons.box_24_regular,
              onTap: () => _showWarehouseItemsDialog(
                'Начальные остатки',
                state.startWarehouseItems,
                dataState,
              ),
            ),
            _sectionButton(
              label: 'Конечные остатки',
              icon: FluentIcons.box_24_regular,
              onTap: () => _showWarehouseItemsDialog(
                'Конечные остатки',
                state.endWarehouseItems,
                dataState,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _sectionButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return FButton(
      style: FButtonStyle.outline(),
      prefix: Icon(icon),
      onPress: onTap,
      child: Text(label),
    );
  }

  void _showWithdrawsDialog(
    List<WithdrawScheme> withdraws,
    DataState state,
  ) {
    showFDialog(
      context: rootContext,
      builder: (context, _, _) {
        return FDialog.raw(
          constraints: BoxConstraints(maxWidth: 900),
          builder: (context, _) {
            return _buildTableDialog(
              icon: FluentIcons.money_24_regular,
              title: 'Выемки',
              child: SizedBox(
                height: 400,
                child: Material(
                  type: MaterialType.transparency,
                  child: DataTable2(
                    dividerThickness: 0,
                    headingRowHeight: 24,
                    columns: [
                      DataColumn2(label: Text('Номер документа')),
                      DataColumn2(label: Text('Касса')),
                      DataColumn2(label: Text('Магазин')),
                      DataColumn2(label: Text('Сумма'), numeric: true),
                      DataColumn2(label: Text('Дата'), numeric: true),
                    ],
                    rows: withdraws.map((withdraw) {
                      final cashReister =
                          state.cashRegisters.firstWhereLogTypeOrNull(
                        (i) => i.refKey == withdraw.cashRegisyerKey,
                      );
                      final store = state.structureUnits.firstWhereLogTypeOrNull(
                        (i) => i.refKey == withdraw.storeKey,
                      );
                      return DataRow2(
                        cells: [
                          DataCell(Text(withdraw.number)),
                          DataCell(Text(cashReister?.description ?? '')),
                          DataCell(Text(store?.description ?? '')),
                          DataCell(
                            Text(NumberFormat().format(withdraw.documentSum)),
                          ),
                          DataCell(
                            Text(
                              DateFormat('HH:mm dd.MM.yyyy').format(
                                withdraw.date,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showCashInfoDialog(
    String label,
    List<CashScheme> cashes,
    DataState state,
  ) {
    showFDialog(
      context: rootContext,
      builder: (context, _, _) {
        return FDialog.raw(
          constraints: BoxConstraints(maxWidth: 500),
          builder: (context, _) {
            return _buildTableDialog(
              icon: FluentIcons.money_24_regular,
              title: label,
              child: SizedBox(
                height: 200,
                child: Material(
                  type: MaterialType.transparency,
                  child: DataTable2(
                    dividerThickness: 0,
                    headingRowHeight: 32,
                    columns: [DataColumn2(label: Text('Сумма'))],
                    rows: cashes.map((item) {
                      return DataRow2(
                        cells: [
                          DataCell(Text(NumberFormat().format(item.value))),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showSelledItemsDialog(
    DetailWorkShiftScheme workShift,
    DataState state,
  ) {
    final theme = Theme.of(rootContext);
    showFDialog(
      context: rootContext,
      builder: (context, _, _) {
        return FDialog.raw(
          constraints: BoxConstraints(maxWidth: 1000),
          builder: (context, _) {
            return _buildTableDialog(
              icon: FluentIcons.cart_24_regular,
              title: 'Проданные товары',
              child: SizedBox(
                height: 600,
                child: Material(
                  type: MaterialType.transparency,
                  child: DataTable2(
                    dividerThickness: 0,
                    headingRowHeight: 32,
                    columns: [
                      DataColumn2(label: Text('Название')),
                      DataColumn2(label: Text('Характеристика')),
                      DataColumn2(label: Text('Кол-во'), numeric: true),
                      DataColumn2(label: Text('Цена'), numeric: true),
                      DataColumn2(label: Text('Сумма'), numeric: true),
                    ],
                    rows: workShift.items.map((item) {
                      final index = workShift.items.indexOf(item);
                      final nomenclature =
                          state.nomenclatures.firstWhereLogTypeOrNull(
                        (i) => i.refKey == item.nomenclatureKey,
                      );
                      final characteristic =
                          state.characteristics.firstWhereLogTypeOrNull(
                        (i) => i.refKey == item.characteristicKey,
                      );
                      return DataRow2(
                        color: WidgetStatePropertyAll(
                          index.isOdd
                              ? theme.custom.rowOddColor
                              : theme.custom.rowEvenColor,
                        ),
                        cells: [
                          DataCell(Text(nomenclature?.name ?? '')),
                          DataCell(Text(characteristic?.description ?? '')),
                          DataCell(
                            Text(NumberFormat().format(item.quantity)),
                          ),
                          DataCell(Text(NumberFormat().format(item.price))),
                          DataCell(
                            Text(NumberFormat().format(item.totalSum)),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showChecksDialog(List<CheckScheme> checks, DataState state) {
    final theme = Theme.of(rootContext);
    showFDialog(
      context: rootContext,
      builder: (context, _, _) {
        return FDialog.raw(
          constraints: BoxConstraints(maxWidth: 900),
          builder: (context, _) {
            return _buildTableDialog(
              icon: FluentIcons.receipt_24_regular,
              title: 'Чеки',
              child: SizedBox(
                height: 500,
                child: Material(
                  type: MaterialType.transparency,
                  child: DataTable2(
                    dividerThickness: 0,
                    headingRowHeight: 24,
                    columns: [
                      DataColumn2(label: Text('Номер')),
                      DataColumn2(label: Text('Тип оплаты')),
                      DataColumn2(label: Text('Сумма'), numeric: true),
                      DataColumn2(label: Text('Дата'), numeric: true),
                    ],
                    rows: checks.map((check) {
                      final index = checks.indexOf(check);
                      return DataRow2(
                        color: WidgetStatePropertyAll(
                          index.isOdd
                              ? theme.custom.rowOddColor
                              : theme.custom.rowEvenColor,
                        ),
                        cells: [
                          DataCell(Text(check.number)),
                          DataCell(Text(check.paymentType)),
                          DataCell(
                            Text(NumberFormat().format(check.documentSum)),
                          ),
                          DataCell(
                            Text(
                              DateFormat('HH:mm dd.MM.yyyy').format(check.date),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showWarehouseItemsDialog(
    String label,
    List<WarehouseItemScheme> items,
    DataState state,
  ) {
    final theme = Theme.of(rootContext);
    showFDialog(
      context: rootContext,
      builder: (context, _, _) {
        return FDialog.raw(
          constraints: BoxConstraints(maxWidth: 900),
          builder: (context, _) {
            return _buildTableDialog(
              icon: FluentIcons.box_24_regular,
              title: label,
              child: SizedBox(
                height: 600,
                child: Material(
                  type: MaterialType.transparency,
                  child: DataTable2(
                    dividerThickness: 0,
                    headingRowHeight: 32,
                    columns: [
                      DataColumn2(label: Text('Название')),
                      DataColumn2(label: Text('Характеристика')),
                      DataColumn2(label: Text('Кол-во'), numeric: true),
                    ],
                    rows: items.map((item) {
                      final index = items.indexOf(item);
                      final nomenclature =
                          state.nomenclatures.firstWhereLogTypeOrNull(
                        (i) => i.refKey == item.nomenclatureKey,
                      );
                      final characteristic =
                          state.characteristics.firstWhereLogTypeOrNull(
                        (i) => i.refKey == item.characteristicKey,
                      );
                      return DataRow2(
                        color: WidgetStatePropertyAll(
                          index.isOdd
                              ? theme.custom.rowOddColor
                              : theme.custom.rowEvenColor,
                        ),
                        cells: [
                          DataCell(Text(nomenclature?.name ?? '')),
                          DataCell(Text(characteristic?.description ?? '')),
                          DataCell(
                            Text(NumberFormat().format(item.quantity)),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTableDialog({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FHeader.nested(
            prefixes: [Icon(icon, size: 28)],
            title: Text(title),
            titleAlignment: Alignment.centerLeft,
            suffixes: [
              FButton.icon(
                onPress: () {
                  AutoRouter.of(rootContext).pop();
                },
                child: Icon(Icons.close),
              ),
            ],
          ),
          child,
        ],
      ),
    );
  }

  Widget actions() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FButton(
          onPress: () {
            PrintService(
              printerUrl: BlocProvider.of<SettingsCubit>(
                rootContext,
              ).state.printer,
            ).print(
              PrintSessionScheme(
                session: cubit.state,
                dataState: BlocProvider.of<DataCubit>(rootContext).state,
                context: rootContext,
              ),
              rootContext,
            );
          },
          child: Text('Печать'),
        ),
      ],
    );
  }
}
