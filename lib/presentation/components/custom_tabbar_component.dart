import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

/// black tab bar
class CustomTabbarBlack extends StatefulWidget {
  const CustomTabbarBlack({
    super.key,
    required this.leftTab,
    required this.rightTab,
    required this.middleTab,
    required this.index,
  });

  final String leftTab;
  final String rightTab;
  final String middleTab;
  final int index;

  @override
  State<CustomTabbarBlack> createState() => _CustomTabbarBlackState();
}

class _CustomTabbarBlackState extends State<CustomTabbarBlack> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Container(
          height: 50.h,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: const EdgeInsets.all(5),
          decoration: ShapeDecoration(
            color: colors.neutral100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          child: TabBar(
            indicatorPadding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            dividerColor: colors.transparent,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            padding: EdgeInsets.zero,
            indicatorColor: colors.transparent,
            tabs: [
              Tab(
                child: Container(
                  width: double.infinity,
                  decoration: _selectedIndex == 0
                      ? ShapeDecoration(
                          color: colors.neutral800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        )
                      : null,
                  child: Center(
                    child: Text(
                      semanticsLabel: widget.leftTab,
                      widget.leftTab,
                      textAlign: TextAlign.center,
                      style: fonts.headingH6Medium.copyWith(
                        fontSize: 12.sp,
                        color: _selectedIndex == 0
                            ? colors.shade0
                            : colors.neutral800,
                      ),
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  width: double.infinity,
                  decoration: _selectedIndex == 1
                      ? ShapeDecoration(
                          color: colors.neutral800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        )
                      : null,
                  child: Center(
                    child: Text(
                      widget.middleTab,
                      textAlign: TextAlign.center,
                      style: fonts.headingH6Medium.copyWith(
                        fontSize: 12.sp,
                        color: _selectedIndex == 1
                            ? colors.shade0
                            : colors.neutral800,
                      ),
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  decoration: _selectedIndex == 2
                      ? ShapeDecoration(
                          color: colors.neutral800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        )
                      : null,
                  child: Center(
                    child: Text(
                      widget.rightTab,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: fonts.headingH6Medium.copyWith(
                        fontSize: 12.sp,
                        color: _selectedIndex == 2
                            ? colors.shade0
                            : colors.neutral800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
