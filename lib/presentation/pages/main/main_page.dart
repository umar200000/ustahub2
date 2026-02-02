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
  late int _currentIndex;
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
    _currentIndex = widget.index ?? 0;
    _initializeNavBar();
  }

  void _initializeNavBar() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<BottomNavBarController>().changeNavBar(false);

      if (widget.index != null && widget.index != 0) {
        _navigationKey.currentState?.setPage(widget.index!);
      }
    });
  }

  void _onTabSelected(int index) {
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ThemeWrapper(
      builder: (ctx, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.shade0,
          body: SafeArea(top: false, child: _buildBody(colors)),
        );
      },
    );
  }

  Widget _buildBody(dynamic colors) {
    return Consumer<BottomNavBarController>(
      builder: (context, navBarController, _) {
        return Stack(
          children: [
            _buildPageView(),
            if (!navBarController.hiddenNavBar) _buildNavigationBar(colors),
          ],
        );
      },
    );
  }

  Widget _buildPageView() {
    return IndexedStack(index: _currentIndex, children: _pages);
  }

  Widget _buildNavigationBar(dynamic colors) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: CurvedNavigationBar(
        key: _navigationKey,
        index: _currentIndex,
        backgroundColor: Colors.transparent,
        color: colors.shade0,
        buttonBackgroundColor: colors.blue500,
        height: _navBarHeight.h,
        animationDuration: _animationDuration,
        animationCurve: Curves.easeInOut,
        items: _buildNavItems(colors),
        onTap: _onTabSelected,
      ),
    );
  }

  List<Widget> _buildNavItems(dynamic colors) {
    final iconPaths = [
      'assets/images/world.png',
      'assets/images/search.png',
      'assets/images/order.png',
      'assets/images/user.png',
    ];

    return List.generate(
      iconPaths.length,
      (index) => _buildNavIcon(
        iconPaths[index],
        isActive: index == _currentIndex,
        colors: colors,
      ),
    );
  }

  Widget _buildNavIcon(
    String assetPath, {
    required bool isActive,
    required dynamic colors,
  }) {
    return Image.asset(
      assetPath,
      width: _iconSize.w,
      height: _iconSize.h,
      color: isActive ? colors.shade0 : colors.neutral600,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
