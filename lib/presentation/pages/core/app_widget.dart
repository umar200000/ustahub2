import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/infrastructure/core/interceptors.dart';
import 'package:ustahub/infrastructure/services/alice/alice.dart';
import 'package:ustahub/infrastructure/services/alice/model/alice_configuration.dart';
import 'package:ustahub/infrastructure/services/local_database/db_service.dart';
import 'package:ustahub/presentation/components/un_focus_widget.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme.dart';

// Initialize Alice once and reuse
final AliceChopperAdapter aliceChopperAdapter = AliceChopperAdapter();
final Alice alice = Alice(
  configuration: AliceConfiguration(
    showNotification: true,
    showInspectorOnShake: false,
  ),
)..addAdapter(aliceChopperAdapter);

class MyApp extends StatelessWidget {
  final DBService dbService;
  final bool connectivityX;
  final Function(BuildContext context)? onGetContext;

  const MyApp({
    super.key,
    required this.dbService,
    required this.connectivityX,
    this.onGetContext,
  });

  @override
  Widget build(BuildContext context) {
    // Remove splash screen
    FlutterNativeSplash.remove();

    // Optimize system UI settings
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top],
    );

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        precacheImage(
          const AssetImage('assets/images/logo_launcher.png'),
          context,
        );

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => GlobalController.create(dbService),
              lazy: false, // Initialize immediately for critical data
            ),
            ChangeNotifierProvider(
              create: (_) => BottomNavBarController.create(),
              lazy: true, // Can be lazy loaded
            ),
            Provider<DBService>.value(value: dbService),
          ],
          child: OnUnFocusTap(
            child: MaterialApp(
              navigatorKey: alice.getNavigatorKey(),
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                if (child == null) return const SizedBox.shrink();

                // Apply text scaling for better readability
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: TextScaler.linear(1.0), // Prevent text scaling
                  ),
                  child: FlutterSmartDialog.init()(context, child),
                );
              },
              navigatorObservers: [FlutterSmartDialog.observer],
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              onGenerateRoute: (_) {
                if (onGetContext != null) {
                  onGetContext!(context);
                }
                return AppRoutes.onGenerateRoute(
                  context: context,
                  notConnection: !connectivityX,
                  isVerified: dbService.getVerified ?? true,
                );
              },
              // Performance optimizations
              themeMode: ThemeMode.system, // Respect system theme
              highContrastTheme: null, // Disable high contrast themes
              highContrastDarkTheme: null,
              themeAnimationDuration: const Duration(
                milliseconds: 200,
              ), // Faster theme transitions
              restorationScopeId: 'app', // Enable state restoration
            ),
          ),
        );
      },
    );
  }
}
