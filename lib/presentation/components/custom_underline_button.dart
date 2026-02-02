import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/styles/theme.dart';

class CustomUnderlineTextButton extends StatelessWidget {
  const CustomUnderlineTextButton({
    super.key,
    required this.colors,
    required this.fonts,
    required this.text,
    required this.onPressed,
    this.fontSize = 16,
  });
  final CustomColorSet colors;
  final FontSet fonts;
  final String text;
  final VoidCallback onPressed;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        foregroundColor: colors.shade100.withOpacity(0.7),
        textStyle: fonts.headingH6Medium.copyWith(
          fontSize: 16.sp,
          decoration: TextDecoration.underline,
        ),
        minimumSize: Size(50, 22.h),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
      ),
      onPressed: onPressed,
      child: Text(semanticsLabel: text, text, textAlign: TextAlign.center),
    );
  }
}
