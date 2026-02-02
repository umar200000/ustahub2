import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ustahub/infrastructure/services/local_database/db_service.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';
import 'package:ustahub/presentation/components/custom_button.dart';

class ViewSelectionDialog extends StatefulWidget {
  const ViewSelectionDialog({super.key});

  @override
  State<ViewSelectionDialog> createState() => _ViewSelectionDialogState();
}

class _ViewSelectionDialogState extends State<ViewSelectionDialog> {
  late bool catalogsGridView;
  late bool productsGridView;

  @override
  void initState() {
    super.initState();
    final dbService = context.read<DBService>();
    catalogsGridView = dbService.getIsCatalogsGridView();
    productsGridView = dbService.getIsProductsGridView();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Dialog(
          backgroundColor: colors.shade0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ViewSection(
                  title: 'category_view'.tr(),
                  isListSelected: !catalogsGridView,
                  isGridSelected: catalogsGridView,
                  onListTap: () => setState(() => catalogsGridView = false),
                  onGridTap: () => setState(() => catalogsGridView = true),
                  isCatalog: true,
                ),
                SizedBox(height: 20.h),
                _ViewSection(
                  title: 'product_view'.tr(),
                  isListSelected: !productsGridView,
                  isGridSelected: productsGridView,
                  onListTap: () => setState(() => productsGridView = false),
                  onGridTap: () => setState(() => productsGridView = true),
                  isCatalog: false,
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () => Navigator.pop(context),
                        title: 'cancel'.tr(),
                        verticalPadding: 12.h,
                        borderColor: colors.transparent,
                        backgroundColor: colors.transparent,
                        titleStyle: fonts.paragraphP2SemiBold,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: CustomButton(
                        onPressed: () async {
                          final dbService = context.read<DBService>();
                          await dbService.setIsCatalogsGridView(
                            catalogsGridView,
                          );
                          await dbService.setIsProductsGridView(
                            productsGridView,
                          );
                          // For backward compatibility
                          Navigator.pop(context);
                        },
                        title: 'apply'.tr(),
                        verticalPadding: 12.h,
                        horizontalPadding: 0,
                        titleStyle: fonts.paragraphP2SemiBold.copyWith(
                          color: colors.shade0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ViewSection extends StatelessWidget {
  const _ViewSection({
    required this.title,
    required this.isListSelected,
    required this.isGridSelected,
    required this.onListTap,
    required this.onGridTap,
    required this.isCatalog,
  });

  final String title;
  final bool isListSelected;
  final bool isGridSelected;
  final VoidCallback onListTap;
  final VoidCallback onGridTap;
  final bool isCatalog;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: fonts.paragraphP1Medium.copyWith(
                      color: colors.shade100,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: _SelectionCard(
                    isSelected: isListSelected,
                    onTap: onListTap,
                    borderColor: colors.primary500,
                    child: Image.asset(
                      isCatalog
                          ? icons.listCatalogBanner
                          : icons.listProductBanner,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _SelectionCard(
                    isSelected: isGridSelected,
                    onTap: onGridTap,
                    borderColor: colors.primary500,
                    child: Image.asset(
                      isCatalog
                          ? icons.gridCatalogBanner
                          : icons.gridProductBanner,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _SelectionCard extends StatelessWidget {
  const _SelectionCard({
    required this.isSelected,
    required this.onTap,
    required this.child,
    required this.borderColor,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final Widget child;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            height: 180.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? borderColor : colors.neutral300,
                width: 2.r,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(child: child),
          ),
        );
      },
    );
  }
}
