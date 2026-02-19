import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ustahub/application2/category_list_bloc_and_data/bloc/category_list_bloc.dart';
import 'package:ustahub/application2/details_service/bloc/details_bloc.dart';
import 'package:ustahub/application2/register_bloc_and_data/bloc/register_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/pages/auth/auth_options.dart';
import 'package:ustahub/presentation/pages/booking_page/pages/booking_page.dart';
import 'package:ustahub/presentation/pages/home/widgets/details_shimmer_widget.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import '../company_details_page/pages/company_details_page.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.serviceId});
  final String serviceId;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageController _imagePageController = PageController();
  int _currentImageIndex = 0;
  bool _isDescriptionExpanded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    context.read<DetailsBloc>().add(
      GetServiceDetailsEvent(serviceId: widget.serviceId),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _imagePageController.dispose();
    super.dispose();
  }

  void _openFullScreenImage(List<dynamic> images, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImageViewer(
          images: images.map((e) => e.imageUrl as String?).toList(),
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.shade0,
          body: BlocBuilder<DetailsBloc, DetailsState>(
            builder: (context, state) {
              if (state.status == Status2.loading) {
                return const DetailsShimmer();
              }

              if (state.status == Status2.error) {
                return Center(
                  child: Text(
                    state.errorMessage ?? "something_went_wrong".tr(),
                    style: TextStyle(color: colors.red500),
                  ),
                );
              }

              if (state.status == Status2.success &&
                  state.detailsServiceModel?.data != null) {
                final data = state.detailsServiceModel!.data!;

                // Category bo'yicha boshqa xizmatlarni yuklash
                if (data.category?.id != null) {
                  context.read<CategoryListBloc>().add(
                    GetCategoryList(categoryId: data.category!.id!),
                  );
                }

                return Column(
                  children: [
                    // App Bar
                    _buildAppBar(colors, fonts),

                    // Scrollable Content
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Service Image Carousel
                            _buildImageCarousel(data, colors),

                            Gap(12.h),

                            // Provider Badge
                            _buildProviderBadge(data, colors, fonts),

                            Gap(8.h),

                            // Service Title
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Text(
                                data.titleUz ?? "",
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: colors.neutral800,
                                ),
                              ),
                            ),

                            Gap(12.h),

                            // Info Row (distance, rating, reviews, icons)
                            _buildInfoRow(data, colors, fonts),

                            Gap(16.h),

                            // Price
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Text(
                                "${data.basePrice ?? '0'} ${data.currencySymbol ?? 'So\'m'}",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: colors.blue500,
                                ),
                              ),
                            ),

                            Gap(20.h),

                            // Tab Bar
                            _buildTabBar(colors, fonts),

                            // Tab Content
                            _buildTabContent(data, colors, fonts),

                            Gap(100.h),
                          ],
                        ),
                      ),
                    ),

                    // Bottom Book Button
                    _buildBottomButton(data, colors, fonts),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        );
      },
    );
  }

  Widget _buildAppBar(CustomColorSet colors, FontSet fonts) {
    return UniversalAppBar(
      title: "details".tr(),
      centerTitle: true,
      showBackButton: true,
      backgroundColor: colors.primary500,
    );
  }

  Widget _buildImageCarousel(dynamic data, CustomColorSet colors) {
    final images = data.images ?? [];

    if (images.isEmpty) {
      return Container(
        height: 220.h,
        margin: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: colors.neutral200,
        ),
        child: Center(
          child: Icon(
            Icons.image_not_supported,
            size: 48.sp,
            color: colors.neutral400,
          ),
        ),
      );
    }

    return Column(
      children: [
        // Image PageView
        Container(
          height: 220.h,
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Stack(
              children: [
                PageView.builder(
                  controller: _imagePageController,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentImageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _openFullScreenImage(images, index),
                      child: Image.network(
                        images[index].imageUrl ?? "",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: colors.neutral200,
                            child: Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 48.sp,
                                color: colors.neutral400,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                // Image counter badge
                if (images.length > 1)
                  Positioned(
                    top: 12.h,
                    right: 12.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        "${_currentImageIndex + 1}/${images.length}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        // Page Indicators
        if (images.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              images.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _currentImageIndex == index ? 20.w : 8.w,
                height: 8.w,
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: _currentImageIndex == index
                      ? colors.blue500
                      : Colors.grey.shade400,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProviderBadge(
    dynamic data,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16.r,
            backgroundColor: colors.blue500,
            backgroundImage: data.provider?.logoUrl != null
                ? NetworkImage(data.provider!.logoUrl!)
                : null,
            child: data.provider?.logoUrl == null
                ? Text(
                    (data.provider?.name ?? "U").substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      color: colors.shade0,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  )
                : null,
          ),
          Gap(8.w),
          Text(
            data.provider?.name ?? "unknown_provider".tr(),
            style: fonts.paragraphP3Bold.copyWith(color: colors.neutral700),
          ),
          Gap(4.w),
          Icon(Icons.verified, size: 16.sp, color: colors.blue500),
        ],
      ),
    );
  }

  Widget _buildInfoRow(dynamic data, CustomColorSet colors, FontSet fonts) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          // Distance
          Icon(
            Icons.location_on_outlined,
            size: 16.sp,
            color: colors.neutral500,
          ),
          Gap(4.w),
          Text(
            "1.2 km",
            style: fonts.paragraphP3Regular.copyWith(color: colors.neutral500),
          ),
          Gap(16.w),

          // Rating
          Icon(Icons.star, size: 16.sp, color: colors.yellow500),
          Gap(4.w),
          Text(
            data.averageRating?.toString() ?? "5.0",
            style: fonts.paragraphP3Bold.copyWith(color: colors.neutral700),
          ),
          Gap(16.w),

          // Reviews
          Icon(
            Icons.chat_bubble_outline,
            size: 14.sp,
            color: colors.neutral500,
          ),
          Gap(4.w),
          Text(
            "${data.totalReviews ?? 0} ${"reviews".tr()}",
            style: fonts.paragraphP3Regular.copyWith(color: colors.neutral500),
          ),

          const Spacer(),

          // Share & Bookmark
          GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                Icon(
                  Icons.share_outlined,
                  size: 20.sp,
                  color: colors.neutral600,
                ),
                Text(
                  "share".tr(),
                  style: fonts.paragraphP3Regular.copyWith(fontSize: 10.sp),
                ),
              ],
            ),
          ),
          Gap(16.w),
          GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                Icon(
                  Icons.bookmark_border,
                  size: 20.sp,
                  color: colors.neutral600,
                ),
                Text(
                  "bookmark".tr(),
                  style: fonts.paragraphP3Regular.copyWith(fontSize: 10.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(CustomColorSet colors, FontSet fonts) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: colors.neutral100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: colors.blue500,
          borderRadius: BorderRadius.circular(10.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: colors.shade0,
        unselectedLabelColor: colors.neutral600,
        labelStyle: fonts.paragraphP3Bold,
        unselectedLabelStyle: fonts.paragraphP3Regular,
        padding: EdgeInsets.all(4.w),
        tabs: [
          Tab(text: "about".tr()),
          Tab(text: "gallery".tr()),
          Tab(text: "review".tr()),
          Tab(text: "services".tr()),
        ],
      ),
    );
  }

  Widget _buildTabContent(dynamic data, CustomColorSet colors, FontSet fonts) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: AnimatedBuilder(
        animation: _tabController,
        builder: (context, child) {
          switch (_tabController.index) {
            case 0:
              return _buildAboutTab(data, colors, fonts);
            case 1:
              return _buildGalleryTab(data, colors);
            case 2:
              return _buildReviewTab(data, colors, fonts);
            case 3:
              return _buildServicesTab(data, colors, fonts);
            default:
              return _buildAboutTab(data, colors, fonts);
          }
        },
      ),
    );
  }

  Widget _buildAboutTab(dynamic data, CustomColorSet colors, FontSet fonts) {
    final description = data.descriptionUz ?? "";
    final shouldTruncate = description.length > 150;
    final displayText = shouldTruncate && !_isDescriptionExpanded
        ? "${description.substring(0, 150)}..."
        : description;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description
        Text(
          displayText,
          style: fonts.paragraphP2Regular.copyWith(
            color: colors.neutral600,
            height: 1.6,
          ),
        ),
        if (shouldTruncate)
          GestureDetector(
            onTap: () {
              setState(() {
                _isDescriptionExpanded = !_isDescriptionExpanded;
              });
            },
            child: Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                _isDescriptionExpanded ? "show_less".tr() : "read_more".tr(),
                style: fonts.paragraphP3Bold.copyWith(color: colors.blue500),
              ),
            ),
          ),

        Gap(24.h),

        // Provider Card
        GestureDetector(
          onTap: () {
            if (data.providerId != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CompanyDetailsPage(providerId: data.providerId!),
                ),
              );
            }
          },
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: colors.neutral50,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: colors.neutral200),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28.r,
                  backgroundColor: colors.blue500,
                  backgroundImage: data.provider?.logoUrl != null
                      ? NetworkImage(data.provider!.logoUrl!)
                      : null,
                  child: data.provider?.logoUrl == null
                      ? Text(
                          (data.provider?.name ?? "U")
                              .substring(0, 1)
                              .toUpperCase(),
                          style: TextStyle(
                            color: colors.shade0,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        )
                      : null,
                ),
                Gap(12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.provider?.name ?? "----",
                        style: fonts.paragraphP2Bold.copyWith(
                          color: colors.neutral800,
                        ),
                      ),
                      Gap(4.h),
                      Text(
                        data.category?.nameUz ?? "Service Provider",
                        style: fonts.paragraphP3Regular.copyWith(
                          color: colors.neutral500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Chat Button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: colors.blue500.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.chat_bubble_outline,
                      size: 20.sp,
                      color: colors.blue500,
                    ),
                  ),
                ),
                Gap(8.w),
                // Call Button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: colors.blue500,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(Icons.phone, size: 20.sp, color: colors.shade0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGalleryTab(dynamic data, CustomColorSet colors) {
    final images = data.images ?? [];
    if (images.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(40.w),
          child: Text(
            "No images available",
            style: TextStyle(color: colors.neutral500, fontSize: 14.sp),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.w,
        childAspectRatio: 1,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _openFullScreenImage(images, index),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              images[index].imageUrl ?? "",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: colors.neutral200,
                  child: Icon(
                    Icons.image_not_supported,
                    color: colors.neutral400,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildReviewTab(dynamic data, CustomColorSet colors, FontSet fonts) {
    final totalReviews = data.totalReviews ?? 0;
    if (totalReviews == 0) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(40.w),
          child: Column(
            children: [
              Icon(
                Icons.rate_review_outlined,
                size: 48.sp,
                color: colors.neutral400,
              ),
              Gap(12.h),
              Text(
                "No reviews yet",
                style: TextStyle(color: colors.neutral500, fontSize: 14.sp),
              ),
            ],
          ),
        ),
      );
    }

    // Placeholder for reviews
    return Column(
      children: [
        // Rating Summary
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: colors.neutral50,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    data.averageRating?.toString() ?? "5.0",
                    style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.bold,
                      color: colors.neutral800,
                    ),
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        size: 16.sp,
                        color: colors.yellow500,
                      ),
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    "$totalReviews reviews",
                    style: fonts.paragraphP3Regular.copyWith(
                      color: colors.neutral500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServicesTab(dynamic data, CustomColorSet colors, FontSet fonts) {
    return BlocBuilder<CategoryListBloc, CategoryListState>(
      builder: (context, catState) {
        if (catState.status == Status2.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        final filteredItems = catState.items
            .where((item) => item.id != data.id)
            .toList();

        if (filteredItems.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(40.w),
              child: Text(
                "No similar services",
                style: TextStyle(color: colors.neutral500, fontSize: 14.sp),
              ),
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredItems.length,
          separatorBuilder: (context, index) => Gap(12.h),
          itemBuilder: (context, index) {
            final item = filteredItems[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(serviceId: item.id!),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: colors.shade0,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: colors.neutral200),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                        item.primaryImageUrl ?? "",
                        width: 70.w,
                        height: 70.w,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 70.w,
                            height: 70.w,
                            color: colors.neutral200,
                            child: Icon(
                              Icons.image_not_supported,
                              color: colors.neutral400,
                            ),
                          );
                        },
                      ),
                    ),
                    Gap(12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.titleUz ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: fonts.paragraphP3Bold.copyWith(
                              color: colors.neutral800,
                            ),
                          ),
                          Gap(4.h),
                          Text(
                            "${item.basePrice} ${item.currencySymbol ?? "So'm"}",
                            style: fonts.paragraphP3Bold.copyWith(
                              color: colors.blue500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16.sp,
                      color: colors.neutral400,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBottomButton(
    dynamic data,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 16.h,
        bottom: MediaQuery.of(context).padding.bottom + 16.h,
      ),
      decoration: BoxDecoration(
        color: colors.shade0,
        boxShadow: [
          BoxShadow(
            color: colors.neutral800.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            final registerState = context.read<RegisterBloc>().state;

            if (registerState.userProfile != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingPage(service: data),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const AuthOptions(showGuestOption: false),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.blue500,
            foregroundColor: colors.shade0,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            elevation: 0,
          ),
          child: Text(
            "book_now".tr(),
            style: fonts.paragraphP2Bold.copyWith(color: colors.shade0),
          ),
        ),
      ),
    );
  }
}

// Full Screen Image Viewer with Zoom
class FullScreenImageViewer extends StatefulWidget {
  final List<String?> images;
  final int initialIndex;

  const FullScreenImageViewer({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Zoomable PageView
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return InteractiveViewer(
                minScale: 1.0,
                maxScale: 4.0,
                child: Center(
                  child: Image.network(
                    widget.images[index] ?? "",
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.white54,
                          size: 64,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),

          // Close Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 24),
              ),
            ),
          ),

          // Image Counter
          if (widget.images.length > 1)
            Positioned(
              top: MediaQuery.of(context).padding.top + 20,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "${_currentIndex + 1} / ${widget.images.length}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

          // Bottom Indicators
          if (widget.images.length > 1)
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 32,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.images.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _currentIndex == index ? 24 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _currentIndex == index
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
