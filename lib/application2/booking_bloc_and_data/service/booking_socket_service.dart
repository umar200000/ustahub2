import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ustahub/application2/register_bloc_and_data/data/model/register_model.dart';
import 'package:ustahub/infrastructure/services/shared_perf/shared_pref_service.dart';
import 'package:ustahub/infrastructure2/init/injection.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as ws_status;

/// Client app uchun 24/7 booking WebSocket ulanish.
/// Buyurtma status o'zgarishlari real-time keladi.
///
/// tokenProvider — har reconnect'da yangi token qaytaradi
/// (SharedPrefService.getTokenModel()?.accessToken yo'lini uzatish kerak).
class BookingSocketService {
  static final BookingSocketService _instance = BookingSocketService._internal();
  factory BookingSocketService() => _instance;
  BookingSocketService._internal();

  static const _wsBase = 'ws://3.64.241.75:8000/api/v1/ws/bookings';

  WebSocketChannel? _channel;
  StreamSubscription? _sub;
  Timer? _reconnectTimer;
  Timer? _pingTimer;
  int _retry = 0;
  bool _closedByUser = false;

  // Callback — har ulanishda fresh token qaytaradi
  String Function()? _tokenProvider;
  String? _userId;

  final _events = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get events => _events.stream;

  bool get isConnected => _channel != null;

  /// [tokenProvider] — har reconnect'da chaqiriladi va fresh token qaytaradi.
  Future<void> connect(String Function() tokenProvider, String userId) async {
    _tokenProvider = tokenProvider;
    _userId = userId;
    _closedByUser = false;
    _retry = 0;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    if (_channel != null) return; // already connected
    await _doConnect();
  }

  bool _isTokenExpiredOrExpiringSoon(String token, {int thresholdMinutes = 3}) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;
      var payload = parts[1];
      final padding = payload.length % 4;
      if (padding != 0) payload += '=' * (4 - padding);
      final decoded = utf8.decode(base64Url.decode(payload));
      final data = jsonDecode(decoded) as Map<String, dynamic>;
      final exp = data['exp'] as int?;
      if (exp == null) return false;
      return DateTime.now().millisecondsSinceEpoch >= exp * 1000 - (thresholdMinutes * 60 * 1000);
    } catch (_) {
      return true;
    }
  }

  Future<String> _refreshTokenIfNeeded(String currentToken) async {
    if (!_isTokenExpiredOrExpiringSoon(currentToken)) return currentToken;

    final prefs = sl<SharedPrefService>();
    final refreshToken = prefs.getTokenModel()?.refreshToken ?? '';
    if (refreshToken.isEmpty) return currentToken;

    try {
      final response = await Dio(BaseOptions(connectTimeout: const Duration(seconds: 10)))
          .post('http://3.64.241.75:8000/api/v1/auth/refresh/', data: {'refresh_token': refreshToken});

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data['success'] == true) {
        final newData = response.data['data'];
        final newModel = TokenModel(
          accessToken: newData['access_token'],
          refreshToken: newData['refresh_token'],
          tokenType: newData['token_type'],
          userType: newData['user_type'],
        );
        prefs.setTokenModel(newModel);
        debugPrint('[BookingWS-Client] Token refreshed proactively');
        return newModel.accessToken ?? currentToken;
      }
    } catch (e) {
      debugPrint('[BookingWS-Client] Proactive token refresh failed: $e');
    }
    return currentToken;
  }

  Future<void> _doConnect() async {
    if (_tokenProvider == null || _userId == null || _closedByUser) return;
    // Guard: stale timer must not tear down an active connection
    if (_channel != null) return;

    final rawToken = _tokenProvider!();
    if (rawToken.isEmpty) {
      debugPrint('[BookingWS-Client] No token, skipping connect');
      _scheduleReconnect();
      return;
    }

    // Refresh token if expired or expiring within 3 minutes
    final token = await _refreshTokenIfNeeded(rawToken);
    if (token.isEmpty) {
      _scheduleReconnect();
      return;
    }

    final roomId = 'client_$_userId';
    final uri = Uri.parse('$_wsBase/$roomId?token=$token');

    WebSocketChannel? channel;
    try {
      channel = WebSocketChannel.connect(uri);
      _channel = channel;
      await channel.ready;
      // Kill stale timer — do NOT reset _retry here.
      // _retry resets only when server confirms "status: connected".
      _reconnectTimer?.cancel();
      _reconnectTimer = null;
      debugPrint('[BookingWS-Client] Handshake OK for $roomId (token may still be expired)');
    } catch (e) {
      debugPrint('[BookingWS-Client] Connect error: $e');
      _channel = null;
      _scheduleReconnect();
      return;
    }

    _sub?.cancel();
    _sub = channel.stream.listen(
      (data) {
        try {
          final msg = jsonDecode(data as String) as Map<String, dynamic>;
          final type = msg['type'];
          if (type == 'status' && msg['status'] == 'connected') {
            _retry = 0;
            debugPrint('[BookingWS-Client] Connected to $roomId');
          } else {
            debugPrint('[BookingWS-Client] ← type=$type booking_id=${msg["booking_id"]}');
          }
          _events.add(msg);
        } catch (e) {
          debugPrint('[BookingWS-Client] Parse error: $e');
        }
      },
      onDone: () {
        debugPrint('[BookingWS-Client] Disconnected (closeCode=${channel?.closeCode})');
        _channel = null;
        _scheduleReconnect();
      },
      onError: (e) {
        debugPrint('[BookingWS-Client] Error: $e');
        _channel = null;
        _scheduleReconnect();
      },
      cancelOnError: true,
    );

    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: 25), (_) {
      final ch = _channel;
      if (ch == null) return;
      try {
        ch.sink.add('ping');
      } catch (_) {
        _pingTimer?.cancel();
        _pingTimer = null;
        _channel = null;
        _scheduleReconnect();
      }
    });
  }

  void _scheduleReconnect() {
    if (_closedByUser) return;
    _pingTimer?.cancel();
    _pingTimer = null;
    _sub?.cancel();
    final secs = (1 << _retry).clamp(1, 30);
    _retry = (_retry + 1).clamp(0, 5);
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(Duration(seconds: secs), _doConnect);
    debugPrint('[BookingWS-Client] Reconnecting in ${secs}s...');
  }

  /// Call after a successful token refresh so the WS reconnects immediately.
  void notifyTokenRefreshed() {
    if (_closedByUser || _tokenProvider == null || _userId == null) return;
    if (_channel != null) return;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _retry = 0;
    _doConnect();
  }

  void disconnect() {
    _closedByUser = true;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _pingTimer?.cancel();
    _pingTimer = null;
    _sub?.cancel();
    _channel?.sink.close(ws_status.normalClosure);
    _channel = null;
    debugPrint('[BookingWS-Client] Disconnected by user');
  }
}
