import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import 'auth_options.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
    _animationController.reset();
    _animationController.forward();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
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

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.shade0,
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(colors, fonts),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    children: [
                      _OnboardingScreen(
                        colors: colors,
                        fonts: fonts,
                        fadeAnimation: _fadeAnimation,
                        slideAnimation: _slideAnimation,
                        illustration: Image.asset('assets/images/first.png'),
                        titleKey: 'onboarding_title_1',
                        descriptionKey: 'onboarding_desc_1',
                      ),
                      _OnboardingScreen(
                        colors: colors,
                        fonts: fonts,
                        fadeAnimation: _fadeAnimation,
                        slideAnimation: _slideAnimation,
                        illustration: Image.asset('assets/images/second.png'),
                        titleKey: 'onboarding_title_2',
                        descriptionKey: 'onboarding_desc_2',
                      ),
                      _OnboardingScreen(
                        colors: colors,
                        fonts: fonts,
                        fadeAnimation: _fadeAnimation,
                        slideAnimation: _slideAnimation,
                        illustration: Image.asset('assets/images/third.png'),
                        titleKey: 'onboarding_title_3',
                        descriptionKey: 'onboarding_desc_3',
                      ),
                    ],
                  ),
                ),
                _buildPageIndicator(colors),
                _buildFooter(colors, fonts),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(CustomColorSet colors, FontSet fonts) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.handyman, color: colors.blue500, size: 24.r),
              8.w.horizontalSpace,
              Text(
                'USTAHUB'.tr(),
                style: fonts.headingH5Bold.copyWith(letterSpacing: 1.2),
              ),
            ],
          ),
          if (_currentPage < 2)
            TextButton(
              onPressed: _finishOnboarding,
              child: Text(
                'skip'.tr(),
                style: fonts.paragraphP2Medium.copyWith(
                  color: colors.neutral600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(CustomColorSet colors) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            width: _currentPage == index ? 24.w : 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: _currentPage == index ? colors.blue500 : colors.neutral200,
              borderRadius: BorderRadius.circular(4.r),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildFooter(CustomColorSet colors, FontSet fonts) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
      child: Column(
        children: [
          GestureDetector(
            onTap: _nextPage,
            child: Container(
              width: double.infinity,
              height: 56.h,
              decoration: BoxDecoration(
                color: colors.blue500,
                borderRadius: BorderRadius.circular(28.r),
              ),
              child: Center(
                child: Text(
                  _currentPage == 2 ? 'get_started'.tr() : 'next'.tr(),
                  style: fonts.paragraphP1Bold.copyWith(color: colors.shade0),
                ),
              ),
            ),
          ),
          12.h.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'already_have_account'.tr(),
                style: fonts.paragraphP3Regular.copyWith(
                  color: colors.neutral600,
                ),
              ),
              GestureDetector(
                onTap: _finishOnboarding,
                child: Text(
                  'sign_in'.tr(),
                  style: fonts.paragraphP3SemiBold.copyWith(
                    color: colors.blue500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OnboardingScreen extends StatelessWidget {
  final CustomColorSet colors;
  final FontSet fonts;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final Widget illustration;
  final String titleKey;
  final String descriptionKey;

  const _OnboardingScreen({
    required this.colors,
    required this.fonts,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.illustration,
    required this.titleKey,
    required this.descriptionKey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        children: [
          Spacer(),
          FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(
                  parent: fadeAnimation,
                  curve: Curves.easeOutBack,
                ),
              ),
              child: illustration,
            ),
          ),
          Spacer(),
          FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(
              position: slideAnimation,
              child: Text(
                titleKey.tr(),
                style: fonts.headingH5Bold,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // 12.h.verticalSpace,
          FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: fadeAnimation,
                      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
                    ),
                  ),
              child: Text(
                descriptionKey.tr(),
                style: fonts.paragraphP3Regular.copyWith(
                  color: colors.neutral600,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class LottieIllustration extends StatelessWidget {
  final String path;

  const LottieIllustration({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240.h,
      width: double.infinity,
      child: Lottie.asset(
        path,
        fit: BoxFit.contain,
        repeat: true,
        animate: true,
      ),
    );
  }
}
