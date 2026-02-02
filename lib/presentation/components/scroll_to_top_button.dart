import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application/profile/profile_bloc.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class ScrollToTopButton extends StatefulWidget {
  final ScrollController scrollController;
  final double? bottom;
  final double? right;
  final Color? buttonColor;
  final Color? iconColor;
  final VoidCallback? onCustomTap;

  const ScrollToTopButton({
    super.key,
    required this.scrollController,
    this.bottom,
    this.right,
    this.buttonColor,
    this.iconColor,
    this.onCustomTap,
  });

  @override
  State<ScrollToTopButton> createState() => _ScrollToTopButtonState();
}

class _ScrollToTopButtonState extends State<ScrollToTopButton> {
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    final ScrollDirection direction =
        widget.scrollController.position.userScrollDirection;

    if (direction == ScrollDirection.reverse) {
      if (!isVisible) {
        setState(() {
          isVisible = true;
        });
      }
    } else if (direction == ScrollDirection.forward) {
      if (isVisible) {
        setState(() {
          isVisible = false;
        });
      }
    }
  }

  void _scrollToTop() {
    if (widget.onCustomTap != null) {
      widget.onCustomTap!();
      setState(() {
        isVisible = false;
      });
      return;
    }

    widget.scrollController
        .animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        )
        .then((value) {
          setState(() {
            isVisible = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Positioned(
          bottom:
              widget.bottom ??
              MediaQuery.of(context).padding.bottom +
                  (context.watch<ProfileBloc>().state.totalAmount != 0
                      ? 68.h
                      : 4.h),
          right: widget.right ?? 16.w,
          child: AnimatedOpacity(
            opacity: isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              transform: Matrix4.translationValues(
                0.0,
                isVisible ? 0.0 : 20.0,
                0.0,
              ),
              child: AnimationButtonEffect(
                onTap: _scrollToTop,
                child: Container(
                  width: 38.r,
                  height: 38.r,
                  decoration: BoxDecoration(
                    color: widget.buttonColor ?? colors.primary500,
                    shape: BoxShape.circle,
                    boxShadow: colors.shadowMM,
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                          return RotationTransition(
                            turns: animation,
                            child: ScaleTransition(
                              scale: animation,
                              child: child,
                            ),
                          );
                        },
                    child: Icon(
                      Icons.arrow_upward,
                      color: widget.iconColor ?? colors.shade0,
                      size: 22.r,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
