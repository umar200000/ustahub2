import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class ShimmerView extends StatelessWidget {
  final Widget child;
  final bool forText;
  final bool isEnabled;

  const ShimmerView({
    super.key,
    required this.child,
    this.forText = false,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        if (!isEnabled) {
          // If shimmer is disabled, return the child widget directly.
          return child;
        }

        return Shimmer.fromColors(
          period: forText
              ? const Duration(milliseconds: 1000)
              : const Duration(milliseconds: 1500),
          baseColor: forText ? colors.neutral400 : colors.neutral200,
          highlightColor: colors.neutral100,
          child: child,
        );
      },
    );
  }
}

class ShimmerContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const ShimmerContainer({
    super.key,
    this.height,
    this.width,
    this.child,
    this.borderRadius,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height?.h,
      width: width?.w,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
      ),
      child: child,
    );
  }
}

class ShimmerWrapBox extends StatelessWidget {
  final Widget child;

  const ShimmerWrapBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
