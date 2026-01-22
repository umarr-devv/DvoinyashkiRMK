import 'package:app/blocs/blocs.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class SellHistoryHeader extends StatelessWidget {
  const SellHistoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return FHeader.nested(
      title: Text('Список чеков'),
      titleAlignment: Alignment.centerLeft,
      prefixes: [Icon(FluentIcons.receipt_24_regular, size: 28)],
      suffixes: [
        FButton.icon(
          onPress: () {
            AutoTabsRouter.of(context).setActiveIndex(0);
          },
          style: FButtonStyle.primary(),
          child: Icon(Icons.add),
        ),
        FButton.icon(
          onPress: () {
            BlocProvider.of<ChecksCubit>(context).update();
          },
          child: Icon(FIcons.refreshCw),
        ),
      ],
    );
  }
}
