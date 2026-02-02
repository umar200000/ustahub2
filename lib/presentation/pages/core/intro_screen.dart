import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ustahub/infrastructure/services/local_database/db_service.dart';
import 'package:ustahub/presentation/components/custom_button.dart';
import 'package:ustahub/presentation/styles/style.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentIndex = 0;

  late final PageController pageController;

  @override
  void initState() {
    pageController = PageController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Style.dark,
      child: ThemeWrapper(
        builder: (context, colors, fonts, icons, controller) {
          return Scaffold(
            backgroundColor: colors.shade0,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Column(
                      children: [
                        CustomButton(
                          onPressed: () {
                            context.read<DBService>().setBool(
                              isSaved: true,
                              key: DBService.intro,
                            );
                            context.read<DBService>().setVerified(
                              isSaved: true,
                            );

                            Navigator.pop(context);
                          },
                          backgroundColor: colors.primary500,
                          title: "lets_get_started".tr(),
                        ),
                        // AnimationButtonEffect(
                        //   onTap: () {
                        //     showAuthModalSheet(context, (_) {
                        //       context.read<DBService>().setLang(isSaved: true);
                        //       context.read<DBService>().setBool(isSaved: true, key: DBService.intro);
                        //       Navigator.pop(context);
                        //     });
                        //   },
                        //   child: Text.rich(
                        //     TextSpan(
                        //       children: [
                        //         TextSpan(semanticsLabel: "${"already_have_an_account".tr()} ", text: "${"already_have_an_account".tr()} "),
                        //         TextSpan(
                        //           semanticsLabel: "sign_in".tr(),
                        //           text: "sign_in".tr(),
                        //           style: const TextStyle(decoration: TextDecoration.underline),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // List<Widget> _screenList(CustomColorSet colors, IconSet icons) {
  //   return [
  //     _buildScreen(
  //       title: "sell_it_profitably_or_buy_a_car".tr(),
  //       image: icons.onboardingBannerOne,
  //     ),
  //     _buildScreen(
  //       title: "rate_the_entire_car_in_one_minute".tr(),
  //       image: icons.onboardingBannerTwo,
  //     ),
  //     _buildScreen(
  //       title: "sign_up_for_car_diagnostics".tr(),
  //       image: icons.onboardingBannerThree,
  //     ),
  //   ];
  // }

  // _buildScreen({required String title, required String image}) {
  //   return ThemeWrapper(
  //     builder: (context, colors, fonts, icons, controller) {
  //       return Column(
  //         children: [
  //           Expanded(
  //             child: image.svg(boxFit: BoxFit.contain),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 32.h),
  //             child: Text(
  //               semanticsLabel: title,
  //               title,
  //               style: fonts.headingH3Bold,
  //               textAlign: TextAlign.start,
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
