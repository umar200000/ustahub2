import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ustahub/presentation/pages/home/home_page.dart';
import 'package:ustahub/presentation/pages/order/main_order_page.dart';
import 'package:ustahub/presentation/pages/profile/profile_page.dart';
import 'package:ustahub/presentation/pages/search/search_page.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class MainPage extends StatefulWidget {
  final int? index;

  const MainPage({super.key, this.index});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  final _navigationKey = GlobalKey<CurvedNavigationBarState>();

  static const _pages = [
    HomePage(),
    SearchPage(),
    MainOrderPage(),
    ProfilePage(),
  ];

  static const _navBarHeight = 60.0;
  static const _iconSize = 18.0;
  static const _animationDuration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _initializeNavBar();
  }

  void _initializeNavBar() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final controller = context.read<BottomNavBarController>();
      controller.changeNavBar(false);

      if (widget.index != null) {
        controller.changeIndex(widget.index!);
      }
    });
  }

  void _onTabSelected(int index) {
    context.read<BottomNavBarController>().changeIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ThemeWrapper(
      builder: (ctx, colors, fonts, icons, controller) {
        return Consumer<BottomNavBarController>(
          builder: (context, navBarController, _) {
            // Controllerdagi indeks o'zgarganda NavBar ham siljishi uchun
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _navigationKey.currentState?.setPage(
                navBarController.currentIndex,
              );
            });

            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: colors.shade0,
              body: SafeArea(
                top: false,
                child: Stack(
                  children: [
                    IndexedStack(
                      index: navBarController.currentIndex,
                      children: _pages,
                    ),
                    if (!navBarController.hiddenNavBar)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: CurvedNavigationBar(
                          key: _navigationKey,
                          index: navBarController.currentIndex,
                          backgroundColor: Colors.transparent,
                          color: colors.shade0,
                          buttonBackgroundColor: colors.blue500,
                          height: _navBarHeight.h,
                          animationDuration: _animationDuration,
                          animationCurve: Curves.easeInOut,
                          items: _buildNavItems(
                            colors,
                            navBarController.currentIndex,
                          ),
                          onTap: _onTabSelected,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> _buildNavItems(dynamic colors, int currentIndex) {
    final iconPaths = [
      'assets/images/world.png',
      'assets/images/search.png',
      'assets/images/order.png',
      'assets/images/user.png',
    ];

    return List.generate(
      iconPaths.length,
      (index) => Image.asset(
        iconPaths[index],
        width: _iconSize.w,
        height: _iconSize.h,
        color: index == currentIndex ? colors.shade0 : colors.neutral600,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
