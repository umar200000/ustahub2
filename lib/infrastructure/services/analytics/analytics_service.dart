import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:ustahub/infrastructure/services/analytics/apps_flayer.dart';
import 'package:ustahub/infrastructure/services/log_service.dart';

class AnalyticsService {
  static const String _screenFrom = "screen_from";
  static const String _screenTo = "screen_to";
  static const String _button = "button";

  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static final AppsFlayer _appsFlare = AppsFlayer.instance;
  static final FacebookAppEvents _facebookAppEvents = FacebookAppEvents();

  static FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  static void setAnalytics() {
    _analytics.setAnalyticsCollectionEnabled(true);
    _facebookAppEvents.setAutoLogAppEventsEnabled(true);
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

    try {
      _facebookAppEvents.logEvent(
        name: name,
        parameters: {
          _button: name,
          _screenFrom: screenFrom,
          if (screenTo != null) _screenTo: screenTo,
        },
      );
    } catch (e) {
      LogService.e('Facebook Analytics error: $e');
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

    try {
      _facebookAppEvents.logEvent(name: name);
    } catch (e) {
      LogService.e('Facebook Analytics screen view error: $e');
    }
  }

  static void analyzeViewContent({
    required String contentId,
    String? currency,
    double? value,
  }) {
    try {
      _facebookAppEvents.logEvent(
        name: 'fb_mobile_content_view',
        parameters: {
          'fb_content_id': contentId,
          if (currency != null) 'fb_currency': currency,
          if (value != null) 'fb_value_to_sum': value,
        },
      );
    } catch (e) {
      LogService.e('Facebook Analytics view content error: $e');
    }
  }

  static void analyzePurchase({
    required double amount,
    required String currency,
    Map<String, dynamic>? parameters,
  }) {
    try {
      _facebookAppEvents.logPurchase(
        amount: amount,
        currency: currency,
        parameters: parameters,
      );
    } catch (e) {
      LogService.e('Facebook Analytics purchase error: $e');
    }
  }

  static void analyzeAddToCart({
    required double value,
    required String currency,
    required String contentId,
  }) {
    try {
      _facebookAppEvents.logEvent(
        name: 'fb_mobile_add_to_cart',
        parameters: {
          'fb_content_id': contentId,
          'fb_currency': currency,
          'fb_value_to_sum': value,
        },
      );
    } catch (e) {
      LogService.e('Facebook Analytics add to cart error: $e');
    }
  }

  static void analyzeInitiateCheckout({
    required double value,
    required String currency,
    required int numItems,
  }) {
    try {
      _facebookAppEvents.logEvent(
        name: 'fb_mobile_initiated_checkout',
        parameters: {
          'fb_currency': currency,
          'fb_value_to_sum': value,
          'fb_num_items': numItems,
        },
      );
    } catch (e) {
      LogService.e('Facebook Analytics initiate checkout error: $e');
    }
  }

  static void analyzeCompleteRegistration({
    required String registrationMethod,
  }) {
    try {
      _facebookAppEvents.logEvent(
        name: 'fb_mobile_complete_registration',
        parameters: {'fb_registration_method': registrationMethod},
      );
    } catch (e) {
      LogService.e('Facebook Analytics complete registration error: $e');
    }
  }

  static void analyzeSearch({
    required String searchString,
    required String contentType,
  }) {
    try {
      _facebookAppEvents.logEvent(
        name: 'fb_mobile_search',
        parameters: {
          'fb_search_string': searchString,
          'fb_content_type': contentType,
        },
      );
    } catch (e) {
      LogService.e('Facebook Analytics search error: $e');
    }
  }

  static void analyzeContact() {
    try {
      _facebookAppEvents.logEvent(name: 'fb_mobile_contact');
    } catch (e) {
      LogService.e('Facebook Analytics contact error: $e');
    }
  }

  static void analyzeRate({required double rating, required String contentId}) {
    try {
      _facebookAppEvents.logEvent(
        name: 'fb_mobile_rate',
        parameters: {'fb_content_id': contentId, 'fb_value_to_sum': rating},
      );
    } catch (e) {
      LogService.e('Facebook Analytics rate error: $e');
    }
  }

  static void setUserId(String userId) {
    try {
      _facebookAppEvents.logEvent(
        name: 'fb_user_id_set',
        parameters: {'user_id': userId},
      );
      _appsFlare.pushUserProfile(userId);
    } catch (e) {
      LogService.e('Set user ID error: $e');
    }
  }

  static void setUserEmail(String email) {
    try {
      _facebookAppEvents.setUserData(email: email);
    } catch (e) {
      LogService.e('Set user email error: $e');
    }
  }

  static void clearUserData() {
    try {
      _facebookAppEvents.clearUserData();
    } catch (e) {
      LogService.e('Clear user data error: $e');
    }
  }

  static void setAutoLogAppEventsEnabled(bool enabled) {
    try {
      _facebookAppEvents.setAutoLogAppEventsEnabled(enabled);
    } catch (e) {
      LogService.e('Set auto log app events error: $e');
    }
  }

  static void logAppActivated() {
    try {
      _facebookAppEvents.logEvent(name: 'fb_mobile_activate_app');
    } catch (e) {
      LogService.e('Log app activated error: $e');
    }
  }

  static void logAppDeactivated() {
    try {
      _facebookAppEvents.logEvent(name: 'fb_mobile_deactivate_app');
    } catch (e) {
      LogService.e('Log app deactivated error: $e');
    }
  }
}
