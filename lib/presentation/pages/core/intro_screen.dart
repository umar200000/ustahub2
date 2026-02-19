import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ustahub/infrastructure/services/local_database/db_service.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentIndex = 0;
  late final PageController pageController;

  final List<OnboardingData> onboardingData = [
    OnboardingData(
      image: 'assets/images/first.png',
      titleKey: 'essential_services_title',
      subtitleKey: 'essential_services_subtitle',
    ),
    OnboardingData(
      image: 'assets/images/second.png',
      titleKey: 'book_services_easily',
      subtitleKey: 'schedule_appointments_conveniently',
    ),
    OnboardingData(
      image: 'assets/images/delivery.png',
      titleKey: 'quality_guaranteed',
      subtitleKey: 'satisfaction_assured_every_time',
    ),
  ];

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (currentIndex < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() {
    context.read<DBService>().setBool(
      isSaved: true,
      key: DBService.intro,
    );
    context.read<DBService>().setVerified(
      isSaved: true,
    );
    Navigator.pop(context);
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
            body: Stack(
              children: [
                // Hero Image - takes up ~55% of screen
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: screenHeight * 0.55,
                  child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemCount: onboardingData.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        onboardingData[index].image,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      );
                    },
                  ),
                ),

                // Progress Indicator at top
                Positioned(
                  top: topPadding + 12.h,
                  left: 16.w,
                  right: 16.w,
                  child: _buildProgressBar(colors),
                ),

                // Bottom Sheet Card - overlaps the image
                Positioned(
                  top: screenHeight * 0.50,
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
                    child: _buildBottomSheetContent(colors, fonts, bottomPadding),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgressBar(CustomColorSet colors) {
    return Row(
      children: List.generate(
        onboardingData.length,
        (index) => Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 4.h,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.r),
              color: index <= currentIndex
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
    final data = onboardingData[currentIndex];

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
          _PrimaryPillButton(
            onPressed: _nextPage,
            title: currentIndex == onboardingData.length - 1
                ? "lets_get_started".tr()
                : "continue".tr(),
            backgroundColor: colors.primary500,
          ),
          SizedBox(height: 12.h),

          // Secondary Button (Already have an account)
          _SecondaryPillButton(
            onPressed: _completeOnboarding,
            title: "already_have_an_account".tr(),
            textColor: colors.shade100,
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

class _PrimaryPillButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color backgroundColor;

  const _PrimaryPillButton({
    required this.onPressed,
    required this.title,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AnimationButtonEffect(
          onTap: onPressed,
          child: Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(50.r),
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              style: fonts.paragraphP1SemiBold.copyWith(
                color: colors.shade0,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SecondaryPillButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color textColor;

  const _SecondaryPillButton({
    required this.onPressed,
    required this.title,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AnimationButtonEffect(
          onTap: onPressed,
          child: Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50.r),
              border: Border.all(
                color: textColor,
                width: 1.5,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              style: fonts.paragraphP1Medium.copyWith(
                color: textColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
