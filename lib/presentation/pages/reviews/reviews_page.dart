import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ustahub/application2/review_bloc_and_data/bloc/review_bloc.dart';
import 'package:ustahub/application2/review_bloc_and_data/data/model/review_model.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import '../../../infrastructure2/init/injection.dart';

class ReviewsPage extends StatefulWidget {
  final String serviceId;
  final String? serviceTitle;
  final double? averageRating;
  final int? totalReviews;

  const ReviewsPage({
    super.key,
    required this.serviceId,
    this.serviceTitle,
    this.averageRating,
    this.totalReviews,
  });

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    sl<ReviewBloc>().add(
      GetServiceReviewsEvent(serviceId: widget.serviceId),
    );
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final bloc = sl<ReviewBloc>();
      if (bloc.state.status != Status2.loading && !bloc.state.isLastPage) {
        bloc.add(GetServiceReviewsEvent(
          serviceId: widget.serviceId,
          isFetchMore: true,
        ));
      }
    }
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
                child: BlocBuilder<ReviewBloc, ReviewState>(
                  bloc: sl<ReviewBloc>(),
                  builder: (context, state) {
                    if (state.status == Status2.loading &&
                        state.reviews.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state.status == Status2.error &&
                        state.reviews.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 48.sp,
                                color: colors.neutral400,
                              ),
                              Gap(12.h),
                              Text(
                                state.errorMessage ?? "error_occurred".tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: colors.neutral500,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Gap(16.h),
                              ElevatedButton(
                                onPressed: () {
                                  sl<ReviewBloc>().add(
                                    GetServiceReviewsEvent(
                                      serviceId: widget.serviceId,
                                    ),
                                  );
                                },
                                child: Text("retry".tr()),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (state.reviews.isEmpty &&
                        state.status == Status2.success) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.all(40.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.rate_review_outlined,
                                size: 48.sp,
                                color: colors.neutral400,
                              ),
                              Gap(12.h),
                              Text(
                                "no_reviews_yet".tr(),
                                style: TextStyle(
                                  color: colors.neutral500,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.only(bottom: 32.h),
                      itemCount: state.reviews.length +
                          1 + // summary card
                          1 + // header
                          (state.isLastPage ? 0 : 1), // loading indicator
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: EdgeInsets.only(top: 16.h),
                            child: _buildSummaryCard(
                              colors,
                              fonts,
                              state,
                            ),
                          );
                        }

                        if (index == 1) {
                          return Padding(
                            padding:
                                EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 12.h),
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
                                  '${state.total}',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: colors.neutral500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        final reviewIndex = index - 2;

                        if (reviewIndex >= state.reviews.length) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        final review = state.reviews[reviewIndex];
                        return _ReviewCard(
                          review: review,
                          colors: colors,
                          fonts: fonts,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryCard(
    CustomColorSet colors,
    FontSet fonts,
    ReviewState state,
  ) {
    final avgRating = widget.averageRating ?? 0.0;
    final totalReviews = state.total;

    final distribution = <int, int>{5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (final r in state.reviews) {
      final stars = (r.rating ?? 0).clamp(1, 5);
      distribution[stars] = (distribution[stars] ?? 0) + 1;
    }

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
                avgRating.toStringAsFixed(1),
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
                  final filled = i < avgRating.round();
                  return Icon(
                    filled ? Icons.star_rounded : Icons.star_outline_rounded,
                    size: 15.sp,
                    color: colors.yellow500,
                  );
                }),
              ),
              SizedBox(height: 6.h),
              Text(
                '$totalReviews ${"reviews_count".tr()}',
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
                final count = distribution[stars] ?? 0;
                final total = state.reviews.length;
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
  final ReviewData review;
  final CustomColorSet colors;
  final FontSet fonts;

  const _ReviewCard({
    required this.review,
    required this.colors,
    required this.fonts,
  });

  String _getDisplayName() {
    if (review.userName != null && review.userName!.isNotEmpty) {
      return review.userName!;
    }
    final first = review.user?.firstName ?? '';
    final last = review.user?.lastName ?? '';
    final fullName = '$first $last'.trim();
    return fullName.isNotEmpty ? fullName : 'user'.tr();
  }

  String? _getAvatarUrl() {
    return review.userAvatar ?? review.user?.avatarUrl;
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final diff = now.difference(date);

      if (diff.inDays == 0) return 'today'.tr();
      if (diff.inDays == 1) return 'yesterday'.tr();
      if (diff.inDays < 7) return '${diff.inDays} ${"days_ago".tr()}';
      if (diff.inDays < 30) {
        final weeks = (diff.inDays / 7).floor();
        return '$weeks ${"weeks_ago".tr()}';
      }
      if (diff.inDays < 365) {
        final months = (diff.inDays / 30).floor();
        return '$months ${"months_ago".tr()}';
      }
      return '${date.day}.${date.month.toString().padLeft(2, '0')}.${date.year}';
    } catch (_) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = _getDisplayName();
    final avatarUrl = _getAvatarUrl();
    final rating = review.rating ?? 0;

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
              if (avatarUrl != null && avatarUrl.isNotEmpty)
                CircleAvatar(
                  radius: 22.w,
                  backgroundImage: NetworkImage(avatarUrl),
                  backgroundColor: colors.blue500.withValues(alpha: 0.12),
                )
              else
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: colors.blue500.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    name.isNotEmpty ? name.substring(0, 1).toUpperCase() : '?',
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
                      name,
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
                      _formatDate(review.createdAt),
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: colors.neutral500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
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
                      rating.toStringAsFixed(1),
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
          if (review.comment != null && review.comment!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Text(
              review.comment!,
              style: TextStyle(
                fontSize: 13.sp,
                color: colors.neutral700,
                height: 1.5,
              ),
            ),
          ],
          if (review.providerResponse != null &&
              review.providerResponse!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: colors.neutral50,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: colors.neutral200),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.reply_rounded,
                    size: 16.sp,
                    color: colors.neutral500,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "provider_response".tr(),
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color: colors.neutral600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          review.providerResponse!,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: colors.neutral600,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
