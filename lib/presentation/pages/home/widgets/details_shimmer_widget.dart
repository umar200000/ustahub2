import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DetailsShimmer extends StatelessWidget {
  const DetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // App Bar shimmer
          _buildAppBarShimmer(context),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image shimmer
                  _buildImageShimmer(),

                  // Provider badge shimmer
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        _buildCircleShimmer(32.w),
                        SizedBox(width: 8.w),
                        _buildShimmerBox(width: 100.w, height: 14.h),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Title shimmer
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: _buildShimmerBox(width: 220.w, height: 24.h),
                  ),
                  SizedBox(height: 12.h),

                  // Info row shimmer
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        _buildShimmerBox(width: 60.w, height: 16.h),
                        SizedBox(width: 16.w),
                        _buildShimmerBox(width: 50.w, height: 16.h),
                        SizedBox(width: 16.w),
                        _buildShimmerBox(width: 80.w, height: 16.h),
                        const Spacer(),
                        _buildShimmerBox(width: 20.w, height: 20.h),
                        SizedBox(width: 16.w),
                        _buildShimmerBox(width: 20.w, height: 20.h),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Price shimmer
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: _buildShimmerBox(width: 120.w, height: 24.h),
                  ),
                  SizedBox(height: 20.h),

                  // Tab bar shimmer
                  _buildTabBarShimmer(),
                  SizedBox(height: 20.h),

                  // Content shimmer
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildShimmerBox(width: double.infinity, height: 14.h),
                        SizedBox(height: 8.h),
                        _buildShimmerBox(width: double.infinity, height: 14.h),
                        SizedBox(height: 8.h),
                        _buildShimmerBox(width: 280.w, height: 14.h),
                        SizedBox(height: 8.h),
                        _buildShimmerBox(width: 200.w, height: 14.h),
                        SizedBox(height: 24.h),

                        // Provider card shimmer
                        _buildProviderShimmer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom button shimmer
          _buildBottomButtonShimmer(context),
        ],
      ),
    );
  }

  Widget _buildAppBarShimmer(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8.h,
        left: 16.w,
        right: 16.w,
        bottom: 12.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          _buildShimmerBox(width: 36.w, height: 36.h, radius: 10.r),
          const Spacer(),
          _buildShimmerBox(width: 60.w, height: 18.h),
          const Spacer(),
          _buildShimmerBox(width: 36.w, height: 36.h, radius: 10.r),
        ],
      ),
    );
  }

  Widget _buildImageShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 220.h,
        margin: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    );
  }

  Widget _buildTabBarShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 45.h,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  Widget _buildShimmerBox({
    required double width,
    required double height,
    double? radius,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius ?? 4.r),
        ),
      ),
    );
  }

  Widget _buildCircleShimmer(double size) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildProviderShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120.w,
                    height: 16.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: 80.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtonShimmer(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 16.h,
        bottom: MediaQuery.of(context).padding.bottom + 16.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 52.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
      ),
    );
  }
}
