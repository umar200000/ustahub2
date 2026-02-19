import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application2/category_bloc_and_data/data/model/category_model.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
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
                      color: colors.shade100,
                      fontSize: 18.sp,
                    ),
                  ),
                  AnimationButtonEffect(
                    onTap: () {
                      // TODO: Navigate to all categories
                    },
                    child: Text(
                      'see_all'.tr(),
                      style: fonts.paragraphP3Regular.copyWith(
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
    final lang = context.locale.languageCode;
    String title = service.nameUz ?? '';
    if (lang == 'ru') title = service.nameRu ?? service.nameUz ?? '';
    if (lang == 'en') title = service.nameEn ?? service.nameUz ?? '';

    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AnimationButtonEffect(
          onTap: () {
            if (service.id != null && service.nameUz != null) {
              Navigator.push(
                context,
                AppRoutes.categoryListPage(service.id!, service.nameUz!),
              );
            }
          },
          child: Container(
            width: 75.w,
            margin: EdgeInsets.only(right: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Circular image container
                Container(
                  width: 65.w,
                  height: 65.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.shade0,
                    boxShadow: [
                      BoxShadow(
                        color: colors.neutral300.withValues(alpha: 0.5),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: service.iconUrl != null && service.iconUrl!.isNotEmpty
                        ? Image.network(
                            service.iconUrl!,
                            width: 65.w,
                            height: 65.w,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildPlaceholderIcon(colors),
                          )
                        : _buildPlaceholderIcon(colors),
                  ),
                ),
                SizedBox(height: 8.h),
                // Label
                Text(
                  title,
                  style: fonts.paragraphP3Regular.copyWith(
                    color: colors.neutral700,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaceholderIcon(dynamic colors) {
    return Container(
      width: 65.w,
      height: 65.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.blue500.withValues(alpha: 0.1),
      ),
      child: Icon(
        Icons.category_outlined,
        size: 28.w,
        color: colors.blue500,
      ),
    );
  }
}

// Keep the old ServiceCard for backward compatibility if needed elsewhere
class ServiceCard extends StatelessWidget {
  final CategoryModel service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    String title = service.nameUz ?? '';
    if (lang == 'ru') title = service.nameRu ?? service.nameUz ?? '';
    if (lang == 'en') title = service.nameEn ?? service.nameUz ?? '';

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
                title,
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
