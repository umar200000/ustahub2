import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/pages/home/details/details_info.dart';
import 'package:ustahub/presentation/pages/home/details/service_details_page.dart';
import 'package:ustahub/presentation/pages/home/widgets/home_app_bar.dart';
import 'package:ustahub/presentation/pages/home/widgets/service_product_widget.dart';
import 'package:ustahub/presentation/pages/home/widgets/service_widget.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Set<int> _favoriteIndices = {};

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.neutral50,
          body: Column(
            children: [
              const HomeAppBar(),
              Expanded(child: _buildScrollableContent(colors)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildScrollableContent(dynamic colors) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // 12.h.verticalSpace,
        ServicesGrid(services: services),
        // 16.h.verticalSpace,
        _buildServiceProvidersList(colors),
      ],
    );
  }

  Widget _buildServiceProvidersList(dynamic colors) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: 16.h),
        itemCount: serviceProviders.length,
        itemBuilder: (context, index) => _buildProviderCard(index),
      ),
    );
  }

  Widget _buildProviderCard(int index) {
    final provider = serviceProviders[index];
    return ServiceProviderCard(
      name: provider['name'] as String,
      profession: provider['profession'] as String,
      distance: (provider['distance'] as num).toDouble(),
      rating: (provider['rating'] as num).toDouble(),
      reviewCount: provider['reviewCount'] as int,
      duration: provider['duration'] as String,
      priceFrom: provider['priceFrom'] as int,
      isVerified: provider['isVerified'] as bool,
      isAvailable: provider['isAvailable'] as bool,
      mainImageUrl: provider['mainImageUrl'] as String?,
      image2Url: provider['image2Url'] as String?,
      image3Url: provider['image3Url'] as String?,
      isFavorite: _favoriteIndices.contains(index),
      onFavorite: () => _toggleFavorite(index),
      onTap: () => _navigateToDetail(provider),
    );
  }

  void _navigateToDetail(Map<String, dynamic> provider) {
    Navigator.of(context).push(
      ServiceProviderDetailPage.route(
        name: provider['name'] as String,
        profession: provider['profession'] as String,
        distance: (provider['distance'] as num).toDouble(),
        rating: (provider['rating'] as num).toDouble(),
        reviewCount: provider['reviewCount'] as int,
        duration: provider['duration'] as String,
        priceFrom: provider['priceFrom'] as int,
        isVerified: provider['isVerified'] as bool,
        isAvailable: provider['isAvailable'] as bool,
        mainImageUrl: provider['mainImageUrl'] as String? ?? '',
        image2Url: provider['image2Url'] as String?,
        image3Url: provider['image3Url'] as String?,
        description: provider['description'] as String?,
        services: provider['services'] as List<Map<String, dynamic>>?,
        workingHours: provider['workingHours'] as Map<String, dynamic>?,
        phoneNumber: provider['phoneNumber'] as String?,
        language: provider['language'] as String?,
        location: provider['location'] as String?,
        yearsExperience: (provider['yearsExperience'] as int?) ?? 5,
        completedJobs: (provider['completedJobs'] as int?) ?? 189,
      ),
    );
  }

  void _toggleFavorite(int index) {
    setState(() {
      if (_favoriteIndices.contains(index)) {
        _favoriteIndices.remove(index);
      } else {
        _favoriteIndices.add(index);
      }
    });
  }
}
