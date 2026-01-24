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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 240,
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
                end: state.endDate,
                label: const Text('Начало'),
                format: DateFormat('dd.MM.yyyy'),
                hint: 'Выберите дату',
              ),
            ),
            SizedBox(
              width: 240,
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
            Expanded(child: SizedBox()),
            FButton(
              onPress: () {
                cubit.setDate(
                  startDate: DateTime.now().subtract(Duration(days: 31)),
                  endDate: DateTime.now(),
                );
              },
              style: FButtonStyle.outline(),
              child: Text('Месяц'),
            ),
            FButton(
              onPress: () {
                cubit.setDate(
                  startDate: DateTime.now().subtract(Duration(days: 7)),
                  endDate: DateTime.now(),
                );
              },
              style: FButtonStyle.outline(),
              child: Text('Неделя'),
            ),
            FButton(
              onPress: () {
                cubit.setDate(
                  startDate: DateTime.now().copyWith(
                    hour: 0,
                    minute: 0,
                    second: 0,
                  ),
                  endDate: DateTime.now().copyWith(
                    hour: 23,
                    minute: 59,
                    second: 59,
                  ),
                );
              },
              style: FButtonStyle.outline(),
              child: Text('Сегодня'),
            ),
          ],
        );
      },
    );
  }
}
