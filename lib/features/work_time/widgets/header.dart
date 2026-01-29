import 'package:app/blocs/blocs.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class WorkTimeHeader extends StatelessWidget {
  const WorkTimeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return FHeader.nested(
      title: Text('Рабочее время'),
      titleAlignment: Alignment.centerLeft,
      prefixes: [Icon(FluentIcons.clock_24_regular, size: 28)],
      suffixes: [
        FButton.icon(
          onPress: () {
            BlocProvider.of<WorkShiftsCubit>(context).update();
            BlocProvider.of<SessionCubit>(context).getCurrentWorkShift();
          },
          child: Icon(FIcons.refreshCw),
        ),
      ],
    );
  }
}
