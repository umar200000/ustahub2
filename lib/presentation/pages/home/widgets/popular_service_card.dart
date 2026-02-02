import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/styles/style.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class PopularServicesCard extends StatelessWidget {
  final String serviceName;
  final String description;
  final IconData icon;
  final Color iconBgColor;
  final VoidCallback? onTap;

  const PopularServicesCard({
    super.key,
    required this.serviceName,
    required this.description,
    required this.icon,
    required this.iconBgColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AnimationButtonEffect(
          onTap: onTap,
          child: Container(
            height: 140.h,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: colors.shade0,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: colors.neutral200),
              boxShadow: Style.shadowMMMM,
            ),
            child: Stack(
              children: [
                // Decorative circles in background
                Positioned(
                  right: -20.w,
                  top: -20.h,
                  child: Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: iconBgColor.withOpacity(0.05),
                    ),
                  ),
                ),
                Positioned(
                  right: 10.w,
                  bottom: -30.h,
                  child: Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: iconBgColor.withOpacity(0.08),
                    ),
                  ),
                ),

                // Content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Icon
                    Container(
                      width: 56.w,
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: iconBgColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Icon(icon, size: 30.sp, color: iconBgColor),
                    ),

                    // Text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          serviceName,
                          style: fonts.headingH5SemiBold.copyWith(
                            fontSize: 16.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        2.h.verticalSpace,
                        Text(
                          description,
                          style: fonts.paragraphP3Regular.copyWith(
                            color: colors.neutral500,
                            fontSize: 13.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
