import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:ustahub/domain/common/token_ext.dart';
import 'package:ustahub/infrastructure/services/analytics/apps_flayer.dart';
import 'package:ustahub/infrastructure/services/analytics/analytics_service.dart';
import 'package:ustahub/infrastructure/services/connectivity.dart';
import 'package:ustahub/infrastructure/services/local_database/db_service.dart';
import 'package:ustahub/infrastructure/services/log_service.dart';
import 'package:ustahub/presentation/styles/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ustahub/utils/firebase_options.dart';

class AppInit {
  static bool? connectivityX;
  static DBService? dbService;

  AppInit._();

  static Future<AppInit> get create async {
    await appInitialized();

    // Run connectivity check and DB initialization in parallel
    final results = await Future.wait([
      ConnectivityX().create(),
      DBService.create,
    ]);

    connectivityX = results[0] as bool;
    dbService = results[1] as DBService;

    if (kDebugMode) {
      debugPrint('\nTOKEN: ${dbService?.token.toToken}\n');
    }

    return AppInit._();
  }

  static Future<void> appInitialized() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Start Hive initialization early - it can run in parallel with other tasks
    final hiveInit = Hive.initFlutter();

    try {
      // Initialize Firebase first - many services depend on it
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions().getOptions(),
        );
        debugPrint("Firebase initialized successfully");
      }

      // Enable FCM auto-initialization
      await FirebaseMessaging.instance.setAutoInitEnabled(true);

      // Set up background message handler
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );
    } catch (e) {
      debugPrint("Firebase initialization error: $e");
    }

    // Initialize LogService
    LogService.create;

    // Wait for parallel initialization tasks
    await Future.wait([
      // Wait for Hive to complete initialization
      hiveInit,

      // Easy Localization
      EasyLocalization.ensureInitialized(),

      // Device Orientation
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]),
    ]);

    // Configure system UI style
    SystemChrome.setSystemUIOverlayStyle(Style.light);

    // Set up logging
    _setupLogging();

    // Initialize BLoC observer in debug mode
    if (kDebugMode) {
      Bloc.observer = LogBlocObserver();
    }

    // Configure HTTP client
    HttpOverrides.global = MyHttpOverrides();

    // Start AppsFlyer, Analytics, and ensure screen size
    await Future.wait([
      AppsFlayer.instance.afStart(),
      ScreenUtil.ensureScreenSize(),
    ]);

    // Initialize Analytics after other services
    AnalyticsService.setAnalytics();
  }

  static void _setupLogging() => Logger.root
    ..level = kDebugMode ? Level.ALL : Level.WARNING
    ..onRecord.listen(
      (record) => debugPrint(
        '${record.level.name}: '
        '${record.time} '
        '${record.loggerName}: '
        '${record.message}',
      ),
    );
}

// FOR BACKGROUND CHECK
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Safely initialize Firebase for background messages
  try {
    // Initialize Firebase first if not already initialized
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions().getOptions(),
      );
      debugPrint('Firebase initialized in background handler');
    }

    // Log the background message
    debugPrint('=== BACKGROUND MESSAGE RECEIVED ===');
    debugPrint('Message ID: ${message.messageId}');
    debugPrint('Message ID (sent): ${message.messageId}');
    debugPrint('Notification Title: ${message.notification?.title}');
    debugPrint('Notification Body: ${message.notification?.body}');
    debugPrint('Message Data: ${message.data}');
    debugPrint('Message From: ${message.from}');
    debugPrint('Message Sent Time: ${message.sentTime}');

    // The system will automatically show the notification for background messages
    // We just need to ensure Firebase is initialized
    debugPrint('Background message handled successfully');
  } catch (e, stackTrace) {
    debugPrint('Error in background message handler: $e');
    debugPrint('Stack trace: $stackTrace');
  }
}

Future<void> initializeFirebase() async {
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions().getOptions(),
      );
    } else {
      Firebase.app(); // Get the existing app instance
    }
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }
}

/// bloc logger
class LogBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      print("\n----------$bloc Changed-----------\n");
    }
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      print("$bloc closed---------------------");
    }
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      print("$bloc created---------------------");
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      LogService.d('---------Event------------${bloc.runtimeType} $event');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      print('---------Error------------${bloc.runtimeType} $error');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      print("--------------$bloc Transition---------------------");
    }
  }
}

/// ssl
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// /// Allows you to set and enable a proxy for your app
// class CustomProxy {
//   /// A string representing an IP address for the proxy server
//   final String ipAddress;

//   /// The port number for the proxy server
//   /// Can be null if port is default.
//   final int? port;

//   /// Set this to true
//   /// - Warning: Setting this to true in production apps can be dangerous. Use with care!
//   bool allowBadCertificates;

//   /// Initializer
//   CustomProxy({required this.ipAddress, this.port, this.allowBadCertificates = false});

//   /// Initializer from string
//   /// Note: Uses static method, rather than named init to allow final properties.
//   static CustomProxy? fromString({required String? proxy}) {
//     // Check if valid
//     if (proxy == null || proxy == "") {
//       assert(false, "Proxy string passed to CustomProxy.fromString() is invalid.");
//       return null;
//     }

//     // Build and return
//     final proxyParts = proxy.split(":");
//     final ipAddress = proxyParts[0];
//     final port = proxyParts.isNotEmpty ? int.tryParse(proxyParts[1]) : null;
//     return CustomProxy(
//       ipAddress: ipAddress,
//       port: port ?? 0,
//     );
//   }

//   /// Enable the proxy
//   void enable() {
//     HttpOverrides.global = CustomProxyHttpOverride.withProxy(toString());
//   }

//   /// Disable the proxy
//   void disable() {
//     HttpOverrides.global = null;
//   }

//   @override
//   String toString() {
//     String proxy = ipAddress;
//     if (port != null) {
//       proxy += ":$port";
//     }
//     return proxy;
//   }
// }

// /// This class overrides the global proxy settings.
// class CustomProxyHttpOverride extends HttpOverrides {
//   /// The entire proxy server
//   /// Format: "localhost:8888"
//   final String proxyString;

//   /// Set this to true
//   /// - Warning: Setting this to true in production apps can be dangerous. Use with care!
//   final bool allowBadCertificates;

//   /// Initializer
//   CustomProxyHttpOverride.withProxy(
//     this.proxyString, {
//     this.allowBadCertificates = false,
//   });

//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..findProxy = (uri) {
//         assert(proxyString.isNotEmpty, 'You must set a valid proxy if you enable it!');
//         return "PROXY $proxyString;";
//       }
//       ..badCertificateCallback = allowBadCertificates ? (X509Certificate cert, String host, int port) => true : null;
//   }
// }
