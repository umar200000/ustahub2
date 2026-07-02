import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ustahub/presentation/components/custom_button.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class UpdateRequiredPage extends StatelessWidget {
  final bool isForceUpdate;
  final String? storeUrl;
  final String? releaseNotes;

  const UpdateRequiredPage({
    super.key,
    required this.isForceUpdate,
    this.storeUrl,
    this.releaseNotes,
  });

  Future<void> _launchStore() async {
    if (storeUrl == null || storeUrl!.isEmpty) return;
    final uri = Uri.parse(storeUrl!);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return PopScope(
          canPop: !isForceUpdate,
          child: Scaffold(
            backgroundColor: colors.bgSurface,
            appBar: isForceUpdate
                ? null
                : AppBar(
                    backgroundColor: colors.bgSurface,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(Icons.close, color: colors.neutral700),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    const Spacer(),

                    // Icon
                    Container(
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: colors.primary500.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colors.primary500.withValues(alpha: 0.3),
                          width: 2.w,
                        ),
                      ),
                      child: Icon(
                        Icons.system_update_rounded,
                        size: 56.r,
                        color: colors.primary500,
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Title
                    Text(
                      'Yangilanish mavjud',
                      textAlign: TextAlign.center,
                      style: fonts.headingH6Bold.copyWith(
                        color: colors.neutral800,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Description
                    Text(
                      'Ilovadan foydalanishni davom ettirish uchun yangi versiyani yuklab oling.',
                      textAlign: TextAlign.center,
                      style: fonts.paragraphP1Regular.copyWith(
                        color: colors.neutral500,
                        height: 1.5,
                      ),
                    ),

                    // Release notes
                    if (releaseNotes != null) ...[
                      SizedBox(height: 24.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: colors.primary500.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: colors.primary500.withValues(alpha: 0.2),
                            width: 1.w,
                          ),
                        ),
                        child: Text(
                          releaseNotes!,
                          style: fonts.paragraphP2Regular.copyWith(
                            color: colors.neutral700,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],

                    const Spacer(),

                    // Update button
                    CustomButton(
                      onPressed: _launchStore,
                      title: 'Yangilash',
                      backgroundColor: colors.primary500,
                    ),

                    // "Later" button (only for optional update)
                    if (!isForceUpdate) ...[
                      SizedBox(height: 12.h),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Keyinroq',
                          style: fonts.paragraphP1Medium.copyWith(
                            color: colors.neutral500,
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
