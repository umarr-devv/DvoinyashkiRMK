import 'package:app/features/order/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

@RoutePage()
class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      child: Row(
        children: [
          // CustomerWindowOperation(),
          Expanded(child: SmartCatalog()),
          OrderBasket(),
          OrderScanner(),
        ],
      ),
    );
  }
}
