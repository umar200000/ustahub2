import 'package:dio/dio.dart';
import 'package:ustahub/infrastructure2/init/injection.dart';

class ChatRepo {
  final _dio = sl<Dio>();

  Future<Response> getOrCreateConversation({
    required String bookingId,
    required String userId,
    required String masterId,
  }) async {
    return await _dio.post("api/v1/chat/conversations/", data: {
      "type": "direct",
      "user_id": userId,
      "master_id": masterId,
      "booking_id": bookingId,
    });
  }

  Future<Response> getMessages({
    required String conversationId,
    int skip = 0,
    int limit = 50,
  }) async {
    return await _dio.get(
      "api/v1/chat/conversations/$conversationId/messages/",
      queryParameters: {"skip": skip, "limit": limit, "order": "asc"},
    );
  }

  Future<void> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    await _dio.post("api/v1/chat/messages/", data: {
      "conversation_id": conversationId,
      "type": "text",
      "content": content,
    });
  }

  /// Mark all messages in a conversation as read.
  /// POST api/v1/chat/conversations/{id}/read-all/
  Future<void> markConversationAsRead(String conversationId) async {
    try {
      await _dio.post("api/v1/chat/conversations/$conversationId/read-all/");
    } catch (_) {}
  }

  /// Fetch all conversations with unread counts per booking.
  /// GET api/v1/chat/conversations/
  Future<Map<String, int>> getConversationUnreadCounts() async {
    try {
      final response = await _dio.get("api/v1/chat/conversations/");
      final raw = response.data?['data'];
      final List items;
      if (raw is List) {
        items = raw;
      } else {
        items = (raw?['items'] as List?) ?? [];
      }
      final result = <String, int>{};
      for (final c in items.cast<Map<String, dynamic>>()) {
        final bookingId = c['booking_id'] as String?;
        final unreadCount = (c['unread_count'] as int?) ?? 0;
        if (bookingId != null && unreadCount > 0) {
          result[bookingId] = unreadCount;
        }
      }
      return result;
    } catch (_) {
      return {};
    }
  }
}
