import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/components/universal_image.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';
import 'package:ustahub/utils/extensions.dart';

class ServiceProviderCard extends StatelessWidget {
  final String name;
  final String profession;
  final double distance;
  final double rating;
  final int reviewCount;
  final String duration;
  final int priceFrom;
  final bool isVerified;
  final bool isAvailable;
  final String? mainImageUrl;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final bool isFavorite;
  final String? provinceName;

  const ServiceProviderCard({
    super.key,
    required this.name,
    required this.profession,
    required this.distance,
    required this.rating,
    required this.reviewCount,
    required this.duration,
    required this.priceFrom,
    this.isVerified = false,
    this.isAvailable = true,
    this.mainImageUrl,
    this.onTap,
    this.onFavorite,
    this.isFavorite = false,
    this.provinceName,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        final radius = BorderRadius.circular(22.r);
        return AnimationButtonEffect(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: colors.shade0,
              borderRadius: radius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: radius,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageSection(colors, fonts),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 14.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitleRow(colors, fonts),
                        SizedBox(height: 8.h),
                        _buildCategoryPill(colors),
                        SizedBox(height: 14.h),
                        Container(
                          height: 1,
                          color: colors.neutral100,
                        ),
                        SizedBox(height: 14.h),
                        _buildFooterRow(colors, fonts),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSection(dynamic colors, dynamic fonts) {
    return SizedBox(
      height: 200.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          (mainImageUrl != null && mainImageUrl!.isNotEmpty)
              ? UniversalImage(image: mainImageUrl!, fit: BoxFit.cover)
              : Container(
                  color: colors.neutral200,
                  child: Icon(
                    Icons.construction,
                    size: 60.sp,
                    color: colors.neutral400,
                  ),
                ),
          IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.45),
                  ],
                  stops: const [0.55, 1.0],
                ),
              ),
            ),
          ),
          if (provinceName != null && provinceName!.isNotEmpty)
            Positioned(
              top: 12.h,
              left: 12.w,
              child: _glassChip(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 14,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      provinceName!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            top: 10.h,
            right: 10.w,
            child: GestureDetector(
              onTap: onFavorite,
              behavior: HitTestBehavior.opaque,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.28),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.45),
                        width: 0.8,
                      ),
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 18.sp,
                      color: isFavorite ? colors.red500 : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleRow(dynamic colors, dynamic fonts) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              Flexible(
                child: Text(
                  name,
                  style: fonts.headingH5SemiBold.copyWith(fontSize: 16.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isVerified) ...[
                SizedBox(width: 4.w),
                Icon(
                  Icons.verified_rounded,
                  size: 16.sp,
                  color: colors.blue500,
                ),
              ],
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: colors.yellow500.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star_rounded, size: 14.sp, color: colors.yellow500),
              SizedBox(width: 3.w),
              Text(
                rating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: colors.neutral800,
                ),
              ),
              if (reviewCount > 0) ...[
                SizedBox(width: 3.w),
                Text(
                  '($reviewCount)',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: colors.neutral500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryPill(dynamic colors) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: colors.blue500.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.work_outline_rounded,
            size: 13.sp,
            color: colors.blue500,
          ),
          SizedBox(width: 5.w),
          Flexible(
            child: Text(
              profession,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: colors.blue500,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterRow(dynamic colors, dynamic fonts) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'from'.tr().toUpperCase(),
                style: TextStyle(
                  fontSize: 10.sp,
                  color: colors.neutral400,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: 3.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    priceFrom.formatNumber(),
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: colors.blue500,
                      height: 1.1,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'uzs'.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: colors.neutral500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: colors.blue500,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: colors.blue500.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'book_now'.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 6.w),
              Icon(
                Icons.arrow_forward_rounded,
                size: 16.sp,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _glassChip({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.32),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.25),
              width: 0.6,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
