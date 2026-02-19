import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class InfoDetailPage extends StatelessWidget {
  final String titleKey;
  final String contentKey;
  final IconData icon;

  const InfoDetailPage({
    super.key,
    required this.titleKey,
    required this.contentKey,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.shade0,
          body: Column(
            children: [
              UniversalAppBar(
                title: titleKey.tr(),
                showBackButton: true,
                centerTitle: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20.r),
                        decoration: BoxDecoration(
                          color: colors.blue500.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, color: colors.blue500, size: 48.sp),
                      ),
                      Gap(24.h),
                      Text(
                        titleKey.tr(),
                        style: fonts.headingH4Bold.copyWith(
                          color: colors.shade100,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Gap(16.h),
                      Text(
                        contentKey.tr(),
                        style: fonts.paragraphP2Regular.copyWith(
                          color: colors.neutral700,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Gap(32.h),
                      Divider(color: colors.neutral200),
                      Gap(20.h),
                      Text(
                        "contact_email".tr(),
                        style: fonts.paragraphP3Medium.copyWith(
                          color: colors.blue500,
                        ),
                      ),
                      Gap(8.h),
                      if (titleKey == "about_ustahub")
                        Text(
                          "app_version".tr(),
                          style: fonts.paragraphP3Regular.copyWith(
                            color: colors.neutral400,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
