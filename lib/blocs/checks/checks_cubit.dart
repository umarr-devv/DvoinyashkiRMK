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

    final Map<String, dynamic> params = {
      '\$top': state.limit.toString(),
      '\$skip': state.offset.toString(),
      '\$filter': 'КассаККМ_Key eq guid\'${cashRegister!.refKey}\'',
      '\$orderby': 'Date desc',
      '\$format': 'json',
    };

    await client.getChecks(fullPath: buildODataQuery(params));
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
