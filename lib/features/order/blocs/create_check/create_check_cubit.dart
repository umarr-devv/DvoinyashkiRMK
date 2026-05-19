import 'package:app/blocs/blocs.dart';
import 'package:app/client/clients.dart';
import 'package:app/core/consts/consts.dart';
import 'package:app/features/order/blocs/blocs.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'create_check_cubit.g.dart';
part 'create_check_data.dart';
part 'create_check_state.dart';

class CreateCheckCubit extends Cubit<CreateCheckState> {
  CreateCheckCubit(
    this.settingsCubit,
    this.authCubit,
    this.sessionCubit,
    this.orderCubit,
    this.udsCustomerCubit,
    this.connectivityCubit,
  ) : super(CreateCheckInitial(paymentType: cashPaymentType));

  final SettingsCubit settingsCubit;
  final AuthCubit authCubit;
  final SessionCubit sessionCubit;
  final OrderCubit orderCubit;
  final UdsCustomerCubit udsCustomerCubit;
  final ConnectivityCubit connectivityCubit;

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
  String? get udsCode => udsCustomerCubit.state.code;

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

  void setDebtUser(Object user) {
    final newState = state.copyWith(debtUser: user);
    emit(CreateCheckUpdate(newState));
  }

  Future create() async {
    if (cashRegister == null ||
        author == null ||
        store == null ||
        subdivision == null ||
        user == null) {
      emit(CreateCheckSettingsFailure(state));
      return;
    }
    if (workShift == null || order == null) {
      emit(CreateCheckSessionFailure(state));
      return;
    }
    if (connectivityCubit.state is ConnectivityOffline) {
      emit(CreateCheckFailure(state));
      return;
    }
    emit(CreateCheckLoading(state));
    try {
      final CreateCheckScheme data = createCashScheme();
      final check = await client.createCheck(data: data);

      if (udsCode != null || udsCustomer != null) {
        try {
          await udsPoints();
          emit(CreateCheckUdsTransaction(state));
        } catch (exc) {
          await client.deleteCheck(refKey: check.refKey);
          emit(CreateCheckUdsFailure(state));
          return;
        }
      }

      for (final i in order!.items.where((i) => i.specification != null)) {
        await createProduction(i);
      }

      await client.postCheck(refKey: check.refKey);
      final newState = state.copyWith(
        check: check,
        debtUser: undefined,
        udsPoints: 0,
        totalSum: 0,
        customerPay: 0,
      );
      emit(CreateCheckLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(CreateCheckFailure(state));
    }
  }

  void saveOffline(OfflineChecksCubit offlineChecksCubit) {
    if (udsCustomer != null || udsCode != null) {
      emit(CreateCheckUdsOfflineNotSupported(state));
      return;
    }
    if (state.debtUser != null) {
      emit(CreateCheckDebtOfflineNotSupported(state));
      return;
    }
    final scheme = createCashScheme();
    offlineChecksCubit.addCheck(scheme);
    emit(CreateCheckOfflineSaved(state));
  }

  Future udsPoints() async {
    await udsClient.postTransaction(
      data: UDSTransactionScheme(
        code: udsCode!,
        cashier: UDSTransactionCashierScheme(
          externalId: (store?.udsUID.isNotEmpty ?? false)
              ? store!.udsUID
              : defaultUdsExternalId,
          name: store?.description ?? '',
        ),
        receipt: UDSTransactionReceiptScheme(
          total: state.totalSum,
          cash: state.totalSum - state.udsPoints,
          points: state.udsPoints,
        ),
      ),
    );
  }

  Future createProduction(OrderItem item) async {
    final response = await client.createProduction(
      data: CreateProductionScheme(
        date: DateTime.now(),
        structureUnitKey: store!.refKey,
        fromStructureUnitKey: store!.refKey,
        toStructureUnitKey: store!.refKey,
        items: [
          CreateProductionItemScheme(
            lineNumber: 1,
            nomenclatureKey: item.product.nomenclature.refKey,
            characteristicKey: item.product.characteristic?.refKey,
            quantity: item.quantity,
            unitKey: item.product.nomenclature.unitKey,
            key: 1,
            specificationKey: item.specification!.refKey,
          ),
        ],
        resources: item.specification!.items.map((i) {
          final index = item.specification!.items.indexOf(i);
          return CreateProductionResourceScheme(
            lineNumber: index + 1,
            nomenclatureKey: i.nomenclatureKey,
            characteristicKey: i.characteristicKey,
            quantity: i.quantity,
            unitKey: i.unitKey,
            key: index + 1,
          );
        }).toList(),
      ),
    );

    await client.postProduction(refKey: response.refKey);
  }

  CreateCheckScheme createCashScheme() {
    return CreateCheckScheme(
      date: DateTime.now(),
      authorKey: author!.refKey,
      cashRegisterKey: cashRegister!.refKey,
      userKey: user!.refKey,
      sessionKey: workShift!.refKey,
      sessionNumber: 1,
      udsCustomer: udsCustomer?.user.displayName,
      udsDiscountCode: udsCode,
      udsDiscount: 0,
      comment: null,
      responsibleKey: user!.refKey,
      subdivisionKey: subdivision!.refKey,
      customer: udsCustomer?.user.displayName,
      employeersDebtKey: state.paymentType == debtPaymentType
          ? state.debtUser?.refKey
          : null,
      debt: state.paymentType == debtPaymentType ? state.totalSum : 0,
      isCashlessPayment: false,
      cash: state.totalSumToPay,
      getCash: state.totalSumToPay,
      documentSum: state.totalSum,
      getCashless: 0,
      cashless: 0,
      udsPayment: state.udsPoints,
      paymentForm: state.paymentType == cashPaymentType
          ? CheckScheme.cashPaymentType
          : CheckScheme.cashlessPaymentType,
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
    );
  }
}
