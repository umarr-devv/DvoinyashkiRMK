import 'package:app/blocs/blocs.dart';
import 'package:app/features/order/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

@RoutePage()
class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      child: Row(
        children: [
          Expanded(
            child: BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                if (state.useSmartCatalog) {
                  return const SmartCatalog();
                } else {
                  return const OrderCatalog();
                }
              },
            ),
          ),
          OrderBasket(),
          OrderScanner(),
        ],
      ),
    );
  }
}
