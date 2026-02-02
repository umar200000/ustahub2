// ignore_for_file: unused_field

import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:ustahub/presentation/pages/core/app_widget.dart';
import 'package:ustahub/infrastructure/services/log_service.dart';
import 'package:timezone/data/latest_all.dart' as tzd;
import 'package:timezone/timezone.dart' as tz;
import 'package:firebase_core/firebase_core.dart';
import 'package:ustahub/utils/firebase_options.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final BuildContext _context;
  String darwinNotificationCategoryPlain = 'plainCategory';

  NotificationService._(this._context, this._flutterLocalNotificationsPlugin);

  static NotificationService create({
    required BuildContext context,
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) {
    return NotificationService._(context, flutterLocalNotificationsPlugin);
  }

  Future<String?> getToken() async {
    try {
      debugPrint("=== Starting FCM token retrieval ===");

      if (Firebase.apps.isEmpty) {
        debugPrint("Initializing Firebase...");
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions().getOptions(),
        );
        debugPrint("Firebase initialized successfully");
      } else {
        debugPrint("Firebase already initialized");
      }

      if (Platform.isIOS) {
        debugPrint("iOS platform detected - requesting permissions...");
        await _iosPermission();

        // Wait for APNS token to be available (important for simulator)
        debugPrint(
          "Waiting for APNS token (this may take a few seconds on simulator)...",
        );
        String? apnsToken = await _waitForAPNSToken(
          maxRetries: 15,
          delayMs: 1000,
        );

        if (apnsToken != null) {
          debugPrint("✓ APNS token obtained: ${apnsToken.substring(0, 10)}...");
          LogService.i("APNS token obtained successfully");
        } else {
          debugPrint(
            "⚠ Warning: APNS token not available yet, but continuing with FCM token request",
          );
          LogService.w(
            "APNS token not available - notifications may not work on simulator",
          );
          debugPrint(
            "Note: On iOS simulator, APNS token may take longer to become available",
          );
          debugPrint(
            "⚠ IMPORTANT: Without APNS token, FCM notifications will NOT work on iOS!",
          );
        }
      }

      // Check if service is available before requesting token
      final NotificationSettings settings = await _firebaseMessaging
          .getNotificationSettings();
      debugPrint(
        "Notification authorization status: ${settings.authorizationStatus}",
      );

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        debugPrint("❌ Push notifications are denied by the user");
        LogService.w("Push notifications are denied by the user");
        return null;
      }

      debugPrint("Requesting FCM token...");
      final token = await _firebaseMessaging.getToken();

      if (token == null || token.isEmpty) {
        debugPrint("❌ FCM token retrieval returned empty value");
        LogService.w("FCM token is null or empty");
        return null;
      }

      debugPrint(
        "✓ FCM token received: ${token.substring(0, 10)}...${token.substring(token.length - 4)}",
      );
      debugPrint("📱 Full FCM Token (for testing): $token");
      debugPrint("📋 Token length: ${token.length}");

      // Verify token format for iOS
      if (Platform.isIOS) {
        if (token.contains('APA91b') || token.length < 100) {
          debugPrint(
            "⚠ WARNING: Token format looks suspicious for iOS. iOS tokens are typically longer.",
          );
        } else {
          debugPrint("✓ Token format looks correct for iOS");
        }
      }

      LogService.i("FCM token obtained successfully");
      debugPrint("=== FCM token retrieval completed ===");
      return token;
    } catch (e, stackTrace) {
      debugPrint("❌ Error getting FCM token: $e");
      debugPrint("Stack trace: $stackTrace");
      LogService.e("Error getting FCM token: $e");
      return null;
    }
  }

  /// Wait for APNS token to become available (important for iOS simulator)
  Future<String?> _waitForAPNSToken({
    int maxRetries = 15,
    int delayMs = 1000,
  }) async {
    for (int i = 0; i < maxRetries; i++) {
      try {
        final apnsToken = await _firebaseMessaging.getAPNSToken();
        if (apnsToken != null && apnsToken.isNotEmpty) {
          debugPrint(
            "APNS token obtained successfully: ${apnsToken.substring(0, 10)}...",
          );
          LogService.i("APNS token obtained successfully");
          return apnsToken;
        }

        if (i < maxRetries - 1) {
          debugPrint(
            "APNS token not available yet, retrying in ${delayMs}ms... (attempt ${i + 1}/$maxRetries)",
          );
          await Future.delayed(Duration(milliseconds: delayMs));
        }
      } catch (e) {
        debugPrint("Error checking APNS token: $e");
        LogService.w(
          "Error checking APNS token (attempt ${i + 1}/$maxRetries): $e",
        );
        if (i < maxRetries - 1) {
          await Future.delayed(Duration(milliseconds: delayMs));
        }
      }
    }

    debugPrint("APNS token not available after $maxRetries attempts");
    LogService.w(
      "APNS token not available after $maxRetries attempts - notifications may not work",
    );
    return null;
  }

  Future<void> _iosPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    // Handle the authorization status
    debugPrint(
      "iOS notification permission status: ${settings.authorizationStatus}",
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      LogService.i('User granted notification permission');
      debugPrint('User granted notification permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      LogService.i('User granted provisional notification permission');
      debugPrint('User granted provisional notification permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      LogService.w('User denied notification permission');
      debugPrint('User denied notification permission');
    } else {
      LogService.w(
        'Notification permission status: ${settings.authorizationStatus}',
      );
      debugPrint(
        'Notification permission status: ${settings.authorizationStatus}',
      );
    }

    // Log detailed settings
    final detailedSettings = await _firebaseMessaging.getNotificationSettings();
    debugPrint(
      "Detailed notification settings: ${detailedSettings.toString()}",
    );
    LogService.i("Notification settings: ${detailedSettings.toString()}");
  }

  void firebaseCloudMessagingListeners() async {
    try {
      // Ensure Firebase is initialized first
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions().getOptions(),
        );
        debugPrint("Firebase initialized in firebaseCloudMessagingListeners");
      }

      if (Platform.isIOS) {
        debugPrint(
          "iOS: Requesting permissions in firebaseCloudMessagingListeners",
        );
        await _iosPermission();

        // Wait for APNS token on iOS
        debugPrint("iOS: Checking APNS token availability...");
        final apnsToken = await _waitForAPNSToken(maxRetries: 5, delayMs: 1000);
        if (apnsToken != null) {
          debugPrint(
            "iOS: APNS token available: ${apnsToken.substring(0, 10)}...",
          );
        } else {
          debugPrint("iOS: APNS token not yet available");
        }
      }

      // Get and log the token - use a safer logging approach
      debugPrint("Getting FCM token in firebaseCloudMessagingListeners...");
      final token = await _firebaseMessaging.getToken();
      if (token != null && token.isNotEmpty) {
        final maskedToken =
            "${token.substring(0, 8)}...${token.substring(token.length - 4)}";
        LogService.i("FCM token obtained: $maskedToken");
        debugPrint("FCM token obtained: $maskedToken");
      } else {
        LogService.w("FCM token is null or empty");
        debugPrint("FCM token is null or empty");
      }

      // Configure foreground notification presentation options for iOS
      // This ensures notifications are shown even when app is in foreground
      if (Platform.isIOS) {
        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
              alert: true,
              badge: true,
              sound: true,
            );
        debugPrint(
          "iOS foreground notification presentation options configured",
        );
      }
    } catch (e) {
      LogService.e("Error in firebaseCloudMessagingListeners: $e");
      debugPrint("Firebase messaging error: $e");
    }

    // Set up message handlers...
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      LogService.i(
        'Message received in foreground: ${message.notification?.toMap()} ${message.data}',
      );
      debugPrint('=== FOREGROUND MESSAGE RECEIVED ===');
      debugPrint('Title: ${message.notification?.title}');
      debugPrint('Body: ${message.notification?.body}');
      debugPrint('Data: ${message.data}');
      debugPrint('Platform: ${Platform.isAndroid ? "Android" : "iOS"}');

      // Show notification for both Android and iOS when app is in foreground
      // iOS will also show via AppDelegate, but we show local notification as backup
      if (message.notification != null) {
        try {
          // For Android, ensure notification channel exists before showing
          if (Platform.isAndroid) {
            final androidImplementation = _flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin
                >();

            if (androidImplementation != null) {
              // Ensure channel exists (it should already be created, but double-check)
              await androidImplementation.createNotificationChannel(
                const AndroidNotificationChannel(
                  'sazu_market_notifications',
                  'SaZu Market Notifications',
                  description:
                      'Notifications for orders, updates, and important messages',
                  importance: Importance.high,
                  playSound: true,
                  enableVibration: true,
                ),
              );
              debugPrint("Android notification channel verified/created");
            }
          }

          // Generate a valid 32-bit integer ID (max value: 2147483647)
          final notificationId =
              DateTime.now().millisecondsSinceEpoch % 2147483647;

          await showNotification(
            id: notificationId,
            title: message.notification!.title ?? "Notification",
            body: message.notification!.body ?? "",
            payload: json.encode(message.data),
          );
          debugPrint('✅ Local notification shown for foreground message');
          LogService.i('Local notification shown for foreground message');
        } catch (e, stackTrace) {
          debugPrint('❌ Error showing foreground notification: $e');
          debugPrint('Stack trace: $stackTrace');
          LogService.e('Error showing foreground notification: $e');
        }
      } else {
        debugPrint('⚠️ Message received but notification is null');
      }
    });

    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      LogService.e(' onMessageOpenedApp data: ${message.data}');
      if (message.notification != null) {
        LogService.e(
          'onMessageOpenedApp Message also contained a notification: ${message.notification}',
        );
        // Generate a valid 32-bit integer ID
        final notificationId =
            DateTime.now().millisecondsSinceEpoch % 2147483647;
        showNotification(
          id: notificationId,
          title: message.notification?.title ?? "",
          body: message.notification?.body ?? "",
          payload: json.encode(message.data),
        );
      }
    });
  }

  @pragma('vm:entry-point')
  static Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    LogService.e(' onBackgroundMessageMessage data: ${message.data}');
    if (message.notification != null) {
      LogService.e(
        'onBackgroundMessage Message also contained a notification: ${message.notification}',
      );
      // Note: Since this is a static method, we can't access instance methods directly
      // This is handled by the system showing the notification for background messages
    }
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      handleMessage(initialMessage.data['deeplink']);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(
      (r) => handleMessage(r.data['deeplink']),
    );
  }

  notificationInit() async {
    /// notification
    await _configureLocalTimeZone();

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        !kIsWeb && Platform.isLinux
        ? null
        : await _flutterLocalNotificationsPlugin
              .getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {}

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final List<DarwinNotificationCategory> darwinNotificationCategories =
        <DarwinNotificationCategory>[
          DarwinNotificationCategory(
            "textCategory",
            actions: <DarwinNotificationAction>[
              DarwinNotificationAction.text(
                'text_1',
                'Action 1',
                buttonTitle: 'Send',
                placeholder: 'Placeholder',
              ),
            ],
          ),
          DarwinNotificationCategory(
            "plainCategory",
            actions: <DarwinNotificationAction>[
              DarwinNotificationAction.plain('id_1', 'Action 1'),
              DarwinNotificationAction.plain(
                'id_2',
                'Action 2 (destructive)',
                options: <DarwinNotificationActionOption>{
                  DarwinNotificationActionOption.destructive,
                },
              ),
              DarwinNotificationAction.plain(
                "id_3",
                'Action 3 (foreground)',
                options: <DarwinNotificationActionOption>{
                  DarwinNotificationActionOption.foreground,
                },
              ),
              DarwinNotificationAction.plain(
                'id_4',
                'Action 4 (auth required)',
                options: <DarwinNotificationActionOption>{
                  DarwinNotificationActionOption.authenticationRequired,
                },
              ),
            ],
            options: <DarwinNotificationCategoryOption>{
              DarwinNotificationCategoryOption.allowAnnouncement,
            },
          ),
        ];

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          notificationCategories: darwinNotificationCategories,
        );
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(
          defaultActionName: 'Open notification',
          defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
        );
    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
          macOS: initializationSettingsDarwin,
          linux: initializationSettingsLinux,
        );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse message) {
        LogService.i(message.payload ?? "");
        if (message.payload != null && message.payload!.isNotEmpty) {
          if (message.payload == "Alice") {
            alice.showInspector();
            return;
          }
          try {
            Map<String, dynamic> map = json.decode(message.payload ?? "{}");
            handleMessage(map['deeplink']);
          } catch (e) {
            LogService.e(e.toString());
          }
        } else {}
      },
      onDidReceiveBackgroundNotificationResponse: _notificationTapBackground,
    );

    await _isAndroidPermissionGranted();
    await _requestPermissions();

    // Subscribe to topic after all permissions are handled
    if (Platform.isIOS) {
      // For iOS, ensure we have an APNS token before subscribing
      try {
        debugPrint(
          "iOS: Waiting for APNS token before subscribing to topic...",
        );
        final apnsToken = await _waitForAPNSToken(
          maxRetries: 15,
          delayMs: 1000,
        );

        if (apnsToken != null) {
          await _firebaseMessaging.subscribeToTopic("all");
          LogService.i("iOS: Successfully subscribed to topic 'all'");
          debugPrint("iOS: Successfully subscribed to topic 'all'");
        } else {
          LogService.w(
            "iOS: APNS token not available, will retry on token refresh",
          );
          debugPrint(
            "iOS: APNS token not available, setting up token refresh listener",
          );

          // Set up listener for when APNS token becomes available
          FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
            LogService.i(
              "iOS: FCM token refreshed: ${fcmToken.substring(0, 10)}...",
            );
            debugPrint("iOS: FCM token refreshed, checking APNS token...");

            final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
            if (apnsToken != null) {
              try {
                await _firebaseMessaging.subscribeToTopic("all");
                LogService.i(
                  "iOS: Successfully subscribed to topic 'all' after token refresh",
                );
                debugPrint(
                  "iOS: Successfully subscribed to topic 'all' after token refresh",
                );
              } catch (e) {
                LogService.e(
                  "iOS: Error subscribing to topic after token refresh: $e",
                );
              }
            }
          });
        }
      } catch (e) {
        LogService.e("iOS: Error during topic subscription: $e");
        debugPrint("iOS: Error during topic subscription: $e");
      }
    } else {
      // For Android and other platforms
      await _firebaseMessaging.subscribeToTopic("all");
      LogService.i("Android: Successfully subscribed to topic 'all'");
    }
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final androidImplementation = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();

      if (androidImplementation != null) {
        final areEnabled = await androidImplementation
            .areNotificationsEnabled();
        debugPrint("Android notifications enabled: $areEnabled");
        LogService.i("Android notifications enabled: $areEnabled");

        // Create notification channel (required for Android 8.0+)
        await androidImplementation.createNotificationChannel(
          const AndroidNotificationChannel(
            'sazu_market_notifications', // Channel ID
            'SaZu Market Notifications', // Channel name
            description:
                'Notifications for orders, updates, and important messages',
            importance: Importance.high,
            playSound: true,
            enableVibration: true,
          ),
        );
        debugPrint("Android notification channel created");
        LogService.i("Android notification channel created");
      }
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(
            alert: true,
            badge: true,
            critical: true,
            provisional: true,
            sound: true,
          );
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            provisional: true,
            critical: true,
          );
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >()
          ?.checkPermissions()
          .then((value) {
            LogService.i(value);
          });
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      await androidImplementation?.requestNotificationsPermission();
    }
  }

  static Future<void> _configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tzd.initializeTimeZones();
    final TimezoneInfo timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName.toString()));
  }

  @pragma('vm:entry-point')
  static void _notificationTapBackground(
    NotificationResponse notificationResponse,
  ) {
    LogService.i(
      'notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}',
    );
    if (notificationResponse.input?.isNotEmpty ?? false) {
      LogService.i(
        'notification action tapped with input: ${notificationResponse.input}',
      );
    }
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    try {
      debugPrint("Attempting to show notification - ID: $id, Title: $title");

      NotificationDetails notificationDetails;

      // For Android, use BigTextStyle for better notification display
      if (Platform.isAndroid) {
        final androidDetails = AndroidNotificationDetails(
          'sazu_market_notifications', // Must match channel ID
          'SaZu Market Notifications',
          channelDescription:
              'Notifications for orders, updates, and important messages',
          icon: "@mipmap/ic_launcher",
          importance: Importance.high,
          priority: Priority.high,
          enableVibration: true,
          playSound: true,
          showWhen: true,
          ticker: 'New notification from SaZu Market',
          styleInformation: BigTextStyleInformation(body),
          channelShowBadge: true,
          enableLights: true,
          color: const Color.fromARGB(
            255,
            43,
            255,
            0,
          ), // Yellow color matching your app
        );
        notificationDetails = NotificationDetails(android: androidDetails);
        debugPrint(
          "Android notification details created with channel: sazu_market_notifications",
        );
      } else {
        notificationDetails = _getPlatformSpecificNotificationDetails();
      }

      // Show the notification
      await _flutterLocalNotificationsPlugin.show(
        id,
        title.isEmpty ? "SaZu Market" : title,
        body,
        notificationDetails,
        payload: payload,
      );

      debugPrint("✅ Notification displayed successfully - ID: $id");
      LogService.i("Notification shown: $title");
    } catch (e, stackTrace) {
      debugPrint("❌ Error showing notification: $e");
      debugPrint("Stack trace: $stackTrace");
      LogService.e("Error showing notification: $e");

      // Try to show a basic notification as fallback
      if (Platform.isAndroid) {
        try {
          final fallbackDetails = NotificationDetails(
            android: AndroidNotificationDetails(
              'sazu_market_notifications',
              'SaZu Market Notifications',
              channelDescription:
                  'Notifications for orders, updates, and important messages',
              importance: Importance.high,
              priority: Priority.high,
            ),
          );
          await _flutterLocalNotificationsPlugin.show(
            id,
            title.isEmpty ? "SaZu Market" : title,
            body,
            fallbackDetails,
          );
          debugPrint("✅ Fallback notification shown");
        } catch (fallbackError) {
          debugPrint("❌ Fallback notification also failed: $fallbackError");
        }
      }
    }
  }

  NotificationDetails _getPlatformSpecificNotificationDetails() {
    if (Platform.isAndroid) {
      return NotificationDetails(android: _getAndroidNotificationDetails());
    } else if (Platform.isIOS || Platform.isMacOS) {
      return NotificationDetails(
        iOS: _getDarwinNotificationDetails(),
        macOS: _getDarwinNotificationDetails(),
      );
    } else {
      // Default fallback
      return NotificationDetails(
        android: _getAndroidNotificationDetails(),
        iOS: _getDarwinNotificationDetails(),
      );
    }
  }

  AndroidNotificationDetails _getAndroidNotificationDetails() {
    return const AndroidNotificationDetails(
      'sazu_market_notifications', // Channel ID - must match manifest
      'SaZu Market Notifications', // Channel name
      channelDescription:
          'Notifications for orders, updates, and important messages',
      icon: "@mipmap/ic_launcher", // Use app launcher icon
      importance: Importance.high, // High importance for notifications
      priority: Priority.high, // High priority
      enableVibration: true, // Enable vibration
      playSound: true, // Play sound
      showWhen: true, // Show timestamp
      ticker: 'New notification from SaZu Market',
      styleInformation: BigTextStyleInformation(''), // Will be set dynamically
    );
  }

  DarwinNotificationDetails _getDarwinNotificationDetails() {
    return DarwinNotificationDetails(
      presentAlert: true,
      // sound: 'custom_sound.aiff',
      presentBadge: true,
      presentSound: true,
      presentBanner: true,
      presentList: true,
      threadIdentifier: 'thread_id',
      categoryIdentifier: darwinNotificationCategoryPlain,
    );
  }

  /// Handle Message
  void handleMessage(String? url, {bool updateMessages = true}) {
    // bool navBar = _context.read<BottomNavBarController>().hiddenNavBar;
    LogService.i("_handleMessage $url");
    if (url != null) {
      // Uri uri = Uri.parse(url);
      // List<String> segments = uri.pathSegments;
      // String? lastSegment = segments.lastOrNull;

      // if (segments.contains('profile')) {
      //   Navigator.push(_context, AppRoutes.main(_context, true));
      // } else if (segments.contains('my_auction_detail') && lastSegment != null) {
      //   int? id = int.tryParse(lastSegment);
      //   if (id != null) {
      //     Navigator.push(_context, AppRoutes.myAuctionOfferList(_context, id)).then((_) {
      //       _context.read<BottomNavBarController>().changeNavBar(navBar);
      //     });
      //   }
      // } else if (segments.contains('auction_offers') && lastSegment != null) {
      //   int? id = int.tryParse(lastSegment);
      //   if (id != null) {
      //     _context.read<BottomNavBarController>().changeNavBar(true);
      //     Navigator.push(_context, AppRoutes.getAuctionOfferList(id, _context)).then((_) {
      //       _context.read<BottomNavBarController>().changeNavBar(navBar);
      //     });
      //   }
      // } else if (segments.contains('auction') && lastSegment != null) {
      //   int? id = int.tryParse(lastSegment);
      //   if (id != null) {
      //     _context.read<BottomNavBarController>().changeNavBar(true);
      //     Navigator.push(
      //             _context,
      //             AppRoutes.getProductCard(
      //                 model: CarPostModel((p0) => p0..id = id),
      //                 isAuction: true,
      //                 isOffer: false,
      //                 isMine: false))
      //         .then((_) {
      //       _context.read<BottomNavBarController>().changeNavBar(navBar);
      //     });
      //   }
      // } else if (segments.contains('message')) {
      //   String? roomId = uri.queryParameters['room_id'];
      //   if (roomId != null) {
      //     int? id = int.tryParse(roomId);
      //     if (id != null) {
      //       Navigator.of(_context).push(AppRoutes.getChatDetail(roomId: id)).then((_) {
      //         _context.read<BottomNavBarController>().changeNavBar(navBar);
      //       });
      //     }
      //   }
      // } else if (segments.contains('car_detail') && lastSegment != null) {
      //   _context.read<ProfileBloc>().add(const ProfileEvent.getAuctionCarList());
      //   String? action = uri.queryParameters['action'];
      //   int? id = int.tryParse(lastSegment);
      //   if (id != null) {
      //     Navigator.push(
      //       _context,
      //       AppRoutes.getProductCard(
      //           model: CarPostModel((p0) => p0..id = id),
      //           scrollToDiagnostics: action == "go_diagnostic"),
      //     ).then((_) {
      //       _context.read<BottomNavBarController>().changeNavBar(navBar);
      //     });
      //   }
      // } else if (segments.contains('my_ads') && lastSegment != null) {
      //   Navigator.push(_context, AppRoutes.getAds(_context)).then((_) {
      //     _context.read<BottomNavBarController>().changeNavBar(navBar);
      //   });
      // } else if (segments.contains('check-diagnostics')) {
      //   Navigator.push(
      //     _context,
      //     AppRoutes.getBuyoutWebView(
      //       title: "diagnostics".tr(),
      //       url: Constants.addLanguageUrl("/check-diagnostics?mobile=true"),
      //     ),
      //   ).then((_) {
      //     _context.read<BottomNavBarController>().changeNavBar(navBar);
      //   });
      // } else if (segments.contains('auction_create') && lastSegment != null) {
      //   Navigator.push(
      //           _context,
      //           AppRoutes.addCarPage(
      //               hasLicencePlate: false, context: _context, type: AddCarNavigationType.auction))
      //       .then((_) {
      //     _context.read<BottomNavBarController>().changeNavBar(navBar);
      //   });
      // } else if (segments.contains('auction_list') && lastSegment != null) {
      //   Navigator.push(
      //     _context,
      //     AppRoutes.getBuyoutMarketplace(),
      //   ).then((_) {
      //     _context.read<BottomNavBarController>().changeNavBar(navBar);
      //   });
      // } else if (segments.contains('diagnostic_create') && lastSegment != null) {
      //   Navigator.push(
      //     _context,
      //     AppRoutes.getIntroDiagnostics(),
      //   ).then((_) {
      //     _context.read<BottomNavBarController>().changeNavBar(navBar);
      //   });
      // } else if (segments.contains('price_prediction')) {
      //   Navigator.push(
      //       _context,
      //       AppRoutes.getCreateCar(
      //         type: AddCarNavigationType.pricePrediction,
      //       )).then((_) {
      //     _context.read<BottomNavBarController>().changeNavBar(navBar);
      //   });
      // } else {
      //   if (url.startsWith("http")) {
      //     Navigator.push(_context, AppRoutes.getWebView(url));
      //   } else {
      //     Navigator.push(_context, AppRoutes.getWebView(Constants.addLanguageUrl("/$url")));
      //   }
      // }

      // if (updateMessages) {
      //   chatBloc.add(const ChatEvent.getRooms(page: 1));
      //   chatBloc.add(const ChatEvent.getContacts(page: 1));
      //   chatBloc.add(const ChatEvent.getNotifications(
      //     page: 1,
      //   ));
      // }
    }
  }
}
