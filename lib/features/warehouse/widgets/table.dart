import 'package:app/blocs/blocs.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:app/shared/widgets/dotted_line.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/widgets/progress.dart';
import 'package:intl/intl.dart';
import 'package:talker/talker.dart';

class WarehouseTable extends StatelessWidget {
  const WarehouseTable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<DataCubit, DataState>(
      builder: (context, dataState) {
        return BlocBuilder<WarehouseCubit, WarehouseState>(
          builder: (context, state) {
            if (dataState is DataLoading || state is WarehouseLoading) {
              return FCircularProgress();
            } else {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  final nomen = dataState.nomenclatures.firstWhereLogTypeOrNull(
                    (i) => i.refKey == item.nomenclatureKey,
                  );
                  final char = dataState.characteristics
                      .firstWhereLogTypeOrNull(
                        (i) => i.refKey == item.characteristicKey,
                      );
                  return ListTile(
                    leading: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: theme.custom.muted,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(FluentIcons.image_24_regular, size: 28),
                    ),
                    title: Text(nomen?.name ?? ''),
                    subtitle: Text(char?.description ?? ''),
                    trailing: Text(
                      NumberFormat.decimalPattern().format(item.quantity),
                      style: TextStyle(
                        color: item.quantity < 0
                            ? theme.custom.destructiveTextForeground
                            : theme.custom.foreground,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, inedx) => CustomDottedLine(),
                itemCount: state.items.length,
              );
            }
          },
        );
      },
    );
  }
}
