import 'package:app/blocs/blocs.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:talker/talker.dart';

class WorkTimeTable extends StatelessWidget {
  const WorkTimeTable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(context),
      builder: (context, dataState) {
        return BlocBuilder<WorkShiftsCubit, WorkShiftsState>(
          bloc: BlocProvider.of<WorkShiftsCubit>(context),
          builder: (context, state) {
            if (state is WorkShiftsLoading) {
              return FCircularProgress();
            }
            return DataTable2(
              dividerThickness: 0,
              columnSpacing: 8,
              columns: [
                DataColumn2(label: Text('Номер')),
                DataColumn2(label: Text('Сотрудник')),
                DataColumn2(label: Text('Касса')),
                DataColumn2(label: Text('Начало'), numeric: true),
                DataColumn2(label: Text('Конец'), numeric: true),
                DataColumn2(label: Text('Статус'), numeric: true),
              ],
              rows: state.workShifts.map((workShift) {
                final index = state.workShifts.indexOf(workShift);
                final user = dataState.users.firstWhereLogTypeOrNull(
                  (i) => i.refKey == workShift.userKey,
                );
                final cashRegister = dataState.cashRegisters
                    .firstWhereLogTypeOrNull(
                      (i) => i.refKey == workShift.cashRegisterKey,
                    );
                return DataRow2(
                  color: WidgetStatePropertyAll(
                    index.isOdd
                        ? theme.custom.rowOddColor
                        : theme.custom.rowEvenColor,
                  ),
                  cells: [
                    DataCell(
                      Row(
                        spacing: 6,
                        children: [
                          Icon(FluentIcons.clock_24_regular),
                          Expanded(child: Text(workShift.number)),
                        ],
                      ),
                    ),
                    DataCell(
                      user != null
                          ? Row(
                              spacing: 6,
                              children: [
                                Icon(FluentIcons.person_24_regular),
                                Expanded(child: Text(user.description)),
                              ],
                            )
                          : SizedBox(),
                    ),
                    DataCell(Text(cashRegister?.description ?? '')),
                    DataCell(
                      Text(
                        DateFormat(
                          'HH:mm dd.MM.yyyy',
                        ).format(workShift.workShiftStart),
                      ),
                    ),
                    DataCell(
                      Text(
                        workShift.workShiftEnd != null
                            ? DateFormat(
                                'HH:mm dd.MM.yyyy',
                              ).format(workShift.workShiftEnd!)
                            : '',
                      ),
                    ),
                    DataCell(
                      Row(
                        spacing: 6,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            workShift.posted
                                ? Icons.check
                                : FluentIcons.clock_24_regular,
                            size: 20,
                          ),
                          Text(workShift.status),
                        ],
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
