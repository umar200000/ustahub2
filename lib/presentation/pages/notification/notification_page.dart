import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ustahub/presentation/components/c_app_bar.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.shade0,
          body: Column(
            children: [
              CAppBar(
                title: "notifications".tr(),
                centerTitle: true,
                isBack: true,
                trailing: 28.w.horizontalSpace,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/animations/no_notification.json",
                      width: 240.w,
                      height: 240.h,
                    ),
                    8.h.verticalSpace,
                    Text(
                      "no_notifications_description".tr(),
                      style: fonts.headingH6Regular,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
