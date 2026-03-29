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

  final List<NotificationItem> _notifications = [];

  List<NotificationItem> get notifications =>
      List.unmodifiable(_notifications);

  int _unreadCount = 0;

  int get unreadCount => _unreadCount;

  NotificationProvider() {
    _loadFromStorage();
  }

  void addNotification({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) {
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
    _unreadCount = 0;
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
        notifyListeners();
      }
    } catch (_) {}
  }
}
