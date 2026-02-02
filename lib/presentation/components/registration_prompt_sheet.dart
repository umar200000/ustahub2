import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/infrastructure/services/local_database/db_service.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/pages/core/register_page.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class RegistrationPromptSheet extends StatelessWidget {
  final String? message;
  final VoidCallback? onSkip;

  const RegistrationPromptSheet({super.key, this.message, this.onSkip});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: colors.shade0,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              8.h.verticalSpace,
              Center(
                child: Container(
                  height: 3.h,
                  width: 32.w,
                  decoration: BoxDecoration(
                    color: colors.neutral800,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
              ),
              24.h.verticalSpace,
              Icon(Icons.person_add, size: 64.r, color: colors.primary500),
              16.h.verticalSpace,
              Text(
                "join_us".tr(),
                style: fonts.headingH6SemiBold,
                textAlign: TextAlign.center,
              ),
              8.h.verticalSpace,
              Text(
                message ?? "registration_required_message".tr(),
                style: fonts.paragraphP2Regular.copyWith(
                  color: colors.neutral600,
                ),
                textAlign: TextAlign.center,
              ),
              24.h.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: AnimationButtonEffect(
                      onTap: () {
                        Navigator.pop(context);
                        onSkip?.call();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: colors.neutral200),
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "maybe_later".tr(),
                          style: fonts.paragraphP2Medium.copyWith(
                            color: colors.neutral600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  16.w.horizontalSpace,
                  Expanded(
                    child: AnimationButtonEffect(
                      onTap: () async {
                        Navigator.pop(context);
                        try {
                          final dbService = await DBService.create;
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                            (route) => false,
                          );
                        } catch (e) {
                          // Fallback navigation if DBService fails
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: colors.primary500,
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "register_now".tr(),
                          style: fonts.paragraphP2SemiBold.copyWith(
                            color: colors.shade0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              (MediaQuery.of(context).padding.bottom + 16.h).verticalSpace,
            ],
          ),
        );
      },
    );
  }
}

// Helper function to show registration prompt
Future<void> showRegistrationPrompt(
  BuildContext context, {
  String? message,
  VoidCallback? onSkip,
}) {
  context.read<BottomNavBarController>().changeNavBar(true);

  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) =>
        RegistrationPromptSheet(message: message, onSkip: onSkip),
  ).then((value) {
    context.read<BottomNavBarController>().changeNavBar(false);
  });
}
