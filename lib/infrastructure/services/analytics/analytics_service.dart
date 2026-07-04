import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:ustahub/infrastructure/services/analytics/apps_flayer.dart';
import 'package:ustahub/infrastructure/services/log_service.dart';

class AnalyticsService {
  static const String _screenFrom = "screen_from";
  static const String _screenTo = "screen_to";
  static const String _button = "button";

  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static final AppsFlayer _appsFlare = AppsFlayer.instance;

  static FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  static void setAnalytics() {
    _analytics.setAnalyticsCollectionEnabled(true);
  }

  static Future<void> analyzeEvent({
    required String name,
    required String screenFrom,
    String? screenTo,
  }) async {
    try {
      _analytics.logScreenView(
        screenName: name,
        parameters: {
          _button: name,
          _screenFrom: screenFrom,
          if (screenTo != null) _screenTo: screenTo,
        },
      );
    } catch (e) {
      LogService.e('Firebase Analytics error: $e');
    }

    try {
      _appsFlare.logEvent(name, {
        _button: name,
        _screenFrom: screenFrom,
        if (screenTo != null) _screenTo: screenTo,
      });
    } catch (e) {
      LogService.e('AppsFlyer error: $e');
    }
  }

  static void analyzeScreenView(String name) {
    try {
      _analytics.logScreenView(screenName: name);
    } catch (e) {
      LogService.e('Firebase Analytics screen view error: $e');
    }

    try {
      _appsFlare.logEvent(name, null);
    } catch (e) {
      LogService.e('AppsFlyer screen view error: $e');
    }
  }

  static void analyzeViewContent({
    required String contentId,
    String? currency,
    double? value,
  }) {}

  static void analyzePurchase({
    required double amount,
    required String currency,
    Map<String, dynamic>? parameters,
  }) {}

  static void analyzeAddToCart({
    required double value,
    required String currency,
    required String contentId,
  }) {}

  static void analyzeInitiateCheckout({
    required double value,
    required String currency,
    required int numItems,
  }) {}

  static void analyzeCompleteRegistration({
    required String registrationMethod,
  }) {}

  static void analyzeSearch({
    required String searchString,
    required String contentType,
  }) {}

  static void analyzeContact() {}

  static void analyzeRate({required double rating, required String contentId}) {}

  static void setUserId(String userId) {
    try {
      _appsFlare.pushUserProfile(userId);
    } catch (e) {
      LogService.e('Set user ID error: $e');
    }
  }

  static void setUserEmail(String email) {}

  static void clearUserData() {}

  static void setAutoLogAppEventsEnabled(bool enabled) {}

  static void logAppActivated() {}

  static void logAppDeactivated() {}
}
