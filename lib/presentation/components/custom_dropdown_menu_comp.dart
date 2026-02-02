import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class CustomDropDownMenuComp extends StatelessWidget {
  const CustomDropDownMenuComp({
    super.key,
    required this.list,
    this.onSelected,
  });

  final List<String> list;
  final Function(String? value)? onSelected;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return DropdownMenu(
          menuStyle: MenuStyle(
            fixedSize: const WidgetStatePropertyAll(Size(0, 300)),
            backgroundColor: WidgetStatePropertyAll(colors.neutral800),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10.r),
                  bottomLeft: Radius.circular(10.r),
                ),
              ),
            ),
          ),
          onSelected: onSelected,
          expandedInsets: EdgeInsets.zero,
          initialSelection: list.first,
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: colors.neutral800),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: colors.neutral800),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            constraints: BoxConstraints.tight(Size.fromHeight(42.h)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: colors.neutral800),
            ),
          ),
          dropdownMenuEntries: <DropdownMenuEntry<String>>[
            ...list.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry(value: value, label: value);
            }),
          ],
        );
      },
    );
  }
}
