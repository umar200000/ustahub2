import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.backgroundColor,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8.w,
        right: 8.w,
        bottom: MediaQuery.of(context).padding.bottom + 10.h,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 4.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.78),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: activeColor.withValues(alpha: 0.12),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: activeColor.withValues(alpha: 0.10),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                  spreadRadius: -4,
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                _navItems.length,
                (index) => _NavItem(
                  data: _navItems[index],
                  isActive: currentIndex == index,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  onTap: () => onTap(index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItemData {
  final String? icon;
  final String? activeIcon;
  final IconData? iconData;
  final IconData? activeIconData;
  final String label;

  const _NavItemData({
    this.icon,
    this.activeIcon,
    this.iconData,
    this.activeIconData,
    required this.label,
  });
}

final List<_NavItemData> _navItems = [
  _NavItemData(
    icon: 'assets/images/world.png',
    activeIcon: 'assets/images/world.png',
    label: 'home',
  ),
  _NavItemData(
    icon: 'assets/images/search.png',
    activeIcon: 'assets/images/search.png',
    label: 'search',
  ),
  _NavItemData(
    iconData: Icons.favorite_border_rounded,
    activeIconData: Icons.favorite_rounded,
    label: 'favorites',
  ),
  _NavItemData(
    icon: 'assets/images/order.png',
    activeIcon: 'assets/images/order.png',
    label: 'orders',
  ),
  _NavItemData(
    icon: 'assets/images/user.png',
    activeIcon: 'assets/images/user.png',
    label: 'profile',
  ),
];

class _NavItem extends StatelessWidget {
  final _NavItemData data;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  const _NavItem({
    required this.data,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? activeColor : inactiveColor;
    final Widget iconWidget;
    if (data.iconData != null) {
      iconWidget = Icon(
        isActive ? (data.activeIconData ?? data.iconData!) : data.iconData!,
        size: 22.sp,
        color: color,
      );
    } else {
      iconWidget = Image.asset(
        isActive ? (data.activeIcon ?? data.icon!) : data.icon!,
        width: 20.w,
        height: 20.h,
        color: color,
      );
    }

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              iconWidget,
              SizedBox(height: 2.h),
              Text(
                data.label.tr(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color,
                  fontSize: 10.sp,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
