import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application2/category_bloc_and_data/data/model/category_model.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/pages/home/widgets/icon_widget.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class ServicesGrid extends StatefulWidget {
  final List<CategoryModel> services;

  const ServicesGrid({super.key, required this.services});

  @override
  State<ServicesGrid> createState() => _ServicesGridState();
}

class _ServicesGridState extends State<ServicesGrid> {
  static const int _initialDisplayCount = 2;
  bool _isExpanded = false;

  List<CategoryModel> get _displayedServices {
    return _isExpanded
        ? widget.services
        : widget.services.take(_initialDisplayCount).toList();
  }

  bool get _hasMoreServices => widget.services.length > _initialDisplayCount;

  void _toggleExpansion() {
    setState(() => _isExpanded = !_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Column(
          children: [
            _buildServicesGrid(colors),
            if (_hasMoreServices) ...[
              _buildToggleButton(colors, fonts),
              8.h.verticalSpace,
            ],
          ],
        );
      },
    );
  }

  Widget _buildServicesGrid(dynamic colors) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 8.h,
            childAspectRatio: 1.5,
          ),
          itemCount: _displayedServices.length,
          itemBuilder: (context, index) {
            final service = _displayedServices[index];
            return ServiceCard(service: service);
          },
        ),
      ),
    );
  }

  Widget _buildToggleButton(dynamic colors, dynamic fonts) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: AnimationButtonEffect(
        onTap: _toggleExpansion,
        child: Container(
          height: 56.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: colors.shade0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isExpanded ? "Show less".tr() : "All services".tr(),
                style: fonts.paragraphP1Bold.copyWith(color: colors.neutral700),
              ),
              8.w.horizontalSpace,
              AnimatedRotation(
                turns: _isExpanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: colors.neutral700,
                  size: 24.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final CategoryModel service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    String title = service.nameUz ?? '';
    if (lang == 'ru') title = service.nameRu ?? service.nameUz ?? '';
    if (lang == 'en') title = service.nameEn ?? service.nameUz ?? '';

    return IconWidget(
      title: title,
      subtitle: "", // API da hozircha subtitle yo'q
      icon: service.iconUrl != null && service.iconUrl!.isNotEmpty
          ? Image.network(
              service.iconUrl!,
              width: 40.w,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.category, size: 40.w),
            )
          : Icon(Icons.category, size: 40.w),
    );
  }
}
