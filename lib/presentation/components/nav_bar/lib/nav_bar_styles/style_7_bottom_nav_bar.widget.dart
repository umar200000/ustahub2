part of '../persistent_tab_view.dart';

class BottomNavStyle7 extends StatelessWidget {
  const BottomNavStyle7({super.key, this.navBarEssentials = const NavBarEssentials(items: null)});
  final NavBarEssentials? navBarEssentials;

  Widget _buildItem(final PersistentBottomNavBarItem item, final bool isSelected, final double? height, final bool isDefault) =>
      navBarEssentials!.navBarHeight == 0
          ? const SizedBox.shrink()
          : Container(
            height: height! / 1.6,
            padding: EdgeInsets.all(item.contentPadding),
            child: Container(
              alignment: Alignment.center,
              height: height / 1.6,
              child: ShimmerView(
                forText: true,
                key: ValueKey(item.withShimmer),
                isEnabled: item.withShimmer,
                child: item.customNavWidget ?? SizedBox.shrink(),
              ),
            ),
          );

  @override
  Widget build(final BuildContext context) {
    if (navBarEssentials!.items![2].customNavWidget == null) {
      return SizedBox.shrink();
    }

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: double.infinity,
          height: navBarEssentials!.navBarHeight,
          color: Style.shade0.withOpacity(0.6),
          padding: EdgeInsets.only(top: 6.h, left: 16.w, right: 16.w, bottom: MediaQuery.of(context).padding.bottom + 4.h),
          child: AnimationButtonEffect(
            onTap: () {
              if (!navBarEssentials!.items![2].withShimmer) {
                if (navBarEssentials!.items![2].onPressed != null) {
                  navBarEssentials!.items![2].onPressed!(navBarEssentials!.selectedScreenBuildContext);
                } else {
                  navBarEssentials!.onItemSelected!(2);
                }
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: navBarEssentials!.selectedIndex == 0 ? Style.primary500 : Color(0xFF514131),
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
              child: _buildItem(
                navBarEssentials!.items![2],
                navBarEssentials!.selectedIndex == 2,
                navBarEssentials!.navBarHeight,
                true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
