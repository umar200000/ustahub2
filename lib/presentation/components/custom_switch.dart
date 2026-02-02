import 'package:flutter/material.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class CSwitch extends StatelessWidget {
  final bool value;
  final void Function(bool) onChanged;
  const CSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Switch(
          value: value,
          onChanged: onChanged,
          activeColor: colors.shade0,
          inactiveThumbColor: colors.shade0,
          inactiveTrackColor: colors.neutral500,
          trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((state) {
            if (state.contains(WidgetState.selected)) {
              return colors.primary500;
            }
            return colors.neutral500;
          }),
          trackColor: WidgetStateProperty.resolveWith<Color?>((state) {
            if (state.contains(WidgetState.selected)) {
              return colors.primary500;
            }
            return colors.neutral500;
          }),
        );
      },
    );
  }
}
