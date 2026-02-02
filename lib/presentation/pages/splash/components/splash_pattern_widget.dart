import 'package:flutter/material.dart';
import 'package:ustahub/presentation/components/marquee_widget.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class SplashPatternWidget extends StatelessWidget {
  const SplashPatternWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: IgnorePointer(
            child: Marquee(
              textDirection: TextDirection.ltr,
              autoRepeat: true,
              pauseDuration: const Duration(milliseconds: 50),
              directionMarguee: DirectionMarguee.oneDirection,
              child: SizedBox(
                width: 900,
                // child: Image.asset(
                //   color: Colors.black,
                //   "assets/images/bcg.png",
                //   fit: BoxFit.fitWidth,
                //   filterQuality: FilterQuality.high,
                // ),
              ),
            ),
          ),
        );
      },
    );
  }
}
