import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/style.dart';
import '../styles/theme_wrapper.dart';
import 'animation_effect.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool isDisabled;
  final double? verticalPadding;
  final double? horizontalPadding;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? disableColor;
  final double? borderRadius;
  final Widget? titleWidget;
  final TextStyle? style;

  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    this.isDisabled = false,
    required this.title,
    this.verticalPadding,
    this.horizontalPadding,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.titleWidget,
    this.disableColor,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, _, __) {
        return OutlinedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStateColor.resolveWith(
              (states) => backgroundColor ?? Colors.transparent,
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 32.r),
              ),
            ),
            side: WidgetStateProperty.all<BorderSide>(
              BorderSide(color: borderColor ?? Style.transparent, width: 1),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding ?? 12.h,
              horizontal: horizontalPadding ?? 42.w,
            ),
            child:
                titleWidget ??
                Text(
                  semanticsLabel: title,
                  title,
                  style:
                      style ??
                      fonts.paragraphP2Regular.copyWith(
                        color: textColor ?? colors.shade100,
                        fontSize: 12.sp,
                      ),
                ),
          ),
        );
      },
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final String title;
  final TextStyle? titleStyle;
  final Color? titleColor;
  final bool isDisabled;
  final double borderWidth;
  final Color? disableColor;
  final double? verticalPadding;
  final double? horizontalPadding;
  final bool haveBorder;
  final bool isInfinityWidth;
  final Color? borderColor;
  final Widget? titleWidget;
  final List<BoxShadow>? shadow;
  final double? borderRadius;
  final Gradient? gradient;

  const CustomButton({
    super.key,
    this.shadow,
    required this.onPressed,
    this.isDisabled = false,
    this.haveBorder = true,
    required this.title,
    this.titleStyle,
    this.titleColor,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1,
    this.verticalPadding,
    this.horizontalPadding,
    this.isInfinityWidth = true,
    this.titleWidget,
    this.borderRadius,
    this.disableColor,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, __, ___) {
        return AnimationButtonEffect(
          onTap: isDisabled ? null : onPressed,
          child: Container(
            width: isInfinityWidth ? double.infinity : null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
              border: haveBorder
                  ? Border.all(
                      color: isDisabled
                          ? disableColor ?? colors.shade0
                          : borderColor ?? colors.transparent,
                      width: borderWidth,
                    )
                  : null,
              color: isDisabled
                  ? disableColor ?? colors.neutral200
                  : backgroundColor ?? colors.blue500,
              boxShadow: isDisabled ? null : shadow,
              gradient: gradient,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: verticalPadding ?? 12.h,
                horizontal: horizontalPadding ?? 8.w,
              ),
              child:
                  titleWidget ??
                  Text(
                    semanticsLabel: title,
                    title,
                    textAlign: TextAlign.center,
                    style:
                        titleStyle ??
                        fonts.paragraphP1SemiBold.copyWith(
                          color: isDisabled
                              ? colors.neutral600
                              : titleColor ?? colors.shade0,
                        ),
                  ),
            ),
          ),
        );
      },
    );
  }
}
