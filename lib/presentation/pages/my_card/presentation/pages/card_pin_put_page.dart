import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:ustahub/application2/card_bloc_and_data/bloc/card_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import 'success_card_page.dart';

class CardPinPutPage extends StatefulWidget {
  final int transactionId;
  final String phone;

  const CardPinPutPage({
    super.key,
    required this.transactionId,
    required this.phone,
  });

  @override
  State<CardPinPutPage> createState() => _CardPinPutPageState();
}

class _CardPinPutPageState extends State<CardPinPutPage> {
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String _maskPhone(String phone) {
    if (phone.length < 6) return phone;
    return "+${phone.substring(0, 3)} ${phone.substring(3, 5)} *** ** ${phone.substring(phone.length - 2)}";
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        final defaultPinTheme = PinTheme(
          width: 48.w,
          height: 56.h,
          textStyle: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: colors.neutral800,
          ),
          decoration: BoxDecoration(
            color: colors.shade0,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: colors.neutral300, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        );

        final focusedPinTheme = defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: colors.shade0,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: colors.primary500, width: 2),
            boxShadow: [
              BoxShadow(
                color: colors.primary500.withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        );

        final submittedPinTheme = defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: colors.primary500.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: colors.primary500, width: 1.5),
          ),
        );

        final errorPinTheme = defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: colors.red500.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: colors.red500, width: 2),
          ),
        );

        return Scaffold(
          backgroundColor: colors.shade0,
          body: BlocConsumer<CardBloc, CardState>(
            listener: (context, state) {
              if (state.confirmStatus == Status2.success) {
                FocusScope.of(context).unfocus();
                Future.delayed(const Duration(milliseconds: 150), () {
                  if (mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SuccessCardPage(),
                      ),
                    );
                  }
                });
              } else if (state.confirmStatus == Status2.error) {
                _pinController.clear();
                _focusNode.requestFocus();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? "error".tr()),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state.confirmStatus == Status2.loading;

              return Column(
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
                        children: [
                          // Icon
                          Container(
                            width: 72.w,
                            height: 72.w,
                            decoration: BoxDecoration(
                              color: colors.primary500.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.sms_outlined,
                              size: 36.sp,
                              color: colors.primary500,
                            ),
                          ),
                          Gap(24.h),

                          // Title
                          Text(
                            "enter_code".tr(),
                            style: fonts.headingH4Bold.copyWith(
                              color: colors.neutral800,
                            ),
                          ),
                          Gap(8.h),

                          // Subtitle
                          Text(
                            "sms_code_sent_to"
                                .tr(args: [_maskPhone(widget.phone)]),
                            textAlign: TextAlign.center,
                            style: fonts.paragraphP2Regular.copyWith(
                              color: colors.neutral500,
                              height: 1.5,
                            ),
                          ),
                          Gap(40.h),

                          // Pin input
                          Pinput(
                            length: 6,
                            controller: _pinController,
                            focusNode: _focusNode,
                            autofocus: true,
                            enabled: !isLoading,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            submittedPinTheme: submittedPinTheme,
                            errorPinTheme: errorPinTheme,
                            separatorBuilder: (_) => SizedBox(width: 8.w),
                            hapticFeedbackType: HapticFeedbackType.lightImpact,
                            cursor: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 12.h),
                                  width: 22.w,
                                  height: 2.h,
                                  decoration: BoxDecoration(
                                    color: colors.primary500,
                                    borderRadius: BorderRadius.circular(1.r),
                                  ),
                                ),
                              ],
                            ),
                            onCompleted: (pin) {
                              context.read<CardBloc>().add(
                                ConfirmCardEvent(
                                  transactionId: widget.transactionId,
                                  otp: pin,
                                ),
                              );
                            },
                          ),

                          Gap(32.h),

                          // Loading
                          if (isLoading)
                            SizedBox(
                              width: 28.w,
                              height: 28.w,
                              child: CircularProgressIndicator(
                                color: colors.primary500,
                                strokeWidth: 3,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
