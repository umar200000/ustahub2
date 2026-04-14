import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ustahub/application2/category_list_bloc_and_data/bloc/category_list_bloc.dart';
import 'package:ustahub/application2/details_service/bloc/details_bloc.dart';
import 'package:ustahub/application2/register_bloc_and_data/bloc/register_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/components/shimmer_widgets.dart';
import 'package:ustahub/presentation/pages/auth/auth_options.dart';
import 'package:ustahub/presentation/pages/booking_page/pages/booking_page.dart';
import 'package:ustahub/presentation/pages/home/widgets/details_shimmer_widget.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import '../../../application2/details_service/data/model/details_model.dart';
import '../company_details_page/pages/company_details_page.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.serviceId, this.providerName});
  final String serviceId;
  final String? providerName;
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

                final title = data.title;

                return Column(
                  children: [
                    Expanded(
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          _buildSliverAppBar(data, colors, fonts),
                          SliverToBoxAdapter(
                            child: Transform.translate(
                              offset: Offset(0, -24.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colors.shade0,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(28.r),
                                  ),
                                ),
                                padding: EdgeInsets.only(top: 44.h),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    _buildTitleSection(
                                      data,
                                      title,
                                      colors,
                                      fonts,
                                    ),
                                    Gap(16.h),
                                    _buildStatsPills(data, colors, fonts),
                                    Gap(18.h),
                                    _buildDivider(colors),
                                    Gap(18.h),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: _TabBarHeaderDelegate(
                              child: Container(
                                color: colors.shade0,
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: _buildTabBar(colors, fonts),
                              ),
                              height: 52.h,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Container(
                              color: colors.shade0,
                              child: Column(
                                children: [
                                  _buildTabContent(data, colors, fonts),
                                  Gap(100.h),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

  Widget _buildSliverAppBar(
    dynamic data,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    final images = data.images ?? [];

    return SliverAppBar(
      expandedHeight: 320.h,
      pinned: true,
      stretch: true,
      elevation: 0,
      backgroundColor: colors.primary500,
      surfaceTintColor: colors.primary500,
      leadingWidth: 70.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: Center(
          child: Container(
            height: 36.w,
            width: 36.w,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20.sp,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.fadeTitle,
        ],
        background: images.isEmpty
            ? Container(
                color: colors.neutral100,
                child: Center(
                  child: Icon(
                    Icons.image_not_supported_rounded,
                    size: 48.sp,
                    color: colors.neutral400,
                  ),
                ),
              )
            : Stack(
                fit: StackFit.expand,
                children: [
                  PageView.builder(
                    controller: _imagePageController,
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() => _currentImageIndex = index);
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _openFullScreenImage(images, index),
                        child: Image.network(
                          images[index].imageUrl ?? "",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: colors.neutral200,
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported_rounded,
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
                  IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.25),
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.45),
                          ],
                          stops: const [0.0, 0.4, 1.0],
                        ),
                      ),
                    ),
                  ),
                  if (images.length > 1)
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 14.h,
                      right: 72.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.45),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.photo_library_rounded,
                              size: 12.sp,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              "${_currentImageIndex + 1}/${images.length}",
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
                  if (images.length > 1)
                    Positioned(
                      bottom: 40.h,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          images.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: _currentImageIndex == index ? 20.w : 6.w,
                            height: 6.w,
                            margin: EdgeInsets.symmetric(horizontal: 3.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: _currentImageIndex == index
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }

  Widget _buildTitleSection(
    dynamic data,
    String? title,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    final providerName =
        data.provider?.name ?? widget.providerName ?? "unknown_provider".tr();
    final providerLogo = data.provider?.logoUrl;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: colors.neutral800,
              height: 1.2,
              letterSpacing: -0.3,
            ),
          ),
          Gap(12.h),
          Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: colors.blue500,
                  shape: BoxShape.circle,
                  image: providerLogo != null
                      ? DecorationImage(
                          image: NetworkImage(providerLogo),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                alignment: Alignment.center,
                child: providerLogo == null
                    ? Text(
                        providerName.substring(0, 1).toUpperCase(),
                        style: TextStyle(
                          color: colors.shade0,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                        ),
                      )
                    : null,
              ),
              Gap(10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            providerName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: colors.neutral800,
                            ),
                          ),
                        ),
                        Gap(4.w),
                        Icon(
                          Icons.verified_rounded,
                          size: 15.sp,
                          color: colors.blue500,
                        ),
                      ],
                    ),
                    Text(
                      'specialist'.tr(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: colors.neutral500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsPills(
    dynamic data,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          _StatPill(
            icon: Icons.star_rounded,
            iconColor: colors.yellow500,
            bg: colors.yellow500.withValues(alpha: 0.12),
            label: (data.averageRating?.toString()) ?? "5.0",
            textColor: colors.neutral800,
          ),
          Gap(8.w),
          _StatPill(
            icon: Icons.reviews_rounded,
            iconColor: colors.blue500,
            bg: colors.blue500.withValues(alpha: 0.10),
            label: "${data.totalReviews ?? 0}",
            textColor: colors.neutral800,
          ),
          Gap(8.w),
          if (data.provinceName != null &&
              (data.provinceName as String).isNotEmpty)
            _StatPill(
              icon: Icons.location_on_rounded,
              iconColor: colors.neutral600,
              bg: colors.neutral100,
              label: data.provinceName as String,
              textColor: colors.neutral700,
            ),
        ],
      ),
    );
  }

  Widget _buildDivider(CustomColorSet colors) {
    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      color: colors.neutral100,
    );
  }


  Widget _buildTabBar(CustomColorSet colors, FontSet fonts) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      height: 44.h,
      decoration: BoxDecoration(
        color: colors.neutral100,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: colors.shade0,
          borderRadius: BorderRadius.circular(11.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: colors.blue500,
        unselectedLabelColor: colors.neutral500,
        labelStyle: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.1,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
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

  Widget _buildTabContent(
    ServiceData data,
    CustomColorSet colors,
    FontSet fonts,
  ) {
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

  Widget _buildAboutTab(
    ServiceData data,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    final description = data.description;

    final categoryName = data.category?.name ?? "";

    final shouldTruncate = (description ?? "").length > 150;
    final displayText = shouldTruncate && !_isDescriptionExpanded
        ? "${description!.substring(0, 150)}..."
        : (description ?? "");

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
                        categoryName,
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
            "no_images_available".tr(),
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
                "no_reviews_yet".tr(),
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
          return const ServiceListShimmer();
        }

        final filteredItems = catState.items
            .where((item) => item.id != data.id)
            .toList();

        if (filteredItems.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(40.w),
              child: Text(
                "no_similar_services".tr(),
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
            final locale = context.locale.languageCode;
            final itemTitle = locale == 'uz'
                ? item.titleUz
                : locale == 'ru'
                ? item.titleRu
                : item.titleEn ?? item.titleUz ?? "";

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
                            itemTitle ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: fonts.paragraphP3Bold.copyWith(
                              color: colors.neutral800,
                            ),
                          ),
                          Gap(4.h),
                          Text(
                            "${item.basePrice} ${"uzs".tr()}",
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
    final priceText = data.basePrice ?? '0';
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 12.h,
        bottom: MediaQuery.of(context).padding.bottom + 12.h,
      ),
      decoration: BoxDecoration(
        color: colors.shade0,
        border: Border(
          top: BorderSide(color: colors.neutral100, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'from'.tr().toUpperCase(),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: colors.neutral400,
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      priceText,
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
                      "uzs".tr(),
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
          Gap(12.w),
          ElevatedButton(
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
              padding:
                  EdgeInsets.symmetric(horizontal: 22.w, vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "book_now".tr(),
                  style: TextStyle(
                    color: colors.shade0,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 6.w),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 18.sp,
                  color: colors.shade0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TabBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _TabBarHeaderDelegate({required this.child, required this.height});

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      color: Colors.transparent,
      elevation: overlapsContent ? 2 : 0,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _TabBarHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.height != height;
  }
}

class _StatPill extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color bg;
  final String label;
  final Color textColor;

  const _StatPill({
    required this.icon,
    required this.iconColor,
    required this.bg,
    required this.label,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: iconColor),
          SizedBox(width: 5.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
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
