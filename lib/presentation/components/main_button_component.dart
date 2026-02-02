import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class MainButtonComponent extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final EdgeInsets? margin;
  final bool isLoading;
  final Widget? child;
  final Widget? childAfter;

  const MainButtonComponent({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
    this.fontSize,
    this.margin,
    this.child,
    this.isLoading = false,
    this.childAfter,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder:
          (
            BuildContext context,
            CustomColorSet colors,
            FontSet fonts,
            IconSet icons,
            controller,
          ) {
            return GestureDetector(
              onTap: isLoading ? () {} : onPressed,
              child: Container(
                width: width ?? double.infinity,
                height: height ?? 56.h,
                margin: margin,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: backgroundColor == Colors.transparent
                        ? borderColor ?? colors.neutral800
                        : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(32.r),
                  color: backgroundColor ?? colors.primary500,
                ),
                child: Center(
                  child: isLoading
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            child ?? const SizedBox(),
                            child != null
                                ? SizedBox(width: 8.w)
                                : const SizedBox(),
                            Text(
                              semanticsLabel: text,
                              text,
                              style: fonts.paragraphP3Medium.copyWith(
                                fontSize: fontSize,
                                color: textColor ?? colors.shade0,
                              ),
                            ),
                            childAfter != null
                                ? SizedBox(width: 8.w)
                                : const SizedBox(),
                            childAfter ?? const SizedBox(),
                          ],
                        ),
                ),
              ),
            );
          },
    );
  }
}
