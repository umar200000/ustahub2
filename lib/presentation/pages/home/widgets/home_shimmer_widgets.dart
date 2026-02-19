import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerColors {
  static Color baseColor = Colors.grey[300]!;
  static Color highlightColor = Colors.grey[100]!;
}

/// Shimmer for banner carousel
class BannerShimmer extends StatelessWidget {
  const BannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Shimmer.fromColors(
        baseColor: ShimmerColors.baseColor,
        highlightColor: ShimmerColors.highlightColor,
        child: Container(
          height: 160.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ),
    );
  }
}

/// Shimmer for category section
class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header shimmer
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 12.h),
          child: Shimmer.fromColors(
            baseColor: ShimmerColors.baseColor,
            highlightColor: ShimmerColors.highlightColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 140.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                Container(
                  width: 50.w,
                  height: 16.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Category items shimmer
        SizedBox(
          height: 110.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: ShimmerColors.baseColor,
                highlightColor: ShimmerColors.highlightColor,
                child: Container(
                  width: 75.w,
                  margin: EdgeInsets.only(right: 16.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 65.w,
                        height: 65.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: 60.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Shimmer for service card
class ServiceCardShimmer extends StatelessWidget {
  const ServiceCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ShimmerColors.baseColor,
      highlightColor: ShimmerColors.highlightColor,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            // Image placeholder
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            SizedBox(width: 12.w),
            // Content placeholders
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 16.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: 120.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    width: 80.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: 100.w,
                    height: 18.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shimmer for services list
class ServicesListShimmer extends StatelessWidget {
  final int itemCount;

  const ServicesListShimmer({super.key, this.itemCount = 3});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) => const ServiceCardShimmer(),
    );
  }
}
