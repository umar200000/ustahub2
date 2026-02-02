import 'package:flutter/material.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/styles/style.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class CustomFloatActionButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final Widget icon;
  final EdgeInsetsGeometry padding;
  const CustomFloatActionButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.padding = const EdgeInsets.all(6),
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AnimationButtonEffect(
          onTap: onTap,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.primary500,
              shape: BoxShape.circle,
              boxShadow: const [Style.blueIconShadow],
            ),
            child: Padding(padding: padding, child: icon),
          ),
        );
      },
    );
  }
}
