import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ustahub/infrastructure/services/notification_provider.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Hozir';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min oldin';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} soat oldin';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} kun oldin';
    } else {
      return '${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year}';
    }
  }

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
                actions: [
                  Consumer<NotificationProvider>(
                    builder: (context, provider, _) {
                      if (provider.notifications.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return IconButton(
                        onPressed: () {
                          provider.clearAll();
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          color: colors.neutral500,
                          size: 22.sp,
                        ),
                      );
                    },
                  ),
                ],
              ),
              Expanded(
                child: Consumer<NotificationProvider>(
                  builder: (context, provider, _) {
                    final notifications = provider.notifications;

                    if (notifications.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_off_outlined,
                              size: 64.sp,
                              color: colors.neutral300,
                            ),
                            Gap(16.h),
                            Text(
                              'Hozircha habarlar yo\'q',
                              style: fonts.paragraphP2Bold.copyWith(
                                color: colors.neutral400,
                              ),
                            ),
                            Gap(8.h),
                            Text(
                              'Firebase dan notification yuboring',
                              style: fonts.paragraphP3Regular.copyWith(
                                color: colors.neutral400,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: EdgeInsets.all(16.r).copyWith(
                        bottom:
                            MediaQuery.of(context).padding.bottom + 16,
                      ),
                      itemCount: notifications.length,
                      separatorBuilder: (context, index) => Gap(12.h),
                      itemBuilder: (context, index) {
                        final item = notifications[index];
                        return Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: colors.shade0,
                            borderRadius: BorderRadius.circular(16.r),
                            border:
                                Border.all(color: colors.neutral200),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 48.w,
                                height: 48.w,
                                decoration: BoxDecoration(
                                  color: colors.blue500
                                      .withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons
                                      .notifications_active_outlined,
                                  color: colors.blue500,
                                  size: 24.sp,
                                ),
                              ),
                              Gap(12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.title,
                                            style: fonts
                                                .paragraphP2Bold
                                                .copyWith(
                                              color: colors.shade100,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          _formatTime(
                                              item.receivedAt),
                                          style: fonts
                                              .paragraphP3Regular
                                              .copyWith(
                                            color: colors.neutral400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gap(4.h),
                                    Text(
                                      item.body,
                                      style: fonts
                                          .paragraphP3Regular
                                          .copyWith(
                                        color: colors.neutral600,
                                      ),
                                      maxLines: 3,
                                      overflow:
                                          TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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
