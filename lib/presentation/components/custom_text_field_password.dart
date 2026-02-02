import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class CustomTextFieldPasswordwithIcon extends StatefulWidget {
  final String title;
  final String hintText;
  final bool isEmail;
  final bool isPassword;
  final String? error;
  final bool withIcon;

  final TextEditingController? controller;
  final String? Function(String? value)? validator;

  const CustomTextFieldPasswordwithIcon({
    super.key,
    this.controller,
    this.hintText = '',
    this.title = '',
    this.isPassword = true,
    this.isEmail = false,
    this.error,
    this.validator,
    this.withIcon = true,
  });

  @override
  State<CustomTextFieldPasswordwithIcon> createState() =>
      _CustomTextFieldPasswordwithIconState();
}

class _CustomTextFieldPasswordwithIconState
    extends State<CustomTextFieldPasswordwithIcon> {
  bool isUnViziable = true;

  _changeVisibility() {
    setState(() {
      isUnViziable = !isUnViziable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.title.isNotEmpty
                ? Text(
                    semanticsLabel: widget.title,
                    widget.title,
                    style: fonts.headingH6Medium.copyWith(
                      color: widget.error == null
                          ? colors.neutral800
                          : colors.red500,
                    ),
                  )
                : Container(),
            widget.title.isNotEmpty ? SizedBox(height: 6.h) : Container(),
            SizedBox(
              child: TextFormField(
                controller: widget.controller,
                style: fonts.headingH6Medium.copyWith(
                  fontSize: 16.sp,
                  color: colors.neutral800,
                ),
                obscureText: widget.isPassword && isUnViziable,
                keyboardType: _getKeyboardType(),
                validator: widget.validator,
                decoration: InputDecoration(
                  prefixIcon: widget.withIcon
                      ? SizedBox(
                          width: 60.w,
                          child: Row(
                            children: [
                              SizedBox(width: 15.w),
                              icons.passwordO.svg(
                                width: 20.w,
                                height: 20.h,
                                color: colors.primary500,
                              ),
                              SizedBox(
                                height: 22.h,
                                child: VerticalDivider(
                                  color: colors.neutral800,
                                  thickness: 1.w,
                                  width: 22.w,
                                ),
                              ),
                            ],
                          ),
                        )
                      : null,
                  suffixIcon: widget.isPassword
                      ? IconButton(
                          onPressed: _changeVisibility,
                          icon: isUnViziable
                              ? icons.eyeD.svg()
                              : icons.eyeSlashO.svg(),
                        )
                      : null,
                  // focusColor: Style.secondary,
                  fillColor: colors.shade0,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colors.neutral800,
                      width: 1.w,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colors.neutral800,
                      width: 1.w,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colors.neutral800,
                      width: 1.w,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  ),
                  hintText: widget.hintText,
                  hintStyle: fonts.headingH6Medium.copyWith(
                    fontSize: 16.sp,
                    color: colors.shade100.withOpacity(0.5),
                  ),
                  errorText: widget.error,
                  errorStyle: fonts.captionMedium.copyWith(
                    color: colors.red500,
                  ),
                  contentPadding: EdgeInsets.all(15.sp),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  TextInputType? _getKeyboardType() {
    if (widget.isEmail) {
      return TextInputType.emailAddress;
    } else if (widget.isPassword) {
      return TextInputType.visiblePassword;
    } else {
      return null;
    }
  }
}
