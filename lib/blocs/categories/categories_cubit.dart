import 'package:app/client/client.dart';
import 'package:app/core/consts/consts.dart';
import 'package:app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:talker/talker.dart';

part 'categories_cubit.g.dart';
part 'categories_state.dart';

class CategoriesCubit extends HydratedCubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  Future update() async {
    if (state.update == null ||
        DateTime.now().difference(state.update!) > updateInterval) {
      await forceUpdate();
    }
  }

  Future forceUpdate() async {
    emit(CategoriesLoading(state));
    try {
      final response = await client.getCategories();
      final newState = state.copyWith(
        categories: response.categories,
        update: DateTime.now(),
      );
      emit(CategoriesLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(CategoriesFailure(state));
    }
  }

  void pin(CategoryScheme category) {
    final List<String> pinned = List.from(state.pinned);
    final pinnedCategory = pinned.firstWhereLogTypeOrNull(
      (i) => i == category.refKey,
    );
    if (pinnedCategory != null) return;

    pinned.add(category.refKey);

    final newState = state.copyWith(pinned: pinned);
    emit(CategoriesUpdate(newState));
  }

  void unpin(CategoryScheme category) {
    final List<String> pinned = List.from(state.pinned);
    final pinnedCategory = pinned.firstWhereLogTypeOrNull(
      (i) => i == category.refKey,
    );
    if (pinnedCategory == null) return;

    pinned.remove(category.refKey);

    final newState = state.copyWith(pinned: pinned);
    emit(CategoriesUpdate(newState));
  }

  void switchShowEmpty() {
    final newState = state.copyWith(showEmpty: !state.showEmpty);
    emit(CategoriesUpdate(newState));
  }

  void switchListView() {
    final newState = state.copyWith(listView: !state.listView);
    emit(CategoriesUpdate(newState));
  }

  @override
  CategoriesState? fromJson(Map<String, dynamic> json) {
    return CategoriesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CategoriesState state) {
    return state.toJson();
  }
}
