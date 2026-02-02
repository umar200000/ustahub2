import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar({
    super.key,
    required this.count,
    required this.allCount,
  });

  final int count;
  final int allCount;

  @override
  Widget build(BuildContext context) {
    final double barWidth = MediaQuery.of(context).size.width;

    return ThemeWrapper(
      builder: (ctx, colors, fonts, icons, controller) {
        return Stack(
          children: <Widget>[
            Container(height: 8.h, width: barWidth, color: colors.neutral200),
            AnimatedContainer(
              height: 8.h,
              width: barWidth * count / allCount,
              decoration: BoxDecoration(
                color: colors.primary500,
                borderRadius: count == allCount
                    ? BorderRadius.zero
                    : BorderRadius.horizontal(right: Radius.circular(4.r)),
              ),
              duration: const Duration(milliseconds: 300),
            ),
          ],
        );
      },
    );
  }
}
