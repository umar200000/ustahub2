import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ustahub/presentation/pages/auth/widgets/auth_button.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class SuccessCardPage extends StatelessWidget {
  const SuccessCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.shade0,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // Success Image
                Image.asset(
                  "assets/images/success.png",
                  width: 200.w,
                  height: 200.w,
                  fit: BoxFit.contain,
                ),
                Gap(32.h),

                // Title
                Text(
                  "card_added_successfully"
                      .tr(), // "Karta muvaffaqiyatli qo'shildi"
                  textAlign: TextAlign.center,
                  style: fonts.headingH4Bold.copyWith(
                    color: colors.neutral800,
                    fontSize: 24.sp,
                  ),
                ),
                Gap(16.h),

                // Subtitle
                Text(
                  "card_added_message".tr(),
                  textAlign: TextAlign.center,
                  style: fonts.paragraphP2Regular.copyWith(
                    color: colors.neutral500,
                  ),
                ),

                const Spacer(),

                // Bottom Button
                AuthButton(
                  title: "back_to_home".tr(),
                  onTap: () {
                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pushAndRemoveUntil(AppRoutes.main(), (route) => false);
                  },
                  color: colors.primary500,
                  textColor: colors.shade0,
                ),
                Gap(32.h + MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
        );
      },
    );
  }
}
