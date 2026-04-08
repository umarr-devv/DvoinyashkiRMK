import 'package:app/blocs/blocs.dart';
import 'package:app/features/movement/dialogs/create_movement.dart';
import 'package:app/features/movement/widgets/widgets.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class MovementHeader extends StatelessWidget {
  const MovementHeader({super.key, required this.tabIndex});

  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return FHeader.nested(
      title: Text(tabIndex == 0 ? 'Заказ' : 'Перемещение'),
      titleAlignment: Alignment.centerLeft,
      prefixes: const [Icon(FluentIcons.box_24_regular, size: 28)],
      suffixes: [
        TransferFindDialog(),
        FButton.icon(
          onPress: () {
            CreateMovementDialog(context).show();
          },
          style: FButtonStyle.primary(),
          child: const Icon(Icons.add),
        ),
        FButton.icon(
          onPress: () {
            if (tabIndex == 0) {
              BlocProvider.of<MovementsCubit>(context).update();
            } else {
              BlocProvider.of<TransfersCubit>(context).update();
            }
          },
          child: const Icon(FIcons.refreshCw),
        ),
      ],
    );
  }
}
