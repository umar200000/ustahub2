import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ustahub/application2/express_bloc_and_data/data/model/express_model.dart';
import 'package:ustahub/application2/express_bloc_and_data/data/repo/express_repo.dart';
import 'package:ustahub/application2/search_bloc_and_data/bloc/search_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/infrastructure2/init/injection.dart';
import 'package:ustahub/presentation/pages/home/widgets/service_product_widget.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/style.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  bool _isFirstOpen = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
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
            resizeToAvoidBottomInset: true,
            backgroundColor: colors.bgSurface,
            body: SafeArea(
              child: Column(
                children: [
                  // Search Bar
                  _buildSearchBar(colors, fonts),

                  // Filter chips
                  BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (!state.hasFilter) return const SizedBox.shrink();
                      return _buildFilterChips(context, state, colors, fonts);
                    },
                  ),

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
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: colors.shade0,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: colors.neutral200, width: 0.8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
        controller: _searchController,
        focusNode: _focusNode,
        autofocus: _isFirstOpen,
        style: fonts.paragraphP2Regular.copyWith(color: colors.neutral800),
        decoration: InputDecoration(
          hintText: "search".tr(),
          hintStyle: fonts.paragraphP2Regular.copyWith(
            color: colors.neutral600,
          ),
          prefixIcon: Icon(Icons.search, color: colors.neutral600, size: 22.sp),
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
            ),
          ),
          SizedBox(width: 10.w),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              final active = state.hasFilter;
              return GestureDetector(
                onTap: () => _showFilterSheet(context, state),
                child: Container(
                  width: 46.w,
                  height: 46.w,
                  decoration: BoxDecoration(
                    color: active ? Style.primary500 : colors.shade0,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: active ? Style.primary500 : colors.neutral200,
                      width: 0.8,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.tune_rounded,
                    color: active ? Colors.white : colors.neutral600,
                    size: 22.sp,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(
    BuildContext context,
    SearchState state,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 8.h),
      child: Row(
        children: [
          if (state.selectedProvinceName != null)
            _filterChip(
              label: state.selectedProvinceName!,
              icon: Icons.location_city_rounded,
              onRemove: () => sl<SearchBloc>().add(const SearchFilterEvent()),
              colors: colors,
            ),
          if (state.selectedDistrictName != null) ...[
            SizedBox(width: 8.w),
            _filterChip(
              label: state.selectedDistrictName!,
              icon: Icons.map_outlined,
              onRemove: () => sl<SearchBloc>().add(SearchFilterEvent(
                provinceId: state.selectedProvinceId,
                provinceName: state.selectedProvinceName,
              )),
              colors: colors,
            ),
          ],
        ],
      ),
    );
  }

  Widget _filterChip({
    required String label,
    required IconData icon,
    required VoidCallback onRemove,
    required CustomColorSet colors,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Style.primary500.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Style.primary500.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: Style.primary500),
          SizedBox(width: 5.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Style.primary500,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 5.w),
          GestureDetector(
            onTap: onRemove,
            child: Icon(Icons.close, size: 14.sp, color: Style.primary500),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context, SearchState state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: sl<SearchBloc>(),
        child: _SearchFilterSheet(
          initialProvinceId: state.selectedProvinceId,
          initialProvinceName: state.selectedProvinceName,
          initialDistrictId: state.selectedDistrictId,
          initialDistrictName: state.selectedDistrictName,
        ),
      ),
    );
  }

  Widget _buildEmptyState(CustomColorSet colors, FontSet fonts) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40.h),
          // Lottie Animation
          SizedBox(
            width: 250.w,
            height: 250.w,
            child: Lottie.asset(
              'assets/animations/search users.json',
              delegates: LottieDelegates(
                values: [
                  ValueDelegate.color(const [
                    '**',
                    'Stroke 1',
                    '**',
                  ], value: colors.primary500),
                  ValueDelegate.color(const [
                    '**',
                    'Search Icon',
                    '**',
                  ], value: colors.primary500),
                  ValueDelegate.color(const [
                    '**',
                    'Border',
                    '**',
                  ], value: colors.primary500),
                ],
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Title
          Text(
            "what_are_you_searching".tr(),
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
              "search_hint".tr(),
              textAlign: TextAlign.center,
              style: fonts.paragraphP3Regular.copyWith(
                color: colors.neutral500,
                height: 1.4,
              ),
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
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
                  Container(width: 60.w, height: 14.h, color: Colors.grey[400]),
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
          Icon(Icons.error_outline, size: 48.sp, color: colors.red500),
          SizedBox(height: 16.h),
          Text(
            message ?? "something_went_wrong".tr(),
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
          Icon(Icons.search_off, size: 48.sp, color: colors.neutral400),
          SizedBox(height: 16.h),
          Text(
            "no_results".tr(),
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
        final lang = context.locale.languageCode;
        String title;
        if (lang == 'ru') {
          title = item.titleRu ?? item.title ?? item.titleUz ?? "";
        } else if (lang == 'en') {
          title = item.titleEn ?? item.title ?? item.titleUz ?? "";
        } else {
          title = item.titleUz ?? item.title ?? "";
        }
        String category;
        if (lang == 'ru' || lang == 'en') {
          category = item.categoryName ?? item.categoryNameUz ?? "";
        } else {
          category = item.categoryNameUz ?? item.categoryName ?? "";
        }
        return ServiceProviderCard(
          onTap: () {
            _focusNode.unfocus();
            _isFirstOpen = false;
            Navigator.push(context, AppRoutes.detailsPage(item.id ?? ""));
          },
          name: title.isNotEmpty ? title : "unnamed_service".tr(),
          profession: category.isNotEmpty ? category : "specialist".tr(),
          distance: 0.0,
          rating: 5.0,
          reviewCount: 0,
          duration: "unknown".tr(),
          priceFrom: double.tryParse(item.basePrice ?? "0")?.toInt() ?? 0,
          isVerified: false,
          isAvailable: item.status == "active",
          mainImageUrl: item.primaryImageUrl,
          isFavorite: false,
          onFavorite: () {},
          provinceName: item.provinceName,
          isRemote: item.isRemote,
        );
      },
    );
  }
}

/// Viloyat va tuman bo'yicha filter bottom sheet
class _SearchFilterSheet extends StatefulWidget {
  final String? initialProvinceId;
  final String? initialProvinceName;
  final String? initialDistrictId;
  final String? initialDistrictName;

  const _SearchFilterSheet({
    this.initialProvinceId,
    this.initialProvinceName,
    this.initialDistrictId,
    this.initialDistrictName,
  });

  @override
  State<_SearchFilterSheet> createState() => _SearchFilterSheetState();
}

class _SearchFilterSheetState extends State<_SearchFilterSheet> {
  final ClientExpressRepo _repo = ClientExpressRepo();

  List<ExpressProvinceModel> _provinces = [];
  List<ExpressDistrictModel> _districts = [];
  bool _loadingProvinces = true;
  bool _loadingDistricts = false;

  String? _selectedProvinceId;
  String? _selectedProvinceName;
  String? _selectedDistrictId;
  String? _selectedDistrictName;

  @override
  void initState() {
    super.initState();
    _selectedProvinceId = widget.initialProvinceId;
    _selectedProvinceName = widget.initialProvinceName;
    _selectedDistrictId = widget.initialDistrictId;
    _selectedDistrictName = widget.initialDistrictName;
    _loadProvinces();
    if (_selectedProvinceId != null) _loadDistricts(_selectedProvinceId!);
  }

  // O'zbekiston region_id (barqaror — o'zgarmaydi)
  static const _uzbekistanRegionId = 'ca20ece0-c589-4cd7-8778-18ec0abfcc9f';

  Future<void> _loadProvinces() async {
    try {
      final res = await _repo.getProvinces(regionId: _uzbekistanRegionId);
      final body = res.data;
      if (body is Map && body['data'] is List) {
        final list = (body['data'] as List)
            .map((e) => ExpressProvinceModel.fromJson(e))
            .toList();
        if (mounted) setState(() { _provinces = list; _loadingProvinces = false; });
      }
    } catch (_) {
      if (mounted) setState(() => _loadingProvinces = false);
    }
  }

  Future<void> _loadDistricts(String provinceId) async {
    setState(() { _loadingDistricts = true; _districts = []; });
    try {
      final res = await _repo.getDistricts(provinceId: provinceId);
      final body = res.data;
      if (body is Map && body['data'] is List) {
        final list = (body['data'] as List)
            .map((e) => ExpressDistrictModel.fromJson(e))
            .toList();
        if (mounted) setState(() { _districts = list; _loadingDistricts = false; });
      }
    } catch (_) {
      if (mounted) setState(() => _loadingDistricts = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w, height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('filter'.tr(),
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  sl<SearchBloc>().add(const SearchFilterEvent());
                  Navigator.pop(context);
                },
                child: Text('clear'.tr(),
                    style: TextStyle(color: Colors.red, fontSize: 14.sp)),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text('province'.tr(),
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600,
                  color: const Color(0xFF555555))),
          SizedBox(height: 8.h),
          _loadingProvinces
              ? const Center(child: CircularProgressIndicator())
              : DropdownButtonFormField<String>(
                  value: _selectedProvinceId,
                  hint: Text('select_province'.tr()),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                  ),
                  items: _provinces.map((p) => DropdownMenuItem(
                    value: p.id,
                    child: Text(p.name(lang), overflow: TextOverflow.ellipsis),
                  )).toList(),
                  onChanged: (val) {
                    final prov = _provinces.firstWhere((p) => p.id == val);
                    setState(() {
                      _selectedProvinceId = val;
                      _selectedProvinceName = prov.name(lang);
                      _selectedDistrictId = null;
                      _selectedDistrictName = null;
                    });
                    if (val != null) _loadDistricts(val);
                  },
                ),
          SizedBox(height: 16.h),
          Text('district'.tr(),
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600,
                  color: const Color(0xFF555555))),
          SizedBox(height: 8.h),
          _loadingDistricts
              ? const Center(child: CircularProgressIndicator())
              : DropdownButtonFormField<String>(
                  value: _selectedDistrictId,
                  hint: Text(_selectedProvinceId == null
                      ? 'select_province_first'.tr()
                      : 'select_district'.tr()),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: _selectedProvinceId == null
                        ? const Color(0xFFEEEEEE)
                        : const Color(0xFFF5F5F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                  ),
                  items: _districts.map((d) => DropdownMenuItem(
                    value: d.id,
                    child: Text(d.name(lang), overflow: TextOverflow.ellipsis),
                  )).toList(),
                  onChanged: _selectedProvinceId == null ? null : (val) {
                    final dist = _districts.firstWhere((d) => d.id == val);
                    setState(() {
                      _selectedDistrictId = val;
                      _selectedDistrictName = dist.name(lang);
                    });
                  },
                ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                sl<SearchBloc>().add(SearchFilterEvent(
                  provinceId: _selectedProvinceId,
                  provinceName: _selectedProvinceName,
                  districtId: _selectedDistrictId,
                  districtName: _selectedDistrictName,
                ));
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Style.primary500,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r)),
                elevation: 0,
              ),
              child: Text('apply'.tr(),
                  style: TextStyle(color: Colors.white, fontSize: 15.sp,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}
