import 'package:app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:printing/printing.dart';

class PrinterSelect extends StatelessWidget {
  const PrinterSelect({super.key});

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
                description: Text('Для печати чеков и других данных'),
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
