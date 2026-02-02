import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class CDivider extends StatelessWidget {
  final EdgeInsets? padding;
  final Color? color;
  const CDivider({super.key, this.padding, this.color});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Padding(
          padding: padding ?? EdgeInsets.symmetric(vertical: 16.h),
          child: Divider(
            height: 0,
            color: color ?? colors.neutral200,
            thickness: 1.h,
          ),
        );
      },
    );
  }
}
