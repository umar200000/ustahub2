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
  final bool error;

  const CustomTextField({
    super.key,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.prefix,
    this.readOnly = false,
    this.onTap,
    this.error = false,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, themeController) => Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: colors.neutral50,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: error ? colors.red500 : colors.neutral200,
            width: 1.5,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        alignment: Alignment.center,
        child: Row(
          children: [
            if (prefix != null) ...[prefix!, 12.w.horizontalSpace],
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                readOnly: readOnly,
                onTap: onTap,
                style: fonts.paragraphP2Bold.copyWith(
                  color: Colors.black87,
                  fontSize: 16.sp,
                ),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: fonts.paragraphP2Medium.copyWith(
                    color: colors.neutral500,
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
