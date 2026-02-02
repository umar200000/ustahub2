import 'package:flutter/material.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class CustomRadioTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String title;
  final Function(dynamic) onChanged;
  const CustomRadioTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (ctx, colors, fonts, icons, _) {
        return RadioListTile(
          title: Text(
            semanticsLabel: title,
            title,
            style: fonts.paragraphP2SemiBold,
          ),
          value: value,
          groupValue: groupValue,
          onChanged: (ctx) => onChanged(ctx),
        );
      },
    );
  }
}
