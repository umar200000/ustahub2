// import 'dart:developer';

// import 'package:app_links/app_links.dart';
// import 'package:ustahub/infrastructure/services/log_service.dart';
// import 'package:ustahub/infrastructure/services/notification_service.dart';

// /// Provides methods to manage dynamic links.
// final class DynamicLinkService {
//   DynamicLinkService._();

//   static final instance = DynamicLinkService._();

//   final _appLinks = AppLinks();
//   NotificationService? _notification;

//   /// Initializes the [DynamicLinkService].
//   Future<void> initialize(NotificationService notification) async {
//     _notification = notification;

//     _appLinks.uriLinkStream.listen(_handleLinkData).onError((error) {
//       log('$error', name: 'Dynamic Link Handler');
//     });
//     _checkInitialLink();
//   }

//   /// Handle navigation if initial link is found on app start.
//   Future<void> _checkInitialLink() async {
//     final initialLink = await _appLinks.getInitialLink();
//     if (initialLink != null) {
//       _handleLinkData(initialLink);
//     }
//   }

//   /// Handles the link navigation Dynamic Links.
//   void _handleLinkData(Uri data) {
//     final queryParams = data.pathSegments;
//     LogService.i("_handleLinkData: $queryParams");
//     if (queryParams.isNotEmpty) {
//       _notification?.handleMessage(data.path);
//     }
//   }
// }
