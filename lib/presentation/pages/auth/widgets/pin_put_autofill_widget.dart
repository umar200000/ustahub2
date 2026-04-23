import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:ustahub/application2/auth_bloc_and_data/bloc/auth_pin_put_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';
import 'package:ustahub/utils/sms_helper.dart';

import '../../../../application2/auth_bloc_and_data/bloc/auth_bloc.dart';
import '../../../../application2/register_bloc_and_data/bloc/register_bloc.dart';
import '../../../../infrastructure2/init/injection.dart';

class PinPutAutofillWidget extends StatefulWidget {
  const PinPutAutofillWidget({super.key});

  @override
  State<PinPutAutofillWidget> createState() => _PinPutAutofillWidgetState();
}

class _PinPutAutofillWidgetState extends State<PinPutAutofillWidget>
    with CodeAutoFill {
  final authBloc = sl<AuthBloc>();
  final register = sl<RegisterBloc>();
  final pinPutBloc = sl<AuthPinPutBloc>();
  final TextEditingController _pinController = TextEditingController();

  late Timer _timer;
  int _secondsRemaining = 0;
  bool _canResend = false;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    listenForCode();
    if (kReleaseMode) {
      SmsHelper.printAppSignatureForBackend();
    }
  }

  @override
  void codeUpdated() {
    final incoming = code ?? '';
    final match = RegExp(r'\d{6}').firstMatch(incoming);
    final otp = match?.group(0);
    if (otp == null || otp.length != 6) return;

    _pinController.text = otp;
    _submitOtp(otp);
  }

  void _submitOtp(String pin) {
    if (_submitted) return;
    _submitted = true;
    final phone = authBloc.state.authPhoneNumber?.data?.phone;
    if (phone == null) return;
    pinPutBloc.add(VerifyOtpEvent(phoneNumber: phone, code: pin));
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining =
          authBloc.state.authPhoneNumber!.data!.expiresInSeconds!;
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
    cancel();
    SmsAutoFill().unregisterListener();
    _pinController.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authBloc),
        BlocProvider.value(value: register),
        BlocProvider.value(value: pinPutBloc),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.phoneStatus != current.phoneStatus &&
                current.phoneStatus == Status2.success,
            listener: (context, state) {
              _timer.cancel();
              _startTimer();
              _submitted = false;
              _pinController.clear();
              listenForCode();
            },
          ),
          BlocListener<AuthPinPutBloc, AuthPinPutState>(
            listenWhen: (previous, current) =>
                previous.status != current.status &&
                current.status == Status2.error,
            listener: (context, state) {
              _submitted = false;
              _pinController.clear();
            },
          ),
          BlocListener<AuthPinPutBloc, AuthPinPutState>(
            listenWhen: (previous, current) =>
                previous.status != current.status &&
                current.status == Status2.success,
            listener: (context, state) {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context, rootNavigator: true).pop();

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                if (state.isExistingUser == true) {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pushAndRemoveUntil(AppRoutes.main(), (route) => false);
                } else {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).push(AppRoutes.register2Page());
                }
              });
            },
          ),
        ],
        child: ThemeWrapper(
          builder: (context, colors, fonts, icons, controller) {
            final defaultPinTheme = PinTheme(
              width: 50.w,
              height: 56.h,
              textStyle: fonts.subheadingBold.copyWith(
                color: colors.neutral800,
                fontSize: 22.sp,
              ),
              decoration: BoxDecoration(
                color: colors.neutral100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.neutral200),
              ),
            );

            final focusedPinTheme = defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                border: Border.all(color: colors.blue500, width: 2),
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
                color: colors.shade0,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: colors.neutral200,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  24.h.verticalSpace,
                  Text(
                    'enter_sms_code'.tr(),
                    style: fonts.subheadingBold.copyWith(
                      color: colors.neutral800,
                      fontSize: 22.sp,
                    ),
                  ),
                  24.h.verticalSpace,
                  BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state1) {
                      return BlocBuilder<AuthPinPutBloc, AuthPinPutState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              Pinput(
                                controller: _pinController,
                                autofocus: true,
                                length: 6,
                                defaultPinTheme: defaultPinTheme,
                                focusedPinTheme: focusedPinTheme,
                                separatorBuilder: (index) =>
                                    SizedBox(width: 8.w),
                                onCompleted: _submitOtp,
                              ),
                              24.h.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (_secondsRemaining > 0)
                                    Text(
                                      _formatTime(_secondsRemaining),
                                      style: fonts.paragraphP3Medium.copyWith(
                                        color: colors.neutral500,
                                      ),
                                    ),
                                  if (_secondsRemaining == 0)
                                    GestureDetector(
                                      onTap: _canResend
                                          ? () {
                                              authBloc.add(
                                                EnterPhoneNumberEvent(
                                                  phoneNumber: authBloc
                                                      .state
                                                      .authPhoneNumber!
                                                      .data!
                                                      .phone!,
                                                ),
                                              );
                                            }
                                          : null,
                                      child: Text(
                                        'resend_code'.tr(),
                                        style: fonts.paragraphP3SemiBold
                                            .copyWith(
                                              color: _canResend
                                                  ? colors.blue500
                                                  : colors.neutral300,
                                            ),
                                      ),
                                    ),
                                ],
                              ),
                              16.h.verticalSpace,
                              if (state.status == Status2.loading ||
                                  state1.statusUser == Status2.loading)
                                Center(
                                  child: SizedBox(
                                    width: 24.r,
                                    height: 24.r,
                                    child: CircularProgressIndicator(
                                      color: colors.primary500,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              24.h.verticalSpace,
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
