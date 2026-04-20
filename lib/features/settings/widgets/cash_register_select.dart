import 'package:app/blocs/blocs.dart';
import 'package:app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class CashRegisterSelect extends StatelessWidget {
  const CashRegisterSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(context),
      builder: (context, state) {
        final cubit = BlocProvider.of<SettingsCubit>(context);
        return BlocBuilder<SettingsCubit, SettingsState>(
          bloc: cubit,
          builder: (context, settingsState) {
            return SizedBox(
              width: 320,
              child: FSelect<CashRegisterScheme>.searchBuilder(
                label: Text('Касса'),
                hint: 'Выберите кассу',
                contentEmptyBuilder: (context, style) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text('Ничего не найдено'),
                ),
                searchFieldProperties: FSelectSearchFieldProperties(
                  hint: 'Поиск',
                ),
                format: (value) => value.description,
                filter: (query) => state.cashRegisters,
                contentBuilder: (context, query, values) {
                  if (query.length < 2) {
                    return [];
                  }
                  return values
                      .where(
                        (i) => i.description.toLowerCase().contains(
                          query.toLowerCase(),
                        ),
                      )
                      .map(
                        (j) =>
                            FSelectItem(title: Text(j.description), value: j),
                      )
                      .toList();
                },
                control: FSelectControl.managed(
                  initial: settingsState.cashRegister,
                  onChange: (value) {
                    if (value != null && value != settingsState.cashRegister) {
                      cubit.setSettings(cashRegister: value);
                      BlocProvider.of<ChecksCubit>(context).update();
                      BlocProvider.of<WithdrawsCubit>(context).update();
                      BlocProvider.of<StatisticCubit>(context).update();
                      BlocProvider.of<WorkShiftsCubit>(context).update();
                      BlocProvider.of<SessionCubit>(
                        context,
                      ).getCurrentWorkShift();
                    }
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
