import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application2/register_bloc_and_data/bloc/register_bloc.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/pages/profile/screens/user_information_page.dart';
import 'package:ustahub/presentation/pages/profile/widgets/custom_switch.dart';
import 'package:ustahub/presentation/pages/profile/widgets/language_selector.dart';
import 'package:ustahub/presentation/pages/profile/widgets/logout_button.dart';
import 'package:ustahub/presentation/pages/profile/widgets/setting_menu_item.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool notificationsEnabled = true;
  String selectedLanguage = 'English';

  void _showLogoutDialog(
    BuildContext context,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colors.shade0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        contentPadding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 16.h),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEB),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.logout_rounded,
                color: const Color(0xFFFF4D4D),
                size: 32.sp,
              ),
            ),
            20.vSpace,
            Text(
              'logout_account'.tr(),
              style: TextStyle(
                color: const Color(0xFF1F1F1F),
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
            ),
            10.vSpace,
            Text(
              'are_you_sure_logout'.tr(),
              style: TextStyle(
                color: const Color(0xFF757575),
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actionsPadding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        actions: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Center(
                      child: Text(
                        'cancel'.tr(),
                        style: TextStyle(
                          color: const Color(0xFF616161),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              12.w.horizontalSpace,
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.read<RegisterBloc>().add(LogoutEvent());
                    Navigator.pushAndRemoveUntil(
                      context,
                      AppRoutes.getAuthOptions(),
                      (route) => false,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      color: colors.primary500,
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        BoxShadow(
                          color: colors.primary500.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'yes'.tr(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.neutral100,
          body: Column(
            children: [
              UniversalAppBar(
                backgroundColor: colors.primary500,
                showBackButton: false,
                showShadow: false,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                verticalSpacing: 12,
                title: "profile".tr(),
                centerTitle: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionHeader(
                        title: 'account'.tr().toUpperCase(),
                        fonts: fonts,
                        colors: colors,
                      ),
                      _SettingsCard(
                        colors: colors,
                        children: [
                          BlocBuilder<RegisterBloc, RegisterState>(
                            builder: (context, state) => SettingsMenuItem(
                              icon: Icons.person_outline,
                              title: state.userProfile?.firstName ?? "User",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserInformationPage(),
                                  ),
                                );
                              },
                              showTrailing: true,
                              fonts: fonts,
                              colors: colors,
                            ),
                          ),
                        ],
                      ),
                      _SectionHeader(
                        title: 'settings'.tr().toUpperCase(),
                        fonts: fonts,
                        colors: colors,
                      ),
                      _SettingsCard(
                        colors: colors,
                        children: [
                          SettingsMenuItem(
                            icon: Icons.language,
                            title: 'language'.tr(),
                            onTap: () {},
                            fonts: fonts,
                            colors: colors,
                            trailing: LanguageSelector(
                              selectedLanguage: selectedLanguage,
                              onChanged: (value) {
                                setState(() {
                                  selectedLanguage = value;
                                });
                              },
                              fonts: fonts,
                              colors: colors,
                            ),
                          ),
                          Divider(height: 1, color: colors.neutral200),
                          SettingsMenuItem(
                            icon: Icons.notifications_outlined,
                            title: 'notifications'.tr(),
                            onTap: () {},
                            fonts: fonts,
                            colors: colors,
                            trailing: CustomSwitch(
                              value: notificationsEnabled,
                              onChanged: (value) {
                                setState(() {
                                  notificationsEnabled = value;
                                });
                              },
                              colors: colors,
                            ),
                          ),
                        ],
                      ),
                      _SectionHeader(
                        title: 'information'.tr().toUpperCase(),
                        fonts: fonts,
                        colors: colors,
                      ),
                      _SettingsCard(
                        colors: colors,
                        children: [
                          SettingsMenuItem(
                            icon: Icons.info_outline,
                            title: 'about_ustahub'.tr(),
                            onTap: () {},
                            showTrailing: true,
                            fonts: fonts,
                            colors: colors,
                          ),
                          Divider(height: 1, color: colors.neutral200),
                          SettingsMenuItem(
                            icon: Icons.description_outlined,
                            title: 'terms_and_conditions'.tr(),
                            onTap: () {},
                            showTrailing: true,
                            fonts: fonts,
                            colors: colors,
                          ),
                          Divider(height: 1, color: colors.neutral200),
                          SettingsMenuItem(
                            icon: Icons.privacy_tip_outlined,
                            title: 'privacy_policy'.tr(),
                            onTap: () {},
                            showTrailing: true,
                            fonts: fonts,
                            colors: colors,
                          ),
                          Divider(height: 1, color: colors.neutral200),
                          SettingsMenuItem(
                            icon: Icons.work_outline,
                            title: 'work_with_us'.tr(),
                            onTap: () {},
                            showTrailing: true,
                            fonts: fonts,
                            colors: colors,
                          ),
                        ],
                      ),
                      _SectionHeader(
                        title: 'danger_zone'.tr().toUpperCase(),
                        fonts: fonts,
                        colors: colors,
                      ),

                      /// later we use this widget
                      // _SettingsCard(
                      //   colors: colors,
                      //   children: [
                      //     SettingsMenuItem(
                      //       icon: Icons.delete_outline,
                      //       title: 'delete_account'.tr(),
                      //       onTap: () {},
                      //       showTrailing: true,
                      //       fonts: fonts,
                      //       colors: colors,
                      //       iconColor: colors.red500,
                      //       titleColor: colors.red500,
                      //     ),
                      //   ],
                      // ),
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: LogoutButton(
                          onTap: () =>
                              _showLogoutDialog(context, colors, fonts),
                          fonts: fonts,
                          colors: colors,
                        ),
                      ),
                      56.h.verticalSpace,
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

class _SectionHeader extends StatelessWidget {
  final String title;
  final FontSet fonts;
  final CustomColorSet colors;

  const _SectionHeader({
    required this.title,
    required this.fonts,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 12.h),
      child: Text(
        title,
        style: fonts.paragraphP2Medium.copyWith(color: colors.neutral600),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  final CustomColorSet colors;

  const _SettingsCard({required this.children, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: colors.shade0,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
            color: Color(0x08000000),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

extension Spacing on num {
  Widget get vSpace => SizedBox(height: toDouble().h);
  Widget get hSpace => SizedBox(width: toDouble().w);
}
