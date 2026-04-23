part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object?> get props => [];
}

class GetFavoritesEvent extends FavoriteEvent {
  final bool isFetchMore;
  const GetFavoritesEvent({this.isFetchMore = false});

  @override
  List<Object?> get props => [isFetchMore];
}

class ToggleFavoriteEvent extends FavoriteEvent {
  final String serviceId;
  final FavoriteServiceData? serviceData;
  // Kartochkadagi haqiqiy joriy holat (service.isFavorite). Agar berilsa,
  // FavoriteBloc favoriteIds emas, shu qiymatga qarab POST/DELETE qiladi.
  final bool? currentlyFavorite;
  const ToggleFavoriteEvent({
    required this.serviceId,
    this.serviceData,
    this.currentlyFavorite,
  });

  @override
  List<Object?> get props => [serviceId, serviceData, currentlyFavorite];
}
