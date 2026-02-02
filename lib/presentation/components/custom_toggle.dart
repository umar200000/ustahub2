import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class CustomToggle<T> extends StatelessWidget {
  final List<Widget> iconList;
  final Function(T value) onChanged;
  final T current;
  final List<T> values;
  final double height;
  final Size indicatorSize;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final bool elevation;
  const CustomToggle({
    super.key,
    required this.iconList,
    required this.onChanged,
    required this.current,
    required this.values,
    this.height = 36,
    this.indicatorSize = const Size.fromWidth(76),
    this.backgroundColor,
    this.indicatorColor,
    this.elevation = false,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AnimatedToggleSwitch.size(
          current: current,
          indicatorSize: indicatorSize,
          values: values,
          onChanged: onChanged,
          height: height,
          borderWidth: 3.w,
          fittingMode: FittingMode.none,
          animationDuration: const Duration(milliseconds: 200),
          selectedIconScale: 1,
          style: ToggleStyle(
            backgroundColor: backgroundColor ?? colors.neutral50,
            indicatorColor: indicatorColor ?? colors.shade0,
            borderColor: backgroundColor ?? colors.neutral50,
            indicatorBorderRadius: BorderRadius.circular(68.r),
            borderRadius: BorderRadius.circular(32.r),
            boxShadow: elevation ? colors.shadowS : null,
            indicatorBoxShadow: [
              // const BoxShadow(color: Color.fromRGBO(8, 8, 8, 0.03), blurRadius: 2.52069, offset: Offset(0, 0.96537)),
              // const BoxShadow(color: Color.fromRGBO(8, 8, 8, 0.03), blurRadius: 6.96937, offset: Offset(0, 2.66912)),
              // const BoxShadow(color: Color.fromRGBO(8, 8, 8, 0.03), blurRadius: 16.77957, offset: Offset(0, 6.42622)),
              // const BoxShadow(color: Color.fromRGBO(8, 8, 8, 0.03), blurRadius: 55.65902, offset: Offset(0, 18.94775)),
            ],
          ),
          // inactiveOpacity: 0.8,
          iconOpacity: 1,
          iconList: iconList,
        );
      },
    );
  }
}
