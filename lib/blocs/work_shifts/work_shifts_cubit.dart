import 'package:app/blocs/blocs.dart';
import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:talker/talker.dart';

part 'work_shifts_cubit.g.dart';
part 'work_shifts_state.dart';

class WorkShiftsCubit extends HydratedCubit<WorkShiftsState> {
  WorkShiftsCubit(this.settingsCubit) : super(WorkShiftsInitial());

  final SettingsCubit settingsCubit;

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  CashRegisterScheme? get cashRegister => settingsCubit.state.cashRegister;

  Future update() async {
    if (cashRegister == null) return;
    if (state is WorkShiftsLoading) return;
    emit(WorkShiftsLoading(state));
    try {
      final Map<String, dynamic> params = {
        '\$select':
            "Ref_Key,Number,Date,Posted,Ответственный_Key,Автор_Key,КассаККМ_Key,КассоваяСмена_Key,Комментарий,"
            "НачалоКассовойСмены,ОкончаниеКассовойСмены,СтатусКассовойСмены,Статья_Key,"
            "СтруктурнаяЕдиница_Key,СуммаДокумента",
        '\$top': state.limit.toString(),
        '\$skip': state.offset.toString(),
        '\$filter': 'КассаККМ_Key eq guid\'${cashRegister!.refKey}\'',
        '\$orderby': 'Date desc',
        '\$format': 'json',
      };

      final response = await client.getWorkShifts(
        fullPath: buildODataQuery(params),
      );
      final newState = state.copyWith(workShifts: response.workShifts);
      emit(WorkShiftsLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(WorkShiftsFailure(state));
    }
  }

  Future setPageNum(int pageNum) async {
    if (pageNum == state.pageNum) return;
    final newState = state.copyWith(pageNum: pageNum);
    emit(WorkShiftsUpdate(newState));
    await update();
  }

  @override
  WorkShiftsState? fromJson(Map<String, dynamic> json) {
    return WorkShiftsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(WorkShiftsState state) {
    return state.toJson();
  }
}
