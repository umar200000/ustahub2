import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

Future<T?> showCBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  bool top = true,
  bool bottom = true,
  bool expand = false,
  bool changeNavBar = false,
  Color? backgroundColor,
  WidgetBuilder? builder,
}) async {
  context.read<BottomNavBarController>().changeNavBar(true);

  final expandSize = 1.sh - MediaQuery.of(context).padding.top;
  final paddingBottom = MediaQuery.of(context).padding.bottom;

  final areaSize = (top ? 22.h : 0) + (bottom ? paddingBottom + 4.h : 0);

  final T? result =
      await showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        constraints: BoxConstraints(maxHeight: expandSize, minHeight: .24.sh),
        builder: (BuildContext context) {
          return ThemeWrapper(
            builder: (context, colors, fonts, icons, controller) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.shade0,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (top) ...[
                      12.h.verticalSpace,
                      Center(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(56.r),
                            color: backgroundColor ?? colors.neutral400,
                          ),
                          child: SizedBox(height: 2.h, width: 32.w),
                        ),
                      ),
                      4.h.verticalSpace,
                    ],
                    SizedBox(
                      height: expand ? expandSize - (areaSize) : null,
                      child: Builder(
                        builder: (context) {
                          if (builder != null) {
                            return builder(context);
                          }
                          return child;
                        },
                      ),
                    ),
                    if (bottom) SafeArea(top: false, child: 4.h.verticalSpace),
                  ],
                ),
              );
            },
          );
        },
      ).then((value) {
        context.read<BottomNavBarController>().changeNavBar(changeNavBar);

        return value;
      });

  return result;
}
