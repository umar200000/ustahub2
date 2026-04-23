import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application2/banner_bloc_and_data/bloc/banner_bloc.dart';
import 'package:ustahub/application2/category_bloc_and_data/bloc/category_bloc.dart';
import 'package:ustahub/application2/favorite_bloc_and_data/bloc/favorite_bloc.dart';
import 'package:ustahub/application2/favorite_bloc_and_data/data/model/favorite_model.dart';
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
  final ScrollController _scrollController = ScrollController();
  String? _currentLanguage;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadInitialData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Til o'zgarganini tekshirish
    final newLang = context.locale.languageCode;

    if (_currentLanguage != null && _currentLanguage != newLang) {
      _loadInitialData(forceRefresh: true);
    }
    _currentLanguage = newLang;
  }

  void _loadInitialData({bool forceRefresh = false}) {
    final bannerState = context.read<BannerBloc>().state;
    final categoryState = context.read<CategoryBloc>().state;
    final serviceState = context.read<ServiceBloc>().state;

    // Har safar yangi til kodi bilan request ketishi uchun forceRefresh ishlatamiz
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
    final scrolled = _scrollController.position.pixels > 4;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
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
          backgroundColor: colors.bgSurface,
          body: Column(
            children: [
              HomeAppBar(showShadow: _isScrolled),
              Expanded(
                child: RefreshIndicator(
                  color: colors.primary500,
                  backgroundColor: colors.shade0,
                  onRefresh: () async {
                    _loadInitialData(forceRefresh: true);
                    context
                        .read<FavoriteBloc>()
                        .add(const GetFavoritesEvent());
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

                          if (state.status == Status2.loading &&
                              categories.isEmpty) {
                            return const CategoryShimmer();
                          }

                          if (categories.isNotEmpty) {
                            return ServicesGrid(services: categories);
                          }

                          if (state.status == Status2.error) {
                            return Center(
                              child: Text(state.errorMessage ?? "error".tr()),
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),

                      BlocBuilder<ServiceBloc, ServiceState>(
                        builder: (context, state) {
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
                              return Center(
                                child: Text("no_services_found".tr()),
                              );
                            }
                            return Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(
                                    bottom:
                                        16.h +
                                        MediaQuery.of(context).padding.bottom,
                                  ),
                                  itemCount: services.length,
                                  itemBuilder: (context, index) {
                                    final service = services[index];

                                    // Tilga qarab modeldan kerakli maydonni tanlaymiz
                                    final lang = context.locale.languageCode;
                                    String title =
                                        service.title ??
                                        ""; // Default mahalliylashtirilgan title

                                    if (lang == 'ru') {
                                      title =
                                          service.titleRu ??
                                          service.title ??
                                          service.titleUz ??
                                          "";
                                    } else if (lang == 'en') {
                                      title =
                                          service.titleEn ??
                                          service.title ??
                                          service.titleUz ??
                                          "";
                                    } else {
                                      title =
                                          service.titleUz ??
                                          service.title ??
                                          "";
                                    }

                                    final serviceId = service.id ?? "";
                                    final resolvedName = title.isNotEmpty
                                        ? title
                                        : "unnamed_service".tr();
                                    final resolvedProfession =
                                        service.categoryName ??
                                        "specialist".tr();
                                    final resolvedPrice =
                                        double.tryParse(
                                          service.basePrice ?? "0",
                                        )?.toInt() ??
                                        0;
                                    final resolvedAvailable =
                                        service.status == "active";

                                    return BlocBuilder<FavoriteBloc,
                                        FavoriteState>(
                                      buildWhen: (prev, curr) =>
                                          prev.favoriteIds
                                                  .contains(serviceId) !=
                                              curr.favoriteIds
                                                  .contains(serviceId),
                                      builder: (context, favState) {
                                        final isFav =
                                            (service.isFavorite == true) ||
                                                favState.favoriteIds
                                                    .contains(serviceId);
                                        return ServiceProviderCard(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              AppRoutes.detailsPage(
                                                serviceId,
                                                providerName:
                                                    service.providerName,
                                              ),
                                            );
                                          },
                                          name: resolvedName,
                                          profession: resolvedProfession,
                                          provinceName: service.provinceName,
                                          distance: 0.0,
                                          rating: 5.0,
                                          reviewCount: 0,
                                          duration: "unknown".tr(),
                                          priceFrom: resolvedPrice,
                                          isVerified: false,
                                          isAvailable: resolvedAvailable,
                                          mainImageUrl:
                                              service.primaryImageUrl,
                                          isFavorite: isFav,
                                          onFavorite: () {
                                            context.read<ServiceBloc>().add(
                                                  UpdateServiceFavoriteEvent(
                                                    serviceId: serviceId,
                                                    isFavorite: !isFav,
                                                  ),
                                                );
                                            context.read<FavoriteBloc>().add(
                                                  ToggleFavoriteEvent(
                                                    serviceId: serviceId,
                                                    currentlyFavorite: isFav,
                                                    serviceData:
                                                        FavoriteServiceData(
                                                      id: serviceId,
                                                      providerId:
                                                          service.providerId,
                                                      providerName: service
                                                          .providerName,
                                                      title: resolvedName,
                                                      description:
                                                          service.description,
                                                      basePrice:
                                                          service.basePrice,
                                                      maxPrice:
                                                          service.maxPrice,
                                                      status: service.status,
                                                      primaryImageUrl: service
                                                          .primaryImageUrl,
                                                      categoryName:
                                                          resolvedProfession,
                                                      provinceName: service
                                                          .provinceName,
                                                      currencyCode: service
                                                          .currencyCode,
                                                      currencySymbol: service
                                                          .currencySymbol,
                                                    ),
                                                  ),
                                                );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                                if (state.status == Status2.loading)
                                  const ServiceCardShimmer(),
                              ],
                            );
                          } else if (state.status == Status2.error) {
                            return Center(
                              child: Text(state.errorMessage ?? "error".tr()),
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
}
