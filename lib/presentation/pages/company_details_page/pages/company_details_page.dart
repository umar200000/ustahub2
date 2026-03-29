import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ustahub/application2/company_bloc_and_data/bloc/company_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/pages/home/widgets/service_product_widget.dart'
    hide Gap;
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class CompanyDetailsPage extends StatefulWidget {
  final String providerId;

  const CompanyDetailsPage({super.key, required this.providerId});

  @override
  State<CompanyDetailsPage> createState() => _CompanyDetailsPageState();
}

class _CompanyDetailsPageState extends State<CompanyDetailsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<CompanyBloc>().add(
      GetProviderDetailsEvent(providerId: widget.providerId),
    );
    context.read<CompanyBloc>().add(
      GetProviderServicesEvent(providerId: widget.providerId),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<CompanyBloc>().add(
        GetProviderServicesEvent(
          providerId: widget.providerId,
          isFetchMore: true,
        ),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.neutral50,
          appBar: AppBar(
            backgroundColor: colors.shade0,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              "about_company".tr(),
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: BlocBuilder<CompanyBloc, CompanyState>(
            builder: (context, state) {
              if (state.status == Status2.loading &&
                  state.companyDetailsResponse == null) {
                return _buildPageShimmer(colors);
              }

              if (state.status == Status2.error &&
                  state.companyDetailsResponse == null) {
                return Center(child: Text(state.errorMessage ?? "error".tr()));
              }

              final data = state.companyDetailsResponse?.data;
              if (data == null) return const SizedBox.shrink();

              final services = state.servicesData?.servicesModel ?? [];
              final lang = context.locale.languageCode;

              return ListView(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                children: [
                  // Cover Image & Logo
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 180.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: colors.blue500.withValues(alpha: 0.1),
                          image: data.coverImageUrl != null
                              ? DecorationImage(
                                  image: NetworkImage(data.coverImageUrl!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: -40.h,
                        left: 20.w,
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: colors.shade0,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 45.r,
                            backgroundColor: colors.neutral200,
                            backgroundImage: data.logoUrl != null
                                ? NetworkImage(data.logoUrl!)
                                : null,
                            child: data.logoUrl == null
                                ? Icon(
                                    Icons.business,
                                    size: 40.sp,
                                    color: colors.neutral400,
                                  )
                                : null,
                          ),
                        ),
                      ),
                      if (data.isVerified ?? false)
                        Positioned(
                          bottom: -5.h,
                          left: 85.w,
                          child: Container(
                            padding: EdgeInsets.all(2.w),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.verified,
                              color: Colors.blue,
                              size: 24,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Gap(50.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.name ?? "unnamed".tr(),
                          style: GoogleFonts.poppins(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Gap(4.h),
                        Text(
                          "provider".tr(),
                          style: fonts.paragraphP2Regular.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                        Gap(20.h),

                        // Stats Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStatItem(
                              "services_label".tr(),
                              data.totalServices?.toString() ?? "0",
                              colors,
                              fonts,
                            ),
                            _buildStatItem(
                              "masters_label".tr(),
                              data.totalMasters?.toString() ?? "0",
                              colors,
                              fonts,
                            ),
                            _buildStatItem(
                              "rating_label".tr(),
                              data.rating?.toString() ?? "5",
                              colors,
                              fonts,
                            ),
                          ],
                        ),
                        Gap(24.h),

                        Text(
                          "about_company".tr(),
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Gap(8.h),
                        Text(
                          data.description ?? "no_description".tr(),
                          style: fonts.paragraphP2Regular.copyWith(
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                        Gap(24.h),

                        // // Contact Info
                        // _buildContactTile(
                        //   Icons.phone_outlined,
                        //   data.phone ?? "not_specified".tr(),
                        //   colors,
                        //   fonts,
                        // ),
                        // _buildContactTile(
                        //   Icons.email_outlined,
                        //   data.email ?? "not_specified".tr(),
                        //   colors,
                        //   fonts,
                        // ),
                        // if (data.website != null)
                        //   _buildContactTile(
                        //     Icons.language,
                        //     data.website!,
                        //     colors,
                        //     fonts,
                        //   ),
                        Gap(32.h),
                        Text(
                          "all_services".tr(),
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Gap(16.h),
                      ],
                    ),
                  ),

                  // Services List
                  if (services.isEmpty && state.status == Status2.success)
                    Center(child: Text("no_services_found".tr()))
                  else if (services.isEmpty && state.status == Status2.loading)
                    _buildServicesShimmer(colors)
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        final service = services[index];
                        String title;
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
                          title = service.titleUz ?? service.title ?? "";
                        }
                        String category;
                        if (lang == 'ru' || lang == 'en') {
                          category =
                              service.categoryName ??
                              service.categoryNameUz ??
                              "";
                        } else {
                          category =
                              service.categoryNameUz ??
                              service.categoryName ??
                              "";
                        }
                        return ServiceProviderCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              AppRoutes.detailsPage(service.id ?? ""),
                            );
                          },
                          name: title.isNotEmpty
                              ? title
                              : "unnamed_service".tr(),
                          profession: category.isNotEmpty
                              ? category
                              : "specialist".tr(),
                          distance: 0.0,
                          rating: 5.0,
                          reviewCount: 0,
                          duration: "unknown".tr(),
                          priceFrom:
                              int.tryParse(service.basePrice ?? "0") ?? 0,
                          isVerified: false,
                          isAvailable: service.status == "active",
                          mainImageUrl: service.primaryImageUrl,
                          isFavorite: false,
                          onFavorite: () {},
                          provinceName: service.provinceName,
                        );
                      },
                    ),

                  if (state.status == Status2.loading && services.isNotEmpty)
                    _buildServicesShimmer(colors),
                  Gap(40.h),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildPageShimmer(CustomColorSet colors) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(height: 180.h, color: Colors.white),
          Gap(60.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                Gap(8.h),
                Container(
                  width: 120.w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                Gap(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    3,
                    (_) => Container(
                      width: 100.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
                Gap(24.h),
                Container(
                  width: 180.w,
                  height: 18.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                Gap(8.h),
                ...List.generate(
                  3,
                  (_) => Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Container(
                      width: double.infinity,
                      height: 14.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesShimmer(CustomColorSet colors) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(
          2,
          (_) => Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            height: 280.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: colors.shade0,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.neutral200),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: colors.blue500,
            ),
          ),
          Text(
            label,
            style: fonts.paragraphP3Regular.copyWith(color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildContactTile(
    IconData icon,
    String value,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: colors.blue500.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: colors.blue500, size: 20.sp),
          ),
          Gap(12.w),
          Text(
            value,
            style: fonts.paragraphP2Regular.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
