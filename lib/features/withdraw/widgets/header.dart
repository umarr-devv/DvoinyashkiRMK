import 'package:app/blocs/blocs.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class WithdrawHeader extends StatelessWidget {
  const WithdrawHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return FHeader.nested(
      title: Text('Выемки'),
      titleAlignment: Alignment.centerLeft,
      prefixes: [Icon(FluentIcons.money_24_regular, size: 28)],
      suffixes: [
        FButton.icon(
          onPress: () {},
          style: FButtonStyle.primary(),
          child: Icon(Icons.add),
        ),
        FButton.icon(
          onPress: () {
            BlocProvider.of<WithdrawsCubit>(context).update();
          },
          child: Icon(FIcons.refreshCw),
        ),
      ],
    );
  }
}
