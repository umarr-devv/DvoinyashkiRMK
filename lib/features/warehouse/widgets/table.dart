import 'package:app/blocs/blocs.dart';
import 'package:app/features/warehouse/states/states.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:app/shared/widgets/dotted_line.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/widgets/progress.dart';
import 'package:intl/intl.dart';

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
              return ValueListenableBuilder(
                valueListenable: warehouseSearch,
                builder: (context, value, child) {
                  final items = state.items.where((i) {
                    return i
                            .product(context)
                            ?.nomenclature
                            .description
                            ?.toLowerCase()
                            .contains(value.toLowerCase()) ??
                        false;
                  }).toList();
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final product = item.product(context);
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
                        title: Text(product?.nomenclature.description ?? ''),
                        subtitle: Text(
                          product?.characteristic?.description ?? '',
                        ),
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
                    itemCount: items.length,
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
