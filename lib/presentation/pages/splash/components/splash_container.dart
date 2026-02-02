import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class SplashContainer extends StatefulWidget {
  final int? tick;

  const SplashContainer({super.key, required this.tick});

  @override
  State<SplashContainer> createState() => _SplashContainerState();
}

class _SplashContainerState extends State<SplashContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> rotation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    // Rotate from 0 to -π/2 (90 degrees) for door opening effect
    rotation = Tween<double>(begin: 0.0, end: -1.57).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );
  }

  @override
  void didUpdateWidget(covariant SplashContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tick == 4 && oldWidget.tick != 4) {
      animationController.forward();
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool firstAnim = widget.tick == 2;
    bool secondAnim = widget.tick == 4;
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Center(
          child: Row(
            children: [
              Expanded(
                child: AnimatedSlide(
                  offset: Offset(firstAnim ? -.6 : 0, 0.0),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutBack,
                  child: Container(
                    height: 86,
                    alignment: Alignment.centerLeft,
                    color: colors.blue500.withOpacity(.01),
                  ),
                ),
              ),
              AnimatedScale(
                scale: firstAnim ? .6 : (secondAnim ? 4 : 1),
                duration: secondAnim
                    ? const Duration(milliseconds: 350)
                    : const Duration(milliseconds: 500),
                curve: secondAnim ? Curves.linear : Curves.easeInOutBack,
                child: AnimatedSlide(
                  offset: Offset(firstAnim ? -2.78 : 0, 0.0),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutBack,
                  child: SizedBox(
                    width: 86,
                    height: 100,
                    child: Stack(
                      children: [
                        // Back door (static)
                        Positioned(
                          left: 0,
                          child: Icon(
                            Icons.handyman,
                            color: colors.shade100,
                            size: 86.r,
                          ),
                        ),
                        // Front door (rotating)
                        Positioned(
                          left: 0,
                          child: AnimatedBuilder(
                            animation: rotation,
                            builder: (context, child) {
                              return Transform(
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateY(rotation.value),
                                alignment: Alignment.centerLeft,
                                child: child,
                              );
                            },
                            child: Icon(
                              Icons.handyman,
                              color: colors.shade100,
                              size: 86.r,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
