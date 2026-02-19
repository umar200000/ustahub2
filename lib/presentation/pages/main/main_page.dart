import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ustahub/presentation/components/custom_bottom_nav_bar.dart';
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
  static const _pages = [
    HomePage(),
    SearchPage(),
    MainOrderPage(),
    ProfilePage(),
  ];

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
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: colors.shade0,
              body: Stack(
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
                      child: CustomBottomNavBar(
                        currentIndex: navBarController.currentIndex,
                        onTap: _onTabSelected,
                        backgroundColor: colors.shade0,
                        activeColor: colors.blue500,
                        inactiveColor: colors.neutral500,
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
