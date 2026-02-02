import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ustahub/presentation/components/c_app_bar.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.shade0,
          body: Column(
            children: [
              CAppBar(
                title: "Orders".tr(),
                centerTitle: true,
                isBack: true,
                trailing: 28.w.horizontalSpace,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/animations/no_order.json",
                      width: 240.w,
                      height: 240.h,
                    ),
                    8.h.verticalSpace,
                    Text(
                      "no_planned_orders".tr(),
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
