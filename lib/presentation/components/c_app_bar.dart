import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class CAppBar extends StatelessWidget {
  final String title;
  final Widget? titleWidget;
  final bool isBack;
  final Widget? leading;
  final Widget? trailing;
  final Widget? bottom;
  final EdgeInsetsGeometry? padding;
  final bool bordered;
  final bool centerTitle;
  final bool blur;
  const CAppBar({
    super.key,
    required this.title,
    this.isBack = true,
    this.leading,
    this.trailing,
    this.padding,
    this.bordered = false,
    this.bottom,
    this.centerTitle = false,
    this.blur = true,
    this.titleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Container(
          // color: Colors.white.withOpacity(.3),
          padding: padding ?? EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [
              const SafeArea(bottom: false, child: SizedBox.shrink()),
              8.h.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (isBack) ...[
                    AnimationButtonEffect(
                      onTap: () => Navigator.pop(context),
                      child: icons.backS.svg(
                        height: 28.r,
                        width: 28.r,
                        color: colors.shade100,
                      ),
                    ),
                    8.w.horizontalSpace,
                  ] else
                    leading ??
                        (centerTitle
                            ? 36.w.horizontalSpace
                            : const SizedBox.shrink()),
                  8.w.horizontalSpace,
                  Expanded(
                    child:
                        titleWidget ??
                        Text(
                          semanticsLabel: title,
                          title,
                          style: fonts.headingH4Medium.copyWith(
                            color: colors.shade100,
                            fontSize: 20.sp,
                          ),
                          textAlign: centerTitle
                              ? TextAlign.center
                              : TextAlign.start,
                        ),
                  ),
                  8.w.horizontalSpace,
                  trailing ?? const SizedBox.shrink(),
                ],
              ),
              12.h.verticalSpace,
              if (bottom != null) ...[bottom!, 12.h.verticalSpace],
            ],
          ),
        );
      },
    );
  }
}
