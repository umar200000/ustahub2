import 'package:easy_localization/easy_localization.dart';
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
    return AnimationButtonEffect(
      onTap: onTap,
      scaleFactor: 0.95,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? colors.neutral600, size: 24.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: fonts.paragraphP1Regular.copyWith(
                  color: titleColor ?? colors.shade100,
                ),
              ),
            ),
            if (trailing != null)
              trailing!
            else if (showTrailing)
              Icon(Icons.chevron_right, color: colors.neutral500, size: 24.sp),
          ],
        ),
      ),
    );
  }
}
