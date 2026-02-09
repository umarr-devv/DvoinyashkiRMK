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
  StatisticCubit(this.settingsCubit)
    : super(
        StatisticInitial(
          startDate: DateTime.now().subtract(Duration(days: 31)),
          endDate: DateTime.now(),
          isHourInterval: false,
        ),
      );

  final SettingsCubit settingsCubit;

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  CashRegisterScheme? get cashRegister => settingsCubit.state.cashRegister;

  Future update() async {
    if (cashRegister == null) return;
    emit(StatisticLoading(state));
    try {
      final Map<String, dynamic> params = {
        '\$select': "Date,Кассир_Key,КлиентUDS,СуммаДокумента,Состав",
        '\$filter':
            "КассаККМ_Key eq guid'${cashRegister!.refKey}' and Date ge ${to1CODataDateTime(state.startDate)} and Date le ${to1CODataDateTime(state.endDate)}",
        '\$format': 'json',
      };

      final response = await client.getCheckStatistics(
        fullPath: buildODataQuery(params),
      );

      final isHourInterval =
          state.endDate.difference(state.startDate) < Duration(days: 5);
      final checkSums = isHourInterval
          ? StatisticCheckSumData.aggregateByHour(response.checks)
          : StatisticCheckSumData.aggregateByDay(response.checks);

      final newState = state.copyWith(
        checks: response.checks,
        checkSums: checkSums,
        userSums: StatisticUserData.aggregateByUser(response.checks),
        isHourInterval: isHourInterval,
      );
      emit(StatisticLoaded(newState));
      await getItemsStatistic();
    } catch (exc, st) {
      talker.error(exc, st);
      emit(StatisticFailure(state));
    }
  }

  Future getItemsStatistic() async {
    if (cashRegister == null) return;
    emit(StatisticAltLoading(state));
    try {
      final Map<String, dynamic> params = {
        '\$select': "Запасы",
        '\$filter':
            "КассаККМ_Key eq guid'${cashRegister!.refKey}' and Date ge ${to1CODataDateTime(state.startDate)} and Date le ${to1CODataDateTime(state.endDate)}",
        '\$format': 'json',
      };

      final response = await client.getChecksItems(
        fullPath: buildODataQuery(params),
      );

      final List<CheckItemScheme> items = response.items
          .expand((i) => i.items)
          .toList();
      final items_ = StatisticItemData.aggregateByNomen(items);
      final newState = state.copyWith(items: items_);
      emit(StatisticAltLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(StatisticFailure(state));
    }
  }

  Future setDate({DateTime? startDate, DateTime? endDate}) async {
    final newState = state.copyWith(startDate: startDate, endDate: endDate);
    emit(StatisticUpdate(newState));
    await update();
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
