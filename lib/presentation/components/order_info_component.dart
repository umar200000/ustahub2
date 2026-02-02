import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class OrderLocationInfo extends StatelessWidget {
  final String? addressTitle;
  final String? addressName;

  const OrderLocationInfo({
    super.key,
    required this.addressTitle,
    required this.addressName,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: colors.neutral200,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              icons.locationS.svg(
                height: 20.r,
                width: 20.r,
                color: colors.red500,
              ),
              6.w.horizontalSpace,
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${addressTitle ?? ""}, ",
                        style: fonts.paragraphP2SemiBold,
                      ),
                      TextSpan(
                        text: addressName ?? "",
                        style: fonts.paragraphP2Regular,
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

class OrderPaymentInfo extends StatelessWidget {
  final String? paymentName;

  const OrderPaymentInfo({super.key, required this.paymentName});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        final isCash = (paymentName ?? "") == "Cash";

        return Row(
          children: [
            !isCash
                ? icons.creditCardS.svg(
                    height: 16.r,
                    width: 16.r,
                    color: colors.blue500,
                  )
                : icons.walletS.svg(height: 16.r, width: 16.r),
            6.w.horizontalSpace,
            Text(
              isCash ? "cash".tr() : "card".tr(),
              style: fonts.paragraphP2Regular,
            ),
          ],
        );
      },
    );
  }
}
