import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class ReviewItem {
  final String userName;
  final String? avatarUrl;
  final double rating;
  final String date;
  final String text;
  final int helpful;

  const ReviewItem({
    required this.userName,
    this.avatarUrl,
    required this.rating,
    required this.date,
    required this.text,
    this.helpful = 0,
  });
}

class ReviewsPage extends StatelessWidget {
  final String? serviceTitle;

  const ReviewsPage({super.key, this.serviceTitle});

  static final List<ReviewItem> _mockReviews = [
    const ReviewItem(
      userName: 'Azizbek Toshmatov',
      rating: 5.0,
      date: '2 kun oldin',
      text:
          'Juda professional ishchi. Vaqtida keldi, ishini sifatli bajardi. Narxi ham arzon. Tavsiya qilaman!',
      helpful: 12,
    ),
    const ReviewItem(
      userName: 'Madina Karimova',
      rating: 5.0,
      date: '1 hafta oldin',
      text:
          'Konditsioner o\'rnatishda juda yaxshi ishladi. Tozaligini ham saqladi, uyni iflos qilmadi. Rahmat!',
      helpful: 8,
    ),
    const ReviewItem(
      userName: 'Javohir Nazarov',
      rating: 4.0,
      date: '2 hafta oldin',
      text:
          'Umumiy olganda yaxshi ishladi. Biroz kechikib keldi, lekin ishini sifatli bajardi. Yana murojaat qilaman.',
      helpful: 5,
    ),
    const ReviewItem(
      userName: 'Shohruh Rahimov',
      rating: 5.0,
      date: '3 hafta oldin',
      text:
          'Tavsiya qilaman! Tajribali usta. Ishni tushuntirib, narxini ham tog\'ri aytib ishladi.',
      helpful: 17,
    ),
    const ReviewItem(
      userName: 'Dilfuza Xolmatova',
      rating: 4.0,
      date: '1 oy oldin',
      text:
          'Yaxshi ish, faqat biroz sekin ishladi. Lekin natijadan mamnunman.',
      helpful: 3,
    ),
    const ReviewItem(
      userName: 'Bobur Yusupov',
      rating: 5.0,
      date: '1 oy oldin',
      text:
          'Eng zo\'r usta! Qo\'shnilarimga ham tavsiya qildim. Har doim xizmat ko\'rsatadi.',
      helpful: 21,
    ),
    const ReviewItem(
      userName: 'Nilufar Saidova',
      rating: 3.0,
      date: '2 oy oldin',
      text:
          'O\'rtacha ishladi. Vaqtni tejamadim lekin ish sifatli bajarildi.',
      helpful: 2,
    ),
  ];

  double get _averageRating => 5.0;

  Map<int, int> get _distribution {
    final map = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (final r in _mockReviews) {
      final stars = r.rating.round().clamp(1, 5);
      map[stars] = (map[stars] ?? 0) + 1;
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.bgSurface,
          body: Column(
            children: [
              UniversalAppBar(
                title: 'reviews_title'.tr(),
                showBackButton: true,
                centerTitle: true,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(bottom: 32.h),
                  children: [
                    SizedBox(height: 16.h),
                    _buildSummaryCard(colors, fonts),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 12.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'all_reviews'.tr(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: colors.neutral800,
                              letterSpacing: -0.2,
                            ),
                          ),
                          Text(
                            '${_mockReviews.length}',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: colors.neutral500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ..._mockReviews.map(
                      (review) => _ReviewCard(
                        review: review,
                        colors: colors,
                        fonts: fonts,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryCard(CustomColorSet colors, FontSet fonts) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: colors.shade0,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _averageRating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 44.sp,
                  fontWeight: FontWeight.w800,
                  color: colors.neutral800,
                  height: 1,
                  letterSpacing: -1.5,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (i) {
                  final filled = i < _averageRating.round();
                  return Icon(
                    filled ? Icons.star_rounded : Icons.star_outline_rounded,
                    size: 15.sp,
                    color: colors.yellow500,
                  );
                }),
              ),
              SizedBox(height: 6.h),
              Text(
                '${_mockReviews.length} ${"reviews_count".tr()}',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: colors.neutral500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(width: 20.w),
          Container(
            width: 1,
            height: 96.h,
            color: colors.neutral100,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [5, 4, 3, 2, 1].map((stars) {
                final count = _distribution[stars] ?? 0;
                final total = _mockReviews.length;
                final ratio = total == 0 ? 0.0 : count / total;
                return Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
                  child: Row(
                    children: [
                      Text(
                        '$stars',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: colors.neutral700,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.star_rounded,
                        size: 11.sp,
                        color: colors.yellow500,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: LinearProgressIndicator(
                            value: ratio,
                            minHeight: 6.h,
                            backgroundColor: colors.neutral100,
                            valueColor: AlwaysStoppedAnimation(
                              colors.yellow500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      SizedBox(
                        width: 22.w,
                        child: Text(
                          '$count',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: colors.neutral500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final ReviewItem review;
  final CustomColorSet colors;
  final FontSet fonts;

  const _ReviewCard({
    required this.review,
    required this.colors,
    required this.fonts,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.shade0,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: colors.blue500.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  review.userName.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: colors.blue500,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: colors.neutral800,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      review.date,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: colors.neutral500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: colors.yellow500.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 13.sp,
                      color: colors.yellow500,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      review.rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: colors.neutral800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            review.text,
            style: TextStyle(
              fontSize: 13.sp,
              color: colors.neutral700,
              height: 1.5,
            ),
          ),
          if (review.helpful > 0) ...[
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(
                  Icons.thumb_up_alt_outlined,
                  size: 13.sp,
                  color: colors.neutral500,
                ),
                SizedBox(width: 5.w),
                Text(
                  '${review.helpful} ${"helpful".tr()}',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: colors.neutral500,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
