import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application2/category_list_bloc_and_data/bloc/category_list_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
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
                        return Center(
                          child: CircularProgressIndicator(
                            color: colors.blue500,
                          ),
                        );
                      }
                      if (state.status == Status2.error &&
                          state.items.isEmpty) {
                        return Center(
                          child: Text(state.errorMessage ?? "Xatolik"),
                        );
                      }
                      if (state.items.isEmpty &&
                          state.status == Status2.success) {
                        return const Center(child: Text("Xizmatlar topilmadi"));
                      }

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
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    color: colors.blue500,
                                  ),
                                ),
                              );
                            }
                            final service = state.items[index];
                            return ServiceProviderCard(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  AppRoutes.detailsPage(service.id ?? ""),
                                );
                              },
                              name: service.titleUz ?? "",
                              profession: service.categoryNameUz ?? "",
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
