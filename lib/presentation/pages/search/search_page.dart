import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application2/search_bloc_and_data/bloc/search_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/infrastructure2/init/injection.dart';
import 'package:ustahub/presentation/components/custom_text_field.dart';
import 'package:ustahub/presentation/pages/home/widgets/service_product_widget.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (_searchController.text.isNotEmpty) {
        sl<SearchBloc>().add(
          SearchQueryEvent(query: _searchController.text, isNewSearch: false),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<SearchBloc>(),
      child: ThemeWrapper(
        builder: (context, colors, fonts, icons, controller) {
          return Scaffold(
            backgroundColor: colors.neutral50,
            body: Column(
              children: [
                // Custom Header
                Container(
                  padding: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: colors.shade0,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24.r),
                      bottomRight: Radius.circular(24.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colors.neutral200.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SafeArea(
                        bottom: false,
                        child: SizedBox(
                          height: 48.h,
                          child: Center(
                            child: Text(
                              "Qidiruv",
                              style: fonts.paragraphP1SemiBold.copyWith(
                                color: colors.neutral800,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: CustomTextField(
                          autoFocus: true,
                          hintText: "Xizmatlarni qidiring...",
                          controller: _searchController,
                          prefixIcon: Icon(
                            Icons.search,
                            color: colors.neutral500,
                            size: 24.sp,
                          ),
                          borderRadius: 12.r,
                          fillColor: colors.neutral50,
                          onChanged: (value) {
                            sl<SearchBloc>().add(
                              SearchQueryEvent(query: value, isNewSearch: true),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Content Area
                Expanded(
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (_searchController.text.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                color: colors.neutral300,
                                size: 80.sp,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                "Xizmatlarni qidirishni boshlang",
                                style: fonts.paragraphP2Regular.copyWith(
                                  color: colors.neutral500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      if (state.status == Status2.loading &&
                          state.items.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.blue),
                        );
                      }

                      if (state.status == Status2.error) {
                        return Center(
                          child: Text(
                            state.errorMessage ?? "Xatolik yuz berdi",
                            style: fonts.paragraphP2Medium.copyWith(
                              color: colors.red500,
                            ),
                          ),
                        );
                      }

                      if (state.items.isEmpty &&
                          state.status == Status2.success) {
                        return Center(
                          child: Text(
                            "Hech narsa topilmadi",
                            style: fonts.paragraphP2Medium.copyWith(
                              color: colors.neutral500,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                        ).copyWith(bottom: 60),
                        itemCount:
                            state.items.length + (state.hasReachedMax ? 0 : 1),
                        itemBuilder: (context, index) {
                          if (index >= state.items.length) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              ),
                            );
                          }

                          final item = state.items[index];
                          return ServiceProviderCard(
                            onTap: () {
                              Navigator.push(
                                context,
                                AppRoutes.detailsPage(item.id ?? ""),
                              );
                            },
                            name: item.titleUz ?? "Nomsiz xizmat",
                            profession: item.categoryNameUz ?? "Mutaxassis",
                            distance: 0.0,
                            rating: 5.0,
                            reviewCount: 0,
                            duration: "Noma'lum",
                            priceFrom:
                                double.tryParse(
                                  item.basePrice ?? "0",
                                )?.toInt() ??
                                0,
                            isVerified: false,
                            isAvailable: item.status == "active",
                            mainImageUrl: item.primaryImageUrl,
                            isFavorite: false,
                            onFavorite: () {},
                          );
                        },
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
