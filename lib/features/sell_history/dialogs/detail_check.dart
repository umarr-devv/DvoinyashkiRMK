import 'package:app/blocs/blocs.dart';
import 'package:app/core/consts/consts.dart';
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

class DetailCheckDialog {
  DetailCheckDialog({required this.refKey, required this.rootContext})
    : cubit = DetailCheckCubit(refKey);

  final String refKey;
  final BuildContext rootContext;

  late final DetailCheckCubit cubit;

  void show() {
    cubit.forceUpdate();
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
    return BlocBuilder<DetailCheckCubit, DetailCheckState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is DetailCheckLoading) {
          return Center(child: FCircularProgress());
        } else if (state.check != null) {
          return Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                title(state.check!),
                Expanded(child: itemsList(state.check!)),
                footer(state.check!),
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget title(DetailCheckScheme check) {
    return FHeader.nested(
      prefixes: [Icon(FluentIcons.receipt_24_regular, size: 28)],
      title: Text(check.number),
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

  Widget itemsList(DetailCheckScheme check) {
    final theme = Theme.of(rootContext);
    return BlocBuilder<ProductsCubit, ProductsState>(
      bloc: BlocProvider.of<ProductsCubit>(rootContext),
      builder: (context, state) {
        return Material(
          type: MaterialType.transparency,
          child: DataTable2(
            dividerThickness: 0,
            columns: [
              DataColumn2(label: Text('Название'), fixedWidth: 320),
              DataColumn2(label: Text('Тип')),
              DataColumn2(label: Text('Цена'), numeric: true),
              DataColumn2(label: Text('Кол-во'), numeric: true),
              DataColumn2(label: Text('Сумма'), numeric: true),
            ],
            rows: check.items.map((i) {
              final item = state.products.firstWhereLogTypeOrNull(
                (k) =>
                    k.nomenclature.refKey == i.nomenclatureKey &&
                    (k.characteristic?.refKey == i.characteriticKey ||
                        i.characteriticKey == emptyRefKey),
              );
              final index = check.items.indexOf(i);
              return DataRow2(
                color: WidgetStatePropertyAll(
                  index.isOdd
                      ? theme.custom.rowOddColor
                      : theme.custom.rowEvenColor,
                ),
                cells: [
                  DataCell(Text(item?.nomenclature.name ?? '')),
                  DataCell(Text(item?.characteristic?.description ?? '')),
                  DataCell(Text(i.price.toStringAsFixed(2))),
                  DataCell(Text(i.quantity.toStringAsFixed(2))),
                  DataCell(Text(i.itemSum.toStringAsFixed(2))),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget footer(DetailCheckScheme check) {
    return Row(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FLabel(
          axis: Axis.vertical,
          label: Text('Сумма'),
          child: Text(check.documentSum.toStringAsFixed(2)),
        ),
        FLabel(
          axis: Axis.vertical,
          label: Text('Тип оплаты'),
          child: Text(check.paymentType),
        ),
        FLabel(
          axis: Axis.vertical,
          label: Text('Статус'),
          child: Text(check.status),
        ),
        BlocBuilder<UsersCubit, UsersState>(
          bloc: BlocProvider.of<UsersCubit>(rootContext),
          builder: (context, state) {
            final user = state.users.firstWhereLogTypeOrNull(
              (i) => i.refKey == check.userKey,
            );
            return FLabel(
              axis: Axis.vertical,
              label: Text('Кассир'),
              child: Text(user?.description ?? ''),
            );
          },
        ),
        FLabel(
          axis: Axis.vertical,
          label: Text('UDS-клиент'),
          child: Text(check.udsClient),
        ),
        FLabel(
          axis: Axis.vertical,
          label: Text('Дата'),
          child: Text(DateFormat('HH:mm dd.MM.yyyy').format(check.date)),
        ),
      ],
    );
  }
}
