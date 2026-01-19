import 'package:app/client/client.dart';
import 'package:app/core/consts/consts.dart';
import 'package:app/models/check.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:talker/talker.dart';

part 'detail_check_cubit.g.dart';
part 'detail_check_state.dart';

class DetailCheckCubit extends HydratedCubit<DetailCheckState> {
  DetailCheckCubit(String refKey) : super(DetailCheckInitial(refKey: refKey));

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  Future update() async {
    if (state.update == null ||
        DateTime.now().difference(state.update!) > updateInterval) {
      // await forceUpdate();
    }
  }

  Future forceUpdate() async {
    emit(DetailCheckLoading(state));
    try {
      final response = await client.getCheck(refKey: state.refKey);
      final newState = state.copyWith(check: response, update: DateTime.now());
      emit(DetailCheckLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(DetailCheckFailure(state));
    }
  }

  @override
  String get id => state.refKey;

  @override
  DetailCheckState? fromJson(Map<String, dynamic> json) {
    return DetailCheckState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(DetailCheckState state) {
    return state.toJson();
  }
}
