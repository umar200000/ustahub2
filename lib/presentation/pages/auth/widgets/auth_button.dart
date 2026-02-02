import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
    required this.color,
    required this.textColor,
  });
  final String title;
  final Function() onTap;
  final IconData? icon;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: .only(bottom: 12.h),
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              if (icon != null) Icon(icon, color: textColor, size: 20),
              if (icon == null) SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w900, color: textColor),
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
