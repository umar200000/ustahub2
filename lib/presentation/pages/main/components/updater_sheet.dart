import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ustahub/presentation/components/custom_button.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';
import 'package:ustahub/utils/constants.dart';
import 'package:ustahub/utils/debounce.dart';

class UpdaterSheet extends StatefulWidget {
  final VoidCallback onUpdate;
  const UpdaterSheet({super.key, required this.onUpdate});

  @override
  State<UpdaterSheet> createState() => _UpdaterSheetState();
}

class _UpdaterSheetState extends State<UpdaterSheet> {
  int count = 0;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, globalController) {
        return Container(
          decoration: BoxDecoration(
            color: colors.shade0,
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          margin: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              24.h.verticalSpace,
              GestureDetector(
                onTap: () {
                  if (count < 4) {
                    count++;
                  } else {
                    SmartDialog.dismiss();
                  }
                },
                child: Image.asset(icons.sazuLogo, width: 54.w, height: 54.h),
              ),
              16.h.verticalSpace,
              Text('version_updated'.tr(), style: fonts.subheadingSemiBold),
              16.h.verticalSpace,
              Text(
                'version_updated_description'.tr(),
                style: fonts.paragraphP2Medium,
                textAlign: TextAlign.center,
              ),
              16.h.verticalSpace,
              CustomButton(
                onPressed: () {
                  onDebounce(() {
                    if (isChecked) {
                      debugPrint(" ----> isChecked : $isChecked");
                      widget.onUpdate.call();
                    } else {
                      if (Platform.isIOS) {
                        launchUrl(Uri.parse(Constants.appStoreUrl)).then((v) {
                          debugPrint(" ----> v : $v");
                        });
                      } else {
                        launchUrl(Uri.parse(Constants.googlePlayUrl));
                      }

                      isChecked = true;
                      setState(() {});
                    }
                  }, const Duration(milliseconds: 300));
                },
                title: isChecked ? 'check_again'.tr() : 'update'.tr(),
                titleStyle: fonts.paragraphP1SemiBold.copyWith(
                  color: colors.shade0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
