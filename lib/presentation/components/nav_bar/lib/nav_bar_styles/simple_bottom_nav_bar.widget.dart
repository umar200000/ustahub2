import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/nav_bar/lib/persistent_tab_view.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class BottomNavSimple extends StatelessWidget {
  const BottomNavSimple({
    super.key,
    this.navBarEssentials = const NavBarEssentials(items: null),
  });
  final NavBarEssentials? navBarEssentials;

  Widget _buildItem(
    final PersistentBottomNavBarItem item,
    final bool isSelected,
    final double? height,
    final bool isNavBar,
  ) => ThemeWrapper(
    builder: (context, colors, fonts, icons, controller) {
      return navBarEssentials!.navBarHeight == 0
          ? const SizedBox.shrink()
          : AnimatedContainer(
              width: 150.w,
              height: height,
              color: Colors.transparent,
              duration: const Duration(milliseconds: 1000),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                alignment: Alignment.center,
                height: height,
                child: Padding(
                  padding: EdgeInsets.only(top: isNavBar ? 0 : 8),
                  child: Column(
                    mainAxisAlignment: isNavBar
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: <Widget>[
                      IconTheme(
                        data: IconThemeData(
                          size: item.iconSize,
                          color: isSelected
                              ? (item.activeColorSecondary ??
                                    item.activeColorPrimary)
                              : item.inactiveColorPrimary ??
                                    item.activeColorPrimary,
                        ),
                        child: isSelected
                            ? item.icon
                            : item.inactiveIcon ?? item.icon,
                      ),
                      if (item.title != null && !isNavBar)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Material(
                            type: MaterialType.transparency,
                            child: FittedBox(
                              child: Text(
                                semanticsLabel: item.title!,
                                item.title!,
                                style: item.textStyle != null
                                    ? (item.textStyle!.apply(
                                        color: isSelected
                                            ? (item.activeColorPrimary)
                                            : item.inactiveColorPrimary,
                                      ))
                                    : fonts.footerMedium.copyWith(
                                        color: isSelected
                                            ? (item.activeColorPrimary)
                                            : item.inactiveColorPrimary,
                                      ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
    },
  );

  @override
  Widget build(final BuildContext context) {
    double height = 16;
    double safeArea = MediaQuery.of(context).padding.bottom / 2;
    return SizedBox(
      height: (navBarEssentials?.navBarHeight ?? 0) + height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: navBarEssentials!.navBarHeight! + safeArea,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0x08141415),
                  spreadRadius: 0,
                  blurRadius: 5.04,
                  offset: Offset(0, 0.97), // changes position of shadow
                ),
                BoxShadow(
                  color: Color(0x06141415),
                  spreadRadius: 0,
                  blurRadius: 13.94,
                  offset: Offset(0, 2.67), // changes position of shadow
                ),
                BoxShadow(
                  color: Color(0x04141415),
                  spreadRadius: 0,
                  blurRadius: 33.56,
                  offset: Offset(0, 6.43), // changes position of shadow
                ),
                BoxShadow(
                  color: Color(0x03141415),
                  spreadRadius: 0,
                  blurRadius: 111.32,
                  offset: Offset(0, 18.95), // changes position of shadow
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                child: Container(
                  height: (navBarEssentials!.navBarHeight ?? 0) + safeArea,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.74),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: safeArea),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: navBarEssentials!.items!.map((final item) {
                final int index = navBarEssentials!.items!.indexOf(item);
                return Flexible(
                  child: GestureDetector(
                    onTap: () {
                      if (navBarEssentials!.items![index].onPressed != null) {
                        navBarEssentials!.items![index].onPressed!(
                          navBarEssentials!.selectedScreenBuildContext,
                        );
                      } else {
                        navBarEssentials!.onItemSelected!(index);
                      }
                    },
                    child: index == 2
                        ? Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: navBarEssentials!.selectedIndex == index
                                    ? item.activeColorPrimary
                                    : item.inactiveColorPrimary ??
                                          item.activeColorPrimary,
                                width: 1.2.w,
                              ),
                            ),
                            margin: EdgeInsets.only(bottom: 10.h),
                            child: _buildItem(
                              item,
                              navBarEssentials!.selectedIndex == index,
                              (navBarEssentials!.navBarHeight ?? 0) - 20.r,
                              true,
                            ),
                          )
                        : _buildItem(
                            item,
                            navBarEssentials!.selectedIndex == index,
                            navBarEssentials!.navBarHeight,
                            false,
                          ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5000000, size.height * 0.9605263);
    path_0.cubicTo(
      size.width * 0.5680721,
      size.height * 0.9605263,
      size.width * 0.6232558,
      size.height * 0.6483039,
      size.width * 0.6232558,
      size.height * 0.2631579,
    );
    path_0.cubicTo(
      size.width * 0.6232558,
      size.height * 0.1700500,
      size.width * 0.6200302,
      size.height * 0.08120355,
      size.width * 0.6141791,
      0,
    );
    path_0.lineTo(size.width * 0.9627907, 0);
    path_0.cubicTo(
      size.width * 0.9833419,
      0,
      size.width,
      size.height * 0.09425579,
      size.width,
      size.height * 0.2105263,
    );
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, size.height * 0.2105263);
    path_0.cubicTo(
      0,
      size.height * 0.09425579,
      size.width * 0.01665916,
      0,
      size.width * 0.03720930,
      0,
    );
    path_0.lineTo(size.width * 0.3858209, 0);
    path_0.cubicTo(
      size.width * 0.3799698,
      size.height * 0.08120355,
      size.width * 0.3767442,
      size.height * 0.1700500,
      size.width * 0.3767442,
      size.height * 0.2631579,
    );
    path_0.cubicTo(
      size.width * 0.3767442,
      size.height * 0.6483039,
      size.width * 0.4319279,
      size.height * 0.9605263,
      size.width * 0.5000000,
      size.height * 0.9605263,
    );
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.white;
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.5000000, size.height * 0.4342105);
    path_1.cubicTo(
      size.width * 0.5294651,
      size.height * 0.4342105,
      size.width * 0.5550535,
      size.height * 0.3402553,
      size.width * 0.5679140,
      size.height * 0.2024066,
    );
    path_1.cubicTo(
      size.width * 0.5775070,
      size.height * 0.09958158,
      size.width * 0.5934023,
      0,
      size.width * 0.6139535,
      0,
    );
    path_1.lineTo(size.width * 0.9627907, 0);
    path_1.cubicTo(
      size.width * 0.9833419,
      0,
      size.width,
      size.height * 0.09425579,
      size.width,
      size.height * 0.2105263,
    );
    path_1.lineTo(size.width, size.height * 0.7894737);
    path_1.cubicTo(
      size.width,
      size.height * 0.9057447,
      size.width * 0.9833419,
      size.height,
      size.width * 0.9627907,
      size.height,
    );
    path_1.lineTo(size.width * 0.03720930, size.height);
    path_1.cubicTo(
      size.width * 0.01665914,
      size.height,
      0,
      size.height * 0.9057447,
      0,
      size.height * 0.7894737,
    );
    path_1.lineTo(0, size.height * 0.2105263);
    path_1.cubicTo(
      0,
      size.height * 0.09425579,
      size.width * 0.01665916,
      0,
      size.width * 0.03720930,
      0,
    );
    path_1.lineTo(size.width * 0.3860465, 0);
    path_1.cubicTo(
      size.width * 0.4065977,
      0,
      size.width * 0.4224930,
      size.height * 0.09958158,
      size.width * 0.4320860,
      size.height * 0.2024066,
    );
    path_1.cubicTo(
      size.width * 0.4449465,
      size.height * 0.3402553,
      size.width * 0.4705349,
      size.height * 0.4342105,
      size.width * 0.5000000,
      size.height * 0.4342105,
    );
    path_1.close();

    Paint paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = Colors.white;
    canvas.drawPath(path_1, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
