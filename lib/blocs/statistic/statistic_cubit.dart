import 'package:app/blocs/settings/settings_cubit.dart';
import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'statistic_cubit.g.dart';
part 'statistic_data.dart';
part 'statistic_state.dart';

class StatisticCubit extends HydratedCubit<StatisticState> {
  StatisticCubit(this.settingsCubit) : super(StatisticInitial());

  final SettingsCubit settingsCubit;

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  CashRegisterScheme? get cashRegister => settingsCubit.state.cashRegister;

  Future update(DateTime? start, DateTime? end) async {
    if (cashRegister == null) return;
    emit(StatisticLoading(state));
    try {
      final Map<String, dynamic> params = {
        '\$select': "Date,Кассир_Key,КлиентUDS,СуммаДокумента,Состав",
        '\$filter':
            "КассаККМ_Key eq guid'${cashRegister!.refKey}' and Date ge datetime'$start' and Date le datetime '$end'",
        '\$format': 'json',
      };

      final response = await client.getCheckStatistics(
        fullPath: buildODataQuery(params),
      );
      final newState = state.copyWith(checks: response.checks, checkSums: StatisticCheckSumAggregate.aggregateByDay(response.checks));
      emit(StatisticLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(StatisticFailure(state));
    }
  }

  @override
  StatisticState? fromJson(Map<String, dynamic> json) {
    return StatisticState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(StatisticState state) {
    return state.toJson();
  }
}
