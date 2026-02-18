import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ustahub/application2/booking_bloc_and_data/bloc/booking_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key, required this.bookingId});
  final String bookingId;

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
    context.read<BookingBloc>().add(
      GetBookingDetailsEvent(id: widget.bookingId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.neutral100,
          body: BlocBuilder<BookingBloc, BookingState>(
            builder: (context, state) {
              if (state.detailsStatus == Status2.loading) {
                return Column(
                  children: [
                    UniversalAppBar(
                      title: "order_details".tr(),
                      centerTitle: true,
                      showBackButton: true,
                      backgroundColor: const Color(0xFF1A1A1A),
                    ),
                    const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff02BDC6),
                        ),
                      ),
                    ),
                  ],
                );
              }

              if (state.detailsStatus == Status2.error) {
                return Column(
                  children: [
                    UniversalAppBar(
                      title: "order_details".tr(),
                      centerTitle: true,
                      showBackButton: true,
                      backgroundColor: const Color(0xFF1A1A1A),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(state.errorMessage ?? "Xatolik yuz berdi"),
                      ),
                    ),
                  ],
                );
              }

              final data = state.bookingModel?.data;
              if (data == null) return const SizedBox();

              return Column(
                children: [
                  UniversalAppBar(
                    title: "order_details".tr(),
                    centerTitle: true,
                    showBackButton: true,
                    backgroundColor: const Color(0xFF1A1A1A),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Status Card
                          _buildSectionCard(
                            colors,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "status".tr(),
                                      style: fonts.paragraphP3Regular.copyWith(
                                        color: colors.neutral500,
                                      ),
                                    ),
                                    Gap(4.h),
                                    Text(
                                      data.status?.toUpperCase() ?? "",
                                      style: fonts.paragraphP1Bold.copyWith(
                                        color: _getStatusColor(
                                          data.status,
                                          colors,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "booking_number".tr(),
                                      style: fonts.paragraphP3Regular.copyWith(
                                        color: colors.neutral500,
                                      ),
                                    ),
                                    Gap(4.h),
                                    Text(
                                      "#${data.bookingNumber}",
                                      style: fonts.paragraphP1Bold,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Gap(16.h),

                          // Service Info
                          _buildSectionCard(
                            colors,
                            title: "service_info".tr(),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Image.network(
                                    data.providerLogo ?? "",
                                    width: 60.w,
                                    height: 60.w,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Icon(Icons.business, size: 40.sp),
                                  ),
                                ),
                                Gap(12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.serviceTitle ?? "",
                                        style: fonts.paragraphP1Bold,
                                      ),
                                      Gap(4.h),
                                      Text(
                                        data.providerName ?? "",
                                        style: fonts.paragraphP3Regular
                                            .copyWith(color: colors.neutral600),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(16.h),

                          // Schedule Info
                          _buildSectionCard(
                            colors,
                            title: "schedule_info".tr(),
                            child: Column(
                              children: [
                                _buildInfoRow(
                                  Icons.calendar_today_outlined,
                                  "date".tr(),
                                  data.scheduledDate ?? "",
                                  colors,
                                  fonts,
                                ),
                                Gap(12.h),
                                _buildInfoRow(
                                  Icons.access_time,
                                  "time".tr(),
                                  data.scheduledTimeStart
                                          ?.split(':')
                                          .take(2)
                                          .join(':') ??
                                      "",
                                  colors,
                                  fonts,
                                ),
                                Gap(12.h),
                                _buildInfoRow(
                                  Icons.location_on_outlined,
                                  "address".tr(),
                                  "Tashkent city",
                                  colors,
                                  fonts,
                                ),
                              ],
                            ),
                          ),
                          Gap(16.h),

                          // Price Info
                          _buildSectionCard(
                            colors,
                            title: "payment_details".tr(),
                            child: Column(
                              children: [
                                _buildPriceRow(
                                  "service_fee".tr(),
                                  "${data.basePrice} UZS",
                                  fonts,
                                  colors,
                                ),
                                const Divider(),
                                _buildPriceRow(
                                  "total_price".tr(),
                                  "${data.totalPrice} UZS",
                                  fonts,
                                  colors,
                                  isTotal: true,
                                ),
                              ],
                            ),
                          ),
                          Gap(16.h),

                          // User Comment
                          if (data.userComment != null &&
                              data.userComment != "-")
                            _buildSectionCard(
                              colors,
                              title: "your_comment".tr(),
                              child: Text(
                                data.userComment!,
                                style: fonts.paragraphP2Regular.copyWith(
                                  color: colors.neutral700,
                                ),
                              ),
                            ),
                          Gap(100.h),
                        ],
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

  Widget _buildSectionCard(
    CustomColorSet colors, {
    String? title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.shade0,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: colors.neutral800,
              ),
            ),
            Gap(12.h),
          ],
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: colors.blue500),
        Gap(12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: fonts.paragraphP3Regular.copyWith(
                color: colors.neutral500,
              ),
            ),
            Text(value, style: fonts.paragraphP2SemiBold),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceRow(
    String label,
    String value,
    FontSet fonts,
    CustomColorSet colors, {
    bool isTotal = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? fonts.paragraphP1Bold
                : fonts.paragraphP2Regular.copyWith(color: colors.neutral600),
          ),
          Text(
            value,
            style: isTotal
                ? fonts.paragraphP1Bold.copyWith(color: colors.blue500)
                : fonts.paragraphP2SemiBold,
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status, CustomColorSet colors) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
      case 'started':
        return colors.blue500;
      case 'completed':
        return Colors.green;
      case 'canceled':
        return colors.red500;
      default:
        return colors.neutral500;
    }
  }
}
