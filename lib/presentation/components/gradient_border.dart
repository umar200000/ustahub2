import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientBorder extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double borderWidth;
  final double? borderRadius;
  final Color? backgroundColor;

  const GradientBorder({
    super.key,
    required this.child,
    required this.gradient,
    this.borderWidth = 2.0,
    this.borderRadius,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient, // Gradient for the border
        borderRadius:
            borderRadius != null ? BorderRadius.circular(borderRadius!) : null,
      ),
      child: Container(
        margin: EdgeInsets.all(borderWidth),
        decoration: BoxDecoration(
          color: backgroundColor, // Inner background color
          borderRadius: borderRadius != null
              ? BorderRadius.circular(borderRadius! - 2.r)
              : null,
        ),
        child: child,
      ),
    );
  }
}
