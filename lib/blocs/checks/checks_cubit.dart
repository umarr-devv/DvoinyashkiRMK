import 'package:app/blocs/blocs.dart';
import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:talker/talker.dart';

part 'checks_cubit.g.dart';
part 'checks_state.dart';

class ChecksCubit extends HydratedCubit<ChecksState> {
  ChecksCubit(this.settingsCubit) : super(ChecksInitial());

  final SettingsCubit settingsCubit;

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  CashRegisterScheme? get cashRegister => settingsCubit.state.cashRegister;

  Future update() async {
    if (cashRegister == null) return;
    emit(ChecksLoading(state));
    try {
      final Map<String, dynamic> params = {
        '\$select':
            "Ref_Key,Number,Date,КассаККМ_Key,Кассир_Key,КассоваяСмена_Key,КлиентUDS,КодСкидкиUDS,СкидкаUDS,СуммаОплатUDS,"
            "Наличные,ОбменИННКассира,ОбменМагазин,ПолученоНаличными,ПолученоЭлектронно,Сдача,Статус,СуммаВключаетНДС,СуммаДокумента,"
            "ФормаОплаты,СтруктурнаяЕдиница_Key",
        '\$top': state.limit.toString(),
        '\$skip': state.offset.toString(),
        '\$filter': 'КассаККМ_Key eq guid\'${cashRegister!.refKey}\'',
        '\$orderby': 'Date desc',
        '\$format': 'json',
      };

      final response = await client.getChecks(
        fullPath: buildODataQuery(params),
      );
      final newState = state.copyWith(checks: response.checks);
      emit(ChecksLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(ChecksFailure(state));
    }
  }

  Future setPageNum(int pageNum) async {
    if (pageNum == state.pageNum) return;
    final newState = state.copyWith(pageNum: pageNum);
    emit(ChecksUpdate(newState));
    await update();
  }

  @override
  ChecksState? fromJson(Map<String, dynamic> json) {
    return ChecksState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ChecksState state) {
    return state.toJson();
  }
}
