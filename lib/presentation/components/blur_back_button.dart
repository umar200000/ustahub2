import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class BlurBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const BlurBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AnimationButtonEffect(
          onTap: onTap ?? () => Navigator.pop(context),
          child: Container(
            height: 38.r,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: colors.shade100.withOpacity(.3),
              boxShadow: colors.shadowMM,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_back, color: colors.shade0, size: 22.r),
                4.w.horizontalSpace,
                Text(
                  "back".tr(),
                  style: fonts.paragraphP2SemiBold.copyWith(
                    color: colors.shade0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
