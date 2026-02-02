import 'package:flutter/widgets.dart';

class AnimationFadeEffect extends StatelessWidget {
  final Duration duration;
  final Curve curve;
  final Widget child;
  const AnimationFadeEffect(
      {super.key,
      required this.duration,
      required this.child,
      this.curve = Curves.easeInOutQuint});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        // final curvedAnimation = CurvedAnimation(
        //   parent: animation,
        //   curve: curve,
        // );

        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: curve,
          ),
          child: child,
        );
      },
      child: child,
    );
  }
}
