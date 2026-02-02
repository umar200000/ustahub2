import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ustahub/infrastructure/services/local_database/db_service.dart';
import 'package:ustahub/presentation/styles/custom_theme_mode.dart';
import 'package:ustahub/presentation/styles/custom_theme_mode_ext.dart';
import 'package:ustahub/presentation/styles/style.dart';

part 'color_set.dart';
part 'font_set.dart';
part 'icon_set.dart';
part 'theme_preference.dart';

class GlobalController with ChangeNotifier {
  final _ThemePreference _themePreference;
  final IconSet _iconSet;
  late FontSet _fontSet;
  late CustomColorSet _colorSet;
  late CustomThemeMode _mode;

  // Memoized getters for better performance
  CustomColorSet get colors => _colorSet;
  CustomThemeMode get mode => _mode;
  bool get isDark => _mode.isDark;
  IconSet get icons => _iconSet;
  FontSet get fonts => _fontSet;
  DBService get dbService => _themePreference._dbService;

  GlobalController._(this._themePreference, this._iconSet) {
    // Initialize theme state
    _mode = _themePreference.getMode();
    _colorSet = CustomColorSet.createOrUpdate(_mode);
    _fontSet = FontSet.createOrUpdate(_colorSet);
  }

  static GlobalController create(DBService dbService) {
    final themePreference = _ThemePreference.create(dbService);
    final iconSet = IconSet.create;

    return GlobalController._(themePreference, iconSet);
  }

  // Public theme control methods
  Future<void> setLight() => _update(CustomThemeMode.light);
  Future<void> setDark() => _update(CustomThemeMode.dark);
  Future<void> clean() => _themePreference.clean();
  Future<void> toggle() => _mode.isLight ? setDark() : setLight();

  // Optimized theme update with batch operations
  Future<void> _update(CustomThemeMode mode) async {
    if (_mode == mode) return; // Skip unnecessary updates

    _mode = mode;
    _colorSet = CustomColorSet.createOrUpdate(mode);
    _fontSet = FontSet.createOrUpdate(_colorSet);

    // Batch operations: first update the UI, then persist the change
    notifyListeners();
    await _themePreference.setMode(mode);
  }
}

class BottomNavBarController with ChangeNotifier {
  bool _hiddenNavBar = false;

  bool get hiddenNavBar => _hiddenNavBar;

  BottomNavBarController._();

  static BottomNavBarController create() => BottomNavBarController._();

  void changeNavBar(bool enabled) {
    if (enabled != _hiddenNavBar) {
      _hiddenNavBar = enabled;
      notifyListeners();
    }
  }
}
