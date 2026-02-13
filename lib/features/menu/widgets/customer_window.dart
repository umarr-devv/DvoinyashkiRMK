import 'dart:convert';

import 'package:app/blocs/blocs.dart';
import 'package:app/features/order/blocs/blocs.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerWindowOperation extends StatefulWidget {
  const CustomerWindowOperation({super.key});

  @override
  State<CustomerWindowOperation> createState() =>
      _CustomerWindowOperationState();
}

class _CustomerWindowOperationState extends State<CustomerWindowOperation> {
  final channel = WindowMethodChannel('channel');

  final windowReady = ValueNotifier<bool>(false);

  void channelListener() {
    final dataCubit = BlocProvider.of<DataCubit>(context);
    final orderCubit = BlocProvider.of<OrderCubit>(context);
    final createCheckCubit = BlocProvider.of<CreateCheckCubit>(context);
    channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'ready':
          windowReady.value = true;
          await Future.delayed(const Duration(seconds: 1));
          await sendData(
            'update_data',
            jsonEncode(dataCubit.state.toJson()),
          );
          await sendData(
            'update_order',
            jsonEncode(orderCubit.state.toJson()),
          );
          await sendData(
            'update_order',
            jsonEncode(createCheckCubit.state.toJson()),
          );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    channelListener();
  }

  Future<void> sendData(String method, dynamic payload) async {
    if (!windowReady.value) return;
    await channel.invokeMethod(method, payload);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(context),
      listener: (context, dataState) async {
        await sendData('update_data', jsonEncode(dataState.toJson()));
      },
      child: BlocListener<OrderCubit, OrderState>(
        bloc: BlocProvider.of<OrderCubit>(context),
        listener: (context, orderState) async {
          await sendData('update_order', jsonEncode(orderState.toJson()));
        },
        child: BlocListener<CreateCheckCubit, CreateCheckState>(
          bloc: BlocProvider.of<CreateCheckCubit>(context),
          listener: (context, createCheckState) async {
             await sendData('update_check', jsonEncode(createCheckState.toJson()));
          },
          child: SizedBox(),
        ),
      ),
    );
  }
}
