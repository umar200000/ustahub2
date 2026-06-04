import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Qo'llab-quvvatlash uchun kontakt ma'lumotlarini backend'dan yuklaydigan singleton servis.
/// App ishga tushganda bir marta yuklanadi va keyin cache'dan foydalaniladi.
class SupportService {
  static final SupportService _instance = SupportService._internal();
  factory SupportService() => _instance;
  SupportService._internal();

  // Fallback (hardcode o'rniga)
  static const String _defaultTelegram = 'MT1707';
  static const String _defaultPhone = '+998997830123';

  String? _telegram;
  String? _phone;
  bool _loaded = false;

  /// Telegram username (@siz bilan)
  String get telegramUsername =>
      '@${(_telegram ?? _defaultTelegram).replaceAll('@', '')}';

  /// Telegram URL (https://t.me/...)
  String get telegramUrl =>
      'https://t.me/${(_telegram ?? _defaultTelegram).replaceAll('@', '')}';

  /// Telefon raqami
  String get phone => _phone ?? _defaultPhone;

  /// Backend'dan bir marta yuklaydi. Xato bo'lsa fallback ishlaydi.
  Future<void> load(Dio dio) async {
    if (_loaded) return;
    try {
      final res = await dio.get('api/v1/public/support/contact/');
      final data = res.data is Map ? res.data['data'] : null;
      if (data is Map) {
        final tg = data['telegram']?.toString();
        final ph = data['phone']?.toString();
        if (tg != null && tg.isNotEmpty) _telegram = tg;
        if (ph != null && ph.isNotEmpty) _phone = ph;
      }
      _loaded = true;
    } catch (e) {
      debugPrint('[SupportService] load failed (fallback used): $e');
    }
  }

  /// Token yangilanganda yoki logout'da reset qilish uchun (ixtiyoriy)
  void reset() {
    _loaded = false;
    _telegram = null;
    _phone = null;
  }
}
