import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../application2/register_bloc_and_data/data/model/register_model.dart';

class SharedPrefService {
  static const String _tokenModel = 'tokenModel';
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

  void setTokenModel(TokenModel tokenModel) {
    _prefs.setString(_tokenModel, jsonEncode(tokenModel.toJson()));
  }

  void setLanguage(String langCode) => _prefs.setString(_lang, langCode);

  // 🔹 Getters

  TokenModel? getTokenModel() {
    final tokenModelString = _prefs.getString(_tokenModel);
    if (tokenModelString == null) return null;
    return TokenModel.fromJson(jsonDecode(tokenModelString));
  }

  String getLanguageCode() => _prefs.getString(_lang) ?? 'uz';

  // 🔹 Hammasini o‘chirish
  void clear() => _prefs.clear();
}
