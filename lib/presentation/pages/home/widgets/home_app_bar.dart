import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/components/custom_text_field.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return UniversalAppBar(
          backgroundColor: const Color(0xFF1A1A1A),
          showBackButton: false,
          showShadow: false,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          verticalSpacing: 12,

          leading: Icon(
            Icons.handyman_sharp,
            color: colors.blue500,
            size: 28.sp,
          ),
          titleWidget: Text(
            "USTAHUB",
            style: fonts.paragraphP1Bold.copyWith(color: colors.shade0),
          ),
          titleAlign: TextAlign.start,
          actions: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: colors.neutral200,
              child: AnimationButtonEffect(
                onTap: () {},
                child: icons.searchS.svg(color: colors.shade100),
              ),
            ),
            SizedBox(width: 8.w),
            CircleAvatar(
              radius: 20.r,
              backgroundColor: colors.neutral200,
              child: AnimationButtonEffect(
                onTap: () {},
                child: Icon(Icons.menu, color: colors.shade100, size: 24.sp),
              ),
            ),
          ],

          bottom: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomTextField(
              hintText: "Find a service",
              controller: TextEditingController(),
              prefixIcon: icons.searchS.svg(color: colors.neutral600),
              borderRadius: 12.r,
              fillColor: colors.shade0,
            ),
          ),
          bottomHeight: 56.h,
        );
      },
    );
  }
}
