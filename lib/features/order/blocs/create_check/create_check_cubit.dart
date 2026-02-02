import 'package:app/blocs/blocs.dart';
import 'package:app/client/clients.dart';
import 'package:app/features/order/blocs/blocs.dart';
import 'package:app/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'create_check_data.dart';
part 'create_check_state.dart';

class CreateCheckCubit extends Cubit<CreateCheckState> {
  CreateCheckCubit(
    this.settingsCubit,
    this.authCubit,
    this.sessionCubit,
    this.orderCubit,
    this.udsCustomerCubit,
  ) : super(CreateCheckInitial(paymentType: cashPaymentType));

  final SettingsCubit settingsCubit;
  final AuthCubit authCubit;
  final SessionCubit sessionCubit;
  final OrderCubit orderCubit;
  final UdsCustomerCubit udsCustomerCubit;

  final client = GetIt.I<RestClient>();
  final udsClient = GetIt.I<UDSClient>();
  final talker = GetIt.I<Talker>();

  CashRegisterScheme? get cashRegister => settingsCubit.state.cashRegister;
  AuthorScheme? get author => settingsCubit.state.author;
  StructureUnitScheme? get store => settingsCubit.state.store;
  StructureUnitScheme? get subdivision => settingsCubit.state.subdivision;
  UserScheme? get user => authCubit.state.user;
  WorkShiftScheme? get workShift => sessionCubit.state.currentWorkShift;
  OrderData? get order => orderCubit.state.currentOrder;
  UDSCustomerScheme? get udsCustomer => udsCustomerCubit.state.customer;

  void init() {
    final newState = state.copyWith(
      totalSum: order?.totalSum ?? 0,
      customerPay: order?.totalSum ?? 0,
    );
    emit(CreateCheckUpdate(newState));
  }

  void setCustomerPay(double value) {
    final newState = state.copyWith(customerPay: value);
    emit(CreateCheckUpdate(newState));
  }

  void setPaymentType(PaymentTypeData paymentType) {
    final newState = state.copyWith(paymentType: paymentType);
    emit(CreateCheckUpdate(newState));
  }

  void setUdsPoints(double udsPoints) {
    final newState = state.copyWith(udsPoints: udsPoints);
    emit(CreateCheckUpdate(newState));
  }

  Future create() async {
    // if (cashRegister == null ||
    //     author == null ||
    //     store == null ||
    //     subdivision == null ||
    //     user == null ||
    //     workShift == null ||
    //     order == null) {
    //   return;
    // }
    emit(CreateCheckLoading(state));
    try {
      await Future.delayed(Duration(seconds: 2));

      emit(CreateCheckLoaded(state));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(CreateCheckFailure(state));
    }
  }

  Future _cashCheck() async {
    final response = await client.createCheck(
      data: CreateCheckScheme(
        date: DateTime.now(),
        authorKey: author!.refKey,
        cashRegisterKey: cashRegister!.refKey,
        userKey: user!.refKey,
        sessionKey: workShift!.cashRegisterShiftKey,
        sessionNumber: 1,
        udsCustomer: udsCustomer?.user.displayName,
        udsDiscountCode: '0',
        udsDiscount: 0,
        comment: null,
        responsibleKey: user!.refKey,
        subdivisionKey: subdivision!.refKey,
        customer: null,
        employeersDebtKey: null,
        cash: order!.totalSum,
        getCash: order!.totalSum,
        documentSum: order!.totalSum,
        getCashless: 0,
        cashless: 0,
        udsPayment: 0,
        paymentForm: CheckScheme.cashPaymentType,
        change: 0,
        storeKey: store!.refKey,
        items: order!.items.map((item) {
          final index = order!.items.indexOf(item);
          return CreateCheckItemScheme(
            lineNumber: index + 1,
            key: index + 1,
            nomenclatureKey: item.product.nomenclature.refKey,
            characteristicKey: item.product.characteristic?.refKey,
            quantity: item.quantity,
            price: item.price,
            totalSum: item.totalSum,
            allSum: item.totalSum,
            unitKey: item.product.nomenclature.unitKey,
          );
        }).toList(),
      ),
    );
    await client.postCheck(refKey: response.refKey);
  }
}
