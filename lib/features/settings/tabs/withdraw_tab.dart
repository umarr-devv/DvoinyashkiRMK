import 'package:app/blocs/blocs.dart';
import 'package:app/models/cash_register.dart';
import 'package:app/utils/undefined.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class SettingsWithdrawTab extends StatelessWidget {
  const SettingsWithdrawTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      child: Padding(
        padding: .symmetric(vertical: 24, horizontal: 8),
        child: Column(children: [CafeCashRegisterSelect()]),
      ),
    );
  }
}

class CafeCashRegisterSelect extends StatelessWidget {
  const CafeCashRegisterSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(context),
      builder: (context, state) {
        final cubit = BlocProvider.of<SettingsCubit>(context);
        return BlocBuilder<SettingsCubit, SettingsState>(
          bloc: cubit,
          builder: (context, settingsState) {
            return Row(
              crossAxisAlignment: .start,
              spacing: 12,
              children: [
                SizedBox(
                  width: 320,
                  child: FSelect<CashRegisterScheme>.searchBuilder(
                    label: Text('Касса для бара'),
                    description: Text(
                      'Эта касса будет использована для создания выемки для дополнительной точки продаж (бар)',
                    ),
                    hint: 'Выберите кассу для бара',
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
                            (j) => FSelectItem(
                              title: Text(j.description),
                              value: j,
                            ),
                          )
                          .toList();
                    },
                    control: FSelectControl.lifted(
                      value: settingsState.cafeCashRegister,
                      onChange: (value) {
                        if (value != null) {
                          cubit.setSettings(cafeCashRegister: value);
                        }
                      },
                    ),
                  ),
                ),
                FLabel(
                  label: Text(''),
                  axis: .vertical,
                  child: FButton.icon(
                    onPress: () {
                      cubit.setSettings(cafeCashRegister: undefined);
                    },
                    child: Icon(FIcons.x),
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
