import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.shade0,
          body: Column(
            children: [
              UniversalAppBar(
                title: "notifications".tr(),
                showBackButton: true,
                centerTitle: true,
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(16.r).copyWith(
                    bottom: MediaQuery.of(context).padding.bottom + 16,
                  ),
                  itemCount: 10, // Mock data count
                  separatorBuilder: (context, index) => Gap(12.h),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: colors.shade0,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: colors.neutral200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Notification Icon/Image
                          Container(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              color: colors.blue500.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.notifications_active_outlined,
                              color: colors.blue500,
                              size: 24.sp,
                            ),
                          ),
                          Gap(12.w),
                          // Text Content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Xizmat tasdiqlandi",
                                        style: fonts.paragraphP2Bold.copyWith(
                                          color: colors.shade100,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "12:45",
                                      style: fonts.paragraphP3Regular.copyWith(
                                        color: colors.neutral400,
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(4.h),
                                Text(
                                  "Sizning 'Santexnika' xizmati bo'yicha buyurtmangiz usta tomonidan qabul qilindi.",
                                  style: fonts.paragraphP3Regular.copyWith(
                                    color: colors.neutral600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
