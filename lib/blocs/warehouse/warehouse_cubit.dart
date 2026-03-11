import 'package:app/blocs/blocs.dart';
import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'warehouse_state.dart';

class WarehouseCubit extends Cubit<WarehouseState> {
  WarehouseCubit(this.settingsCubit) : super(WarehouseInitial());

  final SettingsCubit settingsCubit;

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  StructureUnitScheme? get storeKey => settingsCubit.state.store;

  Future update() async {
    if (storeKey == null) return;
    if (state is WarehouseLoading) return;
    emit(WarehouseLoading(state));
    try {
      final Map<String, dynamic> params = {
        '\$select': "Номенклатура_Key,Характеристика_Key,КоличествоBalance",
        '\$filter': 'СтруктурнаяЕдиница_Key eq guid\'${storeKey!.refKey}\'',
      };
      final response = await client.getWarehouseItems(
        fullPath: buildODataQuery(params),
      );
      final newState = state.copyWith(response.warehouseItems);
      emit(WarehouseLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(WarehouseFailure(state));
    }
  }
}
