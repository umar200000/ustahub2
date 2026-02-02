import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/custom_button.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class EmptyBasket extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onTap;

  const EmptyBasket({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: fonts.headingH6SemiBold,
                textAlign: TextAlign.center,
              ),
              12.h.verticalSpace,
              Text(
                description,
                style: fonts.paragraphP2Medium.copyWith(
                  color: colors.neutral600,
                ),
                textAlign: TextAlign.center,
              ),
              16.h.verticalSpace,
              CustomButton(
                onPressed: onTap,
                title: buttonText,
                isInfinityWidth: false,
                verticalPadding: 12.h,
                horizontalPadding: 24.w,
                titleStyle: fonts.paragraphP1SemiBold.copyWith(
                  color: colors.shade0,
                ),
                backgroundColor: colors.primary500,
                borderColor: colors.primary500,
              ),
              16.h.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
