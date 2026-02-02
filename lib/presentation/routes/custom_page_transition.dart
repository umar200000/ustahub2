import 'package:flutter/material.dart';

class OptimizedPageRoute<T> extends MaterialPageRoute<T> {
  OptimizedPageRoute({
    required super.builder,
    super.settings,
    super.maintainState,
    super.fullscreenDialog,
  });

  @override
  Duration get transitionDuration => const Duration(milliseconds: 150);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 150);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (settings.name == '/') return child;

    // Use a simple fade transition for dialogs
    if (fullscreenDialog) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }

    // Use an optimized slide transition for regular pages
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
          reverseCurve: Curves.easeInOut,
        ),
      ),
      child: child,
    );
  }
}
