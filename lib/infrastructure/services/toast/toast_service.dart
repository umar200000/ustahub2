import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

enum ToastType { success, error, warning, info }

class ToastService {
  static OverlayEntry? _currentToast;

  static void showToast({
    required BuildContext context,
    required String title,
    required String description,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    _hideCurrentToast();

    final overlay = Overlay.of(context);

    _currentToast = OverlayEntry(
      builder: (ctx) => _ToastWidget(
        title: title,
        description: description,
        type: type,
        onDismiss: _hideCurrentToast,
      ),
    );

    overlay.insert(_currentToast!);

    Future.delayed(duration, () {
      _hideCurrentToast();
    });
  }

  static void _hideCurrentToast() {
    _currentToast?.remove();
    _currentToast = null;
  }


  static void success({
    required BuildContext context,
    required String title,
    required String description,
    Duration duration = const Duration(seconds: 3),
  }) {
    showToast(
      context: context,
      title: title,
      description: description,
      type: ToastType.success,
      duration: duration,
    );
  }

  static void error({
    required BuildContext context,
    required String title,
    required String description,
    Duration duration = const Duration(seconds: 4),
  }) {
    showToast(
      context: context,
      title: title,
      description: description,
      type: ToastType.error,
      duration: duration,
    );
  }

  static void warning({
    required BuildContext context,
    required String title,
    required String description,
    Duration duration = const Duration(seconds: 3),
  }) {
    showToast(
      context: context,
      title: title,
      description: description,
      type: ToastType.warning,
      duration: duration,
    );
  }

  static void info({
    required BuildContext context,
    required String title,
    required String description,
    Duration duration = const Duration(seconds: 3),
  }) {
    showToast(
      context: context,
      title: title,
      description: description,
      type: ToastType.info,
      duration: duration,
    );
  }
}

class _ToastWidget extends StatelessWidget {
  final String title;
  final String description;
  final ToastType type;
  final VoidCallback onDismiss;

  const _ToastWidget({
    required this.title,
    required this.description,
    required this.type,
    required this.onDismiss,
  });

  Color _getBackgroundColor() {
    switch (type) {
      case ToastType.success:
        return const Color(0xFF4CAF50);
      case ToastType.error:
        return const Color(0xFFE53935);
      case ToastType.warning:
        return const Color(0xFFFFA726);
      case ToastType.info:
        return const Color(0xFF42A5F5);
    }
  }


  IconData _getIcon() {
    switch (type) {
      case ToastType.success:
        return Icons.check_circle;
      case ToastType.error:
        return Icons.error;
      case ToastType.warning:
        return Icons.warning;
      case ToastType.info:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.up,
          onDismissed: (_) => onDismiss(),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getBackgroundColor(),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(_getIcon(), color: Colors.white, size: 28),
                Gap(12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style:  TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Gap(4.h),
                      Text(description,
                          style:
                          TextStyle(fontSize: 14.sp, color: Colors.white)),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onDismiss,
                  icon: const Icon(Icons.close, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
