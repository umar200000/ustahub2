import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import 'success_card_page.dart';

class CardPinPutPage extends StatefulWidget {
  const CardPinPutPage({super.key});

  @override
  State<CardPinPutPage> createState() => _CardPinPutPageState();
}

class _CardPinPutPageState extends State<CardPinPutPage> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        final defaultPinTheme = PinTheme(
          width: 60.w,
          height: 64.h,
          textStyle: fonts.subheadingBold.copyWith(
            color: colors.neutral800,
            fontSize: 22.sp,
          ),
          decoration: BoxDecoration(
            color: colors.neutral100.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: colors.neutral200),
          ),
        );

        final focusedPinTheme = defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: colors.primary500, width: 2),
          ),
        );

        return Scaffold(
          backgroundColor: colors.shade0,
          body: Column(
            children: [
              UniversalAppBar(
                title: "verify_code".tr(),
                showBackButton: true,
                centerTitle: true,
                backgroundColor: colors.primary500,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 32.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "enter_code".tr(),
                        style: fonts.headingH4Bold.copyWith(
                          color: colors.neutral800,
                        ),
                      ),
                      Gap(12.h),
                      Text(
                        "sms_code_sent_to".tr(args: ["+998 93 *** ** 90"]),
                        style: fonts.paragraphP2Regular.copyWith(
                          color: colors.neutral500,
                        ),
                      ),
                      Gap(32.h),

                      Center(
                        child: Pinput(
                          length: 5,
                          autofocus: true,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          onCompleted: (pin) {
                            // On pin completion, replace current route with success page
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SuccessCardPage(),
                              ),
                            );
                          },
                        ),
                      ),

                      Gap(24.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "00:52",
                            style: fonts.paragraphP3Medium.copyWith(
                              color: colors.neutral500,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "resend_code".tr(),
                              style: fonts.paragraphP3SemiBold.copyWith(
                                color: colors.primary500,
                              ),
                            ),
                          ),
                        ],
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
