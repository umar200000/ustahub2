import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application2/register_bloc_and_data/bloc/register_bloc.dart';
import 'package:ustahub/infrastructure/services/shared_perf/shared_pref_service.dart';
import 'package:ustahub/infrastructure2/init/injection.dart';
import 'package:ustahub/presentation/pages/profile/screens/ai_chat_page.dart';
import 'package:ustahub/presentation/pages/profile/screens/delete_account_page.dart';
import 'package:ustahub/presentation/pages/profile/screens/info_detail_page.dart';
import 'package:ustahub/presentation/pages/profile/screens/user_information_page.dart';
import 'package:ustahub/presentation/pages/payment_history/payment_history_page.dart';
import 'package:ustahub/presentation/pages/profile/widgets/custom_switch.dart';
import 'package:ustahub/presentation/pages/profile/widgets/language_selector.dart';
import 'package:ustahub/presentation/pages/profile/widgets/logout_button.dart';
import 'package:ustahub/presentation/pages/profile/widgets/setting_menu_item.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';
import 'package:ustahub/utils/launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool notificationsEnabled = true;

  String _getLanguageName(Locale locale) {
    if (locale.languageCode == 'ru') return 'Русский';
    if (locale.languageCode == 'uz') return 'O\'zbekcha';
    return 'English';
  }

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
              decoration: const BoxDecoration(
                color: Color(0xFFFFEBEB),
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
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
          backgroundColor: colors.bgSurface,
          body: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 120.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProfileHero(colors: colors, fonts: fonts),
                SizedBox(height: 18.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: _AiChatBanner(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AiChatPage(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: _TokenBalanceCard(colors: colors, fonts: fonts),
                ),
                SizedBox(height: 8.h),
                BlocBuilder<RegisterBloc, RegisterState>(
                  buildWhen: (prev, curr) =>
                      (prev.userProfile == null) !=
                      (curr.userProfile == null),
                  builder: (context, state) {
                    if (state.userProfile == null) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionHeader(
                          title: 'account'.tr(),
                          fonts: fonts,
                          colors: colors,
                        ),
                        _SettingsCard(
                          colors: colors,
                          children: [
                            SettingsMenuItem(
                              icon: Icons.person_outline_rounded,
                              iconColor: colors.blue500,
                              title: 'personal_info'.tr(),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const UserInformationPage(),
                                  ),
                                );
                              },
                              showTrailing: true,
                              fonts: fonts,
                              colors: colors,
                            ),
                            _divider(colors),
                            SettingsMenuItem(
                              icon: Icons.credit_card_rounded,
                              iconColor: const Color(0xFF8B5CF6),
                              title: 'my_card'.tr(),
                              showTrailing: true,
                              onTap: () {
                                Navigator.push(
                                    context, AppRoutes.myCardPage());
                              },
                              fonts: fonts,
                              colors: colors,
                            ),
                            _divider(colors),
                            SettingsMenuItem(
                              icon: Icons.receipt_long_rounded,
                              iconColor: const Color(0xFFF59E0B),
                              title: 'payment_history'.tr(),
                              showTrailing: true,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const PaymentHistoryPage(),
                                  ),
                                );
                              },
                              fonts: fonts,
                              colors: colors,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                _SectionHeader(
                  title: 'settings'.tr(),
                  fonts: fonts,
                  colors: colors,
                ),
                _SettingsCard(
                  colors: colors,
                  children: [
                    SettingsMenuItem(
                      icon: Icons.language_rounded,
                      iconColor: const Color(0xFF10B981),
                      title: 'language'.tr(),
                      onTap: () {},
                      fonts: fonts,
                      colors: colors,
                      trailing: LanguageSelector(
                        selectedLanguage:
                            _getLanguageName(context.locale),
                        onChanged: (name, locale) {
                          sl<SharedPrefService>().setLanguage(
                            locale.languageCode,
                          );
                          context.setLocale(locale);
                          setState(() {});
                        },
                        fonts: fonts,
                        colors: colors,
                      ),
                    ),
                    _divider(colors),
                    SettingsMenuItem(
                      icon: Icons.notifications_rounded,
                      iconColor: const Color(0xFFEF4444),
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
                  title: 'information'.tr(),
                  fonts: fonts,
                  colors: colors,
                ),
                _SettingsCard(
                  colors: colors,
                  children: [
                    SettingsMenuItem(
                      icon: Icons.info_outline_rounded,
                      iconColor: colors.blue500,
                      title: 'about_ustahub'.tr(),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InfoDetailPage(
                              titleKey: "about_ustahub",
                              contentKey: "about_content",
                              icon: Icons.info_outline,
                            ),
                          ),
                        );
                      },
                      showTrailing: true,
                      fonts: fonts,
                      colors: colors,
                    ),
                    _divider(colors),
                    SettingsMenuItem(
                      icon: Icons.description_outlined,
                      iconColor: const Color(0xFF6366F1),
                      title: 'terms_and_conditions'.tr(),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InfoDetailPage(
                              titleKey: "terms_and_conditions",
                              contentKey: "terms_content",
                              icon: Icons.description_outlined,
                            ),
                          ),
                        );
                      },
                      showTrailing: true,
                      fonts: fonts,
                      colors: colors,
                    ),
                    _divider(colors),
                    SettingsMenuItem(
                      icon: Icons.privacy_tip_rounded,
                      iconColor: const Color(0xFF0EA5E9),
                      title: 'privacy_policy'.tr(),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InfoDetailPage(
                              titleKey: "privacy_policy",
                              contentKey: "privacy_content",
                              icon: Icons.privacy_tip_outlined,
                            ),
                          ),
                        );
                      },
                      showTrailing: true,
                      fonts: fonts,
                      colors: colors,
                    ),
                    _divider(colors),
                    SettingsMenuItem(
                      icon: Icons.send_rounded,
                      iconColor: const Color(0xFF0088CC),
                      title: 'contact_with_us'.tr(),
                      onTap: openSupportTelegram,
                      showTrailing: true,
                      fonts: fonts,
                      colors: colors,
                    ),
                    _divider(colors),
                    SettingsMenuItem(
                      icon: Icons.work_rounded,
                      iconColor: const Color(0xFFEC4899),
                      title: 'work_with_us'.tr(),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InfoDetailPage(
                              titleKey: "work_with_us",
                              contentKey: "work_with_us_content",
                              icon: Icons.work_outline,
                            ),
                          ),
                        );
                      },
                      showTrailing: true,
                      fonts: fonts,
                      colors: colors,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: LogoutButton(
                    onTap: () => _showLogoutDialog(context, colors, fonts),
                    fonts: fonts,
                    colors: colors,
                  ),
                ),
                SizedBox(height: 4.h),
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(horizontal: 16.w),
                    childrenPadding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 12.h),
                    title: Text(
                      'Qo\'shimcha',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: colors.neutral500,
                      ),
                    ),
                    iconColor: colors.neutral500,
                    collapsedIconColor: colors.neutral500,
                    children: [
                      _DeleteAccountButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DeleteAccountPage(),
                            ),
                          );
                        },
                        colors: colors,
                      ),
                    ],
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

