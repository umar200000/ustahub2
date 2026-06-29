import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
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
    await _doConnect();
  }

  Future<void> _doConnect() async {
    if (_tokenProvider == null || _userId == null || _closedByUser) return;

    // Fresh token read on every connect attempt
    final token = _tokenProvider!();
    if (token.isEmpty) {
      debugPrint('[BookingWS-Client] No token, skipping connect');
      _scheduleReconnect();
      return;
    }

    final roomId = 'client_$_userId';
    final uri = Uri.parse('$_wsBase/$roomId?token=$token');

    try {
      final channel = WebSocketChannel.connect(uri);
      _channel = channel;
      await channel.ready;
      _retry = 0;
      debugPrint('[BookingWS-Client] Connected to $roomId');
    } catch (e) {
      debugPrint('[BookingWS-Client] Connect error: $e');
      _channel = null;
      _scheduleReconnect();
      return;
    }

    _sub?.cancel();
    _sub = _channel!.stream.listen(
      (data) {
        try {
          final msg = jsonDecode(data as String) as Map<String, dynamic>;
          final type = msg['type'];
          if (type != 'status') {
            debugPrint('[BookingWS-Client] ← type=$type booking_id=${msg["booking_id"]}');
          }
          _events.add(msg);
        } catch (e) {
          debugPrint('[BookingWS-Client] Parse error: $e');
        }
      },
      onDone: () {
        debugPrint('[BookingWS-Client] Disconnected');
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
  }

  void _scheduleReconnect() {
    if (_closedByUser) return;
    _sub?.cancel();
    final secs = (1 << _retry).clamp(1, 30);
    _retry = (_retry + 1).clamp(0, 5);
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(Duration(seconds: secs), _doConnect);
    debugPrint('[BookingWS-Client] Reconnecting in ${secs}s...');
  }

  void disconnect() {
    _closedByUser = true;
    _reconnectTimer?.cancel();
    _sub?.cancel();
    _channel?.sink.close(ws_status.normalClosure);
    _channel = null;
    debugPrint('[BookingWS-Client] Disconnected by user');
  }
}
