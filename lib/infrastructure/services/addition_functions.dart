import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ustahub/infrastructure/services/log_service.dart';
import 'package:ustahub/presentation/components/easy_loading.dart';
import 'package:url_launcher/url_launcher.dart';

class AdditionFunctions {
  static void launchMailClient(String kEmail) async {
    try {
      await launchUrl(
        Uri(scheme: 'mailto', path: kEmail),
        mode: LaunchMode.externalNonBrowserApplication,
      ).then((value) => LogService.i(value));
    } catch (e) {
      await Clipboard.setData(ClipboardData(text: kEmail));
      EasyLoading.showToast("copied_to_clipboard".tr());
    }
  }

  static void launchPath(String path, {bool isWebsite = true}) async {
    late String url;
    if (path.contains("https://") || !isWebsite) {
      url = path;
    } else {
      url = "https://$path";
    }
    try {
      if (!await launchUrl(Uri.parse(url))) {
        EasyLoading.showError("unknown_error".tr());
      }
    } catch (e) {
      EasyLoading.showError("unknown_error".tr());
    }
  }

  /// Returns a URL that can be launched on the current platform
  static Uri createQueryUrl(String query) {
    Uri uri;

    if (kIsWeb) {
      uri = Uri.https('www.google.com', '/maps/search/', {
        'api': '1',
        'query': query,
      });
    } else if (Platform.isAndroid) {
      uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});
    } else if (Platform.isIOS) {
      uri = Uri.https('maps.apple.com', '/', {'q': query});
    } else {
      uri = Uri.https('www.google.com', '/maps/search/', {
        'api': '1',
        'query': query,
      });
    }

    return uri;
  }

  /// Returns a URL that can be launched on the current platform
  /// to open a maps application showing coordinates ([latitude] and [longitude]).
  static Uri createCoordinatesUrl(
    double latitude,
    double longitude, [
    String? label,
  ]) {
    Uri uri;

    if (kIsWeb) {
      uri = Uri.https('www.google.com', '/maps/search/', {
        'api': '1',
        'query': '$latitude,$longitude',
      });
    } else if (Platform.isAndroid) {
      var query = '$latitude,$longitude';

      if (label != null) query += '($label)';

      uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});
    } else if (Platform.isIOS) {
      var params = {'ll': '$latitude,$longitude'};

      if (label != null) params['q'] = label;

      uri = Uri.https('maps.apple.com', '/', params);
    } else {
      uri = Uri.https('www.google.com', '/maps/search/', {
        'api': '1',
        'query': '$latitude,$longitude',
      });
    }

    LogService.i(uri);
    return uri;
  }

  /// Launches the maps application for this platform.
  static Future<bool> launchQuery(String query) {
    return launchUrl(createQueryUrl(query));
  }

  /// Launches the maps application for this platform.
  static Future<bool> launchCoordinates(
    double latitude,
    double longitude, [
    String? label,
  ]) {
    return launchUrl(createCoordinatesUrl(latitude, longitude, label));
  }

  static void makePhoneCall(String phoneNumber) async {
    try {
      final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        throw 'Could not launch $launchUri';
      }
    } catch (e) {
      LogService.e(e);
    }
  }
}
