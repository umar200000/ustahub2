import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class CSeparator extends StatelessWidget {
  const CSeparator({super.key, required this.width, required this.color});

  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final boxHeight = constraints.constrainHeight();
            final dashWidth = width;
            final dashHeight = 2.h;
            final dashCount = (boxHeight / (3 * dashHeight)).floor();
            return Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.vertical,
              children: List.generate(dashCount, (_) {
                return SizedBox(
                  width: dashWidth,
                  height: dashHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                );
              }),
            );
          },
        );
      },
    );
  }
}
