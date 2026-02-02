import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/infrastructure/services/local_database/db_service.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/components/custom_button.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';
import 'package:ustahub/utils/custom_tools.dart';

class IncramentBasketComp extends StatefulWidget {
  final GestureTapCallback onIncrease;
  final GestureTapCallback onDecrease;
  final GestureTapCallback? onInformInc;
  final GestureTapCallback? onInformDec;
  final int limit;
  final bool disable;
  final int count;
  final int informCount;
  final bool circular;

  const IncramentBasketComp({
    super.key,
    required this.limit,
    required this.disable,
    required this.count,
    this.informCount = 0,
    required this.onIncrease,
    required this.onDecrease,
    this.onInformInc,
    this.onInformDec,
    this.circular = false,
  });

  @override
  State<IncramentBasketComp> createState() => _IncramentBasketCompState();
}

class _IncramentBasketCompState extends State<IncramentBasketComp> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        // Product functionality
        if (widget.limit != 0) {
          return widget.count == 0
              ? _buildAddToCartButton(colors, fonts, icons)
              : _buildCounterWidget(colors, fonts);
        }
        // Inform functionality
        else {
          return widget.informCount == 0
              ? _buildInformButton(colors, fonts, icons)
              : _buildInformCounterWidget(colors, fonts);
        }
      },
    );
  }

  Widget _buildAddToCartButton(
    CustomColorSet colors,
    FontSet fonts,
    IconSet icons,
  ) {
    return RepaintBoundary(
      child: AnimationButtonEffect(
        onTap: () => AuthUtils.handleActionWithAuth(
          context,
          widget.onIncrease,
          mounted: mounted,
        ),
        child: Container(
          height: 38.h,
          width: 128.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: colors.primary500,
            boxShadow: colors.shadowS,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
          child: Text(
            "add_to".tr(),
            style: fonts.paragraphP1SemiBold.copyWith(color: colors.shade0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildCounterWidget(CustomColorSet colors, FontSet fonts) {
    final bool canIncrease = widget.limit > widget.count;

    return RepaintBoundary(
      child: Container(
        height: 38.h,
        width: 128.w,
        decoration: BoxDecoration(
          color: colors.primary500,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: colors.shadowS,
        ),
        padding: EdgeInsets.symmetric(vertical: 6.8.h, horizontal: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AnimationButtonEffect(
              onTap: () => AuthUtils.handleActionWithAuth(
                context,
                widget.onDecrease,
                mounted: mounted,
              ),
              child: Container(
                padding: EdgeInsets.only(left: 4.w, right: 14.w),
                color: colors.transparent,
                height: 38.h,
                width: 38.w,
                child: Icon(Icons.remove, color: colors.shade0, size: 18.r),
              ),
            ),
            Text(
              "${widget.count}",
              style: fonts.paragraphP2Medium.copyWith(color: colors.shade0),
              textAlign: TextAlign.center,
            ),
            AnimationButtonEffect(
              onTap: canIncrease
                  ? () => AuthUtils.handleActionWithAuth(
                      context,
                      widget.onIncrease,
                      mounted: mounted,
                    )
                  : null,
              child: Container(
                padding: EdgeInsets.only(right: 4.w, left: 14.w),
                height: 38.h,
                width: 38.w,
                color: colors.transparent,
                child: Icon(
                  Icons.add,
                  color: canIncrease
                      ? colors.shade0
                      : colors.shade0.withOpacity(.5),
                  size: 18.r,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInformButton(
    CustomColorSet colors,
    FontSet fonts,
    IconSet icons,
  ) {
    return RepaintBoundary(
      child: AnimationButtonEffect(
        onTap: () async {
          final dbService = await DBService.create;
          final isFirstTime =
              !(dbService.getBool(key: 'i_want_intro') ?? false);

          if (isFirstTime) {
            bool dontShowAgain = false;

            showDialog(
              context: context,
              builder: (_) => ThemeWrapper(
                builder: (context, colors, fonts, icons, controller) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Center(
                        child: Container(
                          height: 480.h,
                          width: 340.w,
                          decoration: BoxDecoration(
                            color: colors.shade0,
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: colors.shadowS,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 380.h,
                                width: 300.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12.r),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "app_lang".tr() == "ru"
                                          ? icons.iWantBannerRu
                                          : icons.iWantBannerUz,
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                child: Row(
                                  children: [
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                        checkboxTheme: CheckboxThemeData(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              5.r,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Checkbox(
                                        value: dontShowAgain,
                                        onChanged: (value) {
                                          setState(() {
                                            dontShowAgain = value ?? false;
                                          });
                                        },
                                        activeColor: colors.primary500,
                                        side: BorderSide(
                                          color: colors.neutral600,
                                          width: 1.5,
                                        ),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      "dont_show_again".tr(),
                                      style: fonts.paragraphP2Medium,
                                    ),
                                  ],
                                ),
                              ),
                              8.h.verticalSpace,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: AnimationButtonEffect(
                                  onTap: () async {
                                    if (dontShowAgain) {
                                      await dbService.setBool(
                                        key: 'i_want_intro',
                                        isSaved: true,
                                      );
                                    }
                                    Navigator.pop(context);
                                    if (widget.onInformInc != null) {
                                      AuthUtils.handleActionWithAuth(
                                        context,
                                        widget.onInformInc!,
                                        message: "inform_requires_registration"
                                            .tr(),
                                        mounted: mounted,
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colors.primary500,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "ok".tr().toUpperCase(),
                                      style: fonts.paragraphP1SemiBold.copyWith(
                                        color: colors.shade0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else {
            if (widget.onInformInc != null) {
              AuthUtils.handleActionWithAuth(
                context,
                widget.onInformInc!,
                message: "inform_requires_registration".tr(),
                mounted: mounted,
              );
            }
          }
        },
        child: Container(
          height: 32.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            color: colors.shade0,
            boxShadow: colors.shadowS,
          ),
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icons.bellS.svg(
                height: 20.r,
                width: 20.r,
                color: colors.neutral600,
              ),
              SizedBox(width: 10.w),
              Text(
                "i_want".tr(),
                style: fonts.paragraphP2Regular.copyWith(
                  color: colors.shade100,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInformCounterWidget(CustomColorSet colors, FontSet fonts) {
    final bool canIncrease = widget.informCount < 9;

    return RepaintBoundary(
      child: Container(
        height: 38.h,
        width: 128.w,
        decoration: BoxDecoration(
          color: colors.shade0,
          borderRadius: BorderRadius.circular(100.r),
          boxShadow: colors.shadowS,
        ),
        padding: EdgeInsets.symmetric(vertical: 6.8.h, horizontal: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AnimationButtonEffect(
              onTap: () => AuthUtils.handleActionWithAuth(
                context,
                widget.onInformDec!,
                message: "inform_requires_registration".tr(),
                mounted: mounted,
              ),
              child: Container(
                padding: EdgeInsets.only(left: 4.w, right: 14.w),
                color: colors.transparent,
                height: 38.h,
                width: 38.w,
                child: Icon(Icons.remove, color: colors.neutral600, size: 18.r),
              ),
            ),
            Text(
              "${widget.informCount}",
              style: fonts.paragraphP2Medium.copyWith(color: colors.shade100),
              textAlign: TextAlign.center,
            ),
            AnimationButtonEffect(
              onTap: canIncrease
                  ? () => AuthUtils.handleActionWithAuth(
                      context,
                      widget.onInformInc!,
                      message: "inform_requires_registration".tr(),
                      mounted: mounted,
                    )
                  : null,
              child: Container(
                padding: EdgeInsets.only(right: 4.w, left: 14.w),
                height: 38.h,
                width: 38.w,
                color: colors.transparent,
                child: Icon(
                  Icons.add,
                  color: canIncrease
                      ? colors.neutral600
                      : colors.neutral600.withOpacity(.5),
                  size: 18.r,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IncramentBasketCompSmall extends StatefulWidget {
  final GestureTapCallback onIncrease;
  final GestureTapCallback onDecrease;
  final GestureTapCallback? onInformInc;
  final GestureTapCallback? onInformDec;
  final int limit;
  final int count;
  final int informCount;
  final bool disable;
  final bool isSent;
  final String? title;

  const IncramentBasketCompSmall({
    super.key,
    required this.limit,
    required this.count,
    this.informCount = 0,
    required this.disable,
    required this.onIncrease,
    required this.onDecrease,
    this.onInformInc,
    this.onInformDec,
    this.isSent = false,
    this.title,
  });

  @override
  State<IncramentBasketCompSmall> createState() =>
      _IncramentBasketCompSmallState();
}

class _IncramentBasketCompSmallState extends State<IncramentBasketCompSmall> {
  bool showCounter = false;
  Timer? _debounceTimer;

  void _startDebounceTimer() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showCounter = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _handleInteraction() {
    showCounter = true;
    setState(() {});
    _startDebounceTimer();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        // When disabled, always show product count regardless of limit
        if (widget.disable) {
          return _buildDisabledCountDisplay(colors, fonts, widget.count);
        }

        // Product functionality
        if (widget.limit != 0) {
          return _buildProductFunctionalityWidget(colors, fonts, icons);
        }
        // Inform functionality
        else {
          return _buildInformFunctionalityWidget(colors, fonts, icons);
        }
      },
    );
  }

  Widget _buildProductFunctionalityWidget(
    CustomColorSet colors,
    FontSet fonts,
    IconSet icons,
  ) {
    return _buildProductCounterWidget(colors, fonts);
  }

  Widget _buildInformFunctionalityWidget(
    CustomColorSet colors,
    FontSet fonts,
    IconSet icons,
  ) {
    return widget.informCount == 0
        ? _buildInformButton(colors, fonts, icons)
        : _buildInformCounterWidget(colors, fonts);
  }

  Widget _buildDisabledCountDisplay(
    CustomColorSet colors,
    FontSet fonts,
    int count,
  ) {
    final String displayTitle =
        widget.title ?? "${count < 10 ? count : "+9"} ${"pcs".tr()}";

    return Container(
      height: 26.h,
      width: 80.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        color: widget.isSent ? colors.shade0 : colors.neutral100,
        boxShadow: colors.shadowS,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w),
      child: Text(
        displayTitle,
        style: fonts.paragraphP3Medium.copyWith(
          color: colors.neutral600,
          fontWeight: FontWeight.bold,
          fontSize: 11.sp,
        ),
      ),
    );
  }

  Widget _buildProductCounterWidget(CustomColorSet colors, FontSet fonts) {
    final bool canIncrease = widget.limit > widget.count;

    return Container(
      height: 32.h,
      width: 94.w,
      decoration: BoxDecoration(
        color: colors.shade0,
        borderRadius: BorderRadius.circular(100.r),
        boxShadow: colors.shadowS,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimationButtonEffect(
            onTap: () {
              _handleInteraction();
              AuthUtils.handleActionWithAuth(
                context,
                widget.onDecrease,
                mounted: mounted,
              );
            },
            child: Container(
              width: 34.w,
              height: 32.h,
              color: colors.transparent,
              child: Icon(Icons.remove, color: colors.neutral600, size: 18.r),
            ),
          ),
          SizedBox(
            width: 24.w,
            child: Text(
              "${widget.count}",
              style: fonts.paragraphP3Medium.copyWith(
                color: colors.shade100,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          AnimationButtonEffect(
            onTap: canIncrease
                ? () {
                    _handleInteraction();
                    AuthUtils.handleActionWithAuth(
                      context,
                      widget.onIncrease,
                      mounted: mounted,
                    );
                  }
                : null,
            child: Container(
              width: 34.w,
              height: 32.h,
              color: colors.transparent,
              child: Icon(
                Icons.add,
                color: canIncrease
                    ? colors.neutral600
                    : colors.neutral600.withOpacity(.3),
                size: 18.r,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInformButton(
    CustomColorSet colors,
    FontSet fonts,
    IconSet icons,
  ) {
    return AnimationButtonEffect(
      onTap: () async {
        final dbService = await DBService.create;
        final isFirstTime = !(dbService.getBool(key: 'i_want_intro') ?? false);

        if (isFirstTime) {
          bool dontShowAgain = false;

          showDialog(
            context: context,
            builder: (_) => ThemeWrapper(
              builder: (context, colors, fonts, icons, controller) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return Center(
                      child: Container(
                        height: 450.h,
                        width: 340.w,
                        decoration: BoxDecoration(
                          color: colors.shade0,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: colors.shadowS,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 200.h,
                              width: 280.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12.r),
                                ),
                                image: DecorationImage(
                                  image: AssetImage(
                                    "app_lang".tr() == "ru"
                                        ? icons.iWantBannerRu
                                        : icons.iWantBannerUz,
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.w),
                              child: Row(
                                children: [
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      checkboxTheme: CheckboxThemeData(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            5.r,
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: Checkbox(
                                      value: dontShowAgain,
                                      onChanged: (value) {
                                        setState(() {
                                          dontShowAgain = value ?? false;
                                        });
                                      },
                                      activeColor: colors.shade0,
                                      side: BorderSide(
                                        color: colors.neutral600,
                                        width: 1.5,
                                      ),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    "dont_show_again".tr(),
                                    style: fonts.paragraphP3Medium,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: AnimationButtonEffect(
                                onTap: () async {
                                  if (dontShowAgain) {
                                    await dbService.setBool(
                                      key: 'i_want_intro',
                                      isSaved: true,
                                    );
                                  }
                                  Navigator.pop(context);
                                  if (widget.onInformInc != null) {
                                    AuthUtils.handleActionWithAuth(
                                      context,
                                      widget.onInformInc!,
                                      message: "inform_requires_registration"
                                          .tr(),
                                      mounted: mounted,
                                    );
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  decoration: BoxDecoration(
                                    color: colors.shade0,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "ok".tr(),
                                    style: fonts.paragraphP3Medium.copyWith(
                                      color: colors.shade0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        } else {
          if (widget.onInformInc != null) {
            AuthUtils.handleActionWithAuth(
              context,
              widget.onInformInc!,
              message: "inform_requires_registration".tr(),
              mounted: mounted,
            );
          }
        }
      },
      child: Container(
        height: 32.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: colors.shade0,
          boxShadow: colors.shadowS,
        ),
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icons.bellS.svg(
              height: 14.r,
              width: 14.r,
              color: colors.neutral600,
            ),
            SizedBox(width: 6.w),
            Text(
              "i_want".tr(),
              style: fonts.paragraphP3Regular.copyWith(color: colors.shade100),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInformCounterWidget(CustomColorSet colors, FontSet fonts) {
    final bool canIncrease = widget.informCount < 9;

    return Container(
      height: 32.h,
      width: 94.w,
      decoration: BoxDecoration(
        color: widget.isSent ? colors.shade0 : colors.shade0,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimationButtonEffect(
            onTap: () => AuthUtils.handleActionWithAuth(
              context,
              widget.onInformDec!,
              message: "inform_requires_registration".tr(),
              mounted: mounted,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              height: 24.h,
              width: 24.w,
              color: colors.transparent,
              child: Icon(Icons.remove, color: colors.neutral600, size: 18.r),
            ),
          ),
          Text(
            "${widget.informCount}",
            style: fonts.paragraphP2Regular.copyWith(color: colors.shade100),
            textAlign: TextAlign.center,
          ),
          AnimationButtonEffect(
            onTap: canIncrease
                ? () => AuthUtils.handleActionWithAuth(
                    context,
                    widget.onInformInc!,
                    message: "inform_requires_registration".tr(),
                    mounted: mounted,
                  )
                : null,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              height: 24.h,
              width: 24.w,
              color: colors.transparent,
              child: Icon(
                Icons.add,
                color: canIncrease
                    ? colors.neutral600
                    : colors.neutral600.withOpacity(.5),
                size: 18.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IncramentBasketCompSmallSecond extends StatefulWidget {
  final GestureTapCallback onIncrease;
  final GestureTapCallback onDecrease;
  final GestureTapCallback? onInformInc;
  final GestureTapCallback? onInformDec;
  final int limit;
  final int count;
  final int informCount;
  final bool disable;

  const IncramentBasketCompSmallSecond({
    super.key,
    required this.limit,
    required this.count,
    this.informCount = 0,
    required this.disable,
    required this.onIncrease,
    required this.onDecrease,
    this.onInformInc,
    this.onInformDec,
  });

  @override
  State<IncramentBasketCompSmallSecond> createState() =>
      _IncramentBasketCompSmallSecondState();
}

class _IncramentBasketCompSmallSecondState
    extends State<IncramentBasketCompSmallSecond> {
  // Optimized caching system with instance-specific keys
  static final Map<String, Widget> _globalWidgetCache = {};

  // Unique identifier for this widget instance
  late final String _instanceId;

  // Cache keys for different widget states
  String? _addToCartCacheKey;
  String? _counterCacheKey;
  // Note: We don't cache inform widgets because they have dynamic callbacks

  // Previous state values to detect changes
  int? _prevCount;
  int? _prevLimit;
  bool? _prevDisable;

  // Theme cache
  String? _themeCacheKey;

  @override
  void initState() {
    super.initState();
    // Create unique instance identifier to prevent cross-widget cache contamination
    _instanceId = '${hashCode}_${DateTime.now().microsecondsSinceEpoch}';
  }

  @override
  void dispose() {
    // Clean up cache entries for this widget instance
    _cleanupCache();
    super.dispose();
  }

  void _cleanupCache() {
    if (_addToCartCacheKey != null)
      _globalWidgetCache.remove(_addToCartCacheKey);
    if (_counterCacheKey != null) _globalWidgetCache.remove(_counterCacheKey);
  }

  String _generateCacheKey(String type, Map<String, dynamic> params) {
    // Include instance ID to prevent cross-contamination
    return '$_instanceId:$type:${params.entries.map((e) => '${e.key}=${e.value}').join(',')}';
  }

  bool _shouldRebuild() {
    return _prevCount != widget.count ||
        _prevLimit != widget.limit ||
        _prevDisable != widget.disable;
  }

  void _updatePreviousValues() {
    _prevCount = widget.count;
    _prevLimit = widget.limit;
    _prevDisable = widget.disable;
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ThemeWrapper(
        builder: (context, colors, fonts, icons, controller) {
          final currentThemeKey =
              '${colors.hashCode}:${fonts.hashCode}:${icons.hashCode}';

          // Check if theme changed and invalidate cache if needed
          if (_themeCacheKey != currentThemeKey) {
            _cleanupCache();
            _themeCacheKey = currentThemeKey;
          }

          // Product functionality
          if (widget.limit != 0) {
            return widget.count == 0
                ? _buildAddToCartButton(colors, fonts, icons)
                : _buildCounterWidget(colors, fonts);
          }
          // Inform functionality - Don't cache these as they have dynamic callbacks
          else {
            return widget.informCount == 0
                ? _buildInformButton(colors, fonts, icons)
                : _buildInformCounterWidget(colors, fonts);
          }
        },
      ),
    );
  }

  Widget _buildAddToCartButton(
    CustomColorSet colors,
    FontSet fonts,
    IconSet icons,
  ) {
    final cacheKey = _generateCacheKey('addToCart', {
      'theme': _themeCacheKey,
      'onIncrease':
          widget.onIncrease.hashCode, // Include callback hash for uniqueness
    });

    if (_addToCartCacheKey == cacheKey &&
        _globalWidgetCache.containsKey(cacheKey)) {
      return _globalWidgetCache[cacheKey]!;
    }

    _addToCartCacheKey = cacheKey;
    final widgetInstance = AnimationButtonEffect(
      onTap: () => AuthUtils.handleActionWithAuth(
        context,
        widget.onIncrease,
        mounted: mounted,
      ),
      child: Container(
        height: 32.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: colors.shade0,
          boxShadow: colors.shadowS,
        ),
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icons.basketO.svg(
              height: 14.r,
              width: 14.r,
              color: colors.primary500,
            ),
            SizedBox(width: 6.w),
            Text(
              "add_to".tr(),
              style: fonts.paragraphP3Regular.copyWith(color: colors.blue500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );

    _globalWidgetCache[cacheKey] = widgetInstance;
    return widgetInstance;
  }

  Widget _buildCounterWidget(CustomColorSet colors, FontSet fonts) {
    final bool canIncrease = widget.limit > widget.count;

    final cacheKey = _generateCacheKey('counter', {
      'count': widget.count,
      'limit': widget.limit,
      'canIncrease': canIncrease,
      'theme': _themeCacheKey,
      'onIncrease': widget.onIncrease.hashCode,
      'onDecrease': widget.onDecrease.hashCode,
    });

    if (_counterCacheKey == cacheKey &&
        _globalWidgetCache.containsKey(cacheKey) &&
        !_shouldRebuild()) {
      return _globalWidgetCache[cacheKey]!;
    }

    _counterCacheKey = cacheKey;
    _updatePreviousValues();

    final widgetInstance = Container(
      height: 32.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: colors.shade0,
        boxShadow: colors.shadowS,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: AnimationButtonEffect(
              onTap: () => AuthUtils.handleActionWithAuth(
                context,
                widget.onDecrease,
                mounted: mounted,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                color: colors.transparent,
                height: 24.h,
                width: 24.w,
                child: Icon(Icons.remove, color: colors.neutral600, size: 18.r),
              ),
            ),
          ),
          Text(
            "${widget.count}",
            style: fonts.paragraphP2Regular.copyWith(color: colors.shade100),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: AnimationButtonEffect(
              onTap: canIncrease
                  ? () => AuthUtils.handleActionWithAuth(
                      context,
                      widget.onIncrease,
                      mounted: mounted,
                    )
                  : null,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                height: 24.h,
                width: 24.w,
                color: colors.transparent,
                child: Icon(
                  Icons.add,
                  color: canIncrease
                      ? colors.neutral600
                      : colors.neutral600.withOpacity(.5),
                  size: 18.r,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    _globalWidgetCache[cacheKey] = widgetInstance;
    return widgetInstance;
  }

  Widget _buildInformButton(
    CustomColorSet colors,
    FontSet fonts,
    IconSet icons,
  ) {
    // Don't cache inform button because it has dynamic callbacks that can cause cross-contamination
    return AnimationButtonEffect(
      onTap: () => _handleInformButtonTap(),
      child: Container(
        height: 32.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: colors.shade0,
          boxShadow: colors.shadowS,
        ),
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icons.bellS.svg(height: 14.r, width: 14.r, color: Colors.amber),
            SizedBox(width: 6.w),
            Text(
              "i_want".tr(),
              style: fonts.paragraphP3Regular.copyWith(color: Colors.amber),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Optimized inform button tap handler with better error handling
  Future<void> _handleInformButtonTap() async {
    try {
      final dbService = await DBService.create;
      final isFirstTime = !(dbService.getBool(key: 'i_want_intro') ?? false);

      if (isFirstTime) {
        await _showInformDialog(dbService);
      } else {
        if (widget.onInformInc != null) {
          AuthUtils.handleActionWithAuth(
            context,
            widget.onInformInc!,
            message: "inform_requires_registration".tr(),
            mounted: mounted,
          );
        }
      }
    } catch (e) {
      // Fallback: just call the inform function if authenticated
      if (widget.onInformInc != null) {
        AuthUtils.handleActionWithAuth(
          context,
          widget.onInformInc!,
          message: "inform_requires_registration".tr(),
          mounted: mounted,
        );
      }
    }
  }

  Future<void> _showInformDialog(dynamic dbService) async {
    bool dontShowAgain = false;

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) => StatefulBuilder(
        builder: (context, setState) => ThemeWrapper(
          builder: (context, colors, fonts, icons, controller) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Container(
              height: 490.h,
              width: 340.w,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                color: colors.shade0,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: colors.shadowS,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 366.h,
                    width: 304.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12.r),
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          "app_lang".tr() == "ru"
                              ? icons.iWantBannerRu
                              : icons.iWantBannerUz,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Row(
                      children: [
                        Theme(
                          data: Theme.of(context).copyWith(
                            checkboxTheme: CheckboxThemeData(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                          ),
                          child: Checkbox(
                            value: dontShowAgain,
                            onChanged: (value) {
                              setState(() {
                                dontShowAgain = value ?? false;
                              });
                            },
                            activeColor: colors.primary500,
                            side: BorderSide(
                              color: colors.neutral600,
                              width: 1.5,
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          "dont_show_again".tr(),
                          style: fonts.paragraphP3Medium,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: CustomButton(
                      onPressed: () async {
                        try {
                          if (dontShowAgain) {
                            await dbService.setBool(
                              key: 'i_want_intro',
                              isSaved: true,
                            );
                          }
                          Navigator.pop(dialogContext);
                          if (widget.onInformInc != null) {
                            AuthUtils.handleActionWithAuth(
                              context,
                              widget.onInformInc!,
                              message: "inform_requires_registration".tr(),
                              mounted: mounted,
                            );
                          }
                        } catch (e) {
                          Navigator.pop(dialogContext);
                          if (widget.onInformInc != null) {
                            AuthUtils.handleActionWithAuth(
                              context,
                              widget.onInformInc!,
                              message: "inform_requires_registration".tr(),
                              mounted: mounted,
                            );
                          }
                        }
                      },
                      title: "ok".tr().toUpperCase(),
                      titleStyle: fonts.paragraphP1SemiBold.copyWith(
                        color: colors.shade0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInformCounterWidget(CustomColorSet colors, FontSet fonts) {
    final bool canIncrease = widget.informCount < 9;

    // Don't cache inform counter because it has dynamic callbacks that can cause cross-contamination
    return Container(
      height: 32.h,
      width: 110.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: colors.shade0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AnimationButtonEffect(
            onTap: () => AuthUtils.handleActionWithAuth(
              context,
              widget.onInformDec!,
              message: "inform_requires_registration".tr(),
              mounted: mounted,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              height: 24.h,
              width: 24.w,
              color: colors.transparent,
              child: Icon(
                Icons.remove,
                color: Colors.amber.shade700,
                size: 18.r,
              ),
            ),
          ),
          Text(
            "${widget.informCount}",
            style: fonts.paragraphP2Bold.copyWith(color: Colors.amber.shade800),
            textAlign: TextAlign.center,
          ),
          AnimationButtonEffect(
            onTap: canIncrease
                ? () => AuthUtils.handleActionWithAuth(
                    context,
                    widget.onInformInc!,
                    message: "inform_requires_registration".tr(),
                    mounted: mounted,
                  )
                : null,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              height: 24.h,
              width: 24.w,
              color: colors.transparent,
              child: Icon(
                Icons.add,
                color: canIncrease
                    ? Colors.amber.shade700
                    : Colors.amber.shade700.withOpacity(.5),
                size: 18.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
