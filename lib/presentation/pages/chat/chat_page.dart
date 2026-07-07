import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ustahub/infrastructure/services/shared_perf/shared_pref_service.dart';
import 'package:ustahub/infrastructure2/init/injection.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class _ChatMessage {
  final String id;
  final String content;
  final bool isMe;
  final String senderName;
  final String sentAt;

  _ChatMessage({
    required this.id,
    required this.content,
    required this.isMe,
    required this.senderName,
    required this.sentAt,
  });
}

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.bookingId,
    required this.userId,
    required this.masterId,
    required this.masterName,
    required this.isActive,
  });

  final String bookingId;
  final String userId;
  final String masterId;
  final String masterName;
  final bool isActive;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _repo = ChatRepo();
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  List<_ChatMessage> _messages = [];
  WebSocketChannel? _channel;
  StreamSubscription? _wsSub;
  String? _conversationId;

  bool _loading = true;
  bool _connected = false;
  bool _sending = false;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    _isActive = widget.isActive;
    _initChat();
  }

  @override
  void dispose() {
    _wsSub?.cancel();
    _channel?.sink.close();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _initChat() async {
    try {
      final convRes = await _repo.getOrCreateConversation(
        bookingId: widget.bookingId,
        userId: widget.userId,
        masterId: widget.masterId,
      );
      final convData = convRes.data?['data'] as Map<String, dynamic>?;
      final convId = convData?['id'] as String?;
      if (convId == null) return;

      // Use is_active from API response — it may differ from widget.isActive
      final apiIsActive = convData?['is_active'] as bool? ?? widget.isActive;

      if (mounted) {
        setState(() {
          _conversationId = convId;
          _isActive = apiIsActive;
        });
      }

      await _loadHistory(convId);

      if (apiIsActive) {
        await _connectWebSocket(convId);
      }
    } catch (e) {
      debugPrint('[Chat] Init error: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _loadHistory(String convId) async {
    try {
      final res = await _repo.getMessages(conversationId: convId);
      final rawData = res.data?['data'];
      final List<dynamic> items;
      if (rawData is List) {
        items = rawData;
      } else {
        items = rawData?['items'] as List<dynamic>? ?? [];
      }
      final msgs = items.map((item) {
        // REST response uses sender_user_id; WS uses sender.user_type
        final senderUserId = item['sender_user_id']?.toString();
        final isMe =
            (senderUserId != null &&
                senderUserId.isNotEmpty &&
                senderUserId == widget.userId) ||
            (item['sender'] as Map<String, dynamic>?)?['user_type'] == 'client';
        final senderName = item['sender_name'] as String? ?? widget.masterName;
        return _ChatMessage(
          id: (item['id'] as String?) ?? '',
          content: (item['content'] as String?) ?? '',
          isMe: isMe,
          senderName: isMe ? 'Me' : senderName,
          sentAt: (item['sent_at'] as String?) ?? '',
        );
      }).toList();

      if (mounted) {
        setState(() => _messages = msgs);
        _scrollToBottom();
      }
    } catch (e) {
      debugPrint('[Chat] History load error: $e');
    }
  }

  Future<void> _connectWebSocket(String convId) async {
    final token = sl<SharedPrefService>().getTokenModel()?.accessToken ?? '';
    if (token.isEmpty) return;

    final uri = Uri.parse(
      'ws://3.64.241.75:8000/api/v1/ws/chat/$convId?token=$token',
    );
    debugPrint('[Chat] Connecting WS: $uri');

    try {
      _channel = WebSocketChannel.connect(uri);
      await _channel!.ready;
      _wsSub = _channel!.stream.listen(
        (data) {
          debugPrint('[Chat] <- $data');
          _handleWsMessage(data as String);
        },
        onError: (e) {
          debugPrint('[Chat] WS error: $e');
          if (mounted) setState(() => _connected = false);
        },
        onDone: () {
          debugPrint('[Chat] WS closed');
          if (mounted) setState(() => _connected = false);
        },
        cancelOnError: false,
      );
    } catch (e) {
      debugPrint('[Chat] WS connect failed: $e');
      _channel = null;
      // WS failed — messages will be sent via REST
    }
  }

  void _handleWsMessage(String raw) {
    try {
      final msg = jsonDecode(raw) as Map<String, dynamic>;
      final type = msg['type'] as String?;

      if (type == 'status' && msg['status'] == 'connected') {
        if (mounted) setState(() => _connected = true);
        return;
      }

      if (type == 'message') {
        final inner = msg['message'] as Map<String, dynamic>? ?? {};
        final sender = inner['sender'] as Map<String, dynamic>? ?? {};
        final isMe =
            sender['user_type'] == 'client' ||
            sender['user_id'] == widget.userId;
        final name = (sender['name'] as String?) ?? widget.masterName;

        final chatMsg = _ChatMessage(
          id: (inner['id'] as String?) ?? '',
          content: (inner['content'] as String?) ?? '',
          isMe: isMe,
          senderName: isMe ? 'Me' : name,
          sentAt: (inner['sent_at'] as String?) ?? '',
        );

        if (mounted) {
          setState(() => _messages.add(chatMsg));
          _scrollToBottom();
        }
      }
    } catch (e) {
      debugPrint('[Chat] Parse error: $e');
    }
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty || _conversationId == null || _sending) return;

    if (_channel != null) {
      setState(() => _sending = true);
      try {
        _channel!.sink.add(
          jsonEncode({
            "type": "message",
            "content": text,
            "message_type": "text",
          }),
        );
        _textController.clear();
      } catch (e) {
        debugPrint('[Chat] WS send error: $e');
        _sendViaRest(text);
      } finally {
        if (mounted) setState(() => _sending = false);
      }
    } else {
      _sendViaRest(text);
    }
  }

  Future<void> _sendViaRest(String text) async {
    if (_conversationId == null) return;
    setState(() => _sending = true);
    try {
      await _repo.sendMessage(conversationId: _conversationId!, content: text);
      _textController.clear();
      await _loadHistory(_conversationId!);
      _scrollToBottom();
    } catch (e) {
      debugPrint('[Chat] REST send error: $e');
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _formatTime(String sentAt) {
    try {
      final dt = DateTime.parse(sentAt).toLocal();
      return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (ctx, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.neutral50,
          appBar: AppBar(
            backgroundColor: colors.shade0,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(ctx),
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: colors.neutral800,
                size: 20.sp,
              ),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.chat_bubble_rounded,
                  color: colors.primary500,
                  size: 20.sp,
                ),
                Gap(8.w),
                Expanded(
                  child: Text(
                    widget.masterName.isNotEmpty
                        ? widget.masterName
                        : 'chat'.tr(),
                    style: fonts.paragraphP2SemiBold.copyWith(
                      color: colors.neutral800,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          body: _loading
              ? Center(
                  child: CircularProgressIndicator(color: colors.primary500),
                )
              : Column(
                  children: [
                    // Closed banner
                    if (!_isActive)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        color: colors.neutral100,
                        child: Row(
                          children: [
                            Icon(
                              Icons.lock_rounded,
                              color: colors.neutral500,
                              size: 16.sp,
                            ),
                            Gap(8.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'chat_closed'.tr(),
                                    style: fonts.paragraphP3SemiBold.copyWith(
                                      color: colors.neutral700,
                                    ),
                                  ),
                                  Text(
                                    'chat_closed_desc'.tr(),
                                    style: fonts.paragraphP3Regular.copyWith(
                                      color: colors.neutral500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Messages list
                    Expanded(
                      child: _messages.isEmpty
                          ? Center(
                              child: Text(
                                'chat'.tr(),
                                style: fonts.paragraphP2Regular.copyWith(
                                  color: colors.neutral400,
                                ),
                              ),
                            )
                          : ListView.builder(
                              controller: _scrollController,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 12.h,
                              ),
                              itemCount: _messages.length,
                              itemBuilder: (context, index) {
                                return _buildMessageBubble(
                                  _messages[index],
                                  colors,
                                  fonts,
                                );
                              },
                            ),
                    ),

                    // Input area (only if active)
                    if (_isActive) _buildInputArea(colors, fonts),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildMessageBubble(_ChatMessage msg, dynamic colors, dynamic fonts) {
    final isMe = msg.isMe;
    final timeStr = _formatTime(msg.sentAt);

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 16.r,
              backgroundColor: colors.neutral200,
              child: Icon(
                Icons.person_rounded,
                color: colors.neutral500,
                size: 16.sp,
              ),
            ),
            Gap(8.w),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? colors.primary500 : colors.shade0,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                      bottomLeft: Radius.circular(isMe ? 16.r : 4.r),
                      bottomRight: Radius.circular(isMe ? 4.r : 16.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        msg.content,
                        style: fonts.paragraphP2Regular.copyWith(
                          color: isMe ? Colors.white : colors.neutral800,
                        ),
                      ),
                      if (timeStr.isNotEmpty) ...[
                        Gap(4.h),
                        Text(
                          timeStr,
                          style: fonts.paragraphP3Regular.copyWith(
                            color: isMe
                                ? Colors.white.withValues(alpha: 0.7)
                                : colors.neutral400,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isMe) Gap(8.w),
        ],
      ),
    );
  }

  Widget _buildInputArea(dynamic colors, dynamic fonts) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: colors.shade0,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: colors.neutral100,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: TextField(
                  controller: _textController,
                  style: fonts.paragraphP2Regular.copyWith(
                    color: colors.neutral800,
                  ),
                  maxLines: 4,
                  minLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: 'type_message'.tr(),
                    hintStyle: fonts.paragraphP2Regular.copyWith(
                      color: colors.neutral400,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            Gap(8.w),
            GestureDetector(
              onTap: _conversationId != null ? _sendMessage : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: _conversationId != null
                      ? colors.primary500
                      : colors.neutral300,
                  shape: BoxShape.circle,
                ),
                child: _sending
                    ? Padding(
                        padding: EdgeInsets.all(12.w),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 20.sp,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
