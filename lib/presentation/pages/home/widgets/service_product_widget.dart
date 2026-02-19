import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/components/universal_image.dart';
import 'package:ustahub/presentation/styles/style.dart';
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
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AnimationButtonEffect(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: colors.shade0,
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: colors.neutral200),
              boxShadow: Style.shadowMMMM,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.r),
                  ),
                  child: SizedBox(
                    height: 200.h,
                    width: double.infinity,
                    child: (mainImageUrl != null && mainImageUrl!.isNotEmpty)
                        ? UniversalImage(
                            image: mainImageUrl!,
                            fit: BoxFit.cover,
                          )
                        : _placeholderBig(colors),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(name, style: fonts.headingH5SemiBold),
                          ),
                          GestureDetector(
                            onTap: onFavorite,
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite
                                  ? colors.red500
                                  : colors.neutral400,
                            ),
                          ),
                        ],
                      ),
                      4.h.verticalSpace,
                      Row(
                        children: [
                          Text(
                            profession,
                            style: fonts.paragraphP2Regular.copyWith(
                              color: colors.neutral500,
                              fontFamily: GoogleFonts.balsamiqSans().fontFamily,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.star,
                            size: 14.sp,
                            color: colors.yellow500,
                          ),
                          4.w.horizontalSpace,
                          Text(
                            rating.toStringAsFixed(1),
                            style: fonts.paragraphP2SemiBold,
                          ),
                          4.w.horizontalSpace,
                          Text(
                            '($reviewCount)',
                            style: fonts.paragraphP3Regular.copyWith(
                              color: colors.neutral400,
                            ),
                          ),
                        ],
                      ),
                      12.h.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'From ${priceFrom.formatNumber()} UZS',
                            style: fonts.paragraphP1SemiBold,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: isAvailable
                                  ? colors.blue500
                                  : colors.neutral300,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              isAvailable ? 'Available' : 'Busy',
                              style: fonts.paragraphP2Medium.copyWith(
                                color: colors.shade0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _placeholderBig(dynamic colors) => Container(
    color: colors.neutral200,
    child: Icon(Icons.construction, size: 60.sp, color: colors.neutral400),
  );
}
