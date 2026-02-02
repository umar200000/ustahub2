// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:ustahub/presentation/pages/splash/components/splash_container.dart';
// import 'package:ustahub/presentation/pages/splash/components/splash_pattern_widget.dart';
// import 'package:ustahub/presentation/pages/splash/components/splash_text.dart';
// import 'package:ustahub/presentation/styles/theme_wrapper.dart';

// class SplashScreen extends StatefulWidget {
//   final MaterialPageRoute route;
//   const SplashScreen({super.key, required this.route});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   final _navigatorKey = GlobalKey<NavigatorState>();

//   NavigatorState get navigator => _navigatorKey.currentState!;
//   Timer? timer;

//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarIconBrightness: Brightness.light,
//         systemNavigationBarColor: Colors.transparent,
//       ),
//     );
//     SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.edgeToEdge,
//       overlays: [SystemUiOverlay.top],
//     );

//     _animate();
//   }

//   _animate() {
//     timer?.cancel();
//     timer = Timer.periodic(const Duration(milliseconds: 750), (timer) {
//       setState(() {});
//       if (timer.tick == 4) {
//         timer.cancel();
//         Future.delayed(const Duration(milliseconds: 100)).then(
//           (value) => Navigator.of(
//             context,
//           ).pushAndRemoveUntil(widget.route, (route) => false),
//         );
//       }
//     });
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.light,
//         systemNavigationBarContrastEnforced: false,
//         systemNavigationBarColor: Colors.transparent,
//         systemNavigationBarIconBrightness: Brightness.light,
//       ),
//       child: ThemeWrapper(
//         builder: (context, colors, fonts, icons, controller) {
//           return Scaffold(
//             body: Stack(
//               children: [
//                 const SplashPatternWidget(),
//                 // Positioned(child: SplashText(showText: timer?.tick == 2)),
//                 // Positioned(child: SplashContainer(tick: timer?.tick)),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// Route scaleIn(Widget page) {
//   return PageRouteBuilder(
//     transitionDuration: const Duration(milliseconds: 400),
//     pageBuilder: (context, animation, secondaryAnimation) => page,
//     transitionsBuilder: (context, animation, secondaryAnimation, page) {
//       var begin = 0.3;
//       var end = 1.0;
//       var curve = Curves.ease;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//       return FadeTransition(
//         opacity: animation.drive(
//           Tween(begin: .65, end: 1.0).chain(CurveTween(curve: curve)),
//         ),
//         child: ScaleTransition(scale: animation.drive(tween), child: page),
//       );
//     },
//   );
// }
