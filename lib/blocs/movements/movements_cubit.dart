import 'package:app/blocs/blocs.dart';
import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:talker/talker.dart';

part 'movements_cubit.g.dart';
part 'movements_state.dart';

class MovementsCubit extends HydratedCubit<MovementsState> {
  MovementsCubit(this.settingsCubit) : super(MovementsInitial());

  final SettingsCubit settingsCubit;

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  StructureUnitScheme? get store => settingsCubit.state.store;

  Future update() async {
    if (store == null) return;
    emit(MovementsLoading(state));
    try {
      final Map<String, dynamic> params = {
        '\$select':
            "Ref_Key,Number,Date,Posted,Автор_Key,Ответственный_Key,"
            "СостояниеЗаказа_Key,СтруктурнаяЕдиницаРезерв_Key,"
            "СтруктурнаяЕдиницаПолучатель_Key,ДатаПеремещения,СуммаДокумента",
        '\$top': state.limit.toString(),
        '\$skip': state.offset.toString(),
        '\$filter':
            'СтруктурнаяЕдиницаПолучатель_Key eq guid\'${store!.refKey}\'',
        '\$orderby': 'Date desc',
        '\$format': 'json',
      };

      final movements = await client.getMovements(
        fullPath: buildODataQuery(params),
      );
      final statuses = await client.getMovementsStatuses();
      final newState = state.copyWith(
        movements: movements.movements,
        statuses: statuses.statuses,
      );
      emit(MovementsLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(MovementsFailure(state));
    }
  }

  Future setPageNum(int pageNum) async {
    if (pageNum == state.pageNum) return;
    final newState = state.copyWith(pageNum: pageNum);
    emit(MovementsUpdate(newState));
    await update();
  }

  @override
  MovementsState? fromJson(Map<String, dynamic> json) {
    return MovementsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(MovementsState state) {
    return state.toJson();
  }
}
