import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.blue500,
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'UstaHub',
                        style: fonts.headingH1Bold.copyWith(
                          color: colors.shade0,
                        ),
                      ),
                      4.h.verticalSpace,
                      Text(
                        'Create your account to get \nstarted',
                        textAlign: TextAlign.center,
                        style: fonts.headingH6Medium.copyWith(
                          color: colors.shade0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colors.shade0,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24.0.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        32.h.verticalSpace,
                        _buildSocialButton(
                          icon: Icons.apple,
                          label: 'Continue with Apple',
                          onTap: () {},
                        ),
                        12.h.verticalSpace,
                        _buildSocialButton(
                          icon: Icons.g_mobiledata,
                          label: 'Continue with Google',
                          onTap: () {},
                        ),
                        12.h.verticalSpace,
                        _buildSocialButton(
                          icon: Icons.facebook,
                          label: 'Continue with Facebook',
                          onTap: () {},
                        ),
                        12.h.verticalSpace,
                        _buildSocialButton(
                          icon: Icons.email_outlined,
                          label: 'Continue with Email',
                          onTap: () {},
                        ),
                        24.h.verticalSpace,
                        Row(
                          children: [
                            Expanded(child: Divider(color: colors.neutral500)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Text(
                                'or',
                                style: fonts.paragraphP1Bold.copyWith(
                                  color: colors.neutral500,
                                ),
                              ),
                            ),
                            Expanded(child: Divider(color: colors.neutral500)),
                          ],
                        ),
                        24.h.verticalSpace,
                        Center(
                          child: AnimationButtonEffect(
                            onTap: () {
                              Navigator.push(context, AppRoutes.main());
                            },
                            child: Text(
                              'Continue as Guest',
                              style: fonts.paragraphP1Bold.copyWith(
                                color: colors.shade100,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AnimationButtonEffect(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              color: colors.neutral100,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colors.neutral200, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 24.sp, color: colors.shade100),
                12.w.horizontalSpace,
                Text(
                  label,
                  style: fonts.paragraphP1Regular.copyWith(
                    color: colors.shade100,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
