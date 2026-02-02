import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/pages/home/details/components/service_detail_appbar.dart';
import 'package:ustahub/presentation/pages/home/details/components/service_diagnostics.dart';
import 'package:ustahub/presentation/pages/home/details/components/service_image_carousel.dart';
import 'package:ustahub/presentation/pages/home/details/components/service_others.dart';
import 'package:ustahub/presentation/pages/home/details/components/service_sections.dart';

class ServiceProviderDetailPage extends StatefulWidget {
  final String name;
  final String profession;
  final double distance;
  final double rating;
  final int reviewCount;
  final String duration;
  final int priceFrom;
  final bool isVerified;
  final bool isAvailable;
  final String mainImageUrl;
  final String? image2Url;
  final String? image3Url;
  final String? description;
  final List<Map<String, dynamic>>? services;
  final Map<String, dynamic>? workingHours;
  final String? phoneNumber;
  final String? language;
  final String? location;
  final int yearsExperience;
  final int completedJobs;

  const ServiceProviderDetailPage({
    super.key,
    required this.name,
    required this.profession,
    required this.distance,
    required this.rating,
    required this.reviewCount,
    required this.duration,
    required this.priceFrom,
    required this.isVerified,
    required this.isAvailable,
    required this.mainImageUrl,
    this.image2Url,
    this.image3Url,
    this.description,
    this.services,
    this.workingHours,
    this.phoneNumber,
    this.language,
    this.location,
    this.yearsExperience = 5,
    this.completedJobs = 189,
  });

  static Route route({
    required String name,
    required String profession,
    required double distance,
    required double rating,
    required int reviewCount,
    required String duration,
    required int priceFrom,
    required bool isVerified,
    required bool isAvailable,
    required String mainImageUrl,
    String? image2Url,
    String? image3Url,
    String? description,
    List<Map<String, dynamic>>? services,
    Map<String, dynamic>? workingHours,
    String? phoneNumber,
    String? language,
    String? location,
    int yearsExperience = 5,
    int completedJobs = 189,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ServiceProviderDetailPage(
            name: name,
            profession: profession,
            distance: distance,
            rating: rating,
            reviewCount: reviewCount,
            duration: duration,
            priceFrom: priceFrom,
            isVerified: isVerified,
            isAvailable: isAvailable,
            mainImageUrl: mainImageUrl,
            image2Url: image2Url,
            image3Url: image3Url,
            description: description,
            services: services,
            workingHours: workingHours,
            phoneNumber: phoneNumber,
            language: language,
            location: location,
            yearsExperience: yearsExperience,
            completedJobs: completedJobs,
          ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        var slideTween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: Curves.easeOutCubic));
        var fadeTween = Tween<double>(begin: 0.0, end: 1.0);
        return SlideTransition(
          position: animation.drive(slideTween),
          child: FadeTransition(
            opacity: animation.drive(fadeTween),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 350),
    );
  }

  @override
  State<ServiceProviderDetailPage> createState() =>
      _ServiceProviderDetailPageState();
}

class _ServiceProviderDetailPageState extends State<ServiceProviderDetailPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isFavorite = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<String> get _images {
    final images = [widget.mainImageUrl];
    if (widget.image2Url != null) images.add(widget.image2Url!);
    if (widget.image3Url != null) images.add(widget.image3Url!);
    return images;
  }

  void _toggleFavorite() => setState(() => _isFavorite = !_isFavorite);

  void _handleBack() => Navigator.pop(context);

  void _handleShare() {}

  void _handleMessage() {}

  void _handleBook() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            children: [
              ServiceImageCarousel(images: _images),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                ),
                child: Column(
                  children: [
                    ServiceHeaderSection(
                      name: widget.name,
                      profession: widget.profession,
                      yearsExperience: widget.yearsExperience,
                      isVerified: widget.isVerified,
                    ),
                    ServicePriceSection(priceFrom: widget.priceFrom),
                    16.h.verticalSpace,
                    ServiceCharacteristics(
                      yearsExperience: widget.yearsExperience,
                      completedJobs: widget.completedJobs,
                      distance: widget.distance,
                      duration: widget.duration,
                    ),
                    16.h.verticalSpace,
                    const ServiceDiagnostics(),
                    16.h.verticalSpace,
                    ServiceDescription(description: widget.description),
                    16.h.verticalSpace,
                    ProviderInfoCard(
                      name: widget.name,
                      rating: widget.rating,
                      reviewCount: widget.reviewCount,
                    ),
                    16.h.verticalSpace,
                    const RecommendedServices(),
                    120.h.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ServiceDetailAppBar(
              onBack: _handleBack,
              onShare: _handleShare,
              onFavorite: _toggleFavorite,
              isFavorite: _isFavorite,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ServiceActionBar(
              onMessage: _handleMessage,
              onBook: _handleBook,
            ),
          ),
        ],
      ),
    );
  }
}
