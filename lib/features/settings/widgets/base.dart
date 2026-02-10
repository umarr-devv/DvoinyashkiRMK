import 'package:app/blocs/blocs.dart';
import 'package:app/models/models.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:printing/printing.dart';
import 'package:scaled_app/scaled_app.dart';

class SettingsBase extends StatelessWidget {
  const SettingsBase({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CashRegisterSelect(),
        _AuthorSelect(),
        _StoreSelect(),
        _SubdivisionSelect(),
        _PrinterSelect(),
        _ScaleSlider(),
        Row(),
      ],
    );
  }
}

class _CashRegisterSelect extends StatelessWidget {
  const _CashRegisterSelect();

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

class _StoreSelect extends StatelessWidget {
  const _StoreSelect();

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

class _SubdivisionSelect extends StatelessWidget {
  const _SubdivisionSelect();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(context),
      builder: (context, state) {
        final cubit = BlocProvider.of<SettingsCubit>(context);
        return BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, settingsState) {
            return SizedBox(
              width: 320,
              child: FSelect<StructureUnitScheme>.searchBuilder(
                label: Text('Подразделение'),
                hint: 'Выберите подразделение',
                control: FSelectControl.managed(
                  initial: settingsState.subdivision,
                  onChange: (value) {
                    if (value != null) {
                      cubit.setSettings(subdivision: value);
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

class _AuthorSelect extends StatelessWidget {
  const _AuthorSelect();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(context),
      builder: (context, state) {
        final cubit = BlocProvider.of<SettingsCubit>(context);
        return BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, settingsState) {
            return SizedBox(
              width: 320,
              child: FSelect<AuthorScheme>.searchBuilder(
                label: Text('Автор'),
                hint: 'Выберите автора',
                control: FSelectControl.managed(
                  initial: settingsState.author,
                  onChange: (value) {
                    if (value != null) {
                      cubit.setSettings(author: value);
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
                filter: (query) => state.authors,
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

class _PrinterSelect extends StatelessWidget {
  const _PrinterSelect();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SettingsCubit>(context);
    return BlocBuilder<SettingsCubit, SettingsState>(
      bloc: cubit,
      builder: (context, state) {
        return FutureBuilder(
          future: Printing.listPrinters(),
          builder: (context, asyncSnapshot) {
            if (!asyncSnapshot.hasData) {
              return SizedBox(height: 64);
            }
            return SizedBox(
              width: 320,
              child: FSelect<String>(
                label: Text('Принтер'),
                hint: 'Выберите принтер',
                control: FSelectControl.managed(
                  initial: state.printer,
                  onChange: (value) {
                    if (value != null) {
                      cubit.setSettings(printer: value);
                    }
                  },
                ),
                items: {
                  for (var element in asyncSnapshot.data ?? [])
                    element.name: element.url,
                },
              ),
            );
          },
        );
      },
    );
  }
}

class _ScaleSlider extends StatelessWidget {
  const _ScaleSlider();

  double sliderToPercent(double value) {
    return (75 + value * 50) / 100;
  }

  double percentToSlider(double percent) {
    return (percent * 100 - 75) / 50;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<SettingsCubit>(context);
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return SizedBox(
          width: 420,
          child: Row(
            spacing: 12,
            children: [
              Expanded(
                child: FSlider(
                  label: Text('Масштаб'),
                  control: FSliderControl.managedDiscrete(
                    initial: FSliderValue(max: percentToSlider(state.scale)),
                    onChange: (value) {
                      cubit.setSettings(scale: sliderToPercent(value.max));
                    },
                  ),
                  tooltipBuilder: (controller, value) {
                    return Text(
                      '${(sliderToPercent(value) * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: theme.custom.foreground,
                      ),
                    );
                  },
                  marks: const [
                    FSliderMark(value: 0, label: Text('75%')),
                    FSliderMark(value: 0.1),
                    FSliderMark(value: 0.2),
                    FSliderMark(value: 0.3),
                    FSliderMark(value: 0.4),
                    FSliderMark(value: 0.5, label: Text('100%')),
                    FSliderMark(value: 0.6),
                    FSliderMark(value: 0.7),
                    FSliderMark(value: 0.8),
                    FSliderMark(value: 0.9),
                    FSliderMark(value: 1, label: Text('125%')),
                  ],
                ),
              ),
              FButton.icon(
                onPress: () {
                  ScaledWidgetsFlutterBinding.instance.scaleFactor = (size) =>
                      state.scale;
                },
                child: Icon(Icons.restart_alt),
              ),
            ],
          ),
        );
      },
    );
  }
}
