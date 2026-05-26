import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../data/model/express_model.dart';
import '../data/repo/express_repo.dart';

part 'express_event.dart';
part 'express_state.dart';

class ExpressClientBloc extends Bloc<ExpressClientEvent, ExpressClientState> {
  final ClientExpressRepo _repo = ClientExpressRepo();

  ExpressClientBloc() : super(const ExpressClientState()) {
    on<LoadExpressProvincesEvent>(_onLoadProvinces);
    on<LoadExpressDistrictsEvent>(_onLoadDistricts);
    on<GetExpressCategoriesEvent>(_onGetCategories);
    on<StartExpressSearchEvent>(_onStartSearch);
    on<CancelExpressSearchEvent>(_onCancelSearch);
    on<PollExpressStatusEvent>(_onPollStatus);
    on<ExpressMatchedEvent>(_onMatched);
    on<ExpressNoMastersEvent>(_onNoMasters);
    on<ResetExpressClientEvent>(_onReset);
    on<ClearSearchResultEvent>(_onClearResult);
  }

  // ─── helpers ───────────────────────────────────────────────────────────────

  /// Dio javobini Map ga keltiradi. Backend `Content-Type: application/json`
  /// qaytarmasa, Dio `data` ni String qoldiradi — bu yerda decode qilamiz.
  Map<String, dynamic>? _asMap(dynamic data) {
    if (data is Map) return Map<String, dynamic>.from(data);
    if (data is String && data.isNotEmpty) {
      try {
        final decoded = jsonDecode(data);
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
      } catch (_) {}
    }
    return null;
  }

  /// Javobdan `data` ro'yxatini ajratib oladi.
  List<Map<String, dynamic>> _dataList(dynamic responseData) {
    if (responseData is List) {
      return responseData
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }
    final map = _asMap(responseData);
    final list = map?['data'];
    if (list is List) {
      return list
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }
    return const [];
  }

  // ─── provinces ─────────────────────────────────────────────────────────────

  Future<void> _onLoadProvinces(
    LoadExpressProvincesEvent event,
    Emitter<ExpressClientState> emit,
  ) async {
    emit(state.copyWith(provincesLoading: true));
    try {
      final res = await _repo.getProvinces(regionId: event.regionId);
      final list = _dataList(res.data)
          .map((e) => ExpressProvinceModel.fromJson(e))
          .toList();
      debugPrint('[Express] provinces loaded: ${list.length}');
      emit(state.copyWith(provinces: list, provincesLoading: false));
    } catch (e) {
      debugPrint('[Express] provinces error: $e');
      emit(state.copyWith(provincesLoading: false));
    }
  }

  // ─── districts ─────────────────────────────────────────────────────────────

  Future<void> _onLoadDistricts(
    LoadExpressDistrictsEvent event,
    Emitter<ExpressClientState> emit,
  ) async {
    emit(state.copyWith(districts: const [], districtsLoading: true));
    try {
      final res = await _repo.getDistricts(provinceId: event.provinceId);
      final list = _dataList(res.data)
          .map((e) => ExpressDistrictModel.fromJson(e))
          .toList();
      debugPrint('[Express] districts loaded: ${list.length}');
      emit(state.copyWith(districts: list, districtsLoading: false));
    } catch (e) {
      debugPrint('[Express] districts error: $e');
      emit(state.copyWith(districtsLoading: false));
    }
  }

  // ─── categories ────────────────────────────────────────────────────────────

