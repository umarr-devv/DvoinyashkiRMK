import 'package:app/features/order/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // CustomerWindowOperation(),
        Expanded(child: OrderCatalog()),
        OrderBasket(),
        OrderScanner(),
      ],
    );
  }
}
