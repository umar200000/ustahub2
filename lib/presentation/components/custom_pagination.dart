import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class CustomPagination extends StatefulWidget {
  final VoidCallback? onRefresh;
  final void Function()? onLoading;
  final VoidCallback onRetry;
  final RefreshController controller;
  final Widget? child;
  final Axis? scrollDirection;
  final bool? enablePullDown;
  final bool? enablePullUp;
  final bool? hasFloatActionButton;
  final ScrollController? scrollController;
  final bool? primary;
  final bool reverse;
  final bool isVertical;
  final ScrollPhysics? physics;
  final double loadMoreThreshold;

  const CustomPagination({
    super.key,
    required this.controller,
    this.onRefresh,
    this.onLoading,
    this.child,
    required this.onRetry,
    this.scrollDirection,
    this.enablePullDown,
    this.enablePullUp,
    this.hasFloatActionButton,
    this.scrollController,
    this.primary,
    this.reverse = false,
    this.isVertical = true,
    this.physics,
    this.loadMoreThreshold = 0.8,
  });

  @override
  State<CustomPagination> createState() => _CustomPaginationState();
}

class _CustomPaginationState extends State<CustomPagination> {
  late ScrollController _scrollController;
  bool _isLoading = false;
  bool _isInitialLoad = true;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_onScroll);

    // Check if we need to load more data after the initial build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndLoadMore();
    });
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  Future<void> _checkAndLoadMore() async {
    if (!mounted || _isLoading || widget.onLoading == null) return;

    // Check if we have scrollable content
    if (!_scrollController.hasClients) return;

    final viewportHeight = _scrollController.position.viewportDimension;
    final contentHeight =
        _scrollController.position.extentAfter +
        _scrollController.position.extentBefore;

    // If content doesn't fill the viewport or we're near the bottom
    if (_isInitialLoad ||
        contentHeight < viewportHeight ||
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent *
                widget.loadMoreThreshold) {
      setState(() {
        _isLoading = true;
        _isInitialLoad = false;
      });

      try {
        widget.onLoading!();

        // After loading, check if we need to load more
        if (mounted) {
          setState(() {
            _isLoading = false;
          });

          // Wait for the frame to be rendered
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && _scrollController.hasClients) {
              final newContentHeight =
                  _scrollController.position.extentAfter +
                  _scrollController.position.extentBefore;

              // If still not filled or very close to bottom, load more
              if (newContentHeight < viewportHeight ||
                  _scrollController.position.pixels >=
                      _scrollController.position.maxScrollExtent *
                          widget.loadMoreThreshold) {
                _checkAndLoadMore();
              }
            }
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  void _onScroll() {
    _checkAndLoadMore();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder:
          (
            BuildContext context,
            CustomColorSet colors,
            FontSet fonts,
            IconSet icons,
            _,
          ) {
            return SmartRefresher(
              reverse: widget.reverse,
              scrollController: _scrollController,
              scrollDirection: widget.scrollDirection,
              primary: widget.primary,
              enablePullDown: widget.enablePullDown ?? true,
              enablePullUp: false,
              header: WaterDropMaterialHeader(
                color: colors.shade0,
                backgroundColor: colors.primary500,
              ),
              footer: CustomFooter(
                height:
                    56 + ((widget.hasFloatActionButton ?? false) ? 88.h : 0),
                builder: (BuildContext context, LoadStatus? mode) {
                  Widget body;
                  if (_isLoading) {
                    body = CupertinoActivityIndicator(color: colors.primary500);
                  } else if (mode == LoadStatus.failed) {
                    body = Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom + 8.h,
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: fonts.captionMedium,
                          children: <TextSpan>[
                            TextSpan(
                              semanticsLabel: 'something_went_wrong'.tr(),
                              text: 'something_went_wrong'.tr(),
                              style: fonts.captionMedium,
                            ),
                            const TextSpan(text: ". "),
                            TextSpan(
                              semanticsLabel: 'retry'.tr(),
                              text: 'retry'.tr(),
                              style: fonts.captionMedium.copyWith(
                                color: colors.primary500,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  widget.onRetry();
                                },
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (mode == LoadStatus.noMore) {
                    body = Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        "no_more_data".tr(),
                        semanticsLabel: "no_more_data".tr(),
                        style: fonts.captionMedium,
                      ),
                    );
                  } else {
                    body = const SizedBox();
                  }
                  return RotatedBox(
                    quarterTurns: widget.isVertical ? 0 : 135,
                    child: SizedBox(
                      height:
                          56 +
                          ((widget.hasFloatActionButton ?? false) ? 0.h : 0),
                      child: Center(child: body),
                    ),
                  );
                },
              ),
              physics: widget.physics,
              controller: widget.controller,
              onRefresh: widget.onRefresh,
              child: widget.child,
            );
          },
    );
  }
}
