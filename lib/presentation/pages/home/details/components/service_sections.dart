import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class ServiceHeaderSection extends StatelessWidget {
  final String name;
  final String profession;
  final int yearsExperience;
  final bool isVerified;

  const ServiceHeaderSection({
    super.key,
    required this.name,
    required this.profession,
    required this.yearsExperience,
    required this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$profession, $yearsExperience years experience',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
          ),
          8.h.verticalSpace,
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isVerified)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.verified, color: Colors.blue, size: 14.r),
                      4.w.horizontalSpace,
                      Text(
                        'Verified',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class ServicePriceSection extends StatelessWidget {
  final int priceFrom;

  const ServicePriceSection({super.key, required this.priceFrom});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$$priceFrom',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                4.h.verticalSpace,
                Text(
                  'Starting price',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              'UstaHub Estimate',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceCharacteristics extends StatefulWidget {
  final int yearsExperience;
  final int completedJobs;
  final double distance;
  final String duration;

  const ServiceCharacteristics({
    super.key,
    required this.yearsExperience,
    required this.completedJobs,
    required this.distance,
    required this.duration,
  });

  @override
  State<ServiceCharacteristics> createState() => _ServiceCharacteristicsState();
}

class _ServiceCharacteristicsState extends State<ServiceCharacteristics> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() => _isExpanded = !_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: colors.neutral200),
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Characteristics',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              20.h.verticalSpace,
              _CharacteristicRow(
                label: 'Experience',
                value: '${widget.yearsExperience} years',
              ),
              _CharacteristicRow(
                label: 'Completed Jobs',
                value: '${widget.completedJobs}',
              ),
              _CharacteristicRow(
                label: 'Distance',
                value: '${widget.distance} km',
              ),
              _CharacteristicRow(
                label: 'Response Time',
                value: widget.duration,
              ),
              if (_isExpanded) ...[
                _CharacteristicRow(label: 'Languages', value: 'English, Uzbek'),
                _CharacteristicRow(
                  label: 'Service Area',
                  value: 'Tashkent City',
                ),
                _CharacteristicRow(
                  label: 'Working Hours',
                  value: '8:00 - 20:00',
                ),
              ],
              20.h.verticalSpace,
              GestureDetector(
                onTap: _toggleExpanded,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isExpanded ? 'Show less' : 'View more',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      8.w.horizontalSpace,
                      AnimatedRotation(
                        turns: _isExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black87,
                          size: 20.r,
                        ),
                      ),
                    ],
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

class _CharacteristicRow extends StatelessWidget {
  final String label;
  final String value;

  const _CharacteristicRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.grey[500],
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
