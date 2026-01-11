part of 'categories_cubit.dart';

@JsonSerializable()
class CategoriesState extends Equatable {
  const CategoriesState({
    this.categories = const [],
    this.selected = const [],
    this.update,
  });

  final List<CategoryScheme> categories;
  final List<String> selected;
  final DateTime? update;

  CategoriesState copyWith({
    List<CategoryScheme>? categories,
    List<String>? selected,
    DateTime? update,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      selected: selected ?? this.selected,
      update: update ?? this.update,
    );
  }

  CategoriesState.from(CategoriesState other)
    : categories = other.categories,
      selected = other.selected,
      update = other.update;

  factory CategoriesState.fromJson(Map<String, dynamic> json) =>
      _$CategoriesStateFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesStateToJson(this);

  @override
  List<Object?> get props => [categories, selected, update];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {
  CategoriesLoading(super.state) : super.from();
}

final class CategoriesLoaded extends CategoriesState {
  CategoriesLoaded(super.state) : super.from();
}

final class CategoriesUpdate extends CategoriesState {
  CategoriesUpdate(super.state) : super.from();
}

final class CategoriesFailure extends CategoriesState {
  CategoriesFailure(super.state) : super.from();
}
