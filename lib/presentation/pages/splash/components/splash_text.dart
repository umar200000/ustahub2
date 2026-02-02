import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class SplashText extends StatelessWidget {
  final bool showText;

  const SplashText({super.key, required this.showText});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Center(
          child: AnimatedOpacity(
            opacity: showText ? 1 : 0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutBack,
            child: AnimatedSlide(
              offset: Offset(showText ? .1 : -.4, 0.0),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutBack,
              child: Text(
                'USTAHUB',
                style: fonts.headingH5Bold.copyWith(letterSpacing: 1.2),
              ),
            ),
          ),
        );
      },
    );
  }
}
