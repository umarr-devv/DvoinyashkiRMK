import 'package:app/blocs/blocs.dart';
import 'package:app/core/consts/consts.dart';
import 'package:app/features/sell_history/blocs/detail_check/detail_check_cubit.dart';
import 'package:app/features/sell_history/dialogs/dialogs.dart';
import 'package:app/models/models.dart';
import 'package:app/service/print.dart';
import 'package:app/service/print_schemes/check.dart';
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
          return SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(state.check!),
                info(state.check!),
                itemsList(state.check!),
                DetailCheckFooter(
                  check: state.check!,
                  rootContext: rootContext,
                  cubit: cubit,
                ),
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
                          DataCell(
                            Text(item?.characteristic?.description ?? ''),
                          ),
                          DataCell(Text(i.price.toStringAsFixed(2))),
                          DataCell(Text(i.quantity.toStringAsFixed(2))),
                          DataCell(Text(i.itemSum.toStringAsFixed(2))),
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

  Widget info(DetailCheckScheme check) {
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(rootContext),
      builder: (context, state) {
        final user = state.users.firstWhereLogTypeOrNull(
          (i) => i.refKey == check.userKey,
        );
        final debtUser = state.users.firstWhereLogTypeOrNull(
          (i) => i.refKey == check.employeerDebtKey,
        );
        return Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
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

            FLabel(
              axis: Axis.vertical,
              label: Text('Кассир'),
              child: Text(user?.description ?? ''),
            ),

            if (check.udsClient.isNotEmpty)
              FLabel(
                axis: Axis.vertical,
                label: Text('UDS-клиент'),
                child: Text(check.udsClient),
              ),
            if (debtUser != null)
              FLabel(
                axis: Axis.vertical,
                label: Text('Сотрудник (в Долг)'),
                child: Text(debtUser.description),
              ),
            FLabel(
              axis: Axis.vertical,
              label: Text('Дата'),
              child: Text(DateFormat('HH:mm dd.MM.yyyy').format(check.date)),
            ),
          ],
        );
      },
    );
  }
}

class DetailCheckFooter extends StatefulWidget {
  const DetailCheckFooter({
    super.key,
    required this.check,
    required this.rootContext,
    required this.cubit,
  });

  final DetailCheckScheme check;
  final BuildContext rootContext;
  final DetailCheckCubit cubit;

  @override
  State<DetailCheckFooter> createState() => _DetailCheckFooterState();
}

class _DetailCheckFooterState extends State<DetailCheckFooter> {
  bool isUnposting = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (widget.check.posted)
          FButton(
            onPress: isUnposting
                ? null
                : () async {
                    final confirm = await showFDialog<bool>(
                      context: widget.rootContext,
                      builder: (context, style, animation) {
                        return FDialog(
                          title: const Text('Подтверждение'),
                          body: const Text('Вы уверены, что хотите выполнить полный возврат?'),
                          direction: Axis.horizontal,
                          actions: [
                            FButton(
                              onPress: () {
                                AutoRouter.of(context).maybePop(false);
                              },
                              style: FButtonStyle.outline(),
                              child: const Text('Отмена'),
                            ),
                            FButton(
                              onPress: () {
                                AutoRouter.of(context).maybePop(true);
                              },
                              child: const Text('Подтвердить'),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirm != true) return;

                    setState(() {
                      isUnposting = true;
                    });
                    try {
                      await widget.cubit.client.unpostCheck(
                        refKey: widget.check.refKey,
                      );
                      if (context.mounted) {
                        widget.rootContext.read<ChecksCubit>().update();
                        AutoRouter.of(widget.rootContext).maybePop();
                      }
                    } catch (e, st) {
                      widget.cubit.talker.error(e, st);
                    } finally {
                      if (context.mounted) {
                        setState(() {
                          isUnposting = false;
                        });
                      }
                    }
                  },
            prefix: isUnposting
                ? FCircularProgress()
                : const Icon(FluentIcons.arrow_hook_up_left_24_regular),
            style: FButtonStyle.secondary(),
            child: const Text('Полный возврат'),
          ),
        if (widget.check.posted)
          FButton(
            onPress: isUnposting
                ? null
                : () {
                    ReturnCheckDialog(
                      widget.rootContext,
                      check: widget.check,
                    ).show();
                  },
            prefix: const Icon(FluentIcons.arrow_hook_up_left_24_regular),
            style: FButtonStyle.secondary(),
            child: const Text('Частичный возврат'),
          ),
        FButton(
          onPress: isUnposting
              ? null
              : () {
                  PrintService().print(
                    PrintCheckScheme(
                      check: widget.check,
                      dataState: BlocProvider.of<DataCubit>(
                        widget.rootContext,
                      ).state,
                    ),
                    widget.rootContext,
                  );
                },
          prefix: const Icon(FluentIcons.print_24_regular),
          style: FButtonStyle.outline(),
          child: const Text('Печать'),
        ),
      ],
    );
  }
}
