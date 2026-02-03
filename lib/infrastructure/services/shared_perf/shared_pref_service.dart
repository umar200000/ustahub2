import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String _token = 'token';
  static const String _userAccount = 'user_account';
  static const String _themeMode = 'theme_mode';
  static const String _lang = 'language';

  static late SharedPreferences _prefs;

  const SharedPrefService._();

  /// Initialize qilish (main() da ishlatish kerak)
  static Future<SharedPrefService> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    return const SharedPrefService._();
  }

  // 🔹 Setters
  void setToken(String token) => _prefs.setString(_token, token);

  void setLanguage(String langCode) => _prefs.setString(_lang, langCode);

  void setThemeMode(Brightness brightness) {
    _prefs.setString(
      _themeMode,
      brightness == Brightness.dark ? 'dark' : 'light',
    );
  }

  // 🔹 Getters
  String get getToken => _prefs.getString(_token) ?? '';

  String getLanguageCode() => _prefs.getString(_lang) ?? 'uz';

  Brightness? getThemeMode() {
    final value = _prefs.getString(_themeMode);
    if (value == null) return null;
    return value == 'dark' ? Brightness.dark : Brightness.light;
  }

  // 🔹 Hammasini o‘chirish
  void clear() => _prefs.clear();
}
