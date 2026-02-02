import 'dart:async';
import 'dart:io' show Platform;

import 'package:clarity_flutter/clarity_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ustahub/infrastructure/services/analytics/analytics_service.dart';
import 'package:ustahub/presentation/pages/core/app_init.dart';
import 'package:ustahub/presentation/pages/core/app_widget.dart';
import 'package:ustahub/utils/app_config.dart';
import 'package:ustahub/utils/constants.dart';
import 'package:ustahub/utils/firebase_options.dart';
import 'package:ustahub/utils/sms_helper.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions().getOptions(),
    );

    AppConfig.create(
      appName: Constants.appName,
      baseUrl: Constants.baseUrlP,
      primaryColor: Colors.yellow,
    );

    await AppInit.create;

    AnalyticsService.logAppActivated();

    if (Platform.isAndroid) {
      await SmsHelper.printAppSignatureForBackend();
    }

    final config = ClarityConfig(
      projectId: "twkopn1bbu",
      logLevel: LogLevel.None,
    );

    Locale defaultLocale;
    try {
      final String languageCode = Platform.localeName.split('_')[0];
      defaultLocale = languageCode == "ru"
          ? const Locale('ru', 'RU')
          : languageCode == "en"
          ? const Locale('en', 'US')
          : const Locale('uz', 'UZ');
    } catch (e) {
      defaultLocale = const Locale('uz', 'UZ');
    }
    runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('uz', 'UZ'),
          Locale('ru', 'RU'),
          Locale('en', 'US'),
        ],
        path: 'assets/translation',
        fallbackLocale: const Locale('uz', 'UZ'),
        startLocale: defaultLocale,
        useOnlyLangCode: false,
        useFallbackTranslations: true,
        assetLoader: const RootBundleAssetLoader(),
        child: ClarityWidget(
          clarityConfig: config,
          app: MyApp(
            dbService: AppInit.dbService!,
            connectivityX: AppInit.connectivityX!,
          ),
        ),
      ),
    );
  } catch (error, stack) {
    debugPrint('App initialization error: $error');
    debugPrint('Stack trace: $stack');

    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Error initializing app: $error')),
        ),
      ),
    );
  }
}
