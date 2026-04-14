import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/styles/theme.dart';

class SettingsMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;
  final bool showTrailing;
  final Color? iconColor;
  final Color? titleColor;
  final FontSet fonts;
  final CustomColorSet colors;

  const SettingsMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.fonts,
    required this.colors,
    this.trailing,
    this.showTrailing = false,
    this.iconColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? colors.blue500;
    return AnimationButtonEffect(
      onTap: onTap,
      scaleFactor: 0.98,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: effectiveIconColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10.r),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: effectiveIconColor, size: 18.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: fonts.paragraphP1Regular.copyWith(
                  color: titleColor ?? colors.neutral800,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (trailing != null)
              trailing!
            else if (showTrailing)
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: colors.neutral400,
                size: 14.sp,
              ),
          ],
        ),
      ),
    );
  }
}
