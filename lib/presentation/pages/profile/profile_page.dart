import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/c_app_bar.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/pages/profile/widgets/custom_switch.dart';
import 'package:ustahub/presentation/pages/profile/widgets/language_selector.dart';
import 'package:ustahub/presentation/pages/profile/widgets/logout_button.dart';
import 'package:ustahub/presentation/pages/profile/widgets/setting_menu_item.dart';
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

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.neutral100,
          body: Column(
            children: [
              UniversalAppBar(
                backgroundColor: const Color(0xFF1A1A1A),
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
                      // Account Section
                      _SectionHeader(
                        title: 'account'.tr().toUpperCase(),
                        fonts: fonts,
                        colors: colors,
                      ),
                      _SettingsCard(
                        colors: colors,
                        children: [
                          SettingsMenuItem(
                            icon: Icons.person_outline,
                            title: 'user_information'.tr(),
                            onTap: () {},
                            showTrailing: true,
                            fonts: fonts,
                            colors: colors,
                          ),
                        ],
                      ),

                      // Settings Section
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
                      _SettingsCard(
                        colors: colors,
                        children: [
                          SettingsMenuItem(
                            icon: Icons.delete_outline,
                            title: 'delete_account'.tr(),
                            onTap: () {},
                            showTrailing: true,
                            fonts: fonts,
                            colors: colors,
                            iconColor: colors.red500,
                            titleColor: colors.red500,
                          ),
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: LogoutButton(
                          onTap: () {},
                          fonts: fonts,
                          colors: colors,
                        ),
                      ),

                      40.h.verticalSpace,
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

// Section Header Widget
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

// Settings Card Container
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
