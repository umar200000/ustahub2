import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationItem {
  final String title;
  final String body;
  final DateTime receivedAt;
  final Map<String, dynamic>? data;

  NotificationItem({
    required this.title,
    required this.body,
    required this.receivedAt,
    this.data,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body,
        'receivedAt': receivedAt.toIso8601String(),
        'data': data,
      };

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      receivedAt: DateTime.parse(json['receivedAt']),
      data: json['data'] as Map<String, dynamic>?,
    );
  }
}

class NotificationProvider extends ChangeNotifier {
  static const String _storageKey = 'saved_notifications';
  static const String _unreadCountKey = 'notification_unread_count';

  final List<NotificationItem> _notifications = [];

  List<NotificationItem> get notifications =>
      List.unmodifiable(_notifications);

  int _unreadCount = 0;

  int get unreadCount => _unreadCount;

  bool get hasUnread => _unreadCount > 0;

  NotificationProvider() {
    _loadFromStorage();
  }

  /// Dublikat notification qo'shilishining oldini olish
  bool _isDuplicate(String title, String body) {
    if (_notifications.isEmpty) return false;
    final now = DateTime.now();
    // Oxirgi 5 soniya ichida bir xil title va body kelgan bo'lsa dublikat
    return _notifications.any((n) =>
        n.title == title &&
        n.body == body &&
        now.difference(n.receivedAt).inSeconds < 5);
  }

  void addNotification({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) {
    // Dublikat tekshirish
    if (_isDuplicate(title, body)) {
      return;
    }

    _notifications.insert(
      0,
      NotificationItem(
        title: title,
        body: body,
        receivedAt: DateTime.now(),
        data: data,
      ),
    );
    _unreadCount++;
    _saveToStorage();
    notifyListeners();
  }

  void markAllAsRead() {
    if (_unreadCount == 0) return;
    _unreadCount = 0;
    _saveUnreadCount();
    notifyListeners();
  }

  void clearAll() {
    _notifications.clear();
    _unreadCount = 0;
    _saveToStorage();
    notifyListeners();
  }

  Future<void> _saveToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList =
          _notifications.map((n) => json.encode(n.toJson())).toList();
      await prefs.setStringList(_storageKey, jsonList);
      await prefs.setInt(_unreadCountKey, _unreadCount);
    } catch (_) {}
  }

  Future<void> _saveUnreadCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_unreadCountKey, _unreadCount);
    } catch (_) {}
  }

  Future<void> _loadFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = prefs.getStringList(_storageKey);
      if (jsonList != null) {
        _notifications.clear();
        for (final jsonStr in jsonList) {
          _notifications
              .add(NotificationItem.fromJson(json.decode(jsonStr)));
        }
      }
      _unreadCount = prefs.getInt(_unreadCountKey) ?? 0;
      notifyListeners();
    } catch (_) {}
  }
}
