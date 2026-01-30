import 'package:app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

class WorkTimeSession extends StatelessWidget {
  const WorkTimeSession({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SessionCubit>(context);
    return BlocBuilder<SessionCubit, SessionState>(
      bloc: cubit,
      builder: (context, state) {
        if (state.currentWorkShift != null) {
          return FCard(
            child: Row(
              spacing: 32,
              children: [
                FLabel(
                  label: Text('Текущая смена'),
                  axis: Axis.vertical,
                  child: Text(state.currentWorkShift!.number),
                ),
                FLabel(
                  label: Text('Статус'),
                  axis: Axis.vertical,
                  child: Text(state.currentWorkShift!.status),
                ),
                FLabel(
                  label: Text('Начало'),
                  axis: Axis.vertical,
                  child: Text(
                    DateFormat(
                      'HH:mm dd.MM.yyyy',
                    ).format(state.currentWorkShift!.workShiftStart),
                  ),
                ),
                Expanded(child: SizedBox()),
                FButton(
                  onPress: () {
                    cubit.end();
                  },
                  prefix: state is SessionLoading ? FCircularProgress() : null,
                  child: Text('Завершить'),
                ),
              ],
            ),
          );
        } else {
          return FCard(
            child: Row(
              children: [
                FLabel(
                  label: Text('Текущая смена'),
                  axis: Axis.vertical,
                  child: Text('Не начата'),
                ),
                Expanded(child: SizedBox()),
                FButton(
                  onPress: () {
                    cubit.start();
                  },
                  prefix: state is SessionLoading ? FCircularProgress() : null,
                  child: Text('Начать'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
