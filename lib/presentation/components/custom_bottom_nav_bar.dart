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
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 12.h,
        bottom: MediaQuery.of(context).padding.bottom + 8.h,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          top: BorderSide(
            color: Colors.grey.withValues(alpha: 0.2),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          _navItems.length,
          (index) => _NavItem(
            icon: _navItems[index].icon,
            activeIcon: _navItems[index].activeIcon,
            label: _navItems[index].label,
            isActive: currentIndex == index,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            onTap: () => onTap(index),
          ),
        ),
      ),
    );
  }
}

class _NavItemData {
  final String icon;
  final String activeIcon;
  final String label;

  const _NavItemData({
    required this.icon,
    required this.activeIcon,
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
  final String icon;
  final String activeIcon;
  final String label;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 16.w : 12.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: isActive ? activeColor.withValues(alpha: 0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isActive ? activeIcon : icon,
              width: 22.w,
              height: 22.h,
              color: isActive ? activeColor : inactiveColor,
            ),
            if (isActive) ...[
              SizedBox(width: 8.w),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isActive ? 1.0 : 0.0,
                child: Text(
                  label.tr(),
                  style: TextStyle(
                    color: activeColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
