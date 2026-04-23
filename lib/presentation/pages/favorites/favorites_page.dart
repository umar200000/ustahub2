import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application2/favorite_bloc_and_data/bloc/favorite_bloc.dart';
import 'package:ustahub/application2/service_bloc_and_data/bloc/service_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/pages/home/widgets/service_product_widget.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
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
      final bloc = context.read<FavoriteBloc>();
      if (bloc.state.listStatus != Status2.loading && !bloc.state.isLastPage) {
        bloc.add(const GetFavoritesEvent(isFetchMore: true));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.bgSurface,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
                  child: Row(
                    children: [
                      Text(
                        'favorites'.tr(),
                        style: fonts.headingH4SemiBold.copyWith(
                          fontSize: 22.sp,
                          color: colors.neutral800,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      BlocBuilder<FavoriteBloc, FavoriteState>(
                        builder: (context, state) {
                          if (state.favoriteIds.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: colors.blue500.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              '${state.total}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: colors.blue500,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, state) {
                      if (state.listStatus == Status2.loading &&
                          state.favorites.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state.favorites.isEmpty &&
                          state.listStatus != Status2.loading) {
                        return _EmptyState(colors: colors, fonts: fonts);
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          context
                              .read<FavoriteBloc>()
                              .add(const GetFavoritesEvent());
                        },
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.only(
                            top: 4.h,
                            bottom: 100.h,
                          ),
                          itemCount: state.favorites.length +
                              (state.isLastPage ? 0 : 1),
                          itemBuilder: (context, index) {
                            if (index >= state.favorites.length) {
                              return state.listStatus == Status2.loading
                                  ? const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : const SizedBox.shrink();
                            }

                            final item = state.favorites[index];
                            final serviceId = item.id ?? '';
                            final resolvedPrice =
                                double.tryParse(item.basePrice ?? "0")
                                        ?.toInt() ??
                                    0;

                            return ServiceProviderCard(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  AppRoutes.detailsPage(
                                    serviceId,
                                    providerName: item.providerName,
                                  ),
                                );
                              },
                              name: item.title ?? 'unnamed_service'.tr(),
                              profession:
                                  item.categoryName ?? 'specialist'.tr(),
                              provinceName: item.provinceName,
                              distance: 0.0,
                              rating: 5.0,
                              reviewCount: 0,
                              duration: 'unknown'.tr(),
                              priceFrom: resolvedPrice,
                              isVerified: false,
                              isAvailable: item.status == 'active',
                              mainImageUrl: item.primaryImageUrl,
                              isFavorite: item.isFavorite ?? true,
                              onFavorite: () {
                                context.read<ServiceBloc>().add(
                                      UpdateServiceFavoriteEvent(
                                        serviceId: serviceId,
                                        isFavorite: false,
                                      ),
                                    );
                                context.read<FavoriteBloc>().add(
                                  ToggleFavoriteEvent(
                                    serviceId: serviceId,
                                    currentlyFavorite: true,
                                    serviceData: item,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  final dynamic colors;
  final dynamic fonts;

  const _EmptyState({required this.colors, required this.fonts});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96.w,
              height: 96.w,
              decoration: BoxDecoration(
                color: colors.blue500.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_rounded,
                size: 44.sp,
                color: colors.blue500,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'no_favorites'.tr(),
              style: fonts.headingH5SemiBold.copyWith(
                fontSize: 16.sp,
                color: colors.neutral800,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'no_favorites_desc'.tr(),
              style: TextStyle(
                fontSize: 13.sp,
                color: colors.neutral500,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
