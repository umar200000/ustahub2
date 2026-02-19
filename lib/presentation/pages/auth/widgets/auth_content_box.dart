import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

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
    return BlocProvider.value(
      value: registerBloc,
      child: BlocConsumer<RegisterBloc, RegisterState>(
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
                      color: colors.shade100,
                      fontSize: 24.sp,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  AuthButton(
                    color: colors.shade100,
                    icon: Icons.apple,
                    onTap: () {},
                    textColor: colors.shade0,
                    title: "continue_with_apple".tr(),
                  ),
                  AuthButton(
                    color: colors.primary500,
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
                    color: colors.neutral100,
                    icon: Icons.phone_android,
                    onTap: () {
                      showEnterNumber(context);
                    },
                    textColor: colors.primary500,
                    title: "continue_with_phone".tr(),
                  ),
                  if (widget.showGuestOption)
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        // Fire event in background, navigate immediately
                        registerBloc.add(VisiteGuestEvent());
                        Navigator.of(context, rootNavigator: true)
                            .pushAndRemoveUntil(AppRoutes.main(), (route) => false);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Text(
                          "continue_as_guest".tr(),
                          style: fonts.paragraphP3SemiBold.copyWith(
                            color: colors.primary500,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
