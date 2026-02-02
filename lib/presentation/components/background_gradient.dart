import 'package:flutter/material.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class BackgroundGradient extends StatelessWidget {
  final Alignment alignment;

  const BackgroundGradient({super.key, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        final defaultColor = colors.primary500.withOpacity(0.2);

        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [defaultColor, Colors.transparent],
              stops: const [0.1, 0.5],
              radius: 2,
              center: alignment,
            ),
          ),
        );
      },
    );
  }
}
