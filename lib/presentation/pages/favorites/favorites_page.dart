import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ustahub/infrastructure/services/favorite_provider.dart';
import 'package:ustahub/presentation/pages/home/widgets/service_product_widget.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.bgSurface,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
                  child: Row(
                    children: [
                      Text(
                        'favorites'.tr(),
                        style: fonts.headingH4SemiBold.copyWith(
                          fontSize: 22.sp,
                          color: colors.neutral800,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Consumer<FavoriteProvider>(
                        builder: (context, fav, _) {
                          if (fav.count == 0) return const SizedBox.shrink();
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: colors.blue500.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              '${fav.count}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: colors.blue500,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Consumer<FavoriteProvider>(
                    builder: (context, fav, _) {
                      final items = fav.items;
                      if (items.isEmpty) {
                        return _EmptyState(colors: colors, fonts: fonts);
                      }
                      return ListView.builder(
                        padding: EdgeInsets.only(
                          top: 4.h,
                          bottom: 100.h,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return ServiceProviderCard(
                            onTap: () {
                              Navigator.push(
                                context,
                                AppRoutes.detailsPage(
                                  item.id,
                                  providerName: item.providerName,
                                ),
                              );
                            },
                            name: item.name,
                            profession: item.profession,
                            provinceName: item.provinceName,
                            distance: 0.0,
                            rating: 5.0,
                            reviewCount: 0,
                            duration: 'unknown'.tr(),
                            priceFrom: item.priceFrom,
                            isVerified: false,
                            isAvailable: item.isAvailable,
                            mainImageUrl: item.imageUrl,
                            isFavorite: true,
                            onFavorite: () => fav.remove(item.id),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  final dynamic colors;
  final dynamic fonts;

  const _EmptyState({required this.colors, required this.fonts});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96.w,
              height: 96.w,
              decoration: BoxDecoration(
                color: colors.blue500.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_rounded,
                size: 44.sp,
                color: colors.blue500,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'no_favorites'.tr(),
              style: fonts.headingH5SemiBold.copyWith(
                fontSize: 16.sp,
                color: colors.neutral800,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'no_favorites_desc'.tr(),
              style: TextStyle(
                fontSize: 13.sp,
                color: colors.neutral500,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
