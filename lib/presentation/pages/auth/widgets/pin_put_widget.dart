import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:ustahub/application2/auth_bloc_and_data/bloc/auth_pin_put_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import '../../../../application2/auth_bloc_and_data/bloc/auth_bloc.dart';
import '../../../../application2/register_bloc_and_data/bloc/register_bloc.dart';
import '../../../../infrastructure2/init/injection.dart';

class PinPutWidget extends StatefulWidget {
  const PinPutWidget({super.key});

  @override
  State<PinPutWidget> createState() => _PinPutWidgetState();
}

class _PinPutWidgetState extends State<PinPutWidget> {
  final authBloc = sl<AuthBloc>();
  final register = sl<RegisterBloc>();
  final pinPutBloc = sl<AuthPinPutBloc>();
  late Timer _timer;
  int _secondsRemaining = 0;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
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
            listener: (context, state) {
              if (state.phoneStatus == Status2.success) {
                _timer.cancel();
                _startTimer();
              }
            },
          ),
          BlocListener<AuthPinPutBloc, AuthPinPutState>(
            listener: (context, state) {
              if (state.status == Status2.success) {
                if (state.isExistingUser == true) {
                  // RegisterBloc orqali GetUserProfileEvent allaqachon AuthPinPutBloc'da chaqirilgan bo'lishi kerak
                  // yoki bu yerda chaqirish mumkin:
                  // register.add(GetUserProfileEvent());
                } else {
                  Navigator.pushReplacement(context, AppRoutes.register2Page());
                }
              }
            },
          ),
          BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (ModalRoute.of(context)?.isCurrent != true) return;

              if (state.statusUser == Status2.success) {
                Navigator.pushAndRemoveUntil(
                  context,
                  AppRoutes.main(),
                  (route) => false,
                );
              } else if (state.statusUser == Status2.error) {
                register.add(GetUserProfileEvent());
              }
            },
          ),
        ],
        child: ThemeWrapper(
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
                  BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state1) {
                      return BlocBuilder<AuthPinPutBloc, AuthPinPutState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              Pinput(
                                autofocus: true,
                                length: 6,
                                defaultPinTheme: defaultPinTheme,
                                focusedPinTheme: focusedPinTheme,
                                separatorBuilder: (index) =>
                                    SizedBox(width: 8.w),
                                onCompleted: (pin) {
                                  pinPutBloc.add(
                                    VerifyOtpEvent(
                                      phoneNumber: authBloc
                                          .state
                                          .authPhoneNumber!
                                          .data!
                                          .phone!,
                                      code: pin,
                                    ),
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
                              if (state.status == Status2.loading ||
                                  state1.statusUser == Status2.loading)
                                Center(
                                  child: SizedBox(
                                    width: 24.r,
                                    height: 24.r,
                                    child: CircularProgressIndicator(
                                      color: colors.shade0,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
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
