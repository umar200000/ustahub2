import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as ws_status;

/// Mijoz uchun express qidiruv WebSocket ulanishi.
/// POST /search/ dan session_id olgach connect() chaqiriladi.
/// express_matched yoki express_no_masters kelganda events stream orqali ma'lum qilinadi.
class ExpressClientSocket {
  static const _wsBase = 'ws://3.64.241.75:8000/api/v1/ws/express';

  final String accessToken;
  final String sessionId;

  WebSocketChannel? _channel;
  StreamSubscription? _sub;
  bool _disposed = false;

  final _events = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get events => _events.stream;

  ExpressClientSocket({
    required this.accessToken,
    required this.sessionId,
  });

  Future<void> connect() async {
    if (_disposed) return;

    // Trailing slash YO'Q — /client/{id} ✅
    // Token query parametrida, header'da EMAS
    final uri = Uri.parse('$_wsBase/client/$sessionId?token=$accessToken');
    debugPrint('[WS-Client] Connecting to: $uri');

    try {
      final channel = WebSocketChannel.connect(uri);
      _channel = channel;
      await channel.ready; // 403 → token muammo
      debugPrint('[WS-Client] ✅ Connected: session=$sessionId');
    } catch (e) {
      debugPrint('[WS-Client] ❌ Connect failed: $e');
      if (!_disposed && !_events.isClosed) {
        _events.addError(e);
      }
      return;
    }

    _sub = _channel!.stream.listen(
      (data) {
        debugPrint('[WS-Client] ← RAW: $data');
        try {
          final msg = jsonDecode(data as String) as Map<String, dynamic>;
          debugPrint('[WS-Client] ← type=${msg["type"]} data=$msg');
          if (!_disposed && !_events.isClosed) {
            _events.add(msg);
          }
        } catch (e) {
          debugPrint('[WS-Client] ← parse error: $e (raw=$data)');
        }
      },
      onError: (e) {
        debugPrint('[WS-Client] ⚠ stream error: $e');
        if (!_disposed && !_events.isClosed) {
          _events.addError(e);
        }
      },
      onDone: () {
        debugPrint('[WS-Client] ✗ stream closed: session=$sessionId');
      },
      cancelOnError: false,
    );
  }

  void dispose() {
    _disposed = true;
    _sub?.cancel();
    _channel?.sink.close(ws_status.normalClosure);
    if (!_events.isClosed) _events.close();
    debugPrint('[WS-Client] disposed: session=$sessionId');
  }
}
