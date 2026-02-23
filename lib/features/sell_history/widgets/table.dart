import 'package:app/blocs/blocs.dart';
import 'package:app/features/sell_history/dialogs/detail_check.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
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
        return BlocBuilder<DataCubit, DataState>(
          bloc: BlocProvider.of<DataCubit>(context),
          builder: (context, userStates) {
            return DataTable2(
              dividerThickness: 0,
              columnSpacing: 8,
              columns: [
                DataColumn2(label: Text('Номер')),
                DataColumn2(label: Text('Кассир'), fixedWidth: 320),
                DataColumn2(label: Text('Тип оплаты')),
                DataColumn2(label: Text('Статус')),
                DataColumn2(label: Text('Клиент')),
                DataColumn2(label: Text('Сумма'), numeric: true),
                DataColumn2(label: Text('Дата'), numeric: true),
              ],
              rows: state.checks.map((check) {
                final user = userStates.users.firstWhereLogTypeOrNull(
                  (user) => user.refKey == check.userKey,
                );
                final employeer = userStates.users.firstWhereLogTypeOrNull(
                  (user) => user.refKey == check.employeerDebtKey,
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
                    DataCell(
                      Row(
                        spacing: 6,
                        children: [
                          Icon(FluentIcons.receipt_24_regular),
                          Expanded(child: Text(check.number)),
                        ],
                      ),
                    ),
                    DataCell(
                      user?.description != null
                          ? Row(
                              spacing: 6,
                              children: [
                                Icon(FluentIcons.person_24_regular),
                                Expanded(
                                  child: Text(
                                    user!.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(),
                    ),

                    DataCell(Text(check.paymentType)),
                    DataCell(
                      Row(
                        spacing: 4,
                        children: [
                          Icon(Icons.check),
                          Expanded(child: Text(check.status)),
                        ],
                      ),
                    ),
                    DataCell(
                      check.udsClient.isNotEmpty
                          ? Row(
                              spacing: 6,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(64),
                                  child: Image.asset(
                                    'assets/images/uds_icon.png',
                                    height: 24,
                                  ),
                                ),
                                Expanded(child: Text(check.udsClient)),
                              ],
                            )
                          : Text(employeer?.description ?? ''),
                    ),
                    DataCell(
                      Text(
                        NumberFormat.currency(
                          symbol: '',
                        ).format(check.documentSum),
                      ),
                    ),
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