class _AiChatBanner extends StatelessWidget {
  final VoidCallback onTap;

  const _AiChatBanner({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF7C3AED),
              Color(0xFF3B82F6),
            ],
          ),
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7C3AED).withValues(alpha: 0.25),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(14.r),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.auto_awesome_rounded,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'ai_chat'.tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Text(
                          'AI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'ai_chat_subtitle'.tr(),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.92),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 14.sp,
            ),
          ],
        ),
      ),
    );
  }
}

class _DeleteAccountButton extends StatelessWidget {
  final VoidCallback onTap;
  final CustomColorSet colors;

  const _DeleteAccountButton({required this.onTap, required this.colors});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF5F5),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFFFF4D4D).withValues(alpha: 0.25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete_outline_rounded,
              color: const Color(0xFFFF4D4D),
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'delete_account'.tr(),
              style: TextStyle(
                color: const Color(0xFFFF4D4D),
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _divider(CustomColorSet colors) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(height: 1, color: colors.neutral100),
    );

class _ProfileHero extends StatelessWidget {
  final CustomColorSet colors;
  final FontSet fonts;

  const _ProfileHero({required this.colors, required this.fonts});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.primary500,
            colors.primary500.withValues(alpha: 0.78),
          ],
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(32.r),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.primary500.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16.h,
        left: 20.w,
        right: 20.w,
        bottom: 28.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'profile'.tr(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
          SizedBox(height: 20.h),
          BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              final user = state.userProfile;
              final firstName = user?.firstName ?? 'Guest';
              final lastName = user?.lastName ?? 'User';
              final phone = user?.phone ?? '+998 ** *** ** **';
              final initial =
                  firstName.isNotEmpty ? firstName[0].toUpperCase() : 'G';

              return Row(
                children: [
                  Container(
                    width: 68.w,
                    height: 68.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.6),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: user?.avatarUrl != null
                          ? CachedNetworkImage(
                              imageUrl: user!.avatarUrl!,
                              fit: BoxFit.cover,
                              width: 68.w,
                              height: 68.w,
                              placeholder: (_, __) => Center(
                                child: Text(
                                  initial,
                                  style: TextStyle(
                                    color: colors.primary500,
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              errorWidget: (_, __, ___) => Center(
                                child: Text(
                                  initial,
                                  style: TextStyle(
                                    color: colors.primary500,
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: Text(
                                initial,
                                style: TextStyle(
                                  color: colors.primary500,
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$firstName $lastName',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(
                              Icons.phone_rounded,
                              color: Colors.white.withValues(alpha: 0.85),
                              size: 13.sp,
                            ),
                            SizedBox(width: 5.w),
                            Flexible(
                              child: Text(
                                phone,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color:
                                      Colors.white.withValues(alpha: 0.9),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
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
      padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 10.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: colors.neutral500,
          letterSpacing: 0.8,
        ),
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
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 6),
            blurRadius: 20,
            spreadRadius: 0,
            color: Colors.black.withValues(alpha: 0.04),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _TokenBalanceCard extends StatefulWidget {
  final CustomColorSet colors;
  final FontSet fonts;

  const _TokenBalanceCard({required this.colors, required this.fonts});

  @override
  State<_TokenBalanceCard> createState() => _TokenBalanceCardState();
}

class _TokenBalanceCardState extends State<_TokenBalanceCard> {
  int? _balance;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadBalance();
  }

  Future<void> _loadBalance() async {
    try {
      final dio = sl<Dio>();
      final response = await dio.get("api/v1/client/tokens/balance/");
      if (response.statusCode == 200) {
        final balance = response.data?['data']?['balance'] as int? ?? 0;
        if (mounted) setState(() { _balance = balance; _loading = false; });
      } else {
        if (mounted) setState(() { _loading = false; });
      }
    } catch (_) {
      if (mounted) setState(() { _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6366F1),
            const Color(0xFF8B5CF6),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.toll_rounded, color: Colors.white, size: 24.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'token_balance'.tr(),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
                _loading
                    ? SizedBox(
                        width: 60.w,
                        height: 14.h,
                        child: LinearProgressIndicator(
                          color: Colors.white,
                          backgroundColor: Colors.white.withValues(alpha: 0.3),
                        ),
                      )
                    : Text(
                        '${_balance ?? 0} ${'token'.tr()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension Spacing on num {
  Widget get vSpace => SizedBox(height: toDouble().h);
  Widget get hSpace => SizedBox(width: toDouble().w);
}
