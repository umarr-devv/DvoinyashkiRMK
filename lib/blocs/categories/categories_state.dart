part of 'categories_cubit.dart';

@JsonSerializable()
class CategoriesState extends Equatable {
  const CategoriesState({
    this.categories = const [],
    this.pinned = const [],
    this.showEmpty = true,
    this.update,
    this.listView = false,
  });

  final List<CategoryScheme> categories;
  final List<String> pinned;
  final bool showEmpty;
  final DateTime? update;
  final bool listView;

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
    bool? listView,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      pinned: pinned ?? this.pinned,
      showEmpty: showEmpty ?? this.showEmpty,
      update: update ?? this.update,
      listView: listView ?? this.listView,
    );
  }

  CategoriesState.from(CategoriesState other)
    : categories = other.categories,
      pinned = other.pinned,
      showEmpty = other.showEmpty,
      update = other.update,
      listView = other.listView;

  factory CategoriesState.fromJson(Map<String, dynamic> json) =>
      _$CategoriesStateFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesStateToJson(this);

  @override
  List<Object?> get props => [categories, pinned, update, showEmpty, listView];
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
