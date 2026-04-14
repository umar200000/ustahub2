import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ustahub/application2/banner_bloc_and_data/bloc/banner_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/components/shimmer_widgets.dart';
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
              if (state.detailsStatus == Status2.loading) {
                return const BannerDetailsShimmer();
              }
              if (state.detailsStatus == Status2.error) {
                return Center(child: Text(state.errorMessage ?? "error".tr()));
              }

              final data = state.bannerDetailsModel?.data;
              if (data == null) return const SizedBox();

              // Localized matnlarni olish
              String title = data.title ?? "";
              String subtitle = data.subtitle ?? "";
              String description = data.description ?? "";

              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Modern Silver App Bar
                  SliverAppBar(
                    expandedHeight: 300.h,
                    pinned: true,
                    stretch: true,
                    backgroundColor: colors.primary500,
                    leadingWidth: 70.w,
                    leading: Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Center(
                        child: Container(
                          height: 36.w,
                          width: 36.w,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: const [
                        StretchMode.zoomBackground,
                        StretchMode.blurBackground,
                      ],
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          if (data.imageUrl != null)
                            Image.network(
                              data.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: colors.neutral200,
                                    child: const Icon(
                                      Icons.image_not_supported,
                                    ),
                                  ),
                            ),
                          // Gradient Overlay
                          const DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black45],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Content
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors.shade0,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.r),
                        ),
                      ),
                      transform: Matrix4.translationValues(0, -24.r, 0),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(24.w, 52.h, 24.w, 24.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badge or Label
                            if (subtitle.isNotEmpty)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: colors.blue500.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  subtitle.toUpperCase(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: colors.blue500,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            Gap(16.h),

                            // Title
                            if (title.isNotEmpty)
                              Text(
                                title,
                                style: GoogleFonts.poppins(
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.bold,
                                  color: colors.neutral800,
                                  height: 1.2,
                                ),
                              ),

                            Gap(24.h),
                            Divider(color: colors.neutral100, thickness: 1),
                            Gap(24.h),

                            // Description Section
                            Row(
                              children: [
                                Container(
                                  width: 4.w,
                                  height: 24.h,
                                  decoration: BoxDecoration(
                                    color: colors.blue500,
                                    borderRadius: BorderRadius.circular(2.r),
                                  ),
                                ),
                                Gap(12.w),
                                Text(
                                  "description".tr(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: colors.neutral800,
                                  ),
                                ),
                              ],
                            ),
                            Gap(16.h),

                            if (description.isNotEmpty)
                              Text(
                                description,
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  color: colors.neutral600,
                                  height: 1.7,
                                  letterSpacing: 0.2,
                                ),
                              ),

                            Gap(100.h), // Bottom spacing
                          ],
                        ),
                      ),
                    ),
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
