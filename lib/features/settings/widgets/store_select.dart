import 'package:app/blocs/blocs.dart';
import 'package:app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class StoreSelect extends StatelessWidget {
  const StoreSelect({super.key});

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
              child: FSelect<StructureUnitScheme>.searchBuilder(
                label: Text('Магазина'),
                hint: 'Выберите магазин',
                control: FSelectControl.managed(
                  initial: settingsState.store,
                  onChange: (value) {
                    if (value != null) {
                      cubit.setSettings(store: value);
                      BlocProvider.of<MovementsCubit>(context).update();
                      BlocProvider.of<WarehouseCubit>(context).update();
                    }
                  },
                ),
                contentEmptyBuilder: (context, style) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text('Ничего не найдено'),
                ),
                searchFieldProperties: FSelectSearchFieldProperties(
                  hint: 'Поиск',
                ),
                format: (value) => value.description,
                filter: (query) => state.structureUnits,
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
              ),
            );
          },
        );
      },
    );
  }
}
