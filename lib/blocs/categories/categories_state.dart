part of 'categories_cubit.dart';

@JsonSerializable()
class CategoriesState extends Equatable {
  const CategoriesState({
    this.categories = const [],
    this.pinned = const [],
    this.showEmpty = true,
    this.update,
  });

  final List<CategoryScheme> categories;
  final List<String> pinned;
  final bool showEmpty;
  final DateTime? update;

  List<CategoryScheme> get pinnedCategories {
    return categories
        .where((category) => pinned.contains(category.refKey))
        .toList();
  }

  CategoriesState copyWith({
    List<CategoryScheme>? categories,
    List<String>? pinned,
    bool? showEmpty,
    DateTime? update,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      pinned: pinned ?? this.pinned,
      showEmpty: showEmpty ?? this.showEmpty,
      update: update ?? this.update,
    );
  }

  CategoriesState.from(CategoriesState other)
    : categories = other.categories,
      pinned = other.pinned,
      showEmpty = other.showEmpty,
      update = other.update;

  factory CategoriesState.fromJson(Map<String, dynamic> json) =>
      _$CategoriesStateFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesStateToJson(this);

  @override
  List<Object?> get props => [categories, pinned, update, showEmpty];
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
