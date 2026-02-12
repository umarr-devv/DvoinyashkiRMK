import 'package:app/blocs/blocs.dart';
import 'package:app/service/toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker/talker.dart';

class OrderScanner extends StatefulWidget {
  const OrderScanner({super.key});

  @override
  State<OrderScanner> createState() => _OrderScannerState();
}

class _OrderScannerState extends State<OrderScanner> {
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final orderCubit = BlocProvider.of<OrderCubit>(context);
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(context),
      builder: (context, dataState) {
        return BlocBuilder<OrderCubit, OrderState>(
          bloc: orderCubit,
          builder: (context, orderState) {
            return BarcodeKeyboardListener(
              onBarcodeScanned: (value) async {
                Focus.of(context).requestFocus(focusNode);
                if (value.length < 4) {
                  return;
                }
                if (!ModalRoute.of(context)!.isCurrent) {
                  return;
                }
                if (AutoTabsRouter.of(context).activeIndex != 0) {
                  return;
                }
                final product = dataState.products.firstWhereLogTypeOrNull(
                  (i) => i.barcodes.expand((i) => [i.barcode]).contains(value),
                );
                if (product != null) {
                  orderCubit.adaptiveAdd(
                    OrderItem(
                      product: product,
                      quantity: 1,
                      price: product.sellPrice?.price.price.toDouble() ?? 0,
                    ),
                    1,
                  );
                } else {
                  ToastService.showToast(
                    context,
                    notification: NotificationData(
                      type: NotificationType.error,
                      title: 'Не найдена номенклатура',
                      description:
                          'Номенклатура с штрихкодом $value не найдена',
                    ),
                  );
                }
              },
              child: SizedBox(),
            );
          },
        );
      },
    );
  }
}
