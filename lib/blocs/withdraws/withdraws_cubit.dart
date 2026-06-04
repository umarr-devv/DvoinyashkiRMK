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
  WithdrawsCubit(this.settingsCubit, this.sessionCubit)
    : super(WithdrawsInitial());

  final SettingsCubit settingsCubit;
  final SessionCubit sessionCubit;

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  CashRegisterScheme? get cashRegister => settingsCubit.state.cashRegister;
  CashRegisterScheme? get cafeCashRegister =>
      settingsCubit.state.cafeCashRegister;
  WorkShiftScheme? get currentWorkShift => sessionCubit.state.currentWorkShift;

  Future update({bool updateCash = false}) async {
    if (cashRegister == null) return;
    if (state is WithdrawsLoading) return;
    emit(WithdrawsLoading(state));
    try {
      final Map<String, dynamic> params = {
        '\$top': state.limit.toString(),
        '\$skip': state.offset.toString(),
        '\$filter':
            'КассаККМ_Key eq guid\'${cashRegister!.refKey}\''
            '${cafeCashRegister != null ? " or КассаККМ_Key eq guid'${cafeCashRegister!.refKey}'" : ""}',
        '\$orderby': 'Date desc',
        '\$format': 'json',
      };

      final response = await client.getWithdraws(
        fullPath: buildODataQuery(params),
      );

      if (updateCash) {
        final Map<String, dynamic> params = {
          '\$filter': 'КассаККМ_Key eq guid\'${cashRegister!.refKey}\'',
          '\$select': 'КассаККМ_Key,СуммаBalance',
        };
        final cashResponse = await client.getCash(
          fullPath: buildODataQuery(params),
        );
        if (cashResponse.cashes.isNotEmpty) {
          final newState = state.copyWith(cash: cashResponse.cashes[0]);
          emit(WithdrawsLoading(newState));
        }
      }

      if (currentWorkShift != null) {
        final Map<String, dynamic> params = {
          '\$filter':
              'ОтчетОРозничныхПродажах_Key eq guid\'${currentWorkShift!.refKey}\''
              '${cafeCashRegister != null ? " or КассаККМ_Key eq guid'${cafeCashRegister!.refKey}'" : ""}',
          '\$orderby': 'Date desc',
          '\$format': 'json',
        };

        final response = await client.getWithdraws(
          fullPath: buildODataQuery(params),
        );
        final newState = state.copyWith(sessionWithdraws: response.withdraws);
        emit(WithdrawsLoading(newState));
      }
      final accepting = await getWithdrawAccepting(response.withdraws);
      await getNotAcceptedWithdraws();
      final newState = state.copyWith(
        withdraws: response.withdraws,
        accepting: accepting,
      );
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

  Future<Map<String, bool>?> getWithdrawAccepting(
    List<WithdrawScheme> withdraws,
  ) async {
    if (withdraws.isEmpty) {
      final newState = state.copyWith(accepting: <String, bool>{});
      emit(WithdrawsLoading(newState));
      return null;
    }

    final Map<String, bool> accepting = {
      for (var element in withdraws) element.refKey: false,
    };

    const int chunkSize = 5;
    final List<List<WithdrawScheme>> chunks = [];

    for (var i = 0; i < withdraws.length; i += chunkSize) {
      chunks.add(
        withdraws.sublist(
          i,
          i + chunkSize > withdraws.length ? withdraws.length : i + chunkSize,
        ),
      );
    }

    try {
      final futures = chunks.map((chunk) {
        final filterConditions = chunk
            .map((i) {
              return "ДокументОснование eq cast(guid'${i.refKey}', 'Document_ВыемкаНаличных')";
            })
            .join(' or ');

        final Map<String, dynamic> params = {
          '\$filter': filterConditions,
          '\$format': 'json',
          '\$select': 'Ref_Key,Posted,ДокументОснование',
        };

        return client.getWithdrawsAccepting(fullPath: buildODataQuery(params));
      });

      final responses = await Future.wait(futures);

      for (final response in responses) {
        if (response.value.isNotEmpty) {
          for (final item in response.value) {
            final String? baseDocKey = item.withdrawKey;
            if (baseDocKey != null && accepting.containsKey(baseDocKey)) {
              accepting[baseDocKey] = true;
            }
          }
        }
      }
      // ignore: empty_catches
    } catch (e) {}

    return accepting;
  }

  Future getNotAcceptedWithdraws() async {
    final List<WithdrawScheme> result = [];

    final twoDaysAgo = DateTime.now().subtract(Duration(days: 2));
    final formattedDate = twoDaysAgo.toIso8601String().substring(0, 19);
    final Map<String, dynamic> params = {
      '\$filter':
          'Date ge datetime\'$formattedDate\' and '
          'КассаККМ_Key eq guid\'${cashRegister!.refKey}\''
          '${cafeCashRegister != null ? " or КассаККМ_Key eq guid'${cafeCashRegister!.refKey}'" : ""}',
      '\$orderby': 'Date desc',
      '\$format': 'json',
    };
    final response = await client.getWithdraws(
      fullPath: buildODataQuery(params),
    );
    final accepting = await getWithdrawAccepting(response.withdraws);
    if (accepting == null) {
      return;
    }
    for (final i in response.withdraws) {
      if (accepting[i.refKey] == false) {
        result.add(i);
      }
    }
    emit(state.copyWith(notAcceptedWithdraws: result));
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
