import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class UniversalAppBar extends StatelessWidget {
  // Title
  final String? title;
  final Widget? titleWidget;
  final TextAlign titleAlign;
  final TextStyle? titleStyle;

  // Navigation
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Widget? customBackButton;

  // Leading & Trailing
  final Widget? leading;
  final Widget? trailing;
  final List<Widget>? actions;

  // Bottom
  final Widget? bottom;
  final double? bottomHeight;

  // Styling
  final Color? backgroundColor;
  final double? elevation;
  final bool showShadow;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool showBorderRadius;
  final double? borderRadius;

  // Layout
  final bool centerTitle;
  final double? height;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  // Spacing
  final double? leadingWidth;
  final double? trailingWidth;
  final double horizontalSpacing;
  final double verticalSpacing;

  const UniversalAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.titleAlign = TextAlign.start,
    this.titleStyle,
    this.showBackButton = false,
    this.onBackPressed,
    this.customBackButton,
    this.leading,
    this.trailing,
    this.actions,
    this.bottom,
    this.bottomHeight,
    this.backgroundColor,
    this.elevation,
    this.showShadow = true,
    this.padding,
    this.margin,
    this.showBorderRadius = true,
    this.borderRadius,
    this.centerTitle = false,
    this.height,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.leadingWidth,
    this.trailingWidth,
    this.horizontalSpacing = 8,
    this.verticalSpacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Container(
          height: height,
          margin: margin,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.black,
            borderRadius: showBorderRadius
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(borderRadius ?? 24.r),
                    bottomRight: Radius.circular(borderRadius ?? 24.r),
                  )
                : null,
            boxShadow: showShadow
                ? [
                    BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: 8,
                      spreadRadius: 0,
                      color: Colors.black.withOpacity(0.08),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Safe Area
              const SafeArea(bottom: false, child: SizedBox.shrink()),

              SizedBox(height: verticalSpacing.h),

              // Main AppBar Content
              Padding(
                padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment:
                      mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
                  crossAxisAlignment:
                      crossAxisAlignment ?? CrossAxisAlignment.center,
                  children: [
                    // Leading Section
                    if (showBackButton || leading != null)
                      _buildLeading(context),

                    if ((showBackButton || leading != null) &&
                        (title != null || titleWidget != null))
                      SizedBox(width: horizontalSpacing.w),
                    if (title != null || titleWidget != null)
                      Expanded(child: _buildTitle(fonts, colors)),
                    if (trailing != null || actions != null)
                      SizedBox(width: horizontalSpacing.w),

                    if (trailing != null || actions != null) _buildTrailing(),
                  ],
                ),
              ),

              SizedBox(height: verticalSpacing.h),

              // Bottom Widget
              if (bottom != null) ...[
                SizedBox(height: bottomHeight, child: bottom!),
                SizedBox(height: verticalSpacing.h),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildLeading(BuildContext context) {
    if (customBackButton != null) {
      return customBackButton!;
    }

    if (showBackButton) {
      return ThemeWrapper(
        builder: (context, colors, fonts, icons, controller) {
          return AnimationButtonEffect(
            onTap: onBackPressed ?? () => Navigator.pop(context),
            child: Container(
              width: leadingWidth ?? 40.w,
              height: 40.w,
              alignment: Alignment.centerLeft,
              child: icons.backS.svg(
                height: 28.r,
                width: 28.r,
                color: Colors.white,
              ),
            ),
          );
        },
      );
    }

    return SizedBox(width: leadingWidth, child: leading!);
  }

  Widget _buildTitle(FontSet fonts, CustomColorSet colors) {
    if (titleWidget != null) {
      return titleWidget!;
    }

    return Text(
      title!,
      style:
          titleStyle ??
          fonts.headingH4Medium.copyWith(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
      textAlign: centerTitle ? TextAlign.center : titleAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget _buildTrailing() {
    if (actions != null && actions!.isNotEmpty) {
      return SizedBox(
        width: trailingWidth,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: actions!
              .map(
                (action) => Padding(
                  padding: EdgeInsets.only(left: horizontalSpacing.w / 2),
                  child: action,
                ),
              )
              .toList(),
        ),
      );
    }

    return SizedBox(width: trailingWidth, child: trailing!);
  }
}
