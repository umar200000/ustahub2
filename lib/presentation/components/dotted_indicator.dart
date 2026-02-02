import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/styles/theme.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({this.isActive = false, required this.colors, super.key});

  final bool isActive;
  final CustomColorSet colors;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 6.h,
        width: 6.w,
        decoration: BoxDecoration(
          color: isActive ? colors.shade0 : colors.neutral400,
          border: isActive ? null : Border.all(color: colors.neutral400),
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
      ),
    );
  }
}
