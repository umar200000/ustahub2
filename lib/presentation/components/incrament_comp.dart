import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class IncramentComp extends StatefulWidget {
  final void Function(int count) onTap;
  final int? initialCount;
  const IncramentComp({super.key, required this.onTap, this.initialCount});

  @override
  State<IncramentComp> createState() => _IncramentCompState();
}

class _IncramentCompState extends State<IncramentComp> {
  late int _count;

  @override
  void initState() {
    _count = widget.initialCount ?? 0; // Initial count value
    super.initState();
  }

  void _increment() {
    if (_count < 20) {
      _count++;
      widget.onTap(_count);

      setState(() {});
    }
  }

  void _decrement() {
    if (_count > 0) {
      _count--;
      widget.onTap(_count);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // if (_count != 0) ...[
            AnimationButtonEffect(
              onTap: _decrement,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: _count == 0
                      ? colors.neutral100
                      : colors.red500.withOpacity(.15),
                ),
                padding: EdgeInsets.all(4.r),
                child: Icon(
                  Icons.remove,
                  color: _count == 0 ? colors.neutral600 : colors.red500,
                  size: 22.r,
                ),
              ),
            ),
            8.w.horizontalSpace,
            Text(
              "$_count",
              style: fonts.paragraphP3Medium,
              textAlign: TextAlign.center,
            ),
            8.w.horizontalSpace,
            AnimationButtonEffect(
              onTap: _increment,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: colors.primary500.withOpacity(.15),
                ),
                padding: EdgeInsets.all(4.r),
                child: Icon(Icons.add, color: colors.primary500, size: 22.r),
              ),
            ),
            // ],
          ],
        );
      },
    );
  }
}
