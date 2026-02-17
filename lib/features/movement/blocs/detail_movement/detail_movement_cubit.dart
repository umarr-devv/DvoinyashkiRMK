import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'detail_movement_state.dart';

class DetailMovementCubit extends Cubit<DetailMovementState> {
  DetailMovementCubit(this.refKey) : super(DetailMovementInitial());

  final String refKey;

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  Future update() async {
    emit(DetailMovementLoading(state));
    try {
      final response = await client.getMovement(refKey: refKey);
      final newState = state.copyWith(response);
      emit(DetailMovementLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(DetailMovementFailure(state));
    }
  }
}
