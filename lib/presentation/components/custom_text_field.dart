import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final String subTitle;
  final String hintText;
  final String titleHintText;
  final bool isEmail;
  final bool isPassword;
  final bool obscureText;
  final int? minLines;
  final int? maxLines;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function()? onsuffixIconPressed;
  final void Function()? onprefixIconPressed;
  final void Function()? onPressed;
  final TextInputType keyboardType;
  final String? error;
  final int? maxLength;
  final TextEditingController? controller;
  final List<TextInputFormatter>? formatter;
  final TextAlign textAlign;
  final bool readOnly;
  final bool? expands;
  final double? borderWidth;
  final double? borderRadius;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final Color? fillColor;
  final Color? enableBorderColor;
  final InputBorder? border;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool autoFocus;
  final Color? cursorColor;
  final TextCapitalization textCapitalization;
  final TextStyle? textStyle;
  final TextStyle? titleStyle;
  final bool withShadow;

  const CustomTextField({
    super.key,
    this.onPressed,
    this.border,
    this.expands,
    this.enableBorderColor,
    this.onsuffixIconPressed,
    this.onprefixIconPressed,
    this.formatter,
    this.borderWidth = 1.5,
    this.borderRadius,
    this.fillColor,
    this.controller,
    this.hintText = '',
    this.title = '',
    this.subTitle = '',
    this.isPassword = false,
    this.minLines = 1,
    this.maxLines = 2,
    this.isEmail = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLength,
    this.obscureText = false,
    this.error,
    this.titleHintText = '',
    this.readOnly = false,
    this.onChanged,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.padding,
    this.validator,
    this.initialValue,
    this.autoFocus = false,
    this.cursorColor,
    this.textCapitalization = TextCapitalization.none,
    this.textStyle,
    this.withShadow = false,
    this.contentPadding,
    this.titleStyle,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, _) {
        return Padding(
          padding: widget.padding ?? EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.title.isNotEmpty
                  ? Text(
                      semanticsLabel: widget.title,
                      widget.title,
                      style:
                          widget.titleStyle ??
                          fonts.paragraphP2Medium.copyWith(
                            color: widget.error == null
                                ? colors.neutral600
                                : colors.red500,
                          ),
                    )
                  : const SizedBox(),
              widget.title.isNotEmpty
                  ? SizedBox(height: 6.h)
                  : const SizedBox(),
              widget.titleHintText.isNotEmpty
                  ? Text(
                      semanticsLabel: widget.titleHintText,
                      widget.titleHintText,
                      style: fonts.paragraphP2Regular,
                    )
                  : const SizedBox(),
              widget.titleHintText.isNotEmpty
                  ? SizedBox(height: 6.h)
                  : const SizedBox(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 10.r,
                  ),
                  boxShadow: widget.withShadow ? colors.shadowMM : null,
                ),
                child: TextFormField(
                  textCapitalization: widget.textCapitalization,
                  autofocus: widget.autoFocus,
                  initialValue: widget.initialValue,
                  expands: widget.expands ?? false,
                  onTap: widget.onPressed,
                  textInputAction: TextInputAction.done,
                  focusNode: widget.focusNode,
                  maxLength: widget.maxLength,
                  onChanged: widget.onChanged,
                  readOnly: widget.readOnly,
                  textAlign: widget.textAlign,
                  inputFormatters: widget.formatter,
                  minLines: widget.minLines,
                  maxLines: widget.maxLines,
                  cursorColor: widget.cursorColor ?? colors.shade100,
                  controller: widget.controller,
                  style:
                      widget.textStyle ??
                      fonts.paragraphP1SemiBold.copyWith(
                        color: widget.readOnly
                            ? colors.neutral50
                            : colors.shade100,
                      ),
                  obscureText: widget.obscureText,
                  keyboardType: widget.keyboardType,
                  validator: widget.validator,
                  decoration: InputDecoration(
                    counterText: widget.maxLength == 500 ? null : '',
                    suffix: widget.suffixIcon != null
                        ? AnimationButtonEffect(
                            onTap: widget.onsuffixIconPressed,
                            child: widget.suffixIcon!,
                          )
                        : null,
                    prefixIcon: widget.prefixIcon != null
                        ? IconButton(
                            icon: widget.prefixIcon!,
                            onPressed: widget.onprefixIconPressed ?? () {},
                          )
                        : null,
                    focusColor: colors.primary500,
                    fillColor: widget.fillColor ?? colors.transparent,
                    filled: true,
                    isDense: true,
                    border: widget.readOnly
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius ?? 10.r,
                            ),
                            borderSide: BorderSide.none,
                          )
                        : widget.border ??
                              OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  widget.borderRadius ?? 10.r,
                                ),
                                borderSide: BorderSide(
                                  color: colors.neutral50,
                                  width: 1,
                                ),
                              ),
                    enabledBorder: widget.readOnly
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius ?? 10.r,
                            ),
                            borderSide: BorderSide.none,
                          )
                        : widget.border ??
                              OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  widget.borderRadius ?? 10.r,
                                ),
                                borderSide: BorderSide(
                                  color:
                                      widget.enableBorderColor ??
                                      colors.neutral50,
                                  width: widget.borderWidth ?? 1,
                                ),
                              ),
                    focusedBorder: widget.readOnly
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius ?? 10.r,
                            ),
                            borderSide: BorderSide.none,
                          )
                        : widget.border ??
                              OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  widget.borderRadius ?? 10.r,
                                ),
                                borderSide: BorderSide(
                                  color: colors.primary500,
                                  width: widget.borderWidth ?? 1.w,
                                ),
                              ),
                    hintText: widget.hintText,
                    semanticCounterText: widget.hintText,
                    hintStyle: fonts.paragraphP2Regular.copyWith(
                      color: colors.neutral600,
                    ),
                    errorText: widget.error,
                    errorStyle: fonts.captionMedium.copyWith(
                      color: colors.red500,
                    ),
                    contentPadding:
                        widget.contentPadding ??
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                  ),
                ),
              ),
              widget.subTitle.isNotEmpty
                  ? SizedBox(height: 6.h)
                  : const SizedBox(),
              widget.subTitle.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          semanticsLabel: widget.subTitle,
                          widget.subTitle,
                          maxLines: 2,
                          style: fonts.paragraphP1Medium.copyWith(
                            color: widget.error == null
                                ? colors.neutral800
                                : colors.red500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
