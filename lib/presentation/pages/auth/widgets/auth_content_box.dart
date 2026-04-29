import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ustahub/presentation/pages/auth/widgets/pin_put_autofill_widget.dart';
import 'package:ustahub/presentation/pages/auth/widgets/uz_phone_formatter.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import '../../../../application2/auth_bloc_and_data/bloc/auth_bloc.dart';
import '../../../../application2/register_bloc_and_data/bloc/register_bloc.dart';
import '../../../../infrastructure/services/enum_status/status_enum.dart';
import '../../../../infrastructure2/init/injection.dart';
import 'auth_button.dart';
import 'enter_phone_number_box.dart';

class AuthContentBox extends StatefulWidget {
  final bool showGuestOption;

  const AuthContentBox({super.key, this.showGuestOption = true});

  @override
  State<AuthContentBox> createState() => _AuthContentBoxState();
}

class _AuthContentBoxState extends State<AuthContentBox> {
  final registerBloc = sl<RegisterBloc>();

  final TextEditingController _controller = TextEditingController();
  final authBloc = sl<AuthBloc>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void showPinPutWidget(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return const PinPutAutofillWidget();
      },
    );
  }

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
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: registerBloc),
        BlocProvider.value(value: authBloc),
      ],
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (ModalRoute.of(context)?.isCurrent != true) return;
          if (state.phoneStatus == Status2.success) {
            showPinPutWidget(context);
          } else if (state.phoneStatus == Status2.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? "Xatolik"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return BlocConsumer<RegisterBloc, RegisterState>(
            listenWhen: (previous, current) =>
                previous.status != current.status &&
                current.status == Status2.success,
            listener: (context, state) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pushAndRemoveUntil(AppRoutes.main(), (route) => false);
                }
              });
            },
            builder: (context, state) {
              return ThemeWrapper(
                builder: (context, colors, fonts, icons, controller) => Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                      12.h.verticalSpace,
                      // Drag indicator
                      Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: colors.neutral200,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      24.h.verticalSpace,

                      // Title
                      Text(
                        'login_or_create_account'.tr(),
                        textAlign: TextAlign.center,
                        style: fonts.subheadingBold.copyWith(
                          color: colors.neutral800,
                          fontSize: 22.sp,
                          height: 1.2,
                        ),
                      ),

                      24.h.verticalSpace,

                      Container(
                        decoration: BoxDecoration(
                          color: colors.neutral100,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: colors.neutral200),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            Text(
                              "+998 ",
                              style: fonts.paragraphP2SemiBold.copyWith(
                                color: colors.shade100,
                                fontSize: 18.sp,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                autofocus: true,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [UzPhoneFormatter()],
                                style: fonts.paragraphP2SemiBold.copyWith(
                                  color: colors.shade100,
                                  fontSize: 18.sp,
                                ),
                                decoration: InputDecoration(
                                  hintText: "(_ _) _ _ _  _ _  _ _",
                                  hintStyle: fonts.paragraphP2SemiBold.copyWith(
                                    color: colors.neutral500,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      24.h.verticalSpace,
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          final isLoading =
                              state.phoneStatus == Status2.loading;
                          return AuthButton(
                            color: colors.primary500,
                            onTap: isLoading
                                ? () {}
                                : () {
                                    final phoneNumber =
                                        "+998${_controller.text.replaceAll(' ', '')}";

                                    if (phoneNumber.length == 13) {
                                      authBloc.add(
                                        EnterPhoneNumberEvent(
                                          phoneNumber: phoneNumber,
                                        ),
                                      );
                                    }
                                  },
                            textColor: colors.shade0,
                            title: "continue".tr(),
                            child: isLoading
                                ? Center(
                                    child: SizedBox(
                                      width: 24.r,
                                      height: 24.r,
                                      child: CircularProgressIndicator(
                                        color: colors.shade0,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  )
                                : null,
                          );
                        },
                      ),

                      if (widget.showGuestOption)
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: TextButton(
                            onPressed: () {
                              registerBloc.add(VisiteGuestEvent());
                              Navigator.of(
                                context,
                                rootNavigator: true,
                              ).pushAndRemoveUntil(
                                AppRoutes.main(),
                                (route) => false,
                              );
                            },
                            style: TextButton.styleFrom(
                              minimumSize: Size(double.infinity, 44.h),
                            ),
                            child: Text(
                              "continue_as_guest".tr(),
                              style: fonts.paragraphP3SemiBold.copyWith(
                                color: colors.primary500,
                              ),
                            ),
                          ),
                        ),

                      Padding(
                        padding: EdgeInsets.only(top: 4.h, bottom: 6.h),
                        child: GestureDetector(
                          onTap: () => launchUrl(
                            Uri.parse('https://ustahub.net/privacy-policy'),
                            mode: LaunchMode.externalApplication,
                          ),
                          child: Text(
                            'privacy_policy'.tr(),
                            textAlign: TextAlign.center,
                            style: fonts.paragraphP3Regular.copyWith(
                              color: colors.neutral500,
                              decoration: TextDecoration.underline,
                              decorationColor: colors.neutral500,
                            ),
                          ),
                        ),
                      ),

                      10.h.verticalSpace,
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
