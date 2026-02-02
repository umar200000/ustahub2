import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import 'auth_button.dart';
import 'enter_phone_number_box.dart';

class AuthContentBox extends StatelessWidget {
  const AuthContentBox({super.key});

  void showEnterNumber(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return EnterPhoneNumberBox();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) => Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: colors.darkMode800,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            16.h.verticalSpace,
            Text(
              textAlign: TextAlign.center,
              'login_or_create_account'.tr(),
              style: fonts.subheadingRegular.copyWith(
                color: colors.shade0,
                fontSize: 24.sp,
                height: 1.2,
              ),
            ),
            SizedBox(height: 24.h),
            AuthButton(
              color: colors.shade0,
              icon: Icons.apple,
              onTap: () {},
              textColor: colors.shade100,
              title: "continue_with_apple".tr(),
            ),
            AuthButton(
              color: colors.blue500,
              icon: Icons.g_mobiledata,
              onTap: () {},
              textColor: colors.shade0,
              title: "continue_with_google".tr(),
            ),
            AuthButton(
              color: const Color(0xFF1877F2),
              icon: Icons.facebook,
              onTap: () {},
              textColor: colors.shade0,
              title: "continue_with_facebook".tr(),
            ),
            AuthButton(
              color: colors.darkMode700,
              icon: Icons.phone_android,
              onTap: () {
                showEnterNumber(context);
              },
              textColor: colors.blue500,
              title: "continue_with_phone".tr(),
            ),

            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  AppRoutes.main(),
                  (route) => false,
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  "continue_as_guest".tr(),
                  style: fonts.paragraphP3SemiBold.copyWith(
                    color: colors.blue500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