  Future<void> _onGetCategories(
    GetExpressCategoriesEvent event,
    Emitter<ExpressClientState> emit,
  ) async {
    emit(state.copyWith(status: ExpressSearchStatus.loadingCategories, clearError: true));
    try {
      final res = await _repo.getCategories(provinceId: event.provinceId);
      final list = _dataList(res.data)
          .map((e) => ExpressCategoryModel.fromJson(e))
          .toList();
      debugPrint('[Express] categories loaded: ${list.length}');
      emit(state.copyWith(
        status: ExpressSearchStatus.categoriesLoaded,
        categories: list,
      ));
    } on DioException catch (e) {
      debugPrint('[Express] categories DioError: ${e.response?.statusCode} ${e.response?.data}');
      emit(state.copyWith(
        status: ExpressSearchStatus.error,
        errorMessage: _extractError(e),
      ));
    } catch (e) {
      debugPrint('[Express] categories error: $e');
      emit(state.copyWith(
        status: ExpressSearchStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // ─── start search ──────────────────────────────────────────────────────────

  Future<void> _onStartSearch(
    StartExpressSearchEvent event,
    Emitter<ExpressClientState> emit,
  ) async {
    emit(state.copyWith(
      status: ExpressSearchStatus.searching,
      clearSession: true,
      clearMatched: true,
      clearError: true,
    ));

    // ── LOG: so'rov parametrlari ──
    debugPrint(
      '[Express] POST /search/ → '
      'category=${event.categoryId} '
      'province=${event.provinceId} '
      'district=${event.districtId} '
      'lat=${event.latitude} lng=${event.longitude} '
      'payment=${event.paymentMethod}',
    );

    try {
      final res = await _repo.startSearch(
        categoryId: event.categoryId,
        provinceId: event.provinceId,
        districtId: event.districtId,
        latitude: event.latitude,
        longitude: event.longitude,
        paymentMethod: event.paymentMethod,
      );

      // ── LOG: xom javob ──
      debugPrint('[Express] /search/ response status: ${res.statusCode}');
      debugPrint('[Express] /search/ response data: ${res.data}');

      final map = _asMap(res.data);

      // success: false bo'lsa — error
      if (map != null && map['success'] == false) {
        final msg = map['message']?.toString() ?? 'Qidiruv boshlanmadi';
        debugPrint('[Express] /search/ success=false: $msg');
        emit(state.copyWith(
          status: ExpressSearchStatus.error,
          errorMessage: msg,
        ));
        return;
      }

      final data = map?['data'];
      if (data is Map) {
        final session =
            ExpressSessionModel.fromJson(Map<String, dynamic>.from(data));
        debugPrint(
          '[Express] session: id=${session.sessionId} '
          'status=${session.status} '
          'totalMasters=${session.totalMasters} '
          'message=${session.message}',
        );

        if (session.isExhausted) {
          debugPrint('[Express] ❌ Immediately exhausted — no masters found');
          emit(state.copyWith(
            status: ExpressSearchStatus.noMasters,
            session: session,
          ));
        } else {
          debugPrint('[Express] ✅ Searching — session_id=${session.sessionId}');
          emit(state.copyWith(
            status: ExpressSearchStatus.searching,
            session: session,
          ));
        }
      } else {
        final msg = map?['message']?.toString() ?? 'Qidiruv boshlanmadi';
        debugPrint('[Express] /search/ bad response format: $map');
        emit(state.copyWith(
          status: ExpressSearchStatus.error,
          errorMessage: msg,
        ));
      }
    } on DioException catch (e) {
      debugPrint(
        '[Express] /search/ DioError: ${e.response?.statusCode} '
        'data=${e.response?.data}',
      );
      emit(state.copyWith(
        status: ExpressSearchStatus.error,
        errorMessage: _extractError(e),
      ));
    } catch (e) {
      debugPrint('[Express] /search/ unexpected error: $e');
      emit(state.copyWith(
        status: ExpressSearchStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // ─── cancel ────────────────────────────────────────────────────────────────

  Future<void> _onCancelSearch(
    CancelExpressSearchEvent event,
    Emitter<ExpressClientState> emit,
  ) async {
    debugPrint('[Express] cancel session: ${event.sessionId}');
    try {
      await _repo.cancelSearch(sessionId: event.sessionId);
    } catch (e) {
      debugPrint('[Express] cancel error: $e');
    }
    emit(const ExpressClientState());
  }

  // ─── poll status ───────────────────────────────────────────────────────────

  Future<void> _onPollStatus(
    PollExpressStatusEvent event,
    Emitter<ExpressClientState> emit,
  ) async {
    try {
      final res = await _repo.getStatus(sessionId: event.sessionId);
      debugPrint('[Express] poll status data: ${res.data}');

      final map = _asMap(res.data);
      if (map == null) return;

      // Javob `{success, data:{...}}` yoki to'g'ridan-to'g'ri `{status,...}` bo'lishi mumkin
      final inner = map['data'] is Map
          ? Map<String, dynamic>.from(map['data'] as Map)
          : map;

      final statusVal = inner['status']?.toString();
      debugPrint('[Express] poll status value: $statusVal');

      switch (statusVal) {
        case 'matched':
          final bookingId = inner['booking_id']?.toString();
          debugPrint('[Express] 🎉 MATCHED! bookingId=$bookingId');
          emit(state.copyWith(
            status: ExpressSearchStatus.matched,
            matched: ExpressMatchedModel(
              sessionId: inner['session_id']?.toString(),
              bookingId: bookingId,
              masterName: inner['master_name']?.toString(),
              masterPhone: inner['master_phone']?.toString(),
            ),
          ));
          break;
        case 'exhausted':
        case 'canceled':
          debugPrint('[Express] ❌ Poll → noMasters (status=$statusVal)');
          emit(state.copyWith(status: ExpressSearchStatus.noMasters));
          break;
        case 'searching':
          debugPrint('[Express] ⏳ Poll → still searching');
          // Hech narsa qilmaymiz — kutishda davom etamiz
          break;
        default:
          debugPrint('[Express] Poll → unknown status: $statusVal');
      }
    } catch (e) {
      debugPrint('[Express] poll error: $e');
    }
  }

  // ─── matched / noMasters / reset ──────────────────────────────────────────

  void _onMatched(ExpressMatchedEvent event, Emitter<ExpressClientState> emit) {
    debugPrint('[Express] 🎉 WS matched: ${event.matched.masterName}');
    emit(state.copyWith(
      status: ExpressSearchStatus.matched,
      matched: event.matched,
    ));
  }

  void _onNoMasters(ExpressNoMastersEvent event, Emitter<ExpressClientState> emit) {
    debugPrint('[Express] ❌ WS noMasters');
    emit(state.copyWith(status: ExpressSearchStatus.noMasters));
  }

  void _onReset(ResetExpressClientEvent event, Emitter<ExpressClientState> emit) {
    debugPrint('[Express] reset state');
    emit(const ExpressClientState());
  }

  /// Faqat qidiruv natijasini tozalaydi: session/matched/error/status → initial.
  /// Viloyat, tuman va kategoriya ro'yxatlari saqlanib qoladi.
  /// "Qayta qidirish" tugmasi uchun ishlatiladi.
  void _onClearResult(
    ClearSearchResultEvent event,
    Emitter<ExpressClientState> emit,
  ) {
    debugPrint('[Express] clear search result — keeping provinces/districts/categories');
    emit(state.copyWith(
      status: ExpressSearchStatus.initial,
      clearSession: true,
      clearMatched: true,
      clearError: true,
    ));
  }

  // ─── helpers ───────────────────────────────────────────────────────────────

  String _extractError(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      return data['message']?.toString() ??
          data['detail']?.toString() ??
          'Xatolik yuz berdi';
    }
    return 'Xatolik yuz berdi';
  }
}
