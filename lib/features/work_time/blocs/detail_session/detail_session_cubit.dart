import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/odata_query.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker/talker.dart';

part 'detail_session_state.dart';

class DetailSessionCubit extends Cubit<DetailSessionState> {
  DetailSessionCubit(this.sessionRefKey) : super(DetailSessionInitial());

  final String sessionRefKey;

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  Future<DetailSessionState?> update() async {
    emit(DetailSessionLoading(state));
    try {
      final workShift = await client.getWorkShift(refKey: sessionRefKey);

      final Map<String, dynamic> withdrawsParams = {
        '\$filter': 'ОтчетОРозничныхПродажах_Key eq guid\'$sessionRefKey\'',
        '\$format': 'json',
      };
      final withdraws = await client.getWithdraws(
        fullPath: buildODataQuery(withdrawsParams),
      );

      final Map<String, dynamic> warehouseItemsParams = {
        '\$filter':
            'СтруктурнаяЕдиница_Key eq guid\'${workShift.structureUnitKey}\'',
      };

      final Map<String, dynamic> cashParams = {
        '\$filter': 'КассаККМ_Key eq guid\'${workShift.cashRegisterKey}\'',
      };

      final startWarehouseItems = await client.getWarehouseItemsWithPeriod(
        period: workShift.workShiftStart,
        fullPath: buildODataQuery(warehouseItemsParams),
      );

      final startCash = await client.getCashWithPeriod(
        period: workShift.workShiftStart,
        fullPath: buildODataQuery(cashParams),
      );

      WarehouseItemListScheme? endWarehouseItems;
      CashListScheme? endCash;
      if (workShift.workShiftEnd != null) {
        final workShiftEnd = workShift.workShiftEnd!.add(Duration(minutes: 10));
        endWarehouseItems = await client.getWarehouseItemsWithPeriod(
          period: workShiftEnd,
          fullPath: buildODataQuery(warehouseItemsParams),
        );
        endCash = await client.getCashWithPeriod(
          period: workShiftEnd,
          fullPath: buildODataQuery(cashParams),
        );
      }

      final checks = await client.getChecks(
        fullPath: buildODataQuery({
          '\$filter':
              'КассоваяСмена_Key eq guid\'$sessionRefKey\' and Posted eq true',
          '\$format': 'json',
        }),
      );

      final newState = state.copyWith(
        workShift: workShift,
        withdraws: withdraws.withdraws,
        startWarehouseItems: startWarehouseItems.warehouseItems,
        endWarehouseItems: endWarehouseItems?.warehouseItems,
        startCashes: startCash.cashes,
        endCashes: endCash?.cashes,
        checks: checks.checks,
      );
      emit(DetailSessionLoaded(newState));
      return newState;
    } catch (exc, st) {
      talker.error(exc, st);
      emit(DetailSessionFailure(state));
      return null;
    }
  }
}
