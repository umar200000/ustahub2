import 'package:flutter/material.dart';

class AppBreakpoints {
  AppBreakpoints._();

  static const double tabletStart = 600;
  static const double largeTabletStart = 900;

  /// Width that ScreenUtil sees. Set BELOW designSize.width (375) so
  /// `.w/.sp/.h` extensions scale to ~0.91x — content stays compact, never
  /// blowing up on bigger phones or tablets.
  ///
  /// To make UI smaller globally, lower this number. To allow bigger UI,
  /// raise it (max useful value: ~designSize.width = 375).
  static const double scaleCapWidth = 340;

  /// Height that ScreenUtil sees. Kept proportional to scaleCapWidth vs
  /// designSize.height (812) so width/height scaling stay consistent.
  /// 340/375 * 812 ≈ 736.
  static const double scaleCapHeight = 736;
}

extension ResponsiveContext on BuildContext {
  double get _deviceWidth => MediaQuery.of(this).size.width;
  bool get isPhone => _deviceWidth < AppBreakpoints.tabletStart;
  bool get isTablet =>
      _deviceWidth >= AppBreakpoints.tabletStart &&
      _deviceWidth < AppBreakpoints.largeTabletStart;
  bool get isLargeTablet => _deviceWidth >= AppBreakpoints.largeTabletStart;
  bool get isTabletOrLarger => _deviceWidth >= AppBreakpoints.tabletStart;
}

/// Caps the size that `ScreenUtilInit` sees so `.w/.sp/.h` extensions never
/// scale up beyond the cap. Applies to every device whose width or height
/// exceeds the cap (so even modern phones get ~10% smaller UI; tiny phones
/// like iPhone SE keep their natural <1.0x scaling).
///
/// The actual layout still fills the real device because `MaterialApp`
/// re-creates its own `MediaQuery` from the real `View` further down the tree.
class AdaptiveAppFrame extends StatefulWidget {
  final Widget child;

  const AdaptiveAppFrame({super.key, required this.child});

  @override
  State<AdaptiveAppFrame> createState() => _AdaptiveAppFrameState();
}

class _AdaptiveAppFrameState extends State<AdaptiveAppFrame>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final view = View.of(context);
    final mq = MediaQueryData.fromView(view);

    final cappedWidth = mq.size.width > AppBreakpoints.scaleCapWidth
        ? AppBreakpoints.scaleCapWidth
        : mq.size.width;
    final cappedHeight = mq.size.height > AppBreakpoints.scaleCapHeight
        ? AppBreakpoints.scaleCapHeight
        : mq.size.height;

    if (cappedWidth == mq.size.width && cappedHeight == mq.size.height) {
      return widget.child;
    }

    return MediaQuery(
      data: mq.copyWith(size: Size(cappedWidth, cappedHeight)),
      child: widget.child,
    );
  }
}
