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
    this.showShadow = false,
    this.padding,
    this.margin,
    this.showBorderRadius = false,
    this.borderRadius,
    this.centerTitle = true,
    this.height,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.leadingWidth,
    this.trailingWidth,
    this.horizontalSpacing = 8,
    this.verticalSpacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        final bg = backgroundColor ?? colors.shade0;
        final isDark =
            ThemeData.estimateBrightnessForColor(bg) == Brightness.dark;
        final fgColor = isDark ? Colors.white : colors.neutral800;
        final subtleBg = isDark
            ? Colors.white.withValues(alpha: 0.14)
            : colors.neutral100;
        final dividerColor = isDark
            ? Colors.white.withValues(alpha: 0.12)
            : colors.neutral200;

        return Container(
          height: height,
          margin: margin,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: showBorderRadius
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(borderRadius ?? 24.r),
                    bottomRight: Radius.circular(borderRadius ?? 24.r),
                  )
                : null,
            border: !showShadow
                ? Border(bottom: BorderSide(color: dividerColor, width: 0.6))
                : null,
            boxShadow: showShadow
                ? [
                    BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: 12,
                      spreadRadius: 0,
                      color: Colors.black.withValues(alpha: 0.06),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: padding ??
                      EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
                  child: SizedBox(
                    height: 44.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (centerTitle &&
                            (title != null || titleWidget != null))
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 56.w),
                              child: _buildTitle(fonts, fgColor),
                            ),
                          ),
                        Row(
                          children: [
                            if (showBackButton || leading != null)
                              _buildLeading(context, colors, fgColor, subtleBg)
                            else
                              SizedBox(width: 4.w),
                            if (!centerTitle &&
                                (title != null || titleWidget != null)) ...[
                              SizedBox(width: 12.w),
                              Expanded(child: _buildTitle(fonts, fgColor)),
                            ] else
                              const Spacer(),
                            if (trailing != null ||
                                (actions != null && actions!.isNotEmpty))
                              _buildTrailing(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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

  Widget _buildLeading(
    BuildContext context,
    CustomColorSet colors,
    Color fgColor,
    Color subtleBg,
  ) {
    if (customBackButton != null) return customBackButton!;

    if (showBackButton) {
      return AnimationButtonEffect(
        onTap: onBackPressed ?? () => Navigator.pop(context),
        child: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: subtleBg,
            borderRadius: BorderRadius.circular(12.r),
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18.sp,
            color: fgColor,
          ),
        ),
      );
    }

    return SizedBox(width: leadingWidth, child: leading);
  }

  Widget _buildTitle(FontSet fonts, Color fgColor) {
    if (titleWidget != null) return titleWidget!;

    return Text(
      title ?? '',
      style: titleStyle ??
          TextStyle(
            color: fgColor,
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
      textAlign: centerTitle ? TextAlign.center : titleAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget _buildTrailing() {
    if (actions != null && actions!.isNotEmpty) {
      return Row(
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
      );
    }

    return SizedBox(width: trailingWidth, child: trailing);
  }
}
