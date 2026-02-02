import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:ustahub/presentation/routes/routes.dart'; // To'g'ri import
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class PinPutWidget extends StatefulWidget {
  const PinPutWidget({super.key});

  @override
  State<PinPutWidget> createState() => _PinPutWidgetState();
}

class _PinPutWidgetState extends State<PinPutWidget> {
  late Timer _timer;
  int _secondsRemaining = 120; // 2 minut
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 120;
      _canResend = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _canResend = true;
          _timer.cancel();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        final defaultPinTheme = PinTheme(
          width: 50.w,
          height: 56.h,
          textStyle: fonts.subheadingRegular.copyWith(
            color: colors.shade0,
            fontSize: 22.sp,
          ),
          decoration: BoxDecoration(
            color: colors.darkMode700,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors.shade0.withOpacity(0.1)),
          ),
        );

        final focusedPinTheme = defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: colors.blue500),
          ),
        );

        return Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 16.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 32.h,
          ),
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
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: colors.shade0.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              24.h.verticalSpace,
              Text(
                'enter_sms_code'.tr(),
                style: fonts.subheadingRegular.copyWith(
                  color: colors.shade0,
                  fontSize: 22.sp,
                ),
              ),
              24.h.verticalSpace,
              Pinput(
                autofocus: true,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                separatorBuilder: (index) => SizedBox(width: 8.w),
                onCompleted: (pin) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    AppRoutes.main(),
                    (route) => false,
                  );
                },
              ),
              24.h.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _formatTime(_secondsRemaining),
                    style: fonts.paragraphP3Medium.copyWith(
                      color: colors.shade0.withOpacity(0.7),
                    ),
                  ),
                  12.w.horizontalSpace,
                  GestureDetector(
                    onTap: _canResend ? _startTimer : null,
                    child: Text(
                      'resend_code'.tr(),
                      style: fonts.paragraphP3SemiBold.copyWith(
                        color: _canResend
                            ? colors.blue500
                            : colors.shade0.withOpacity(0.3),
                      ),
                    ),
                  ),
                ],
              ),
              16.h.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
