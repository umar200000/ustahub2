import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';

class ServiceDetailAppBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onShare;
  final VoidCallback onFavorite;
  final bool isFavorite;

  const ServiceDetailAppBar({
    super.key,
    required this.onBack,
    required this.onShare,
    required this.onFavorite,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8.h,
        left: 16.w,
        right: 16.w,
        bottom: 8.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionButton(Icons.arrow_back, onBack, isFavorite: false),
          Row(
            children: [
              _buildActionButton(Icons.share, onShare, isFavorite: false),
              8.w.horizontalSpace,
              _buildActionButton(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                onFavorite,
                isFavorite: isFavorite,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    VoidCallback onTap, {
    required bool isFavorite,
  }) {
    return AnimationButtonEffect(
      onTap: onTap,
      child: Container(
        width: 40.r,
        height: 40.r,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isFavorite && icon == Icons.favorite
              ? Colors.red
              : Colors.black87,
          size: 20.r,
        ),
      ),
    );
  }
}
