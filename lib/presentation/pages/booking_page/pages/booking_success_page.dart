import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ustahub/presentation/pages/main/main_page.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class BookingSuccessPage extends StatelessWidget {
  const BookingSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.shade0,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  // Success Image
                  Image.asset(
                    'assets/images/success.png',
                    width: 200.w,
                    height: 200.w,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.check_circle,
                      size: 150.sp,
                      color: colors.blue500,
                    ),
                  ),
                  Gap(32.h),
                  // Success Message
                  Text(
                    "success".tr(),
                    style: GoogleFonts.poppins(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: colors.shade100,
                    ),
                  ),
                  Gap(12.h),
                  Text(
                    "booking_success_msg".tr(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: colors.neutral600,
                      height: 1.5,
                    ),
                  ),
                  const Spacer(),
                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainPage(index: 2),
                          ),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.blue500,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "view_orders".tr(),
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Gap(16.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
