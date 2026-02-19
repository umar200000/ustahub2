import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ustahub/application2/search_bloc_and_data/bloc/search_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/infrastructure2/init/injection.dart';
import 'package:ustahub/presentation/pages/home/widgets/service_product_widget.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme.dart';
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
            backgroundColor: colors.shade0,
            body: SafeArea(
              child: Column(
                children: [
                  // Search Bar
                  _buildSearchBar(colors, fonts),

                  // Content
                  Expanded(
                    child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        if (_searchController.text.isEmpty) {
                          return _buildEmptyState(colors, fonts);
                        }

                        if (state.status == Status2.loading &&
                            state.items.isEmpty) {
                          return _buildLoading();
                        }

                        if (state.status == Status2.error) {
                          return _buildError(colors, fonts, state.errorMessage);
                        }

                        if (state.items.isEmpty &&
                            state.status == Status2.success) {
                          return _buildNoResults(colors, fonts);
                        }

                        return _buildResults(state);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(CustomColorSet colors, FontSet fonts) {
    return Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.neutral100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        style: fonts.paragraphP2Regular.copyWith(color: colors.neutral800),
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: fonts.paragraphP2Regular.copyWith(color: colors.neutral600),
          prefixIcon: Icon(
            Icons.search,
            color: colors.neutral600,
            size: 22.sp,
          ),
          suffixIcon: _searchController.text.isEmpty
              ? Icon(
                  Icons.mic_none_rounded,
                  color: colors.neutral400,
                  size: 22.sp,
                )
              : GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    sl<SearchBloc>().add(
                      const SearchQueryEvent(query: '', isNewSearch: true),
                    );
                    setState(() {});
                  },
                  child: Icon(
                    Icons.close,
                    color: colors.neutral400,
                    size: 20.sp,
                  ),
                ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        ),
        onChanged: (value) {
          setState(() {});
          sl<SearchBloc>().add(
            SearchQueryEvent(query: value, isNewSearch: true),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(CustomColorSet colors, FontSet fonts) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Illustration
        SizedBox(
          width: 180.w,
          height: 120.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background cards
              Positioned(
                top: 20.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: colors.neutral200,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      width: 60.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: colors.neutral200,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                  ],
                ),
              ),
              // Magnifying glass
              Positioned(
                bottom: 0,
                child: Container(
                  width: 70.w,
                  height: 70.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors.blue500,
                      width: 4.w,
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          colors.shade0,
                          colors.yellow500.withValues(alpha: 0.3),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Handle
              Positioned(
                bottom: 0,
                right: 45.w,
                child: Transform.rotate(
                  angle: 0.7,
                  child: Container(
                    width: 6.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: colors.blue500,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 32.h),

        // Title
        Text(
          "What are\nyou searching for?",
          textAlign: TextAlign.center,
          style: fonts.paragraphP1Bold.copyWith(
            color: colors.neutral800,
            fontSize: 22.sp,
            height: 1.3,
          ),
        ),

        SizedBox(height: 12.h),

        // Subtitle
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Text(
            "Search for your favorite thing or find similar results in this area.",
            textAlign: TextAlign.center,
            style: fonts.paragraphP3Regular.copyWith(
              color: colors.neutral500,
              height: 1.4,
            ),
          ),
        ),

        SizedBox(height: 80.h),
      ],
    );
  }

  Widget _buildLoading() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemCount: 5,
      itemBuilder: (context, index) => _buildShimmerItem(),
    );
  }

  Widget _buildShimmerItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 14.h,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: 100.w,
                    height: 12.h,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: 60.w,
                    height: 14.h,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(CustomColorSet colors, FontSet fonts, String? message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48.sp,
            color: colors.red500,
          ),
          SizedBox(height: 16.h),
          Text(
            message ?? "Something went wrong",
            style: fonts.paragraphP2Regular.copyWith(color: colors.neutral600),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults(CustomColorSet colors, FontSet fonts) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 48.sp,
            color: colors.neutral400,
          ),
          SizedBox(height: 16.h),
          Text(
            "No results found",
            style: fonts.paragraphP2Medium.copyWith(color: colors.neutral600),
          ),
        ],
      ),
    );
  }

  Widget _buildResults(SearchState state) {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.only(bottom: 80.h),
      itemCount: state.items.length + (state.hasReachedMax ? 0 : 1),
      itemBuilder: (context, index) {
        if (index >= state.items.length) {
          return _buildShimmerItem();
        }

        final item = state.items[index];
        return ServiceProviderCard(
          onTap: () {
            Navigator.push(context, AppRoutes.detailsPage(item.id ?? ""));
          },
          name: item.titleUz ?? "Nomsiz xizmat",
          profession: item.categoryNameUz ?? "Mutaxassis",
          distance: 0.0,
          rating: 5.0,
          reviewCount: 0,
          duration: "Noma'lum",
          priceFrom: double.tryParse(item.basePrice ?? "0")?.toInt() ?? 0,
          isVerified: false,
          isAvailable: item.status == "active",
          mainImageUrl: item.primaryImageUrl,
          isFavorite: false,
          onFavorite: () {},
        );
      },
    );
  }
}
