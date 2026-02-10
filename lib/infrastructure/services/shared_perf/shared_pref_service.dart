import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../application2/register_bloc_and_data/data/model/profile_model.dart';
import '../../../application2/register_bloc_and_data/data/model/register_model.dart';


class SharedPrefService {
  static const String _tokenModel = 'tokenModel';
  static const String _userProfile = 'user_profile';
  static const String _lang = 'language';

  static late SharedPreferences _prefs;

  const SharedPrefService._();

  /// Initialize qilish (main() da ishlatish kerak)
  static Future<SharedPrefService> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    return const SharedPrefService._();
  }

  // --- User Profile Metodlari ---

  /// Profil ma'lumotlarini saqlash
  Future<void> setUserProfile(UserProfile user) async {
    final jsonString = json.encode(user.toJson());
    // _preferences emas, _prefs ishlatilishi kerak
    await _prefs.setString(_userProfile, jsonString);
  }

  /// Profil ma'lumotlarini olish
  UserProfile? getUserProfile() {
    final jsonString = _prefs.getString(_userProfile);
    if (jsonString == null) return null;
    try {
      return UserProfile.fromJson(json.decode(jsonString));
    } catch (e) {
      return null;
    }
  }

  // --- Token Model Metodlari ---

  void setTokenModel(TokenModel tokenModel) {
    _prefs.setString(_tokenModel, jsonEncode(tokenModel.toJson()));
  }

  TokenModel? getTokenModel() {
    final tokenModelString = _prefs.getString(_tokenModel);
    if (tokenModelString == null) return null;
    return TokenModel.fromJson(jsonDecode(tokenModelString));
  }

  // --- Til Metodlari ---

  void setLanguage(String langCode) => _prefs.setString(_lang, langCode);

  String getLanguageCode() => _prefs.getString(_lang) ?? 'uz';

  // --- Tozalash ---

  void clear() => _prefs.clear();
}