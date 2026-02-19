import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ustahub/application2/booking_bloc_and_data/bloc/booking_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/pages/booking_page/pages/booking_success_page.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import '../../../../application2/details_service/data/model/details_model.dart';
import 'map_selection_page.dart';

class BookingPage extends StatefulWidget {
  final ServiceData service;

  const BookingPage({super.key, required this.service});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  double? selectedLat;
  double? selectedLng;

  void _showCupertinoDatePicker(BuildContext context, CustomColorSet colors) {
    DateTime dateTime = selectedDate ?? DateTime.now();
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 350.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "select_date".tr(),
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text(
                      'ready'.tr(),
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: colors.blue500,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedDate = dateTime;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: selectedDate ?? DateTime.now(),
                minimumDate: DateTime.now().subtract(
                  const Duration(minutes: 1),
                ),
                onDateTimeChanged: (DateTime newDate) {
                  dateTime = newDate;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCupertinoTimePicker(BuildContext context, CustomColorSet colors) {
    TimeOfDay timeOfDay = selectedTime ?? TimeOfDay.now();
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 350.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "select_time".tr(),
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text(
                      'ready'.tr(),
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: colors.blue500,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedTime = timeOfDay;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                use24hFormat: true,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime newTime) {
                  timeOfDay = TimeOfDay.fromDateTime(newTime);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocListener<BookingBloc, BookingState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == Status2.success) {
              context.read<BookingBloc>().add(
                const GetBookingsListEvent(isRefresh: true),
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookingSuccessPage(),
                ),
              );
            } else if (state.status == Status2.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage ?? "something_went_wrong".tr(),
                  ),
                  backgroundColor: colors.red500,
                ),
              );
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "booking".tr(),
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: colors.blue500.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: colors.blue500.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.service.titleUz ?? "Xizmat nomi",
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Gap(4.h),
                              Text(
                                "${widget.service.basePrice ?? '0'} ${widget.service.currencySymbol ?? 'som'}",
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  color: colors.blue500,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (widget.service.images != null &&
                            widget.service.images!.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              widget.service.images![0].imageUrl ?? '',
                              width: 60.w,
                              height: 60.w,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Gap(24.h),

                  Text(
                    "select_date".tr(),
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gap(8.h),
                  InkWell(
                    onTap: () => _showCupertinoDatePicker(context, colors),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, color: colors.blue500),
                          Gap(12.w),
                          Text(
                            selectedDate == null
                                ? "date_not_selected".tr()
                                : DateFormat(
                                    'yyyy-MM-dd',
                                  ).format(selectedDate!),
                            style: GoogleFonts.poppins(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(20.h),

                  Text(
                    "select_time".tr(),
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gap(8.h),
                  InkWell(
                    onTap: () => _showCupertinoTimePicker(context, colors),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.access_time, color: colors.blue500),
                          Gap(12.w),
                          Text(
                            selectedTime == null
                                ? "time_not_selected".tr()
                                : selectedTime!.format(context),
                            style: GoogleFonts.poppins(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(20.h),

                  Text(
                    "select_address".tr(),
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gap(8.h),
                  TextField(
                    controller: _addressController,
                    readOnly: true,
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MapSelectionPage(),
                        ),
                      );
                      if (result != null) {
                        setState(() {
                          _addressController.text = result['address'];
                          selectedLat = result['lat'];
                          selectedLng = result['lng'];
                        });
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "tap_to_select_from_map".tr(),
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: colors.blue500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  Gap(20.h),

                  Text(
                    "leave_a_comment".tr(),
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gap(8.h),
                  TextField(
                    controller: _commentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "additional_info_hint".tr(),
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  Gap(40.h),

                  BlocBuilder<BookingBloc, BookingState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: state.status == Status2.loading
                              ? null
                              : () {
                                  if (selectedDate == null ||
                                      selectedTime == null ||
                                      _addressController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("fill_all_fields".tr()),
                                      ),
                                    );
                                    return;
                                  }

                                  final timeStr =
                                      "${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}:00";

                                  context.read<BookingBloc>().add(
                                    CreateBookingEvent(
                                      serviceId: widget.service.id ?? "",
                                      latitude: selectedLat?.toInt() ?? 0,
                                      longitude: selectedLng?.toInt() ?? 0,
                                      scheduledDate: DateFormat(
                                        'yyyy-MM-dd',
                                      ).format(selectedDate!),
                                      scheduledTimeStart: timeStr,
                                      address: _addressController.text,
                                      userComment:
                                          _commentController.text.isEmpty
                                          ? "-"
                                          : _commentController.text,
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.blue500,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: state.status == Status2.loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "confirm".tr(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
