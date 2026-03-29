import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application2/category_list_bloc_and_data/bloc/category_list_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/components/shimmer_widgets.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/pages/home/widgets/service_product_widget.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import '../../../infrastructure2/init/injection.dart';
import '../../routes/routes.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });
  final String categoryId;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<CategoryListBloc>()
        ..add(GetCategoryList(categoryId: categoryId)),
      child: ThemeWrapper(
        builder: (context, colors, fonts, icons, controller) {
          return Scaffold(
            backgroundColor: colors.shade0,
            body: Column(
              children: [
                UniversalAppBar(
                  title: categoryName,
                  centerTitle: true,
                  showBackButton: true,
                ),
                Expanded(
                  child: BlocBuilder<CategoryListBloc, CategoryListState>(
                    builder: (context, state) {
                      if (state.status == Status2.loading &&
                          state.items.isEmpty) {
                        return const CategoryListShimmer();
                      }
                      if (state.status == Status2.error &&
                          state.items.isEmpty) {
                        return Center(
                          child: Text(state.errorMessage ?? "error".tr()),
                        );
                      }
                      if (state.items.isEmpty &&
                          state.status == Status2.success) {
                        return Center(
                          child: Text("no_services_found".tr()),
                        );
                      }

                      final lang = context.locale.languageCode;

                      return NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (scrollInfo.metrics.pixels >=
                                  scrollInfo.metrics.maxScrollExtent * 0.9 &&
                              state.status != Status2.loading) {
                            context.read<CategoryListBloc>().add(
                              GetCategoryList(categoryId: categoryId),
                            );
                          }
                          return false;
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.only(
                            top: 16.h,
                            bottom:
                                16.h + MediaQuery.of(context).padding.bottom,
                          ),
                          itemCount: state.hasReachedMax
                              ? state.items.length
                              : state.items.length + 1,
                          itemBuilder: (context, index) {
                            if (index >= state.items.length) {
                              return const PaginationShimmer();
                            }
                            final service = state.items[index];
                            String title;
                            if (lang == 'ru') {
                              title = service.titleRu ??
                                  service.titleUz ??
                                  service.titleEn ??
                                  "";
                            } else if (lang == 'en') {
                              title = service.titleEn ??
                                  service.titleUz ??
                                  service.titleRu ??
                                  "";
                            } else {
                              title = service.titleUz ??
                                  service.titleRu ??
                                  service.titleEn ??
                                  "";
                            }
                            String category;
                            if (lang == 'ru' || lang == 'en') {
                              category = service.categoryNameUz ?? "";
                            } else {
                              category = service.categoryNameUz ?? "";
                            }
                            return ServiceProviderCard(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  AppRoutes.detailsPage(service.id ?? ""),
                                );
                              },
                              name: title.isNotEmpty
                                  ? title
                                  : "unnamed_service".tr(),
                              profession: category.isNotEmpty
                                  ? category
                                  : "specialist".tr(),
                              mainImageUrl: service.primaryImageUrl,
                              priceFrom:
                                  int.tryParse(
                                    service.basePrice?.split('.').first ?? '0',
                                  ) ??
                                  0,
                              distance: 1.5,
                              rating: 4.5,
                              reviewCount: 120,
                              duration: "30 min",
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
