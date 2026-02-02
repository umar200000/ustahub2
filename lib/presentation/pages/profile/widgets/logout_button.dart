import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/styles/theme.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onTap;
  final FontSet fonts;
  final CustomColorSet colors;

  const LogoutButton({
    super.key,
    required this.onTap,
    required this.fonts,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationButtonEffect(
      onTap: onTap,
      scaleFactor: 0.95,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: colors.shade0,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 8,
              spreadRadius: 0,
              color: Color(0x08000000),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: colors.red500, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              'logout'.tr(),
              style: fonts.paragraphP1SemiBold.copyWith(color: colors.red500),
            ),
          ],
        ),
      ),
    );
  }
}
