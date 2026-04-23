part of 'favorite_bloc.dart';

class FavoriteState extends Equatable {
  final Status2 listStatus;
  final List<FavoriteServiceData> favorites;
  final Set<String> favoriteIds;
  final String? errorMessage;
  final bool isLastPage;
  final int total;

  const FavoriteState({
    this.listStatus = Status2.initial,
    this.favorites = const [],
    this.favoriteIds = const {},
    this.errorMessage,
    this.isLastPage = false,
    this.total = 0,
  });

  FavoriteState copyWith({
    Status2? listStatus,
    List<FavoriteServiceData>? favorites,
    Set<String>? favoriteIds,
    String? errorMessage,
    bool? isLastPage,
    int? total,
  }) {
    return FavoriteState(
      listStatus: listStatus ?? this.listStatus,
      favorites: favorites ?? this.favorites,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      errorMessage: errorMessage ?? this.errorMessage,
      isLastPage: isLastPage ?? this.isLastPage,
      total: total ?? this.total,
    );
  }

  bool isFavorite(String serviceId) => favoriteIds.contains(serviceId);

  @override
  List<Object?> get props => [
        listStatus,
        favorites,
        favoriteIds,
        errorMessage,
        isLastPage,
        total,
      ];
}
