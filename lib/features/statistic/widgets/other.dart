import 'package:app/blocs/blocs.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:app/shared/widgets/dotted_line.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:talker/talker.dart';

class StatisticOther extends StatelessWidget {
  const StatisticOther({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 480,
      height: double.infinity,
      child: FCard.raw(
        child: Column(
          children: [
            Expanded(child: _StatisticUsers()),
            _StatisticTotal(),
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
              _StatisticTotalItem(
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
              _StatisticTotalItem(
                label: Row(
                  spacing: 6,
                  children: [
                    Icon(FluentIcons.receipt_24_regular),
                    Text('Кол-во чеков'),
                  ],
                ),
                child: Text(state.checks.length.toStringAsFixed(0)),
              ),
              _StatisticTotalItem(
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
              _StatisticTotalItem(
                label: Row(
                  spacing: 6,
                  children: [
                    Icon(FluentIcons.person_24_regular),
                    Text('UDS-клиенты'),
                  ],
                ),
                child: Text(state.uniqueUdsClient.length.toStringAsFixed(0)),
              ),
              _StatisticTotalItem(
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

class _StatisticTotalItem extends StatelessWidget {
  const _StatisticTotalItem({required this.label, required this.child});

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
