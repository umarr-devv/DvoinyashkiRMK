import 'package:app/client/client.dart';
import 'package:app/core/consts/consts.dart';
import 'package:app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'structure_units_cubit.g.dart';
part 'structure_units_state.dart';

class StructureUnitsCubit extends HydratedCubit<StructureUnitsState> {
  StructureUnitsCubit() : super(StructureUnitsInitial());

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  Future update() async {
    if (state.update == null ||
        DateTime.now().difference(state.update!) > updateInterval) {
      await forceUpdate();
    }
  }

  Future forceUpdate() async {
    emit(StructureUnitsLoading(state));
    try {
      final response = await client.getStructureUnits();
      final newState = state.copyWith(
        structureUnits: response.structureUnits,
        update: DateTime.now(),
      );
      emit(StructureUnitsLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(StructureUnitsFailure(state));
    }
  }

  @override
  StructureUnitsState? fromJson(Map<String, dynamic> json) {
    return StructureUnitsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(StructureUnitsState state) {
    return state.toJson();
  }
}
