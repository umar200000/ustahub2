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
  double? _rating;
  String? _reviewText;

  @override
  void initState() {
    super.initState();
    context.read<BookingBloc>().add(
      GetBookingDetailsEvent(id: widget.bookingId),
    );
  }

  void _showReviewSheet(
    BuildContext context,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    double tempRating = 0;
    final TextEditingController reviewController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 20.h,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
              ),
              decoration: BoxDecoration(
                color: colors.shade0,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: colors.neutral300,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  Gap(24.h),
                  Text(
                    "leave_review".tr(), //"Fikr qoldiring"
                    style: fonts.paragraphP1Bold,
                  ),
                  Gap(16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        onPressed: () {
                          setModalState(() {
                            tempRating = index + 1.0;
                          });
                        },
                        icon: Icon(
                          index < tempRating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 36.sp,
                        ),
                      );
                    }),
                  ),
                  Gap(16.h),
                  TextField(
                    controller: reviewController,
                    maxLines: 4,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                      hintText: "write_your_opinion"
                          .tr(), //"Fikringizni yozing..."
                      hintStyle: fonts.paragraphP2Regular.copyWith(
                        color: colors.neutral500, // Hint rangini to'qroq qildim
                      ),
                      filled: true,
                      fillColor: colors.shade0, // Oq fon
                      contentPadding: EdgeInsets.all(16.w),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: colors.neutral500,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: colors.primary500,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  Gap(24.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: tempRating == 0
                          ? null
                          : () {
                              setState(() {
                                _rating = tempRating;
                                _reviewText = reviewController.text;
                              });
                              Navigator.pop(context);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary500,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        "send".tr(), //Yuborish
                        style: fonts.paragraphP2SemiBold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Gap(MediaQuery.of(context).padding.bottom),
                ],
              ),
            );
          },
        );
      },
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
                      backgroundColor: colors.primary500,
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
                      backgroundColor: colors.primary500,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          state.errorMessage ?? "error_occurred".tr(),
                        ),
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
                    backgroundColor: colors.primary500,
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

                          // Review Section (New)
                          if (data.status?.toLowerCase() == 'completed')
                            Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: _rating == null
                                  ? SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () => _showReviewSheet(
                                          context,
                                          colors,
                                          fonts,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: colors.primary500,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 12.h,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "leave_review".tr(), //Fikr qoldirish
                                          style: fonts.paragraphP2SemiBold
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  : _buildSectionCard(
                                      colors,
                                      title: "your_review"
                                          .tr(), //Sizning fikringiz
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: List.generate(5, (index) {
                                              return Icon(
                                                index < _rating!
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                color: Colors.amber,
                                                size: 20.sp,
                                              );
                                            }),
                                          ),
                                          if (_reviewText != null &&
                                              _reviewText!.isNotEmpty) ...[
                                            Gap(8.h),
                                            Text(
                                              _reviewText!,
                                              style: fonts.paragraphP2Regular
                                                  .copyWith(
                                                    color: colors.neutral700,
                                                  ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                            ),

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
                                  "${data.basePrice} ${"uzs".tr()}",
                                  fonts,
                                  colors,
                                ),
                                const Divider(),
                                _buildPriceRow(
                                  "total_price".tr(),
                                  "${data.totalPrice} ${"uzs".tr()}",
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
