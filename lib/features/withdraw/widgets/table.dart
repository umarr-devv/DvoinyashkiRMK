import 'package:app/blocs/blocs.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:talker/talker.dart';

class WithdrawTable extends StatelessWidget {
  const WithdrawTable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<WithdrawsCubit, WithdrawsState>(
      bloc: BlocProvider.of<WithdrawsCubit>(context),
      builder: (context, state) {
        if (state is WithdrawsLoading) {
          return FCircularProgress();
        }
        return BlocBuilder<CashRegistersCubit, CashRegistersState>(
          bloc: BlocProvider.of<CashRegistersCubit>(context),
          builder: (context, cashRegisterState) {
            return BlocBuilder<StructureUnitsCubit, StructureUnitsState>(
              bloc: BlocProvider.of<StructureUnitsCubit>(context),
              builder: (context, structureUnitState) {
                return DataTable2(
                  dividerThickness: 0,
                  columnSpacing: 8,
                  columns: [
                    DataColumn2(label: Text('Номер')),
                    DataColumn2(label: Text('Касса')),
                    DataColumn2(label: Text('Магазин')),
                    DataColumn2(label: Text('Подразделение')),
                    DataColumn2(label: Text('Сумма'), fixedWidth: 320),
                    DataColumn2(label: Text('Комментарий')),
                    DataColumn2(label: Text('Дата'), numeric: true),
                  ],
                  rows: state.withdraws.map((withdraw) {
                    final cashRegister = cashRegisterState.cashRegisters
                        .firstWhereLogTypeOrNull(
                          (i) => i.refKey == withdraw.cashRegisyerKey,
                        );
                    final store = structureUnitState.structureUnits
                        .firstWhereLogTypeOrNull(
                          (i) => i.refKey == withdraw.storeKey,
                        );
                    final subdivision = structureUnitState.structureUnits
                        .firstWhereLogTypeOrNull(
                          (i) => i.refKey == withdraw.subdivisionKey,
                        );
                    final rowIndex = state.withdraws.indexOf(withdraw);
                    return DataRow2(
                      onTap: () {},
                      color: WidgetStatePropertyAll(
                        rowIndex.isOdd
                            ? theme.custom.rowOddColor
                            : theme.custom.rowEvenColor,
                      ),
                      cells: [
                        DataCell(Text(withdraw.number)),
                        DataCell(Text(cashRegister?.description ?? '')),
                        DataCell(Text(store?.description ?? '')),
                        DataCell(Text(subdivision?.description ?? '')),
                        DataCell(Text(withdraw.documentSum.toStringAsFixed(2))),
                        DataCell(Text(withdraw.commentary)),
                        DataCell(
                          Text(
                            DateFormat(
                              'HH:mm dd.MM.yyyy',
                            ).format(withdraw.date),
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
      },
    );
  }
}
