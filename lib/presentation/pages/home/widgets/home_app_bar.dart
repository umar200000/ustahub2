import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ustahub/application2/register_bloc_and_data/bloc/register_bloc.dart';
import 'package:ustahub/infrastructure/services/notification_provider.dart';
import 'package:ustahub/presentation/pages/notification_page/notification_page.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import '../../../components/animation_effect.dart';

class HomeAppBar extends StatelessWidget {
  final bool showShadow;

  const HomeAppBar({super.key, this.showShadow = false});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: colors.shade0,
            boxShadow: showShadow
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  // User info section
                  Expanded(
                    child: BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {
                        final user = state.userProfile;
                        final firstName = user?.firstName ?? 'Guest';
                        final lastName = user?.lastName ?? 'User';

                        return Row(
                          children: [
                            // Profile avatar
                            Container(
                              width: 44.w,
                              height: 44.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors.blue500.withValues(alpha: 0.1),
                                border: Border.all(
                                  color: colors.blue500.withValues(alpha: 0.3),
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  firstName.isNotEmpty
                                      ? firstName[0].toUpperCase()
                                      : 'G',
                                  style: fonts.paragraphP1Bold.copyWith(
                                    color: colors.blue500,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            // Name and location
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '$firstName $lastName',
                                    style: fonts.paragraphP2Bold.copyWith(
                                      color: colors.shade100,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2.h),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 14.sp,
                                        color: colors.neutral500,
                                      ),
                                      SizedBox(width: 4.w),
                                      Expanded(
                                        child: Text(
                                          'Tashkent, Uzbekistan',
                                          style: fonts.paragraphP3Regular
                                              .copyWith(
                                                color: colors.neutral500,
                                              ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  // Action buttons
                  Row(
                    children: [
                      // AnimationButtonEffect(
                      //   onTap: () {
                      //     context.read<BottomNavBarController>().changeIndex(1);
                      //   },
                      //   child: Container(
                      //     width: 44.w,
                      //     height: 44.w,
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       color: colors.neutral100,
                      //     ),
                      //     child: Center(
                      //       child: Icon(
                      //         Icons.search,
                      //         color: colors.shade100,
                      //         size: 22.sp,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(width: 8.w),
                      Consumer<NotificationProvider>(
                        builder: (context, provider, _) {
                          return AnimationButtonEffect(
                            onTap: () {
                              provider.markAllAsRead();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationPage(),
                                ),
                              );
                            },
                            child: SizedBox(
                              width: 44.w,
                              height: 44.w,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 44.w,
                                    height: 44.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colors.neutral100,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.notifications_none_outlined,
                                        color: colors.shade100,
                                        size: 24.sp,
                                      ),
                                    ),
                                  ),
                                  if (provider.unreadCount > 0)
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        padding: EdgeInsets.all(4.r),
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        constraints: BoxConstraints(
                                          minWidth: 18.w,
                                          minHeight: 18.w,
                                        ),
                                        child: Center(
                                          child: Text(
                                            provider.unreadCount > 9
                                                ? '9+'
                                                : '${provider.unreadCount}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
