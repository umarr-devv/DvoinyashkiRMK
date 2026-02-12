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
                        info(state.workShift!),
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

  Widget info(DetailWorkShiftScheme workShift) {
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
              label: Text('Оборот'),
              axis: Axis.vertical,
              child: Text(NumberFormat().format(workShift.documentSum)),
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
        return Material(
          type: MaterialType.transparency,
          child: FAccordion(
            children: [
              withdrawsItems(state.withdraws, dataState),
              cashInfo('Начальный остаток денег', state.startCashes, dataState),
              cashInfo('Конечный остаток денег', state.endCashes, dataState),
              selledItems(state.workShift!, dataState),
              warehouseItems(
                'Начальные остатки',
                state.startWarehouseItems,
                dataState,
              ),
              warehouseItems(
                'Конечный остатки',
                state.endWarehouseItems,
                dataState,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget warehouseItems(
    String label,
    List<WarehouseItemScheme> items,
    DataState state,
  ) {
    final theme = Theme.of(rootContext);
    return FAccordionItem(
      title: Text(label),
      child: SizedBox(
        height: 800,
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
            final nomenclature = state.nomenclatures.firstWhereLogTypeOrNull(
              (i) => i.refKey == item.nomenclatureKey,
            );
            final characteristic = state.characteristics
                .firstWhereLogTypeOrNull(
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
                DataCell(Text(NumberFormat().format(item.quantity))),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget cashInfo(String label, List<CashScheme> cashes, DataState state) {
    return FAccordionItem(
      title: Text(label),
      child: SizedBox(
        height: 100,
        child: DataTable2(
          dividerThickness: 0,
          headingRowHeight: 32,
          columns: [DataColumn2(label: Text('Сумма'))],
          rows: cashes.map((item) {
            return DataRow2(
              cells: [DataCell(Text(NumberFormat().format(item.value)))],
            );
          }).toList(),
        ),
      ),
    );
  }

  FAccordionItem selledItems(DetailWorkShiftScheme workShift, DataState state) {
    final theme = Theme.of(rootContext);
    return FAccordionItem(
      title: Text('Проданные товары'),
      child: SizedBox(
        height: 800,
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
            final nomenclature = state.nomenclatures.firstWhereLogTypeOrNull(
              (i) => i.refKey == item.nomenclatureKey,
            );
            final characteristic = state.characteristics
                .firstWhereLogTypeOrNull(
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
                DataCell(Text(NumberFormat().format(item.quantity))),
                DataCell(Text(NumberFormat().format(item.price))),
                DataCell(Text(NumberFormat().format(item.totalSum))),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget withdrawsItems(List<WithdrawScheme> withdraws, DataState state) {
    return FAccordionItem(
      title: Text('Выемки'),
      child: SizedBox(
        height: 200,
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
            final cashReister = state.cashRegisters.firstWhereLogTypeOrNull(
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
                DataCell(Text(NumberFormat().format(withdraw.documentSum))),
                DataCell(
                  Text(DateFormat('HH:mm dd.MM.yyyy').format(withdraw.date)),
                ),
              ],
            );
          }).toList(),
        ),
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
