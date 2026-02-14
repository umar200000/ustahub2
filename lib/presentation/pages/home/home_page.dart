import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ustahub/application2/category_bloc_and_data/bloc/category_bloc.dart';
import 'package:ustahub/application2/service_bloc_and_data/bloc/service_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/pages/home/widgets/banner_carousel_widget.dart';
import 'package:ustahub/presentation/pages/home/widgets/home_app_bar.dart';
import 'package:ustahub/presentation/pages/home/widgets/service_product_widget.dart';
import 'package:ustahub/presentation/pages/home/widgets/service_widget.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Set<String> _favoriteIds = {};
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ServiceBloc>().add(
        const GetServicesEvent(isFetchMore: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.neutral50,
          body: Column(
            children: [
              const HomeAppBar(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<CategoryBloc>().add(GetCategoriesEvent());
                    context.read<ServiceBloc>().add(const GetServicesEvent());
                  },
                  child: ListView(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(bottom: 60),
                    children: [
                      16.h.verticalSpace,
                      const BannerCarouselWidget(),

                      BlocBuilder<CategoryBloc, CategoryState>(
                        builder: (context, state) {
                          if (state.status == Status2.loading) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              ),
                            );
                          } else if (state.status == Status2.success) {
                            final categories =
                                state.categoryData?.categoryModel ?? [];
                            return ServicesGrid(services: categories);
                          } else if (state.status == Status2.error) {
                            return Center(
                              child: Text(state.errorMessage ?? "Error"),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
                        child: Text(
                          "Praviderlar",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: colors.neutral800,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 110.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 140.w,
                              margin: EdgeInsets.only(right: 12.w),
                              decoration: BoxDecoration(
                                color: colors.shade0,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(12.r),
                                    ),
                                    child: Image.network(
                                      "https://img.freepik.com/free-vector/lightning-bolt-circle-gradient_78370-5397.jpg?semt=ais_user_personalization&w=740&q=80",
                                      height: 80.w,
                                      width: 80.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Text(
                                      "Qurilish kampaynasi",
                                      style: fonts.paragraphP2Bold.copyWith(
                                        color: colors.neutral800,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Gap(4),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const Gap(20),

                      /// ServiceBloc data display
                      BlocBuilder<ServiceBloc, ServiceState>(
                        builder: (context, state) {
                          if (state.status == Status2.loading &&
                              (state.servicesData?.servicesModel ?? [])
                                  .isEmpty) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              ),
                            );
                          } else if (state.status == Status2.success ||
                              (state.status == Status2.loading &&
                                  (state.servicesData?.servicesModel ?? [])
                                      .isNotEmpty)) {
                            final services =
                                state.servicesData?.servicesModel ?? [];
                            if (services.isEmpty) {
                              return const Center(
                                child: Text("Xizmatlar topilmadi"),
                              );
                            }
                            return Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(bottom: 16.h),
                                  itemCount: services.length,
                                  itemBuilder: (context, index) {
                                    final service = services[index];
                                    return ServiceProviderCard(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          AppRoutes.detailsPage(
                                            service.id ?? "",
                                          ),
                                        );
                                      },
                                      name: service.titleUz ?? "Nomsiz xizmat",
                                      profession:
                                          service.categoryNameUz ??
                                          "Mutaxassis",
                                      distance: 0.0,
                                      rating: 5.0,
                                      reviewCount: 0,
                                      duration: "Noma'lum",
                                      priceFrom:
                                          double.tryParse(
                                            service.basePrice ?? "0",
                                          )?.toInt() ??
                                          0,
                                      isVerified: false,
                                      isAvailable: service.status == "active",
                                      mainImageUrl: service.primaryImageUrl,
                                      isFavorite: _favoriteIds.contains(
                                        service.id,
                                      ),
                                      onFavorite: () =>
                                          _toggleFavorite(service.id ?? ""),
                                    );
                                  },
                                ),
                                if (state.status == Status2.loading)
                                  const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: CircularProgressIndicator(
                                      color: Colors.blue,
                                    ),
                                  ),
                              ],
                            );
                          } else if (state.status == Status2.error) {
                            return Center(
                              child: Text(state.errorMessage ?? "Error"),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleFavorite(String id) {
    setState(() {
      if (_favoriteIds.contains(id)) {
        _favoriteIds.remove(id);
      } else {
        _favoriteIds.add(id);
      }
    });
  }
}
