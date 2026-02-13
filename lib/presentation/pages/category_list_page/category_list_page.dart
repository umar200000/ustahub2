import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application2/category_list_bloc_and_data/bloc/category_list_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/pages/home/widgets/service_product_widget.dart';

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
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(categoryName),
          centerTitle: true,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: BlocBuilder<CategoryListBloc, CategoryListState>(
          builder: (context, state) {
            if (state.status == Status2.loading && state.items.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            }
            if (state.status == Status2.error && state.items.isEmpty) {
              return Center(child: Text(state.errorMessage ?? "Xatolik"));
            }
            if (state.items.isEmpty && state.status == Status2.success) {
              return const Center(child: Text("Xizmatlar topilmadi"));
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                // Agar scroll 90% ga yetgan bo'lsa va yana ma'lumot yuklanayotgan bo'lmasa
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
                padding: EdgeInsets.only(top: 16.h, bottom: 20.h),
                itemCount: state.hasReachedMax
                    ? state.items.length
                    : state.items.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.items.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator.adaptive(),
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
    );
  }
}
