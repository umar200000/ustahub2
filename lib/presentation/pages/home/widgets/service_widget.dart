import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application2/category_bloc_and_data/data/model/category_model.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/pages/home/widgets/all_categories_page.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class ServicesGrid extends StatelessWidget {
  final List<CategoryModel> services;

  const ServicesGrid({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'select_category'.tr(),
                    style: fonts.paragraphP1Bold.copyWith(
                      color: Colors.black87,
                      fontSize: 18.sp,
                    ),
                  ),
                  AnimationButtonEffect(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AllCategoriesPage(categories: services),
                        ),
                      );
                    },
                    child: Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: colors.blue500.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14.sp,
                        color: colors.blue500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Horizontal scrollable categories
            SizedBox(
              height: 110.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return _CategoryItem(service: service);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final CategoryModel service;

  const _CategoryItem({required this.service});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AnimationButtonEffect(
          onTap: () {
            if (service.id != null && service.name != null) {
              Navigator.push(
                context,
                AppRoutes.categoryListPage(service.id!, service.name!),
              );
            }
          },
          child: Container(
            width: 75.w,
            margin: EdgeInsets.only(right: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Circular icon container with modern design
                Container(
                  width: 60.w,
                  height: 60.w,
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: colors.blue500.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child:
                      service.iconUrl != null && service.iconUrl!.isNotEmpty
                      ? Image.network(
                          service.iconUrl!,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildPlaceholderIcon(colors),
                        )
                      : _buildPlaceholderIcon(colors),
                ),
                SizedBox(height: 8.h),
                // Label
                Text(
                  service.name ?? "",
                  style: fonts.paragraphP3Regular.copyWith(
                    color: colors.neutral700,
                    fontWeight: FontWeight.w500,
                    fontSize: 11.sp,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaceholderIcon(dynamic colors) {
    return Icon(Icons.category_rounded, size: 28.w, color: colors.blue500);
  }
}

// Keep the old ServiceCard for backward compatibility if needed elsewhere
class ServiceCard extends StatelessWidget {
  final CategoryModel service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: colors.shade0,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (service.iconUrl != null && service.iconUrl!.isNotEmpty)
                Image.network(
                  service.iconUrl!,
                  width: 40.w,
                  height: 40.w,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.category, size: 40.w, color: colors.blue500),
                )
              else
                Icon(Icons.category, size: 40.w, color: colors.blue500),
              SizedBox(height: 8.h),
              Text(
                service.name ?? "",
                style: fonts.paragraphP3Bold.copyWith(color: colors.shade100),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
