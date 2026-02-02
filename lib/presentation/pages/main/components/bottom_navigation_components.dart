import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/nav_bar/lib/persistent_tab_view.dart';
import 'package:ustahub/presentation/styles/style.dart';
import 'package:ustahub/presentation/styles/theme.dart';

// Extension to add customNavWidget property to PersistentBottomNavBarItem
extension CustomProperties on PersistentBottomNavBarItem {
  static final Map<PersistentBottomNavBarItem, Widget?> _customWidgets = {};

  Widget? get customNavWidget => _customWidgets[this];

  void setCustomNavWidget(Widget? widget) {
    _customWidgets[this] = widget;
  }
}

class CustomBottomNavBarItem extends PersistentBottomNavBarItem {
  CustomBottomNavBarItem({
    required String super.title,
    required Color activeColorPrimary,
    required Color inactiveColorPrimary,
    required String icon,
    required String inactiveIcon,
    required double iconSize,
    Widget? customWidget,
    super.withShimmer,
    super.onPressed,
    Key? key,
  }) : super(
         contentPadding: 0,
         icon: ConstrainedBox(
           constraints: BoxConstraints(
             minHeight: iconSize,
             maxHeight: iconSize,
             maxWidth: iconSize,
             minWidth: iconSize,
           ),
           child: icon.svg(
             height: iconSize,
             color: activeColorPrimary,
             boxFit: BoxFit.contain,
           ),
         ),
         inactiveIcon: ConstrainedBox(
           constraints: BoxConstraints(
             minHeight: iconSize,
             maxHeight: iconSize,
             maxWidth: iconSize,
             minWidth: iconSize,
           ),
           child: inactiveIcon.svg(
             height: iconSize,
             color: inactiveColorPrimary,
             boxFit: BoxFit.contain,
           ),
         ),
         textStyle: Style.semiBold14(color: Style.shade0, size: 12.sp),
         activeColorPrimary: Style.primary500,
         inactiveColorPrimary: Style.neutral800,
         inactiveColorSecondary: Style.neutral800,
         activeColorSecondary: Style.shade0,
       ) {
    setCustomNavWidget(customWidget);
  }
}

class CustomBottomNavBarItemWithBadge extends PersistentBottomNavBarItem {
  CustomBottomNavBarItemWithBadge({
    required String title,
    required Color activeColorPrimary,
    required Color inactiveColorPrimary,
    required String icon,
    required String inactiveIcon,
    required double iconSize,
    required Widget badge,
    Key? key,
  }) : super(
         contentPadding: 0,
         icon: Badge(
           backgroundColor: Colors.transparent,
           label: badge,
           child: ConstrainedBox(
             constraints: BoxConstraints(
               minHeight: iconSize,
               maxHeight: iconSize,
               maxWidth: iconSize,
               minWidth: iconSize,
             ),
             child: icon.svg(
               height: iconSize,
               color: activeColorPrimary,
               boxFit: BoxFit.contain,
             ),
           ),
         ),
         inactiveIcon: Badge(
           backgroundColor: Colors.transparent,
           label: badge,
           child: ConstrainedBox(
             constraints: BoxConstraints(
               minHeight: iconSize,
               maxHeight: iconSize,
               maxWidth: iconSize,
               minWidth: iconSize,
             ),
             child: inactiveIcon.svg(
               height: iconSize,
               color: inactiveColorPrimary,
               boxFit: BoxFit.contain,
             ),
           ),
         ),
         title: title.tr(),
         textStyle: Style.semiBold14(color: Style.neutral500, size: 12.sp),
         activeColorPrimary: Style.primary500,
         inactiveColorPrimary: Style.neutral800,
         inactiveColorSecondary: Style.neutral800,
         activeColorSecondary: Style.neutral800,
       );
}

List<PersistentBottomNavBarItem> navBarsItems(
  IconSet icons,
  String? title,
  bool withShimmer,
  Widget? customWidget,
) {
  double iconSize = 22.r;
  return [
    // CustomBottomNavBarItem(
    //   iconSize: iconSize,
    //   inactiveIcon: icons.personO,
    //   icon: icons.personO,
    //   title: "profile".tr(),
    //   activeColorPrimary: Style.shade0,
    //   inactiveColorPrimary: Style.neutral800,
    // ),
    CustomBottomNavBarItem(
      iconSize: iconSize,
      inactiveIcon: icons.homeO,
      icon: icons.homeO,
      title: "home".tr(),
      activeColorPrimary: Style.shade0,
      inactiveColorPrimary: Style.shade0,
    ),
    CustomBottomNavBarItem(
      iconSize: iconSize,
      icon: icons.catalogO,
      inactiveIcon: icons.catalogO,
      title: "catalog".tr(),
      activeColorPrimary: Style.shade0,
      inactiveColorPrimary: Style.shade0,
    ),
    CustomBottomNavBarItem(
      iconSize: iconSize,
      icon: icons.basketO,
      inactiveIcon: icons.basketO,
      title: title ?? "basket".tr(),
      activeColorPrimary: Style.primary500,
      inactiveColorPrimary: Style.shade0,
      withShimmer: withShimmer,
      customWidget: customWidget,
    ),
  ];
}
