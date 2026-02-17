import 'package:app/blocs/blocs.dart';
import 'package:app/core/consts/consts.dart';
import 'package:app/features/movement/blocs/detail_movement/detail_movement_cubit.dart';
import 'package:app/features/sell_history/blocs/detail_check/detail_check_cubit.dart';
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

class DetailMovementDialog {
  DetailMovementDialog({required this.refKey, required this.rootContext})
    : cubit = DetailMovementCubit(refKey);

  final String refKey;
  final BuildContext rootContext;

  late final DetailMovementCubit cubit;

  void show() {
    cubit.update();
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
    return BlocBuilder<DetailMovementCubit, DetailMovementState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is DetailCheckLoading) {
          return Center(child: FCircularProgress());
        } else if (state.movement != null) {
          return Material(
            type: MaterialType.transparency,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title(state.movement!),
                  info(state.movement!),
                  itemsList(state.movement!),
                  footer(state.movement!),
                ],
              ),
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget title(DetailMovementScheme movement) {
    return FHeader.nested(
      prefixes: [Icon(FluentIcons.receipt_24_regular, size: 28)],
      title: Text(movement.number),
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

  Widget itemsList(DetailMovementScheme movement) {
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
                    rows: movement.items.map((i) {
                      final item = state.products.firstWhereLogTypeOrNull(
                        (k) =>
                            k.nomenclature.refKey == i.nomenclatureKey &&
                            (k.characteristic?.refKey == i.characteristicKey ||
                                i.characteristicKey == emptyRefKey),
                      );
                      final index = movement.items.indexOf(i);
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
                          DataCell(Text(i.totalSum.toStringAsFixed(2))),
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

  Widget info(DetailMovementScheme movement) {
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(rootContext),
      builder: (context, state) {
        final user = state.users.firstWhereLogTypeOrNull(
          (i) => i.refKey == movement.userKey,
        );
        final reserve = state.structureUnits.firstWhereLogTypeOrNull(
          (i) => i.refKey == movement.reserveStructureUnitKey,
        );
        final recipient = state.structureUnits.firstWhereLogTypeOrNull(
          (i) => i.refKey == movement.recipientStructureUnitKey,
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
              child: Text(DateFormat('HH:mm dd.MM.yyyy').format(movement.date)),
            ),
            FLabel(
              axis: Axis.vertical,
              label: Text('Дата получения'),
              child: Text(
                DateFormat('HH:mm dd.MM.yyyy').format(movement.movementDate),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget footer(DetailMovementScheme movement) {
    return Row(
      children: [
        FLabel(
          label: Text('Общая сумма'),
          axis: Axis.vertical,
          child: Text(
            NumberFormat().format(movement.documentSum),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
