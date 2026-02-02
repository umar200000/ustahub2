import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:ustahub/infrastructure/services/log_service.dart';

class AppsFlayer {
  AppsflyerSdk? _appsflyerSdk;
  final String _afDevKey = "qXe3oSdLftDeXpXzqoxbXm";

  AppsFlayer._();

  static final instance = AppsFlayer._();

  Future<void> afStart() async {
    try {
      final AppsFlyerOptions options = AppsFlyerOptions(
        afDevKey: _afDevKey,
        appId: "6447933998",
        showDebug: true,
        timeToWaitForATTUserAuthorization: 35,
        manualStart: true,
      );

      _appsflyerSdk = AppsflyerSdk(options);
      await _appsflyerSdk?.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true,
      );

      _appsflyerSdk?.startSDK();

      _appsflyerSdk?.onInstallConversionData((res) {
        LogService.i("onInstallConversionData res: $res");
      });

      _appsflyerSdk?.onAppOpenAttribution((res) {
        LogService.i("onAppOpenAttribution res: $res");
      });
    } catch (e) {
      LogService.e(e);
    }
  }

  void pushUserProfile(String userId) {
    _appsflyerSdk?.setCustomerUserId(userId);
  }

  Future<void> logEvent(String eventName, Map? eventValues) async {
    bool? result;
    try {
      result = await _appsflyerSdk?.logEvent(eventName, eventValues);
    } on Exception catch (e) {
      LogService.e("_appsflyerSdk.logEvent $e");
    }
    LogService.i("Result logEvent: $result");
  }

  // listenAppLink(NotificationService notification) {
  //   _appsflyerSdk?.onDeepLinking((DeepLinkResult dp) {
  //     LogService.i("Deep link status: ${dp.status}");
  //     switch (dp.status) {
  //       case Status.FOUND:
  //         LogService.i(dp.deepLink?.toString());
  //         LogService.i("deep link value: ${dp.deepLink?.deepLinkValue}");
  //         // notification.handleMessage(dp.deepLink?.deepLinkValue);
  //         break;
  //       case Status.NOT_FOUND:
  //         LogService.i("deep link not found");
  //         break;
  //       case Status.ERROR:
  //         LogService.i("deep link error: ${dp.error}");
  //         break;
  //       case Status.PARSE_ERROR:
  //         LogService.i("deep link status parsing error");
  //         break;
  //     }
  //     LogService.i("onDeepLinking res: $dp");
  //   });

  //   if (Platform.isAndroid) {
  //     _appsflyerSdk?.performOnDeepLinking();
  //   }
  // }
}
