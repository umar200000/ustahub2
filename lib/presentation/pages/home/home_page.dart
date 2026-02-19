import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application2/banner_bloc_and_data/bloc/banner_bloc.dart';
import 'package:ustahub/application2/category_bloc_and_data/bloc/category_bloc.dart';
import 'package:ustahub/application2/service_bloc_and_data/bloc/service_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/pages/home/widgets/banner_carousel_widget.dart';
import 'package:ustahub/presentation/pages/home/widgets/home_app_bar.dart';
import 'package:ustahub/presentation/pages/home/widgets/home_shimmer_widgets.dart';
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
    // Ma'lumotlarni yuklashni boshlaymiz
    _loadInitialData();
  }

  void _loadInitialData({bool forceRefresh = false}) {
    final bannerState = context.read<BannerBloc>().state;
    final categoryState = context.read<CategoryBloc>().state;
    final serviceState = context.read<ServiceBloc>().state;

    // Only load if data is empty or force refresh
    if (forceRefresh || (bannerState.bannerModel?.data ?? []).isEmpty) {
      context.read<BannerBloc>().add(GetBannersEvent());
    }
    if (forceRefresh ||
        (categoryState.categoryData?.categoryModel ?? []).isEmpty) {
      context.read<CategoryBloc>().add(GetCategoriesEvent());
    }
    if (forceRefresh ||
        (serviceState.servicesData?.servicesModel ?? []).isEmpty) {
      context.read<ServiceBloc>().add(const GetServicesEvent());
    }
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
          backgroundColor: colors.shade0,
          body: Column(
            children: [
              const HomeAppBar(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    _loadInitialData(forceRefresh: true);
                  },
                  child: ListView(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(bottom: 60),
                    children: [
                      16.h.verticalSpace,
                      const BannerCarouselWidget(),

                      BlocBuilder<CategoryBloc, CategoryState>(
                        builder: (context, state) {
                          final categories =
                              state.categoryData?.categoryModel ?? [];

                          // Show shimmer if loading and no data
                          if (state.status == Status2.loading &&
                              categories.isEmpty) {
                            return const CategoryShimmer();
                          }

                          if (categories.isNotEmpty) {
                            return ServicesGrid(services: categories);
                          }

                          if (state.status == Status2.error) {
                            return Center(
                              child: Text(state.errorMessage ?? "Error"),
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),

                      /// ServiceBloc data display
                      BlocBuilder<ServiceBloc, ServiceState>(
                        builder: (context, state) {
                          // Show shimmer if loading and no data
                          if (state.status == Status2.loading &&
                              (state.servicesData?.servicesModel ?? [])
                                  .isEmpty) {
                            return const ServicesListShimmer(itemCount: 4);
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
                                // Show shimmer for loading more
                                if (state.status == Status2.loading)
                                  const ServiceCardShimmer(),
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
