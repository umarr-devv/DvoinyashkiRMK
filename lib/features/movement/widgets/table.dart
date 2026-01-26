import 'package:app/blocs/blocs.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:talker/talker.dart';

class MovementTable extends StatelessWidget {
  const MovementTable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<MovementsCubit, MovementsState>(
      bloc: BlocProvider.of<MovementsCubit>(context),
      builder: (context, state) {
        if (state is MovementsLoading) {
          return FCircularProgress();
        }
        return BlocBuilder<DataCubit, DataState>(
          bloc: BlocProvider.of<DataCubit>(context),
          builder: (context, dataState) {
            return DataTable2(
              dividerThickness: 0,
              columnSpacing: 8,
              columns: [
                DataColumn2(label: Text('Номер')),
                DataColumn2(label: Text('Сотрудник')),
                DataColumn2(label: Text('Резерв')),
                DataColumn2(label: Text('Получатель')),
                DataColumn2(label: Text('Сумма'), numeric: true),
                DataColumn2(label: Text('Статус'), numeric: true),
                DataColumn2(label: Text('Дата'), numeric: true),
              ],
              rows: state.movements.map((movement) {
                final user = dataState.users.firstWhereLogTypeOrNull(
                  (i) => i.refKey == movement.userKey,
                );
                final reserve = dataState.structureUnits
                    .firstWhereLogTypeOrNull(
                      (i) => i.refKey == movement.reserveStructureUnitKey,
                    );
                final recipient = dataState.structureUnits
                    .firstWhereLogTypeOrNull(
                      (i) => i.refKey == movement.recipientStructureUnitKey,
                    );
                final status = state.statuses.firstWhereLogTypeOrNull(
                  (i) => i.refKey == movement.statusKey,
                );
                final rowIndex = state.movements.indexOf(movement);
                return DataRow2(
                  onTap: () {},
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
                          Expanded(child: Text(movement.number)),
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
                        ).format(movement.documentSum),
                      ),
                    ),
                    DataCell(Text(status?.description ?? '')),
                    DataCell(
                      Text(
                        DateFormat('HH:mm dd.MM.yyyy').format(movement.date),
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
