import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/cached_image_component.dart';

class ServiceImageCarousel extends StatefulWidget {
  final List<String> images;

  const ServiceImageCarousel({super.key, required this.images});

  @override
  State<ServiceImageCarousel> createState() => _ServiceImageCarouselState();
}

class _ServiceImageCarouselState extends State<ServiceImageCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return CachedImageComponent(
                imageUrl: widget.images[index],
                width: double.infinity,
                height: 300.h,
                fit: BoxFit.cover,
              );
            },
          ),
          if (widget.images.length > 1) _buildPageIndicators(),
        ],
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Positioned(
      bottom: 12.h,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.images.length,
          (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            width: _currentIndex == index ? 24.w : 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: _currentIndex == index
                  ? Colors.white
                  : Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ),
      ),
    );
  }
}
