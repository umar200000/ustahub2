import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class CEmpty extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String? title;
  final String? subtitle;
  final Widget? icon;
  final String? onTapTitle;
  const CEmpty({
    super.key,
    this.onTap,
    this.title,
    this.subtitle,
    this.icon,
    this.onTapTitle,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon ?? const SizedBox.shrink(),
            16.h.verticalSpace,
            Text(
              semanticsLabel: title ?? "you_have_no_active_ads".tr(),
              title ?? "you_have_no_active_ads".tr(),
              style: fonts.paragraphP2SemiBold,
            ),
            8.h.verticalSpace,
            Text(
              semanticsLabel:
                  subtitle ?? "active_advertisements_will_appear_here".tr(),
              subtitle ?? "active_advertisements_will_appear_here".tr(),
              style: fonts.paragraphP1Medium.copyWith(color: colors.neutral500),
              textAlign: TextAlign.center,
            ),
            16.h.verticalSpace,
            if (onTap != null)
              OutlinedButton.icon(
                onPressed: onTap,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.r),
                    side: BorderSide(color: colors.neutral200),
                  ),
                  side: BorderSide(width: 1.4.w, color: colors.neutral200),
                  overlayColor: colors.neutral500,
                ),
                icon: onTapTitle == null
                    ? icons.plusS.svg(
                        color: colors.neutral500,
                        height: 14.h,
                        width: 14.h,
                      )
                    : null,
                label: Text(
                  semanticsLabel: onTapTitle ?? "to_add_an_advert".tr(),
                  onTapTitle ?? "to_add_an_advert".tr(),
                  style: fonts.captionMedium.copyWith(color: colors.neutral500),
                ),
              ),
          ],
        );
      },
    );
  }
}
