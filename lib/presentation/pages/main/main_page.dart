import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:ustahub/infrastructure/services/notification_provider.dart';
import 'package:ustahub/infrastructure/services/notification_service.dart';
import 'package:ustahub/presentation/pages/core/app_widget.dart';
import 'package:ustahub/presentation/pages/notification_page/notification_page.dart';
import 'package:ustahub/presentation/components/custom_bottom_nav_bar.dart';
import 'package:ustahub/presentation/pages/favorites/favorites_page.dart';
import 'package:ustahub/presentation/pages/home/home_page.dart';
import 'package:ustahub/presentation/pages/order/main_order_page.dart';
import 'package:ustahub/presentation/pages/profile/profile_page.dart';
import 'package:ustahub/presentation/pages/search/search_page.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class MainPage extends StatefulWidget {
  final int? index;

  const MainPage({super.key, this.index});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  static const _pages = [
    HomePage(),
    SearchPage(),
    FavoritesPage(),
    MainOrderPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _initializeNavBar();
    _initializeNotifications();
  }

  void _initializeNavBar() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final controller = context.read<BottomNavBarController>();
      controller.changeNavBar(false);

      if (widget.index != null) {
        controller.changeIndex(widget.index!);
      }
    });
  }

  void _initializeNotifications() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      final notificationProvider = context.read<NotificationProvider>();
      final plugin = FlutterLocalNotificationsPlugin();

      final notificationService = NotificationService.create(
        context: context,
        flutterLocalNotificationsPlugin: plugin,
        notificationProvider: notificationProvider,
      );

      // Listener'larni o'rnatish (faqat 1 marta)
      notificationService.firebaseCloudMessagingListeners();

      // Init
      try {
        await notificationService.notificationInit();
      } catch (e) {
        // ignore: avoid_print
        print('notificationInit xatolik (lekin listener ishlayapti): $e');
      }

      // App terminated holatda notification bosilgan bo'lsa
      final initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        // Provider'ga qo'shish
        final title = initialMessage.notification?.title ??
            initialMessage.data['title'] ??
            '';
        final body = initialMessage.notification?.body ??
            initialMessage.data['body'] ??
            '';
        if (title.isNotEmpty || body.isNotEmpty) {
          notificationProvider.addNotification(
            title: title,
            body: body,
            data: initialMessage.data,
          );
        }
        _openNotificationPage();
      }

      // FCM Token ni olish
      try {
        final token = await FirebaseMessaging.instance.getToken();
        // ignore: avoid_print
        print('');
        // ignore: avoid_print
        print('========== FCM TOKEN ==========');
        // ignore: avoid_print
        print(token ?? 'TOKEN OLINMADI');
        // ignore: avoid_print
        print('===============================');
        // ignore: avoid_print
        print('');
      } catch (e) {
        // ignore: avoid_print
        print('FCM TOKEN XATOLIK: $e');
      }
    });
  }

  void _openNotificationPage() {
    alice.getNavigatorKey()?.currentState?.push(
      MaterialPageRoute(builder: (_) => const NotificationPage()),
    );
  }

  void _onTabSelected(int index) {
    context.read<BottomNavBarController>().changeIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ThemeWrapper(
      builder: (ctx, colors, fonts, icons, controller) {
        return Consumer<BottomNavBarController>(
          builder: (context, navBarController, _) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: colors.bgSurface,
              body: Stack(
                children: [
                  IndexedStack(
                    index: navBarController.currentIndex,
                    children: _pages,
                  ),
                  if (!navBarController.hiddenNavBar)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: CustomBottomNavBar(
                        currentIndex: navBarController.currentIndex,
                        onTap: _onTabSelected,
                        backgroundColor: colors.shade0,
                        activeColor: colors.blue500,
                        inactiveColor: colors.neutral500,
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
