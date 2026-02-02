import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/domain/models/main/main_model.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/components/cached_image_component.dart';
import 'package:ustahub/presentation/components/dotted_indicator.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';
import 'package:ustahub/utils/extensions.dart';

class GalleryComp extends StatefulWidget {
  const GalleryComp({
    super.key,
    this.bottomGap = 24.0,
    this.onTap,
    required this.images,
    this.height = 250,
    this.borderRadius = 0,
    this.dotBottomPadding,
    this.expand = false,
    this.backgroundColor,
    this.onlyUrl = false,
  });

  final double bottomGap;
  final VoidCallback? onTap;
  final List<ImagesModel>? images;
  final double height;
  final double borderRadius;
  final double? dotBottomPadding;
  final bool expand;
  final bool onlyUrl;
  final Color? backgroundColor;

  @override
  State<GalleryComp> createState() => _GalleryCompState();
}

class _GalleryCompState extends State<GalleryComp>
    with AutomaticKeepAliveClientMixin {
  late final PageController _pageController;
  late int _pageIndex;
  final int _maxImages = 10;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageIndex = 0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int get _effectiveImageCount => (widget.images?.length ?? 0) > _maxImages
      ? _maxImages
      : widget.images?.length ?? 0;

  String _getImageUrl(int index) {
    if (widget.onlyUrl) {
      return widget.images?[index].url ?? "";
    }
    return widget.images?[index].thumbnail ?? widget.images?[index].url ?? "";
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return ColoredBox(
          color: widget.backgroundColor ?? colors.shade0,
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? colors.shade0,
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              height: widget.expand ? null : widget.height,
              child: Stack(
                fit: widget.expand ? StackFit.expand : StackFit.loose,
                children: [
                  PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        _pageIndex = index;
                      });
                    },
                    itemCount: _effectiveImageCount,
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      final imageUrl = _getImageUrl(index);
                      return RepaintBoundary(
                        child: CachedImageComponent(
                          key: ValueKey('gallery_image_$index'),
                          isNetwork: widget.images?[index].url?.isUrl ?? false,
                          fit: BoxFit.cover,
                          height: widget.expand ? double.infinity : 200.h,
                          width: double.infinity,
                          imageUrl: imageUrl,
                          borderRadius: widget.borderRadius,
                          stableKey: index,
                        ),
                      );
                    },
                  ),
                  if (_effectiveImageCount > 1) _buildDotIndicator(colors),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDotIndicator(CustomColorSet colors) {
    return Positioned(
      bottom: 8.h,
      right: 16.w,
      left: 16.w,
      child: Container(
        padding: EdgeInsets.only(bottom: widget.dotBottomPadding ?? 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _effectiveImageCount,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 4),
              child: DotIndicator(
                isActive: index == _pageIndex,
                colors: colors,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///
class Gallery2Comp extends StatefulWidget {
  final List<String> images;
  const Gallery2Comp({
    super.key,
    this.bottomGap = 24.0,
    this.onTap,
    required this.images,
  });

  final double bottomGap;
  final VoidCallback? onTap;

  @override
  State<Gallery2Comp> createState() => _Gallery2CompState();
}

class _Gallery2CompState extends State<Gallery2Comp>
    with AutomaticKeepAliveClientMixin {
  late final PageController _pageController;
  // late int _pageIndex;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // _pageIndex = 0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _handlePreviousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return ColoredBox(
          color: colors.shade0,
          child: Column(
            children: [
              GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  decoration: BoxDecoration(color: colors.shade0),
                  height: 250.h,
                  child: Stack(
                    children: [
                      PageView.builder(
                        onPageChanged: (index) {
                          // setState(() {
                          //   _pageIndex = index;
                          // });
                        },
                        itemCount: widget.images.length,
                        controller: _pageController,
                        itemBuilder: (context, index) => RepaintBoundary(
                          child: CachedImageComponent(
                            key: ValueKey('gallery2_image_$index'),
                            isNetwork: true,
                            fit: BoxFit.contain,
                            height: 250.h,
                            width: double.infinity,
                            imageUrl: widget.images[index],
                            stableKey: index,
                          ),
                        ),
                      ),
                      if (widget.images.length > 1) ...[
                        _buildNavigationButton(
                          colors,
                          icons,
                          isNext: true,
                          onTap: _handleNextPage,
                        ),
                        _buildNavigationButton(
                          colors,
                          icons,
                          isNext: false,
                          onTap: _handlePreviousPage,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavigationButton(
    CustomColorSet colors,
    IconSet icons, {
    required bool isNext,
    required VoidCallback onTap,
  }) {
    return Positioned(
      right: isNext ? 20.w : null,
      left: isNext ? null : 20.w,
      top: 110.h,
      bottom: 110.h,
      child: AnimationButtonEffect(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.r)),
            color: colors.transparent.withOpacity(0.5),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: isNext
              ? icons.forwardS.svg(color: colors.shade0, height: 12)
              : icons.backS.svg(color: colors.shade0, height: 12),
        ),
      ),
    );
  }
}

class GalleryGridComp extends StatelessWidget {
  final List<String> images;
  const GalleryGridComp({super.key, this.onTap, required this.images});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return ColoredBox(
          color: colors.shade0,
          child: Column(
            children: [
              InkWell(
                onTap: onTap,
                child: ColoredBox(
                  color: colors.shade0,
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1.52,
                        ),
                    itemCount: images.length,
                    itemBuilder: (context, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedImageComponent(
                        key: ValueKey('gallery_grid_image_$index'),
                        isNetwork: true,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                        imageUrl: images[index],
                        borderRadius: 5,
                        stableKey: index,
                      ),
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ),
              ),
              16.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
