import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/pages/home/widgets/category_card.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class HomeSliverAppBar extends StatelessWidget {
  final String city;
  final List<Map<String, dynamic>> categories;
  final VoidCallback onNotificationTap;
  final VoidCallback onBasketTap;
  final Function(int index) onCategoryTap;

  const HomeSliverAppBar({
    super.key,
    required this.city,
    required this.categories,
    required this.onNotificationTap,
    required this.onBasketTap,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return SliverPersistentHeader(
          pinned: true,
          delegate: _HomeSliverAppBarDelegate(
            city: city,
            categories: categories,
            colors: colors,
            fonts: fonts,
            icons: icons,
            onNotificationTap: onNotificationTap,
            onBasketTap: onBasketTap,
            onCategoryTap: onCategoryTap,
          ),
        );
      },
    );
  }
}

class _HomeSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final String city;
  final List<Map<String, dynamic>> categories;
  final CustomColorSet colors;
  final FontSet fonts;
  final IconSet icons;
  final VoidCallback onNotificationTap;
  final VoidCallback onBasketTap;
  final Function(int index) onCategoryTap;

  // Heights
  final double _pinnedHeight = 56.0;
  final double _expandedCategoriesHeight = 140.0;
  final double _collapsedCategoriesHeight = 52.0;

  _HomeSliverAppBarDelegate({
    required this.city,
    required this.categories,
    required this.colors,
    required this.fonts,
    required this.icons,
    required this.onNotificationTap,
    required this.onBasketTap,
    required this.onCategoryTap,
  });

  @override
  double get minExtent => (_pinnedHeight + _collapsedCategoriesHeight).h;

  @override
  double get maxExtent => (_pinnedHeight + _expandedCategoriesHeight).h;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    return Container(
      color: colors.shade0,
      child: Column(
        children: [
          _buildTopBar(context),
          _buildCategoriesSection(context, progress),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      height: _pinnedHeight.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          SvgPicture.asset(
            icons.locationS,
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(colors.blue500, BlendMode.srcIn),
          ),
          6.w.horizontalSpace,
          Text(city, style: fonts.paragraphP3Medium),
          const Spacer(),
          AnimationButtonEffect(
            onTap: onNotificationTap,
            child: SvgPicture.asset(
              icons.bellS,
              width: 18.w,
              height: 18.h,
              colorFilter: ColorFilter.mode(colors.neutral500, BlendMode.srcIn),
            ),
          ),
          12.w.horizontalSpace,
          AnimationButtonEffect(
            onTap: onBasketTap,
            child: SvgPicture.asset(
              icons.basketO,
              width: 18.w,
              height: 18.h,
              colorFilter: ColorFilter.mode(colors.neutral500, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context, double progress) {
    final categoriesHeight =
        _expandedCategoriesHeight.h -
        (progress * (_expandedCategoriesHeight - _collapsedCategoriesHeight).h);

    return Container(
      height: categoriesHeight,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: progress < 0.5
          ? _buildExpandedCategories(context, progress)
          : _buildCollapsedCategories(context, progress),
    );
  }

  Widget _buildExpandedCategories(BuildContext context, double progress) {
    final opacity = 1.0 - (progress * 2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: opacity,
          child: Text("categories".tr(), style: fonts.paragraphP1Bold),
        ),
        8.h.verticalSpace,
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final item = categories[index];
              return Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: CategoryCard(
                  icon: item['icon'],
                  title: item['title'],
                  onTap: () => onCategoryTap(index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCollapsedCategories(BuildContext context, double progress) {
    final fadeInProgress = (progress - 0.5) * 2;

    return Opacity(
      opacity: fadeInProgress,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final item = categories[index];
          return Padding(
            padding: EdgeInsets.only(right: 8.w, bottom: 12.h),
            child: _buildSmallCategoryChip(
              icon: item['icon'],
              title: item['title'],
              onTap: () => onCategoryTap(index),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSmallCategoryChip({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return AnimationButtonEffect(
      onTap: onTap,
      child: Container(
        height: _collapsedCategoriesHeight.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: colors.neutral100,
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(color: colors.neutral200, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18.r, color: colors.blue500),
            6.w.horizontalSpace,
            Text(
              title,
              style: fonts.paragraphP3Medium.copyWith(
                color: colors.neutral800,
                fontSize: 12.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_HomeSliverAppBarDelegate oldDelegate) {
    return city != oldDelegate.city || categories != oldDelegate.categories;
  }
}
