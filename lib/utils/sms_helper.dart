import 'package:flutter/foundation.dart';
import 'package:sms_autofill/sms_autofill.dart';

class SmsHelper {
  static SmsHelper? _instance;
  SmsHelper._internal();

  static SmsHelper get instance {
    _instance ??= SmsHelper._internal();
    return _instance!;
  }

  /// Get the app signature for SMS autofill
  /// This signature should be included at the end of SMS messages sent from your backend
  /// for Android to automatically detect and fill OTP codes
  static Future<String> getAppSignature() async {
    try {
      final signature = await SmsAutoFill().getAppSignature;
      debugPrint("App Signature for SMS Autofill: $signature");
      return signature;
    } catch (e) {
      debugPrint("Error getting app signature: $e");
      return "";
    }
  }

  /// Initialize SMS autofill listener
  /// Returns a stream of SMS codes extracted from incoming messages
  static Future<Stream<String>?> initializeSmsListener() async {
    try {
      await SmsAutoFill().listenForCode();

      return SmsAutoFill().code
          .map((smsCode) {
            debugPrint("Raw SMS received: $smsCode");

            // Extract 6-digit code from SMS
            final RegExp regExp = RegExp(r'\b\d{6}\b');
            final match = regExp.firstMatch(smsCode);

            if (match != null) {
              final code = match.group(0) ?? '';
              debugPrint("Extracted OTP code: $code");
              return code;
            }

            // Fallback: if SMS is exactly 6 digits
            if (smsCode.length == 6 && RegExp(r'^\d+$').hasMatch(smsCode)) {
              debugPrint("Using full SMS as OTP: $smsCode");
              return smsCode;
            }

            debugPrint("No valid OTP code found in SMS");
            return '';
          })
          .where((code) => code.isNotEmpty);
    } catch (e) {
      debugPrint("Error initializing SMS listener: $e");
      return null;
    }
  }

  /// Clean up SMS autofill resources
  static void dispose() {
    try {
      SmsAutoFill().unregisterListener();
    } catch (e) {
      debugPrint("Error disposing SMS autofill: $e");
    }
  }

  /// Print app signature for debugging and backend integration
  /// Call this method once to get the signature that should be included in SMS messages
  static Future<void> printAppSignatureForBackend() async {
    final signature = await getAppSignature();
    if (signature.isNotEmpty) {
      debugPrint("=== SMS AUTOFILL SETUP ===");
      debugPrint("Include this signature at the end of your SMS messages:");
      debugPrint("$signature");
      debugPrint("Example SMS format:");
      debugPrint("SAZU Market tasdiqlash kod: 371171\n$signature");
      debugPrint("========================");
    }
  }
}
