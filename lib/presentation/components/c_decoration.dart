import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class CDecoration extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? radius;
  final Color? color;
  final BoxBorder? border;
  const CDecoration({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.radius,
    this.color,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Container(
          padding:
              padding ?? EdgeInsets.symmetric(vertical: 16.h, horizontal: 18.w),
          margin: margin ?? EdgeInsets.only(bottom: 4.h),
          decoration: BoxDecoration(
            color: color ?? colors.shade0,
            borderRadius: BorderRadius.circular(radius ?? 12.r),
            border: border,
            boxShadow: colors.shadowMMMM,
          ),
          child: child,
        );
      },
    );
  }
}
