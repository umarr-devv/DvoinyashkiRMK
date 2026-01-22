import 'package:app/blocs/blocs.dart';
import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:talker/talker.dart';

part 'withdraws_cubit.g.dart';
part 'withdraws_state.dart';

class WithdrawsCubit extends HydratedCubit<WithdrawsState> {
  WithdrawsCubit(this.settingsCubit) : super(WithdrawsInitial());

  final SettingsCubit settingsCubit;

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  CashRegisterScheme? get cashRegister => settingsCubit.state.cashRegister;

  Future update() async {
    if (cashRegister == null) return;
    emit(WithdrawsLoading(state));
    try {
      final Map<String, dynamic> params = {
        '\$top': state.limit.toString(),
        '\$skip': state.offset.toString(),
        '\$filter': 'КассаККМ_Key eq guid\'${cashRegister!.refKey}\'',
        '\$orderby': 'Date desc',
        '\$format': 'json',
      };

      final response = await client.getWithdraws(
        fullPath: buildODataQuery(params),
      );
      final newState = state.copyWith(withdraws: response.withdraws);
      emit(WithdrawsLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(WithdrawsFailure(state));
    }
  }

  Future setPageNum(int pageNum) async {
    if (pageNum == state.pageNum) return;
    final newState = state.copyWith(pageNum: pageNum);
    emit(WithdrawsUpdate(newState));
    await update();
  }

  @override
  WithdrawsState? fromJson(Map<String, dynamic> json) {
    return WithdrawsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(WithdrawsState state) {
    return state.toJson();
  }
}
