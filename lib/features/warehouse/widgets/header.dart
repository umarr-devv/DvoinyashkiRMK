import 'package:app/blocs/blocs.dart';
import 'package:app/features/warehouse/states/states.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class WarehouseHeader extends StatelessWidget {
  const WarehouseHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return FHeader.nested(
      prefixes: [Icon(FluentIcons.box_24_regular, size: 28)],
      title: Text('Склад'),
      titleAlignment: Alignment.centerLeft,
      suffixes: [
        SizedBox(
          width: 320,
          child: FTextField(
            prefixBuilder: (context, style, states) => Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Icon(FIcons.search),
            ),
            hint: 'Поиск',
            control: FTextFieldControl.managed(
              onChange: (value) {
                warehouseSearch.value = value.text;
              },
            ),
          ),
        ),
        FButton.icon(
          onPress: () {
            BlocProvider.of<WarehouseCubit>(context).update();
          },
          child: Icon(FIcons.refreshCw),
        ),
      ],
    );
  }
}
