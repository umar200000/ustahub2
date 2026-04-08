import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ustahub/presentation/pages/auth/widgets/auth_button.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import '../../../main/main_page.dart';

class SuccessCardPage extends StatelessWidget {
  final bool fromPayment;
  const SuccessCardPage({super.key, this.fromPayment = false});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) {
              if (fromPayment) {
                // Stack: PaymentPage → AddCardPage → SuccessCardPage
                // Pop 2 times to return to PaymentPage
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 2);
              } else {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainPage(index: 3),
                  ),
                  (route) => false,
                );
              }
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
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
                    title: fromPayment ? "continue_payment".tr() : "back_to_home".tr(),
                    onTap: () {
                      if (fromPayment) {
                        // Stack: PaymentPage → AddCardPage → SuccessCardPage
                        // Pop 2 times to return to PaymentPage
                        int count = 0;
                        Navigator.of(context).popUntil((_) => count++ >= 2);
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MainPage()),
                          (route) => false,
                        );
                      }
                    },
                    color: colors.primary500,
                    textColor: colors.shade0,
                  ),
                  Gap(32.h + MediaQuery.of(context).padding.bottom),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
