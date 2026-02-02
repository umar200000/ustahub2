import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/components/c_app_bar.dart';
import 'package:ustahub/presentation/components/custom_text_field_with_icon.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;

  final List<String> _popularSearches = [
    'Plumber',
    'Electrician',
    'Cleaner',
    'Painter',
    'Carpenter',
  ];

  final List<String> _recentSearches = [
    'Furniture Assembly',
    'AC Repair',
    'Home Cleaning',
  ];

  final List<Map<String, dynamic>> _categories = [
    {
      'name': 'Home Services',
      'icon': Icons.home_repair_service_outlined,
      'count': '120+',
    },
    {
      'name': 'Cleaning',
      'icon': Icons.cleaning_services_outlined,
      'count': '85+',
    },
    {'name': 'Repair', 'icon': Icons.build_outlined, 'count': '95+'},
    {'name': 'Installation', 'icon': Icons.settings_outlined, 'count': '60+'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
      _isSearching = value.isNotEmpty;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
      _isSearching = false;
    });
  }

  void _performSearch(String query) {
    debugPrint('Searching for: $query');
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          body: Column(
            children: [
              UniversalAppBar(
                backgroundColor: const Color(0xFF1A1A1A),
                showBackButton: false,
                showShadow: false,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                verticalSpacing: 12,
                title: "profile".tr(),
                centerTitle: true,
                bottom: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomTextFieldWithIcon(
                    controller: _searchController,
                    icons: icons.searchO,
                    colors: colors,
                    hintText: 'Search for services...',
                    autoFocus: false,
                    onChanged: _onSearchChanged,
                    hasSuffixIcon: _isSearching,
                    onTap: _isSearching ? _clearSearch : null,
                  ),
                ),
              ),

              Expanded(
                child: _isSearching
                    ? _buildSearchResults(colors, fonts)
                    : _buildSearchSuggestions(colors, fonts, icons),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchSuggestions(
    CustomColorSet colors,
    FontSet fonts,
    IconSet icons,
  ) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      children: [
        if (_popularSearches.isNotEmpty) ...[
          Text('Popular Searches', style: fonts.headingH6Bold),
          12.h.verticalSpace,
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _popularSearches.map((search) {
              return AnimationButtonEffect(
                onTap: () {
                  _searchController.text = search;
                  _performSearch(search);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: colors.shade0,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: colors.neutral200, width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.trending_up,
                        size: 16.r,
                        color: colors.blue500,
                      ),
                      6.w.horizontalSpace,
                      Text(
                        search,
                        style: fonts.paragraphP3Medium.copyWith(
                          color: colors.shade100,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          24.h.verticalSpace,
        ],

        // Recent Searches
        if (_recentSearches.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent', style: fonts.headingH6Bold),
              TextButton(
                onPressed: () {
                  setState(() {
                    _recentSearches.clear();
                  });
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Clear all',
                  style: fonts.paragraphP3Regular.copyWith(
                    color: colors.neutral600,
                  ),
                ),
              ),
            ],
          ),
          12.h.verticalSpace,
          ..._recentSearches.map((search) {
            return AnimationButtonEffect(
              onTap: () {
                _searchController.text = search;
                _performSearch(search);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: colors.shade0,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.history, size: 20.r, color: colors.neutral600),
                    12.w.horizontalSpace,
                    Expanded(
                      child: Text(search, style: fonts.paragraphP2Regular),
                    ),
                    Icon(
                      Icons.north_west,
                      size: 16.r,
                      color: colors.neutral500,
                    ),
                  ],
                ),
              ),
            );
          }),
          24.h.verticalSpace,
        ],

        Text('Categories', style: fonts.headingH6Bold),
        12.h.verticalSpace,
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 1.2,
          ),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final category = _categories[index];
            return AnimationButtonEffect(
              onTap: () {
                _searchController.text = category['name'];
                _performSearch(category['name']);
              },
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: colors.shade0,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: colors.neutral200, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: colors.blue500.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        category['icon'] as IconData,
                        size: 24.r,
                        color: colors.blue500,
                      ),
                    ),
                    8.h.verticalSpace,
                    Text(
                      category['name'] as String,
                      style: fonts.paragraphP2SemiBold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    4.h.verticalSpace,
                    Text(
                      category['count'] as String,
                      style: fonts.paragraphP3Regular.copyWith(
                        color: colors.neutral600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        60.h.verticalSpace,
      ],
    );
  }

  Widget _buildSearchResults(CustomColorSet colors, FontSet fonts) {
    final results = [
      {
        'name': 'Furniture Assembly',
        'category': 'Installation',
        'providers': 15,
        'rating': 4.8,
      },
      {
        'name': 'AC Repair Service',
        'category': 'Repair',
        'providers': 23,
        'rating': 4.7,
      },
      {
        'name': 'Home Deep Cleaning',
        'category': 'Cleaning',
        'providers': 18,
        'rating': 4.9,
      },
    ];

    final filteredResults = results.where((result) {
      return result['name'].toString().toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
    }).toList();

    if (filteredResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64.r, color: colors.neutral300),
            16.h.verticalSpace,
            Text(
              'No results found',
              style: fonts.headingH6Bold.copyWith(color: colors.neutral600),
            ),
            8.h.verticalSpace,
            Text(
              'Try searching with different keywords',
              style: fonts.paragraphP3Regular.copyWith(
                color: colors.neutral500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: EdgeInsets.all(16.w),
      children: [
        Text(
          '${filteredResults.length} results found',
          style: fonts.paragraphP2SemiBold.copyWith(color: colors.neutral600),
        ),
        16.h.verticalSpace,
        ...filteredResults.map((result) {
          return AnimationButtonEffect(
            onTap: () {
              // Navigate to service detail
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: colors.shade0,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: colors.neutral200, width: 1),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48.r,
                    height: 48.r,
                    decoration: BoxDecoration(
                      color: colors.blue500.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.home_repair_service_outlined,
                      color: colors.blue500,
                      size: 24.r,
                    ),
                  ),
                  12.w.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          result['name'] as String,
                          style: fonts.paragraphP2SemiBold,
                        ),
                        4.h.verticalSpace,
                        Row(
                          children: [
                            Icon(Icons.star, size: 14.r, color: Colors.black87),
                            4.w.horizontalSpace,
                            Text(
                              '${result['rating']}',
                              style: fonts.paragraphP3Regular,
                            ),
                            8.w.horizontalSpace,
                            Text(
                              '•',
                              style: fonts.paragraphP3Regular.copyWith(
                                color: colors.neutral500,
                              ),
                            ),
                            8.w.horizontalSpace,
                            Text(
                              '${result['providers']} providers',
                              style: fonts.paragraphP3Regular.copyWith(
                                color: colors.neutral600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16.r,
                    color: colors.neutral400,
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
