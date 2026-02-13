import 'package:app/blocs/blocs.dart';
import 'package:app/features/menu/widgets/customer_window.dart';
import 'package:app/features/order/blocs/blocs.dart';
import 'package:app/features/order/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  SettingsCubit get settingsCubit => BlocProvider.of<SettingsCubit>(context);
  AuthCubit get authCubit => BlocProvider.of<AuthCubit>(context);
  SessionCubit get sessionCubit => BlocProvider.of<SessionCubit>(context);
  OrderCubit get orderCubit => BlocProvider.of<OrderCubit>(context);

  final udsCustomerCubit = UdsCustomerCubit();

  late final CreateCheckCubit createCheckCubit;

  void initCubits() {
    createCheckCubit = CreateCheckCubit(
      settingsCubit,
      authCubit,
      sessionCubit,
      orderCubit,
      udsCustomerCubit,
    );
    createCheckCubit.init();
  }

  @override
  void initState() {
    super.initState();
    initCubits();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: udsCustomerCubit),
        BlocProvider.value(value: createCheckCubit),
      ],
      child: BlocListener<OrderCubit, OrderState>(
        bloc: orderCubit,
        listener: (context, state) {
          createCheckCubit.init();
        },
        child: Row(
          children: [
            CustomerWindowOperation(),
            Expanded(child: OrderCatalog()),
            OrderBasket(),
            OrderScanner(),
          ],
        ),
      ),
    );
  }
}
