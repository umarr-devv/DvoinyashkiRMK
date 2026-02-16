import 'dart:convert';

import 'package:app/blocs/blocs.dart';
import 'package:app/features/order/blocs/blocs.dart';
import 'package:app/service/window.dart';
import 'package:app/shared/icons/icons.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:app/shared/widgets/dotted_line.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:scaled_app/scaled_app.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CustomerWindow extends StatefulWidget {
  const CustomerWindow({super.key});

  @override
  State<CustomerWindow> createState() => _CustomerWindowState();
}

class _CustomerWindowState extends State<CustomerWindow> {
  final channel = WindowMethodChannel('channel');

  final order = ValueNotifier<OrderState?>(null);
  final data = ValueNotifier<DataState?>(null);
  final check = ValueNotifier<CreateCheckState?>(null);

  @override
  void initState() {
    super.initState();

    channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case ('update_order'):
          order.value = OrderState.fromJson(jsonDecode(call.arguments));
        case ('update_data'):
          data.value = DataState.fromJson(jsonDecode(call.arguments));
        case ('update_check'):
          check.value = CreateCheckState.fromJson(jsonDecode(call.arguments));
      }
    });
    channel.invokeMethod('ready');
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).scale(),
      child: MaterialApp(
        theme: lightTheme.toTheme(),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Scaffold(
            body: Column(
              children: [
                displays(),
                Expanded(child: table()),
                footer(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget displays() {
    return FutureBuilder<List<Display>>(
      future: WindowService.getDisplays(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return FCircularProgress();
        return Padding(
          padding: const EdgeInsets.only(top: 12, left: 16),
          child: Row(
            spacing: 12,
            children: snapshot.data!.map((display) {
              return FButton.icon(
                onPress: () async {
                  WindowService.moveToDisplay(display);
                },
                style: FButtonStyle.outline(),
                child: Text('Экран ${snapshot.data!.indexOf(display) + 1}'),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget footer() {
    final theme = Theme.of(context);
    return Column(
      children: [
        CustomDottedLine(),
        ValueListenableBuilder(
          valueListenable: check,
          builder: (context, value, child) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
              child: Row(
                spacing: 48,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      CustomIcons.icon(
                        size: 32,
                        color: theme.custom.secondaryAccent,
                      ),
                      CustomIcons.logo(color: theme.custom.secondaryAccent),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  FLabel(
                    label: Text('Тип оплаты'),
                    axis: Axis.vertical,
                    child: Text(
                      value?.paymentType.label ?? '',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  FLabel(
                    label: Text('UDS-баллы'),
                    axis: Axis.vertical,
                    child: Text(
                      NumberFormat().format(value?.udsPoints ?? 0),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  FLabel(
                    label: Text('Общая сумма'),
                    axis: Axis.vertical,
                    child: Text(
                      NumberFormat().format(value?.totalSum ?? 0),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  FLabel(
                    label: Text('К оплате'),
                    axis: Axis.vertical,
                    child: Text(
                      NumberFormat().format(value?.customerPay ?? 0),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget table() {
    final theme = Theme.of(context);
    return ValueListenableBuilder(
      valueListenable: data,
      builder: (context, dataValue, _) {
        return ValueListenableBuilder(
          valueListenable: order,
          builder: (context, value, child) {
            return DataTable2(
              dividerThickness: 0,
              columnSpacing: 8,
              columns: [
                DataColumn2(label: Text('Название')),
                DataColumn2(label: Text('Тип')),
                DataColumn2(label: Text('Ко-во'), numeric: true),
                DataColumn2(label: Text('Цена'), numeric: true),
                DataColumn2(label: Text('Сумма'), numeric: true),
              ],
              rows:
                  value?.currentOrder?.items.map((item) {
                    final index = value.currentOrder!.items.indexOf(item);
                    final nomenclature = dataValue?.nomenclatures
                        .firstWhereLogTypeOrNull(
                          (i) => i.refKey == item.product.nomenclature.refKey,
                        );
                    final characteristic = dataValue?.characteristics
                        .firstWhereLogTypeOrNull(
                          (i) =>
                              i.refKey == item.product.characteristic?.refKey,
                        );
                    return DataRow2(
                      color: WidgetStatePropertyAll(
                        index.isOdd
                            ? theme.custom.rowOddColor
                            : theme.custom.rowEvenColor,
                      ),
                      cells: [
                        DataCell(Text(nomenclature?.description ?? '')),
                        DataCell(Text(characteristic?.description ?? '')),
                        DataCell(Text(item.quantity.toString())),
                        DataCell(Text(item.price.toString())),
                        DataCell(Text(item.totalSum.toString())),
                      ],
                    );
                  }).toList() ??
                  [],
            );
          },
        );
      },
    );
  }
}
