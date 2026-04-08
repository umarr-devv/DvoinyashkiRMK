import 'package:app/blocs/blocs.dart';
import 'package:app/features/movement/dialogs/detail_transfer.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:collection/collection.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

class TransferTable extends StatelessWidget {
  const TransferTable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<TransfersCubit, TransfersState>(
      bloc: BlocProvider.of<TransfersCubit>(context),
      builder: (context, state) {
        if (state is TransfersLoading) {
          return const Center(child: FCircularProgress());
        }
        return BlocBuilder<DataCubit, DataState>(
          bloc: BlocProvider.of<DataCubit>(context),
          builder: (context, dataState) {
            return DataTable2(
              dividerThickness: 0,
              columnSpacing: 8,
              columns: const [
                DataColumn2(label: Text('Номер')),
                DataColumn2(label: Text('Сотрудник')),
                DataColumn2(label: Text('Оправитель')),
                DataColumn2(label: Text('Получатель')),
                DataColumn2(label: Text('Сумма'), numeric: true),
                DataColumn2(label: Text('Статус'), numeric: true),
                DataColumn2(label: Text('Дата'), numeric: true),
              ],
              rows: state.transfers.map((transfer) {
                final user = dataState.users.firstWhereOrNull(
                  (i) => i.refKey == transfer.authorKey,
                );
                final reserve = dataState.structureUnits.firstWhereOrNull(
                  (i) => i.refKey == transfer.senderUnitKey,
                );
                final recipient = dataState.structureUnits.firstWhereOrNull(
                  (i) => i.refKey == transfer.receiverUnitKey,
                );
                final rowIndex = state.transfers.indexOf(transfer);
                return DataRow2(
                  onTap: () {
                    DetailTransferDialog(
                      transfer: transfer,
                      rootContext: context,
                      isFromTable: true
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
                          Icon(FluentIcons.box_24_regular),
                          Expanded(child: Text(transfer.number)),
                        ],
                      ),
                    ),
                    DataCell(
                      Row(
                        spacing: 6,
                        children: [
                          Icon(FluentIcons.person_24_regular),
                          Text(user?.description ?? ''),
                        ],
                      ),
                    ),
                    DataCell(Text(reserve?.description ?? '')),
                    DataCell(Text(recipient?.description ?? '')),
                    DataCell(
                      Text(
                        NumberFormat.currency(
                          symbol: '',
                        ).format(transfer.documentAmount ?? 0),
                      ),
                    ),
                    DataCell(Text(transfer.isAccepted ? 'Принят' : 'Новый')),
                    DataCell(
                      Text(
                        DateFormat('HH:mm dd.MM.yyyy').format(transfer.date),
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
