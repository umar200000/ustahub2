import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class BackgroundComp extends StatelessWidget {
  final Widget child;
  const BackgroundComp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colors.primary500,
                    colors.shade0,
                    colors.shade0,
                    colors.shade0,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(icons.profileBanner, height: 200.h),
            ),
            child,
          ],
        );
      },
    );
  }
}
