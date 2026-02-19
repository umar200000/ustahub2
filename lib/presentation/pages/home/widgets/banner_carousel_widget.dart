import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application2/banner_bloc_and_data/bloc/banner_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/pages/banner_details_page/pages/banner_details_page.dart';
import 'package:ustahub/presentation/pages/home/widgets/home_shimmer_widgets.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class BannerCarouselWidget extends StatefulWidget {
  const BannerCarouselWidget({super.key});

  @override
  State<BannerCarouselWidget> createState() => _BannerCarouselWidgetState();
}

class _BannerCarouselWidgetState extends State<BannerCarouselWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Event is dispatched from HomePage, no need to dispatch here
  }

  void _startTimer(int count) {
    _timer?.cancel();
    if (count <= 1) return;
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageController.hasClients) {
        if (_currentPage < count - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocConsumer<BannerBloc, BannerState>(
          listener: (context, state) {
            if (state.status == Status2.success) {
              final count = state.bannerModel?.data?.length ?? 0;
              _startTimer(count);
            }
          },
          builder: (context, state) {
            final banners = state.bannerModel?.data ?? [];

            // Only show shimmer if we don't have data yet
            if (state.status == Status2.loading && banners.isEmpty) {
              return const BannerShimmer();
            }

            if (banners.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              children: [
                SizedBox(
                  height: 160.h,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemCount: banners.length,
                    itemBuilder: (context, index) {
                      final banner = banners[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: GestureDetector(
                          onTap: () {
                            if (banner.id != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BannerDetailsPage(bannerId: banner.id!),
                                ),
                              );
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                // Full image
                                Image.network(
                                  banner.imageUrl ?? '',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: colors.neutral200,
                                      child: Center(
                                        child: Icon(
                                          Icons.image_not_supported_outlined,
                                          size: 48.sp,
                                          color: colors.neutral400,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                // Gradient overlay for text readability
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 80.h,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withValues(alpha: 0.7),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Title and subtitle at bottom
                                Positioned(
                                  bottom: 12.h,
                                  left: 16.w,
                                  right: 16.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (banner.title != null &&
                                          banner.title!.isNotEmpty)
                                        Text(
                                          banner.title!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      if (banner.subtitle != null &&
                                          banner.subtitle!.isNotEmpty)
                                        Text(
                                          banner.subtitle!,
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12.sp,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 12.h),
                // Page indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    banners.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _currentPage == index ? 24.w : 8.w,
                      height: 8.w,
                      margin: EdgeInsets.symmetric(horizontal: 3.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: _currentPage == index
                            ? colors.blue500
                            : Colors
                                  .grey
                                  .shade400, // O'zgartirildi: neutral300 -> neutral400
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
