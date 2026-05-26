import 'dart:io' show Platform;

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';
import 'package:ustahub/utils/constants.dart';

/// Firebase Remote Config orqali majburiy / ixtiyoriy yangilanishni tekshiradi.
///
/// Remote Config kalitlari (Firebase Console > Remote Config):
///   android_min_version  (String)  — masalan "1.2.0" yoki "1.2.0+5"
///   android_is_force     (Boolean) — true bo'lsa yopib bo'lmaydigan (majburiy) dialog
///   android_url          (String)  — Play Market havolasi (bo'sh bo'lsa Constants ishlatiladi)
///   ios_min_version      (String)
///   ios_is_force         (Boolean)
///   ios_url              (String)   — App Store havolasi
///
/// Ishlash mantig'i: agar qurilmadagi joriy versiya `*_min_version` dan kichik
/// bo'lsa — dialog chiqadi. `*_is_force == true` bo'lsa dialogni yopib bo'lmaydi
/// va orqaga qaytib bo'lmaydi (foydalanuvchi yangilashga majbur).
class UpdateCheckService {
  UpdateCheckService._();

  /// App ochilganda bir marta tekshiruvni rejalashtirish.
  /// [navKey] — MaterialApp ga ulangan navigator key (dialog shu kontekstda chiqadi).
  static bool _scheduled = false;

  static void scheduleCheck(GlobalKey<NavigatorState>? navKey) {
    if (_scheduled || navKey == null) return;
    _scheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = navKey.currentContext;
      if (ctx != null) checkUpdate(ctx);
    });
  }

  static Future<void> checkUpdate(BuildContext context) async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;

      // Birinchi fetch tugamasdan kalitlar bo'sh kelmasligi uchun default qiymatlar
      await remoteConfig.setDefaults(const {
        'android_min_version': '',
        'android_is_force': false,
        'android_url': '',
        'ios_min_version': '',
        'ios_is_force': false,
        'ios_url': '',
      });

      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          // Yangilanish darhol ta'sir qilishi uchun (ishlab chiqishda 0).
          // Productionda throttling kamaytirish uchun kattaroq qiymat berish mumkin.
          minimumFetchInterval: Duration.zero,
        ),
      );

      await remoteConfig.fetchAndActivate();

      String minVersionStr = '';
      bool isForceUpdate = false;
      String updateUrl = '';

      if (Platform.isAndroid) {
        minVersionStr = remoteConfig.getString('android_min_version');
        isForceUpdate = remoteConfig.getBool('android_is_force');
        updateUrl = remoteConfig.getString('android_url');
      } else if (Platform.isIOS) {
        minVersionStr = remoteConfig.getString('ios_min_version');
        isForceUpdate = remoteConfig.getBool('ios_is_force');
        updateUrl = remoteConfig.getString('ios_url');
      }

      // URL bo'sh bo'lsa — loyihaning standart do'kon havolalari
      if (updateUrl.isEmpty) {
        updateUrl = Platform.isAndroid
            ? Constants.googlePlayUrl
            : Constants.appStoreUrl;
      }

      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersionStr =
          "${packageInfo.version}+${packageInfo.buildNumber}";

      if (_isVersionLessThan(currentVersionStr, minVersionStr)) {
        if (context.mounted) {
          _showCustomUpdateDialog(context, updateUrl, isForceUpdate);
        }
      }
    } catch (e) {
      debugPrint("Remote Config xatoligi: $e");
    }
  }

  /// `current < min` bo'lsa true qaytaradi. "1.2.0+5" va "1.2.0" formatlarini
  /// ham qo'llab-quvvatlaydi (build raqami ixtiyoriy).
  static bool _isVersionLessThan(String current, String min) {
    if (min.isEmpty) return false;

    final currentSplit = current.split('+');
    final minSplit = min.split('+');

    final currentVersionParts =
        currentSplit[0].split('.').map((e) => int.tryParse(e) ?? 0).toList();
    final minVersionParts =
        minSplit[0].split('.').map((e) => int.tryParse(e) ?? 0).toList();

    final maxLength = currentVersionParts.length > minVersionParts.length
        ? currentVersionParts.length
        : minVersionParts.length;

    for (int i = 0; i < maxLength; i++) {
      final curPart = i < currentVersionParts.length ? currentVersionParts[i] : 0;
      final minPart = i < minVersionParts.length ? minVersionParts[i] : 0;

      if (curPart < minPart) return true;
      if (curPart > minPart) return false;
    }

    final currentBuild =
        currentSplit.length > 1 ? (int.tryParse(currentSplit[1]) ?? 0) : 0;
    final minBuild =
        minSplit.length > 1 ? (int.tryParse(minSplit[1]) ?? 0) : 0;

    return currentBuild < minBuild;
  }

  static void _showCustomUpdateDialog(
    BuildContext context,
    String url,
    bool isForceUpdate,
  ) {
    showDialog(
      context: context,
      barrierDismissible: !isForceUpdate,
      builder: (dialogContext) {
        return ThemeWrapper(
          builder: (context, colors, fonts, icons, controller) {
            return PopScope(
              canPop: !isForceUpdate,
              child: Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 340.w),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colors.shade0,
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(color: colors.neutral200, width: 1.w),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 24.h),
                      Container(
                        padding: EdgeInsets.all(16.r),
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
                          size: 40.r,
                          color: colors.primary500,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "ubdate.title".tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: colors.neutral800,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Text(
                          isForceUpdate
                              ? "ubdate.force_text".tr()
                              : "ubdate.flexible_text".tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: colors.neutral500,
                            height: 1.4,
                          ),
                        ),
                      ),
                      SizedBox(height: 28.h),
                      Divider(
                        color: colors.neutral200,
                        height: 1.h,
                        thickness: 1.w,
                      ),
                      Row(
                        children: [
                          if (!isForceUpdate) ...[
                            Expanded(
                              child: InkWell(
                                onTap: () => Navigator.pop(dialogContext),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(24.r),
                                ),
                                child: Container(
                                  height: 56.h,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "ubdate.later_btn".tr(),
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: colors.neutral500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 1.w,
                              height: 56.h,
                              color: colors.neutral200,
                            ),
                          ],
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final uri = Uri.parse(url);
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(
                                    uri,
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(24.r),
                                bottomLeft: Radius.circular(
                                  isForceUpdate ? 24.r : 0,
                                ),
                              ),
                              child: Container(
                                height: 56.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isForceUpdate
                                      ? colors.primary500.withValues(alpha: 0.12)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(24.r),
                                    bottomLeft: Radius.circular(
                                      isForceUpdate ? 24.r : 0,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "ubdate.update_btn".tr(),
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                    color: colors.primary500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
