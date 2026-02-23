import 'package:app/blocs/blocs.dart';
import 'package:app/models/category.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class ProductionCategoriesDialog {
  ProductionCategoriesDialog(this.rootContext);

  final BuildContext rootContext;

  void show() {
    showFDialog(
      context: rootContext,
      builder: (context, style, animation) {
        return FDialog.raw(
          builder: (context, style) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [title(), body()],
              ),
            );
          },
        );
      },
    );
  }

  Widget title() {
    return FHeader.nested(
      title: Text('Категории для авто-сборки'),
      titleAlignment: Alignment.centerLeft,
      prefixes: [Icon(FIcons.coffee, size: 24)],
      suffixes: [
        FButton.icon(
          onPress: () {
            AutoRouter.of(rootContext).maybePop();
          },
          child: Icon(Icons.close),
        ),
      ],
    );
  }

  Widget body() {
    final cubit = BlocProvider.of<SettingsCubit>(rootContext);
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(rootContext),
      builder: (context, dataCubit) {
        return BlocBuilder<SettingsCubit, SettingsState>(
          bloc: cubit,
          builder: (context, state) {
            return FMultiSelect<CategoryScheme>.search(
              {for (var element in dataCubit.categories) element.name: element},
              control: FMultiValueControl.managed(
                initial: Set.from(state.productionCategories),
                onChange: (value) {
                  cubit.setSettings(productionCategories: value.toList());
                },
              ),
              label: Text('Категории'),
              searchFieldProperties: FSelectSearchFieldProperties(
                hint: 'Поиск',
              ),
              hint: Text('Выберите категорию'),
              description: Text(
                'Выбрите категории позиций, для которых будут списываться сырье по спецификации при продаже',
              ),
            );
          },
        );
      },
    );
  }
}
