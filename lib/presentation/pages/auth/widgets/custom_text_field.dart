import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefix;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomTextField({
    super.key,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.prefix,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) => Container(
        height: 56.h,
        decoration: BoxDecoration(
          color: colors.darkMode700,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.shade0.withOpacity(0.1)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        alignment: Alignment.center,
        child: Row(
          children: [
            if (prefix != null) ...[prefix!, 8.w.horizontalSpace],
            Expanded(
              child: TextField(
                controller: this.controller,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                readOnly: readOnly,
                onTap: onTap,
                style: fonts.paragraphP2SemiBold.copyWith(
                  color: colors.shade0,
                  fontSize: 16.sp,
                ),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: fonts.paragraphP2SemiBold.copyWith(
                    color: colors.shade0.withOpacity(0.3),
                    fontSize: 16.sp,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
