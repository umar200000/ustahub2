import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceDiagnostics extends StatelessWidget {
  const ServiceDiagnostics({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'UstaHub Verification',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
          ),
          12.h.verticalSpace,
          _DiagnosticItem(
            icon: Icons.check_circle,
            text: 'Background verified',
          ),
          _DiagnosticItem(icon: Icons.visibility, text: 'Skills assessment'),
          _DiagnosticItem(icon: Icons.tune, text: 'Equipment check'),
          _DiagnosticItem(icon: Icons.star, text: 'Customer ratings'),
        ],
      ),
    );
  }
}

class _DiagnosticItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _DiagnosticItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 20.r),
          12.w.horizontalSpace,
          Text(text, style: TextStyle(fontSize: 14.sp)),
        ],
      ),
    );
  }
}
