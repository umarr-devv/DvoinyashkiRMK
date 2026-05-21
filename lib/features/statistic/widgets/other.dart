import 'package:app/blocs/blocs.dart';
import 'package:app/models/models.dart';
import 'package:app/service/print.dart';
import 'package:app/service/print_schemes/print_schemes.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:app/shared/widgets/dotted_line.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:talker/talker.dart';

class StatisticOther extends StatefulWidget {
  const StatisticOther({super.key});

  @override
  State<StatisticOther> createState() => _StatisticOtherState();
}

class _StatisticOtherState extends State<StatisticOther> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 560,
      height: double.infinity,
      child: FCard.raw(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: FButton(
                      onPress: () {
                        setState(() {
                          index = 0;
                        });
                      },
                      style: index == 0
                          ? FButtonStyle.primary()
                          : FButtonStyle.secondary(),
                      child: Text('Сотрудники'),
                    ),
                  ),
                  Expanded(
                    child: FButton(
                      onPress: () {
                        setState(() {
                          index = 1;
                        });
                      },
                      style: index == 1
                          ? FButtonStyle.primary()
                          : FButtonStyle.secondary(),
                      child: Text('Номенклатура'),
                    ),
                  ),
                  Expanded(
                    child: FButton(
                      onPress: () {
                        setState(() {
                          index = 2;
                        });
                      },
                      style: index == 2
                          ? FButtonStyle.primary()
                          : FButtonStyle.secondary(),
                      child: Text('Категории'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (index == 0) {
                    return Column(
                      children: [
                        Expanded(child: _StatisticUsers()),
                        _StatisticTotal(),
                      ],
                    );
                  } else if (index == 1) {
                    return _NomencaltureStatistic();
                  } else {
                    return _CategoryStatistic();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatisticUsers extends StatelessWidget {
  const _StatisticUsers();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<StatisticCubit, StatisticState>(
      bloc: BlocProvider.of<StatisticCubit>(context),
      builder: (context, state) {
        if (state is StatisticLoading) {
          return FCircularProgress();
        }
        final filtredUserSums = state.filtredUserSums;
        return BlocBuilder<DataCubit, DataState>(
          bloc: BlocProvider.of<DataCubit>(context),
          builder: (context, dataState) {
            return DataTable2(
              columnSpacing: 2,
              dividerThickness: 0,
              columns: [
                DataColumn2(label: SizedBox(), fixedWidth: 52),
                DataColumn2(label: Text('Сотрудник'), fixedWidth: 160),
                DataColumn2(label: Text('Кол-во чеков'), numeric: true),
                DataColumn2(label: Text('Сумма'), numeric: true),
              ],
              rows: filtredUserSums.map((userSum) {
                final user = dataState.users.firstWhereLogTypeOrNull(
                  (i) => i.refKey == userSum.userKey,
                );
                final int index = filtredUserSums.indexOf(userSum);
                return DataRow2(
                  onTap: () {},
                  cells: [
                    DataCell(
                      index <= 3
                          ? Icon(
                              FluentIcons.trophy_24_filled,
                              size: 24,
                              color: index == 0
                                  ? theme.custom.gold
                                  : index == 1
                                  ? theme.custom.silver
                                  : theme.custom.bronze,
                            )
                          : SizedBox(),
                    ),
                    DataCell(
                      Text(
                        user?.description ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    DataCell(Text(userSum.checkCount.toStringAsFixed(0))),
                    DataCell(
                      Text(
                        NumberFormat.currency(
                          symbol: '',
                        ).format(userSum.totalSum),
                      ),
                    ),
                  ],
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}

class _StatisticTotal extends StatelessWidget {
  const _StatisticTotal();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticCubit, StatisticState>(
      bloc: BlocProvider.of<StatisticCubit>(context),
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            spacing: 8,
            children: [
              StatisticTotalItem(
                label: Row(
                  spacing: 6,
                  children: [
                    Icon(FluentIcons.money_24_regular),
                    Text('Общий оборот'),
                  ],
                ),
                child: Text(
                  NumberFormat.currency(symbol: '').format(state.totalSum),
                ),
              ),
              StatisticTotalItem(
                label: Row(
                  spacing: 6,
                  children: [
                    Icon(FluentIcons.receipt_24_regular),
                    Text('Кол-во чеков'),
                  ],
                ),
                child: Text(state.checks.length.toStringAsFixed(0)),
              ),
              StatisticTotalItem(
                label: Row(
                  spacing: 6,
                  children: [
                    Icon(FluentIcons.receipt_money_24_regular),
                    Text('Средний чек'),
                  ],
                ),
                child: Text(
                  NumberFormat.currency(symbol: '').format(state.avgCheckSum),
                ),
              ),
              StatisticTotalItem(
                label: Row(
                  spacing: 6,
                  children: [
                    Icon(FluentIcons.person_24_regular),
                    Text('UDS-клиенты'),
                  ],
                ),
                child: Text(state.uniqueUdsClient.length.toStringAsFixed(0)),
              ),
              StatisticTotalItem(
                label: Row(
                  spacing: 6,
                  children: [
                    Icon(FluentIcons.person_24_regular),
                    Text('UDS-баллы'),
                  ],
                ),
                child: Text(NumberFormat().format(state.totalUdsPoints)),
              ),
              StatisticTotalItem(
                label: Row(
                  spacing: 6,
                  children: [
                    Icon(Icons.percent_rounded),
                    Text('Привлеченность UDS'),
                  ],
                ),
                child: Text('${(state.udsPercent * 100).toStringAsFixed(2)}%'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class StatisticTotalItem extends StatelessWidget {
  const StatisticTotalItem({
    super.key,
    required this.label,
    required this.child,
  });

  final Widget label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconTheme(
          data: IconThemeData(color: theme.custom.mutedForeground, size: 20),
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: theme.custom.mutedForeground,
            ),
            child: label,
          ),
        ),
        Expanded(child: CustomDottedLine()),
        DefaultTextStyle(
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: theme.custom.foreground,
          ),
          child: child,
        ),
      ],
    );
  }
}

class _NomencaltureStatistic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<StatisticCubit, StatisticState>(
      bloc: BlocProvider.of<StatisticCubit>(context),
      builder: (context, state) {
        if (state is StatisticAltLoading) {
          return FCircularProgress();
        }
        return BlocBuilder<DataCubit, DataState>(
          bloc: BlocProvider.of<DataCubit>(context),
          builder: (context, dataState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FButton(
                      style: FButtonStyle.secondary(),
                      onPress: () {
                        PrintService().print(
                          PrintStatisticNomenclatureScheme(
                            items: state.items,
                            dataState: dataState,
                          ),
                          context,
                        );
                      },
                      prefix: const Icon(
                        FluentIcons.print_24_regular,
                        size: 20,
                      ),
                      child: const Text('Печать'),
                    ),
                  ),
                ),
                Expanded(
                  child: DataTable2(
                    columnSpacing: 2,
                    dividerThickness: 0,
                    columns: [
                      DataColumn2(label: Text('Название'), fixedWidth: 160),
                      DataColumn2(label: Text('Характеристика')),
                      DataColumn2(label: Text('Кол-во'), numeric: true),
                      DataColumn2(label: Text('Сумма'), numeric: true),
                    ],
                    rows: state.items.map((item) {
                      final nomenclature = dataState.nomenclatures
                          .firstWhereLogTypeOrNull(
                            (i) => i.refKey == item.nomenclatureKey,
                          );
                      final characteristic = dataState.characteristics
                          .firstWhereLogTypeOrNull(
                            (i) => i.refKey == item.characteristicKey,
                          );
                      final int index = state.items.indexOf(item);
                      return DataRow2(
                        onTap: () {},
                        color: WidgetStatePropertyAll(
                          index.isOdd
                              ? theme.custom.rowOddColor
                              : theme.custom.rowEvenColor,
                        ),
                        cells: [
                          DataCell(Text(nomenclature?.name ?? '')),
                          DataCell(Text(characteristic?.description ?? '')),
                          DataCell(
                            Text(
                              NumberFormat.currency(
                                symbol: '',
                              ).format(item.totalQuantity),
                            ),
                          ),
                          DataCell(
                            Text(
                              NumberFormat.currency(
                                symbol: '',
                              ).format(item.totalSum),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _CategoryStatistic extends StatelessWidget {
  Map<String?, List<StatisticItemData>> getCategoryData(
    List<StatisticItemData> items,
    List<NomenclatureScheme> nomens,
  ) {
    final Map<String?, List<StatisticItemData>> data = {};

    for (final i in items) {
      final nomen = nomens.firstWhereLogTypeOrNull(
        (j) => j.refKey == i.nomenclatureKey,
      );
      if (nomen == null) {
        continue;
      }
      final groupKey = nomen.groupKey;
      data.putIfAbsent(groupKey, () => []);
      data[groupKey]!.add(i);
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<StatisticCubit, StatisticState>(
      bloc: BlocProvider.of<StatisticCubit>(context),
      builder: (context, state) {
        if (state is StatisticAltLoading) {
          return FCircularProgress();
        }
        return BlocBuilder<DataCubit, DataState>(
          bloc: BlocProvider.of<DataCubit>(context),
          builder: (context, dataState) {
            final data = getCategoryData(state.items, dataState.nomenclatures);
            return Column(
              children: [
                Padding(
                  padding: .all(8),
                  child: FButton(
                    onPress: () {
                      PrintService().print(
                        PrintStatisticCategoryScheme(
                          items: data,
                          dataState: dataState,
                        ),
                        context,
                      );
                    },
                    style: FButtonStyle.secondary(),
                    prefix: Icon(FluentIcons.print_24_regular),
                    child: Text('Печать'),
                  ),
                ),
                Expanded(
                  child: DataTable2(
                    columnSpacing: 2,
                    dividerThickness: 0,
                    columns: [
                      DataColumn2(label: Text('Название'), fixedWidth: 160),
                      DataColumn2(label: Text('Кол-во'), numeric: true),
                      DataColumn2(label: Text('Сумма'), numeric: true),
                    ],
                    rows: data.entries.map((item) {
                      final key = item.key;
                      final value = item.value;

                      final totalQuantity = value.fold(
                        0.0,
                        (a, b) => a + b.totalQuantity,
                      );
                      final totalSum = value.fold(
                        0.0,
                        (a, b) => a + b.totalSum,
                      );
                      final int index = data.keys.toList().indexOf(key);
                      final group = dataState.groups.firstWhereLogTypeOrNull(
                        (i) => i.refKey == key,
                      );
                      return DataRow2(
                        onTap: () {},
                        color: WidgetStatePropertyAll(
                          index.isOdd
                              ? theme.custom.rowOddColor
                              : theme.custom.rowEvenColor,
                        ),
                        cells: [
                          DataCell(
                            SelectableText(group?.name ?? 'Без категории'),
                          ),
                          DataCell(
                            Text(
                              NumberFormat.currency(
                                symbol: '',
                              ).format(totalQuantity),
                            ),
                          ),
                          DataCell(
                            Text(
                              NumberFormat.currency(
                                symbol: '',
                              ).format(totalSum),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
