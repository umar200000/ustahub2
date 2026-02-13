import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';
import '../data/model/search_model.dart';
import '../data/repo/search_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepo _searchRepo = SearchRepo();

  SearchBloc() : super(const SearchState()) {
    on<SearchQueryEvent>(_onSearchQuery, transformer: debounce(_duration));
  }

  Future<void> _onSearchQuery(
    SearchQueryEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      return emit(const SearchState());
    }

    // Yangi qidiruv bo'lsa, holatni boshlang'ichga qaytaramiz
    if (event.isNewSearch || event.query != state.query) {
      emit(
        state.copyWith(
          status: Status2.loading,
          items: [],
          hasReachedMax: false,
          query: event.query,
        ),
      );
    } else if (state.hasReachedMax) {
      return;
    }

    try {
      final response = await _searchRepo.getSearchList(
        query: event.query,
        skip: state.items.length,
        limit: 20,
      );

      if (response.statusCode == 200) {
        final searchResponse = SearchListResponse.fromJson(response.data);
        final items = searchResponse.data ?? [];

        emit(
          items.isEmpty
              ? state.copyWith(status: Status2.success, hasReachedMax: true)
              : state.copyWith(
                  status: Status2.success,
                  items: List.of(state.items)..addAll(items),
                  hasReachedMax: items.length < 20,
                  query: event.query,
                ),
        );
      }
    } on DioException catch (e) {
      String? serverErrorMessage;
      if (e.response?.data != null && e.response?.data is Map) {
        serverErrorMessage =
            e.response?.data['error']?['message'] ??
            e.response?.data['message'];
      }
      emit(
        state.copyWith(
          status: Status2.error,
          errorMessage: serverErrorMessage ?? e.message ?? "Xatolik",
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: Status2.error, errorMessage: e.toString()));
    }
  }
}
