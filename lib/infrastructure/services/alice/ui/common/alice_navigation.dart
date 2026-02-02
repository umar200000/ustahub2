import 'package:ustahub/infrastructure/services/alice/core/alice_core.dart';
import 'package:ustahub/infrastructure/services/alice/model/alice_http_call.dart';
import 'package:ustahub/infrastructure/services/alice/ui/call_details/page/alice_call_details_page.dart';
import 'package:ustahub/infrastructure/services/alice/ui/calls_list/page/alice_calls_list_page.dart';
import 'package:ustahub/infrastructure/services/alice/ui/stats/alice_stats_page.dart';
import 'package:flutter/material.dart';

/// Simple navigation helper class for Alice.
class AliceNavigation {
  /// Navigates to calls list page with error handling
  static Future<void> navigateToCallsList({required AliceCore core}) async {
    try {
      final context = core.getContext();
      if (context == null) {
        throw StateError(
          "Context is null in AliceCore. Ensure NavigatorKey is properly set.",
        );
      }

      // Check if the widget is still mounted before navigating
      if (!context.mounted) return;

      await Navigator.push<void>(
        context,
        MaterialPageRoute(builder: (context) => AliceCallsListPage(core: core)),
      );
    } catch (e) {
      debugPrint('Alice navigation error: $e');
      // You might want to add proper error reporting here
    }
  }

  /// Navigates to call details page with error handling
  static Future<void> navigateToCallDetails({
    required AliceHttpCall call,
    required AliceCore core,
  }) async {
    try {
      final context = core.getContext();
      if (context == null) {
        throw StateError(
          "Context is null in AliceCore. Ensure NavigatorKey is properly set.",
        );
      }

      if (!context.mounted) return;

      await Navigator.push<void>(
        context,
        MaterialPageRoute(
          builder: (context) => AliceCallDetailsPage(call: call, core: core),
        ),
      );
    } catch (e) {
      debugPrint('Alice navigation error: $e');
    }
  }

  /// Navigates to stats page with error handling
  static Future<void> navigateToStats({required AliceCore core}) async {
    try {
      final context = core.getContext();
      if (context == null) {
        throw StateError(
          "Context is null in AliceCore. Ensure NavigatorKey is properly set.",
        );
      }

      if (!context.mounted) return;

      await Navigator.push<void>(
        context,
        MaterialPageRoute(builder: (context) => AliceStatsPage(core)),
      );
    } catch (e) {
      debugPrint('Alice navigation error: $e');
    }
  }
}
