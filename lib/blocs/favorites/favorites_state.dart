part of 'favorites_cubit.dart';

@JsonSerializable()
class FavoritesState extends Equatable {
  const FavoritesState({this.favoriteKeys = const []});

  final List<String> favoriteKeys;

  FavoritesState copyWith(List<String>? favoriteKeys) {
    return FavoritesState(favoriteKeys: favoriteKeys ?? this.favoriteKeys);
  }

  FavoritesState.from(FavoritesState other) : favoriteKeys = other.favoriteKeys;

  factory FavoritesState.fromJson(Map<String, dynamic> json) =>
      _$FavoritesStateFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritesStateToJson(this);

  @override
  List<Object?> get props => [favoriteKeys];
}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesUpdate extends FavoritesState {
  FavoritesUpdate(super.state) : super.from();
}
