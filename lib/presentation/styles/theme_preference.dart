part of 'theme.dart';

class _ThemePreference {
  final DBService _dbService;

  // Cache the theme mode to avoid repeated database access
  CustomThemeMode? _cachedMode;

  _ThemePreference._(this._dbService);

  static _ThemePreference create(DBService dbService) {
    return _ThemePreference._(dbService);
  }

  // DBService get dbService => _dbService;

  CustomThemeMode getMode() {
    // Return cached value if available
    if (_cachedMode != null) return _cachedMode!;

    // Otherwise load from storage and cache
    final modeKey = _dbService.getThemeMode ?? CustomThemeMode.light.toKey;
    _cachedMode = CustomThemeModeX.toValue(modeKey);

    return _cachedMode!;
  }

  Future<void> setMode(CustomThemeMode mode) async {
    // Update cache first for immediate access
    _cachedMode = mode;
    // Then persist to storage
    await _dbService.setThemeMode(mode.toKey);
  }

  Future<void> clean() async {
    // Clear cache when signing out
    _cachedMode = null;
    await _dbService.signOut();
  }
}
