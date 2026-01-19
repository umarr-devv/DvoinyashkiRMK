import 'package:app/blocs/blocs.dart';
import 'package:app/features/sell_history/dialogs/detail_check.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:talker/talker.dart';

class SellHistoryTable extends StatelessWidget {
  const SellHistoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ChecksCubit, ChecksState>(
      bloc: BlocProvider.of<ChecksCubit>(context),
      builder: (context, state) {
        if (state is ChecksLoading) {
          return FCircularProgress();
        }
        return BlocBuilder<UsersCubit, UsersState>(
          bloc: BlocProvider.of<UsersCubit>(context),
          builder: (context, userStates) {
            return DataTable2(
              dividerThickness: 0,
              columns: [
                DataColumn2(label: Text('Номер')),
                DataColumn2(label: Text('Кассир')),
                DataColumn2(label: Text('Сумма')),
                DataColumn2(label: Text('Статус')),
                DataColumn2(label: Text('Тип оплаты')),
                DataColumn2(label: Text('Дата'), numeric: true),
              ],
              rows: state.checks.map((check) {
                final user = userStates.users.firstWhereLogTypeOrNull(
                  (user) => user.refKey == check.userKey,
                );
                final rowIndex = state.checks.indexOf(check);
                return DataRow2(
                  onTap: () {
                    DetailCheckDialog(
                      refKey: check.refKey,
                      rootContext: context,
                    ).show();
                  },
                  color: WidgetStatePropertyAll(
                    rowIndex.isOdd
                        ? theme.custom.rowOddColor
                        : theme.custom.rowEvenColor,
                  ),
                  cells: [
                    DataCell(Text(check.number)),
                    DataCell(Text(user?.description ?? '')),
                    DataCell(Text(check.documentSum.toStringAsFixed(0))),
                    DataCell(Text(check.status)),
                    DataCell(Text(check.paymentType)),
                    DataCell(
                      Text(DateFormat('HH:mm dd.MM.yyyy').format(check.date)),
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
