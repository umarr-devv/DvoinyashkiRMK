import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorites_state.dart';
part 'favorites_cubit.g.dart';

class FavoritesCubit extends HydratedCubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());
  void add(String favoriteKey) {
    final List<String> favoriteKeys = List.from(state.favoriteKeys);
    if (!favoriteKeys.contains(favoriteKey)) {
      favoriteKeys.add(favoriteKey);
      final newState = state.copyWith(favoriteKeys);
      emit(FavoritesUpdate(newState));
    }
  }

  void remove(String favoriteKey) {
    final List<String> favoriteKeys = List.from(state.favoriteKeys);
    if (favoriteKeys.contains(favoriteKey)) {
      favoriteKeys.remove(favoriteKey);
      final newState = state.copyWith(favoriteKeys);
      emit(FavoritesUpdate(newState));
    }
  }

  @override
  FavoritesState? fromJson(Map<String, dynamic> json) {
    return FavoritesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(FavoritesState state) {
    return state.toJson();
  }
}
