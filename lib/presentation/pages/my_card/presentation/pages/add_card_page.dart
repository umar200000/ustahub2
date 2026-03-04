import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/pages/auth/widgets/auth_button.dart';
import 'package:ustahub/presentation/pages/auth/widgets/custom_text_field.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';
import 'package:ustahub/utils/extensions.dart';

import 'card_pin_put_page.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.shade0,
          body: Column(
            children: [
              UniversalAppBar(
                title: "add_card".tr(),
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
                    children: [
                      // Card Number Input
                      CustomTextField(
                        controller: _cardNumberController,
                        hintText: "0000 0000 0000 0000",
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                          CardNumberFormatter(),
                        ],
                        prefix: Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: Icon(
                            Icons.credit_card,
                            color: Colors.black87,
                            size: 24.sp,
                          ),
                        ),
                      ),
                      Gap(20.h),

                      // Expiry and CVV
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: _expiryController,
                              hintText: "MM/YY",
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                                CardMMYYFormatter(),
                              ],
                            ),
                          ),
                          Gap(16.w),
                          Expanded(
                            child: CustomTextField(
                              controller: _cvvController,
                              hintText: "CVV",
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Gap(60.h),

                      // Add Card Button
                      AuthButton(
                        title: "add_card".tr(),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CardPinPutPage(),
                            ),
                          );
                        },
                        color: colors.primary500,
                        textColor: colors.shade0,
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
