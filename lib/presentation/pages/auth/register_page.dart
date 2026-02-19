import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import 'auth_options.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      image: 'assets/images/first.png',
      titleKey: 'essential_services_title',
      subtitleKey: 'essential_services_subtitle',
    ),
    OnboardingData(
      image: 'assets/images/second.png',
      titleKey: 'onboarding_title_2',
      subtitleKey: 'onboarding_desc_2',
    ),
    OnboardingData(
      image: 'assets/images/third.png',
      titleKey: 'onboarding_title_3',
      subtitleKey: 'onboarding_desc_3',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const AuthOptions()),
    );
  }

  String _getCurrentLanguageCode(BuildContext context) {
    final locale = context.locale;
    switch (locale.languageCode) {
      case 'uz':
        return 'UZ';
      case 'ru':
        return 'RU';
      case 'en':
        return 'EN';
      default:
        return 'UZ';
    }
  }

  void _showLanguageSelector(
    BuildContext context,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.shade0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'select_language'.tr(),
              style: fonts.headingH6Bold,
            ),
            SizedBox(height: 16.h),
            _buildLanguageOption(
              context,
              colors,
              fonts,
              'O\'zbekcha',
              'UZ',
              const Locale('uz', 'UZ'),
            ),
            _buildLanguageOption(
              context,
              colors,
              fonts,
              'Русский',
              'RU',
              const Locale('ru', 'RU'),
            ),
            _buildLanguageOption(
              context,
              colors,
              fonts,
              'English',
              'EN',
              const Locale('en', 'US'),
            ),
            SizedBox(height: bottomPadding),
          ],
        ),
      ),
    );
  }

  double get bottomPadding => MediaQuery.of(context).padding.bottom;

  Widget _buildLanguageOption(
    BuildContext context,
    CustomColorSet colors,
    FontSet fonts,
    String name,
    String code,
    Locale locale,
  ) {
    final isSelected = context.locale == locale;
    return GestureDetector(
      onTap: () {
        context.setLocale(locale);
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primary500.withValues(alpha: 0.1)
              : colors.neutral100,
          borderRadius: BorderRadius.circular(12.r),
          border: isSelected
              ? Border.all(color: colors.primary500, width: 1.5)
              : null,
        ),
        child: Row(
          children: [
            Text(
              name,
              style: fonts.paragraphP1Medium.copyWith(
                color: isSelected ? colors.primary500 : colors.shade100,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: colors.primary500,
                size: 20.r,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: ThemeWrapper(
        builder: (context, colors, fonts, icons, controller) {
          return Scaffold(
            backgroundColor: colors.shade0,
            body: GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity != null) {
                  if (details.primaryVelocity! < -200) {
                    // Swipe left - next page
                    if (_currentPage < _onboardingData.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 320),
                        curve: Curves.easeInOut,
                      );
                    }
                  } else if (details.primaryVelocity! > 200) {
                    // Swipe right - previous page
                    if (_currentPage > 0) {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 320),
                        curve: Curves.easeInOut,
                      );
                    }
                  }
                }
              },
              child: Stack(
                children: [
                  // Hero Image - takes up ~55% of screen
                  Positioned(
                    top: topPadding + 130.h,
                    left: 0,
                    right: 0,
                    height: screenHeight * 0.45,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: _onboardingData.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          _onboardingData[index].image,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        );
                      },
                    ),
                  ),

                  // Header - Logo and Language
                  Positioned(
                    top: topPadding + 12.h,
                    left: 16.w,
                    right: 16.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Logo
                        Image.asset(
                          'assets/images/ustahub-logo.png',
                          height: 96.h,
                        ),
                        // Language selector
                        GestureDetector(
                          onTap: () => _showLanguageSelector(context, colors, fonts),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: colors.shade0.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.language,
                                  size: 18.r,
                                  color: colors.shade100,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  _getCurrentLanguageCode(context),
                                  style: fonts.paragraphP3Medium.copyWith(
                                    color: colors.shade100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Progress Indicator below header
                  Positioned(
                    top: topPadding + 110.h,
                    left: 16.w,
                    right: 16.w,
                    child: _buildProgressBar(colors),
                  ),

                  // Bottom Sheet Card - overlaps the image
                  Positioned(
                    top: screenHeight * 0.52,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors.shade0,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.r),
                          topRight: Radius.circular(32.r),
                        ),
                      ),
                      child: _buildBottomSheetContent(
                        colors,
                        fonts,
                        bottomPadding,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgressBar(CustomColorSet colors) {
    return Row(
      children: List.generate(
        _onboardingData.length,
        (index) => Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 4.h,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.r),
              color: index <= _currentPage
                  ? colors.primary500
                  : const Color(0xFFD9D9D9),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheetContent(
    CustomColorSet colors,
    FontSet fonts,
    double bottomPadding,
  ) {
    final data = _onboardingData[_currentPage];

    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, bottomPadding + 16.h),
      child: Column(
        children: [
          // Headline
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Text(
              data.titleKey.tr(),
              key: ValueKey(data.titleKey),
              style: fonts.headingH5Bold.copyWith(
                color: colors.shade100,
                fontSize: 22.sp,
                letterSpacing: -0.3,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.h),

          // Supporting text
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Text(
              data.subtitleKey.tr(),
              key: ValueKey(data.subtitleKey),
              style: fonts.paragraphP2Regular.copyWith(
                color: colors.neutral500,
                fontSize: 14.sp,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const Spacer(),

          // Primary Button (Continue)
          AnimationButtonEffect(
            onTap: _nextPage,
            child: Container(
              width: double.infinity,
              height: 56.h,
              decoration: BoxDecoration(
                color: colors.primary500,
                borderRadius: BorderRadius.circular(50.r),
              ),
              alignment: Alignment.center,
              child: Text(
                _currentPage == _onboardingData.length - 1
                    ? 'get_started'.tr()
                    : 'continue'.tr(),
                style: fonts.paragraphP1SemiBold.copyWith(
                  color: colors.shade0,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Secondary text link (Already have an account)
          GestureDetector(
            onTap: _finishOnboarding,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                'already_have_an_account'.tr(),
                style: fonts.paragraphP2Medium.copyWith(
                  color: colors.primary500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingData {
  final String image;
  final String titleKey;
  final String subtitleKey;

  OnboardingData({
    required this.image,
    required this.titleKey,
    required this.subtitleKey,
  });
}
