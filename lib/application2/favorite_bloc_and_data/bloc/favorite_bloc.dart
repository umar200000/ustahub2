import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';
import '../../../infrastructure2/common/error_helper.dart';
import '../data/model/favorite_model.dart';
import '../data/repo/favorite_repo.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepo _favoriteRepo = FavoriteRepo();

  FavoriteBloc() : super(const FavoriteState()) {
    on<GetFavoritesEvent>(_onGetFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onGetFavorites(
    GetFavoritesEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    if (event.isFetchMore &&
        (state.isLastPage || state.listStatus == Status2.loading)) {
      return;
    }

    if (!event.isFetchMore) {
      emit(state.copyWith(
        listStatus: Status2.loading,
        isLastPage: false,
      ));
    } else {
      emit(state.copyWith(listStatus: Status2.loading));
    }

    try {
      const int limit = 20;
      final int skip = event.isFetchMore ? state.favorites.length : 0;

      final response = await _favoriteRepo.getFavorites(
        skip: skip,
        limit: limit,
      );

      if (response.statusCode == 200) {
        final parsed = FavoriteListResponse.fromJson(response.data);

        if (parsed.success == true) {
          final List<FavoriteServiceData> currentList = event.isFetchMore
              ? List<FavoriteServiceData>.from(state.favorites)
              : [];
          final List<FavoriteServiceData> newList = parsed.data ?? [];
          final bool isLastPage = newList.length < limit;

          final allFavorites = [...currentList, ...newList];
          final ids = allFavorites
              .where((f) => f.id != null)
              .map((f) => f.id!)
              .toSet();

          emit(state.copyWith(
            listStatus: Status2.success,
            favorites: allFavorites,
            favoriteIds: ids,
            isLastPage: isLastPage,
            total: parsed.total ?? allFavorites.length,
          ));
        } else {
          emit(state.copyWith(
            listStatus: Status2.error,
            errorMessage: extractFromResponseData(response.data),
          ));
        }
      }
    } on DioException catch (e) {
      emit(state.copyWith(
        listStatus: Status2.error,
        errorMessage: extractErrorMessage(e),
      ));
    } catch (e) {
      emit(state.copyWith(
        listStatus: Status2.error,
        errorMessage: extractErrorMessage(e),
      ));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    final serviceId = event.serviceId;
    final wasInFavorites = event.currentlyFavorite ??
        state.favoriteIds.contains(serviceId);

    // Optimistic update — darhol UI ni o'zgartir
    final newIds = Set<String>.from(state.favoriteIds);
    final newFavorites = List<FavoriteServiceData>.from(state.favorites);

    if (wasInFavorites) {
      newIds.remove(serviceId);
      newFavorites.removeWhere((f) => f.id == serviceId);
    } else {
      newIds.add(serviceId);
      // Agar service data berilgan bo'lsa, favorites listga ham qo'sh
      if (event.serviceData != null) {
        newFavorites.insert(0, event.serviceData!);
      }
    }

    emit(state.copyWith(
      favoriteIds: newIds,
      favorites: newFavorites,
      total: wasInFavorites ? state.total - 1 : state.total + 1,
    ));

    // Background da API chaqir
    try {
      if (wasInFavorites) {
        await _favoriteRepo.removeFavorite(serviceId);
      } else {
        await _favoriteRepo.addFavorite(serviceId);
      }
    } catch (e) {
      // Agar xato bo'lsa — backend dan haqiqiy favorites ni qayta yuklab olamiz
      // Bu "allaqachon favorite" yoki "allaqachon olib tashlangan" holatlarini ham hal qiladi
      try {
        final response = await _favoriteRepo.getFavorites(skip: 0, limit: 100);
        if (response.statusCode == 200) {
          final parsed = FavoriteListResponse.fromJson(response.data);
          if (parsed.success == true) {
            final freshList = parsed.data ?? [];
            final freshIds = freshList
                .where((f) => f.id != null)
                .map((f) => f.id!)
                .toSet();
            emit(state.copyWith(
              favorites: freshList,
              favoriteIds: freshIds,
              total: parsed.total ?? freshList.length,
            ));
            return;
          }
        }
      } catch (_) {}

      // Agar refresh ham xato bo'lsa — rollback
      final rollbackIds = Set<String>.from(state.favoriteIds);
      final rollbackFavorites =
          List<FavoriteServiceData>.from(state.favorites);

      if (wasInFavorites) {
        rollbackIds.add(serviceId);
        if (event.serviceData != null) {
          rollbackFavorites.insert(0, event.serviceData!);
        }
      } else {
        rollbackIds.remove(serviceId);
        rollbackFavorites.removeWhere((f) => f.id == serviceId);
      }

      emit(state.copyWith(
        favoriteIds: rollbackIds,
        favorites: rollbackFavorites,
        total: wasInFavorites ? state.total + 1 : state.total - 1,
      ));
    }
  }
}
