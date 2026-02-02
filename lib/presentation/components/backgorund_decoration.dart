import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class BackgorundDecoration extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const BackgorundDecoration({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Container(
          padding:
              padding ??
              EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 2.h,
                bottom: 2.h,
                left: 10.w,
                right: 10.w,
              ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // image: DecorationImage(image: AssetImage(icons.profileBanner), fit: BoxFit.cover, alignment: Alignment.topCenter),
            gradient: LinearGradient(
              colors: [
                colors.primary500,
                colors.primary500.withOpacity(.9),
                colors.primary500.withOpacity(.7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          height: MediaQuery.of(context).padding.top + 50.h,
          child: child,
        );
      },
    );
  }
}
