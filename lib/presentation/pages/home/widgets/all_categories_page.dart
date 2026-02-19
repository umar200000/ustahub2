import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application2/category_bloc_and_data/data/model/category_model.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class AllCategoriesPage extends StatelessWidget {
  final List<CategoryModel> categories;

  const AllCategoriesPage({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.shade0,
          body: Column(
            children: [
              UniversalAppBar(
                title: 'categories'.tr(),
                showBackButton: true,
                centerTitle: true,
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(16.r),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 20.h,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return _CategoryGridItem(category: category);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CategoryGridItem extends StatelessWidget {
  final CategoryModel category;

  const _CategoryGridItem({required this.category});

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    String title = category.nameUz ?? '';
    if (lang == 'ru') title = category.nameRu ?? category.nameUz ?? '';
    if (lang == 'en') title = category.nameEn ?? category.nameUz ?? '';

    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AnimationButtonEffect(
          onTap: () {
            if (category.id != null && category.nameUz != null) {
              Navigator.push(
                context,
                AppRoutes.categoryListPage(category.id!, category.nameUz!),
              );
            }
          },
          child: Column(
            children: [
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: colors.blue500.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child:
                        category.iconUrl != null && category.iconUrl!.isNotEmpty
                        ? Image.network(
                            category.iconUrl!,
                            width: 45.w,
                            height: 45.w,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildPlaceholderIcon(colors),
                          )
                        : _buildPlaceholderIcon(colors),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                title,
                style: fonts.paragraphP3SemiBold.copyWith(
                  color: colors.neutral800,
                  fontSize: 12.sp,
                ),
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

  Widget _buildPlaceholderIcon(dynamic colors) {
    return Icon(Icons.category_rounded, size: 32.w, color: colors.blue500);
  }
}
