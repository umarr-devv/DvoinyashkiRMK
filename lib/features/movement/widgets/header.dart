import 'package:app/blocs/blocs.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class MovementHeader extends StatelessWidget {
  const MovementHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return FHeader.nested(
      title: Text('Заказ'),
      titleAlignment: Alignment.centerLeft,
      prefixes: [Icon(FluentIcons.box_24_regular, size: 28)],
      suffixes: [
        FButton.icon(
          onPress: () {},
          style: FButtonStyle.primary(),
          child: Icon(Icons.add),
        ),
        FButton.icon(
          onPress: () {
            BlocProvider.of<MovementsCubit>(context).update();
          },
          child: Icon(FIcons.refreshCw),
        ),
      ],
    );
  }
}
