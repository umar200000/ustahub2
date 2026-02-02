import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/styles/theme.dart';

class LanguageSelector extends StatelessWidget {
  final String selectedLanguage;
  final ValueChanged<String> onChanged;
  final FontSet fonts;
  final CustomColorSet colors;

  const LanguageSelector({
    super.key,
    required this.selectedLanguage,
    required this.onChanged,
    required this.fonts,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationButtonEffect(
      onTap: () => _showLanguageBottomSheet(context),
      scaleFactor: 0.95,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: colors.neutral100,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedLanguage,
              style: fonts.paragraphP2Regular.copyWith(color: colors.shade100),
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.keyboard_arrow_down,
              color: colors.neutral600,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.shade0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'select_language'.tr(),
                style: fonts.paragraphP1SemiBold.copyWith(
                  color: colors.shade100,
                ),
              ),
              SizedBox(height: 16.h),
              ..._buildLanguageOptions(context),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildLanguageOptions(BuildContext context) {
    final languages = [
      'English',
      'Español',
      'Français',
      'Deutsch',
      'Русский',
      'O\'zbekcha',
    ];
    return languages.map((language) {
      return AnimationButtonEffect(
        onTap: () {
          onChanged(language);
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Row(
            children: [
              Text(
                language,
                style: fonts.paragraphP1Regular.copyWith(
                  color: selectedLanguage == language
                      ? colors.blue500
                      : colors.shade100,
                ),
              ),
              const Spacer(),
              if (selectedLanguage == language)
                Icon(Icons.check, color: colors.blue500, size: 24.sp),
            ],
          ),
        ),
      );
    }).toList();
  }
}
