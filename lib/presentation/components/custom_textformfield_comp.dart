import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class CustomTextFieldComp extends StatelessWidget {
  const CustomTextFieldComp({
    super.key,
    this.label,
    this.type,
    this.onTap,
    this.controller,
    this.readOnly = false,
    this.trailingIcon = false,
    this.onTapTrailingIcon,
    this.inputFormatters,
    this.initialValue,
  });

  final String? label;
  final TextInputType? type;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextEditingController? controller;
  final bool trailingIcon;
  final VoidCallback? onTapTrailingIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, _) {
        return TextFormField(
          initialValue: initialValue,
          inputFormatters: inputFormatters,
          controller: controller,
          onTap: onTap,
          readOnly: readOnly,
          keyboardType: type,
          cursorColor: colors.neutral800,
          decoration: InputDecoration(
            suffixIcon: trailingIcon
                ? IconButton(
                    onPressed: onTapTrailingIcon,
                    icon: icons.editO.svg(color: colors.neutral800, height: 16),
                  )
                : null,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colors.neutral800),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colors.neutral800),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: colors.neutral800),
            ),
            label: Text(
              semanticsLabel: label ?? '',
              label ?? '',
              textAlign: TextAlign.center,
              style: fonts.paragraphP2Regular.copyWith(
                color: colors.neutral800.withOpacity(0.7),
                fontSize: 12.sp,
              ),
            ),
          ),
        );
      },
    );
  }
}
