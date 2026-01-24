import 'package:app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

class StaticticFilter extends StatelessWidget {
  const StaticticFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<StatisticCubit>(context);
    return BlocBuilder<StatisticCubit, StatisticState>(
      bloc: cubit,
      builder: (context, state) {
        return Row(
          spacing: 12,
          children: [
            SizedBox(
              width: 320,
              child: FDateField.calendar(
                control: FDateFieldControl.managed(
                  initial: state.startDate,
                  onChange: (value) {
                    if (value != null) {
                      cubit.setDate(startDate: value);
                    }
                  },
                ),
                start: DateTime.now().subtract(Duration(days: 90)),
                end: DateTime.now(),
                label: const Text('Начало'),
                format: DateFormat('dd.MM.yyyy'),
                hint: 'Выберите дату',
              ),
            ),
            SizedBox(
              width: 320,
              child: FDateField.calendar(
                control: FDateFieldControl.managed(
                  initial: state.endDate,
                  onChange: (value) {
                    if (value != null) {
                      cubit.setDate(endDate: value);
                    }
                  },
                ),
                start: state.startDate,
                end: DateTime.now(),
                label: const Text('Конец'),
                format: DateFormat('dd.MM.yyyy'),
                hint: 'Выберите дату',
              ),
            ),
          ],
        );
      },
    );
  }
}
