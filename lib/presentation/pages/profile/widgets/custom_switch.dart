import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/styles/theme.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final CustomColorSet colors;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationButtonEffect(
      onTap: () => onChanged(!value),
      scaleFactor: 0.9,
      child: Container(
        width: 51.w,
        height: 31.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: value ? colors.blue500 : colors.neutral200,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.all(2.w),
            width: 27.w,
            height: 27.h,
            decoration: BoxDecoration(
              color: colors.shade0,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: Color(0x12000000),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
