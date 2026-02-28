import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ustahub/application2/banner_bloc_and_data/bloc/banner_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class BannerDetailsPage extends StatefulWidget {
  const BannerDetailsPage({super.key, required this.bannerId});
  final String bannerId;

  @override
  State<BannerDetailsPage> createState() => _BannerDetailsPageState();
}

class _BannerDetailsPageState extends State<BannerDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<BannerBloc>().add(GetBannerDetailsEvent(id: widget.bannerId));
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.shade0,
          body: BlocBuilder<BannerBloc, BannerState>(
            builder: (context, state) {
              final data = state.bannerDetailsModel?.data;

              // 1. Backenddan kelgan tayyor localized matnlarni olamiz
              String title = data?.title ?? "";
              String subtitle = data?.subtitle ?? "";
              String description = data?.description ?? "";

              // 2. Agar ular bo'sh bo'lsa, fallback (tilga qarab tanlash)
              if (title.isEmpty || subtitle.isEmpty || description.isEmpty) {
                final lang = context.locale.languageCode;
                if (lang == 'ru') {
                  if (title.isEmpty)
                    title = data?.titleRu ?? data?.titleUz ?? "";
                  if (subtitle.isEmpty)
                    subtitle = data?.subtitleRu ?? data?.subtitleUz ?? "";
                  if (description.isEmpty)
                    description =
                        data?.descriptionRu ?? data?.descriptionUz ?? "";
                } else if (lang == 'en') {
                  if (title.isEmpty)
                    title = data?.titleEn ?? data?.titleUz ?? "";
                  if (subtitle.isEmpty)
                    subtitle = data?.subtitleEn ?? data?.subtitleUz ?? "";
                  if (description.isEmpty)
                    description =
                        data?.descriptionEn ?? data?.descriptionUz ?? "";
                } else {
                  if (title.isEmpty) title = data?.titleUz ?? "";
                  if (subtitle.isEmpty) subtitle = data?.subtitleUz ?? "";
                  if (description.isEmpty)
                    description = data?.descriptionUz ?? "";
                }
              }

              return Stack(
                children: [
                  Builder(
                    builder: (context) {
                      if (state.detailsStatus == Status2.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state.detailsStatus == Status2.error) {
                        return Center(
                          child: Text(state.errorMessage ?? "error".tr()),
                        );
                      }
                      if (data == null) return const SizedBox();

                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(110.h),
                            // Banner Image
                            if (data.imageUrl != null)
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16.r),
                                  child: Image.network(
                                    data.imageUrl!,
                                    width: double.infinity,
                                    height: 220.h,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                              height: 220.h,
                                              color: colors.neutral200,
                                              child: const Icon(
                                                Icons.image_not_supported,
                                              ),
                                            ),
                                  ),
                                ),
                              ),

                            // Content
                            Padding(
                              padding: EdgeInsets.all(20.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title
                                  if (title.isNotEmpty)
                                    Text(
                                      title,
                                      style: GoogleFonts.poppins(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold,
                                        color: colors.shade100,
                                      ),
                                    ),
                                  if (subtitle.isNotEmpty) ...[
                                    Gap(8.h),
                                    Text(
                                      subtitle,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: colors.blue500,
                                      ),
                                    ),
                                  ],
                                  Gap(16.h),
                                  // Divider
                                  Divider(color: colors.neutral200),
                                  Gap(16.h),
                                  // Description
                                  if (description.isNotEmpty)
                                    Text(
                                      description,
                                      style: GoogleFonts.poppins(
                                        fontSize: 15.sp,
                                        color: colors.neutral700,
                                        height: 1.6,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  UniversalAppBar(
                    title: title.isNotEmpty ? title : "details".tr(),
                    centerTitle: true,
                    showBackButton: true,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
