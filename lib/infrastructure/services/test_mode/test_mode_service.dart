import 'package:ustahub/infrastructure/services/shared_perf/shared_pref_service.dart';
import 'package:ustahub/infrastructure2/init/injection.dart';

/// Centralized check for "demo / sandbox" mode.
///
/// When the backend marks a user as `is_test: true` (e.g. Play Market reviewer
/// accounts), every mutating action in the app should be faked locally instead
/// of hitting the real API:
///   - bookings, cards, favorites, payments, profile edits → local stubs
/// Read-only GET endpoints (services, banners, search, categories, etc.)
/// continue to use the real backend so the UI still feels populated.
///
/// Usage:
/// ```dart
/// if (TestMode.isOn) {
///   // emit fake success
///   return;
/// }
/// // real API call
/// ```
class TestModeService {
  TestModeService(this._prefs);

  final SharedPrefService _prefs;

  bool get isOn {
    final user = _prefs.getUserProfile();
    return user?.isTest == true;
  }
}

/// Convenience accessor — `TestMode.isOn`.
class TestMode {
  TestMode._();
  static bool get isOn {
    try {
      return sl<TestModeService>().isOn;
    } catch (_) {
      return false;
    }
  }
}
