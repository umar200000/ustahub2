import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/pages/auth/widgets/pin_put_widget.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import 'auth_button.dart';

class EnterPhoneNumberBox extends StatefulWidget {
  const EnterPhoneNumberBox({super.key});

  @override
  State<EnterPhoneNumberBox> createState() => _EnterPhoneNumberBoxState();
}

class _EnterPhoneNumberBoxState extends State<EnterPhoneNumberBox> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void showPinPutWidget(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return PinPutWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) => Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 16.h,
          bottom:
              MediaQuery.of(context).viewInsets.bottom +
              MediaQuery.of(context).padding.bottom,
        ),
        decoration: BoxDecoration(
          color: colors.darkMode800,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: colors.shade0.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            24.h.verticalSpace,
            Text(
              'enter_phone_number'.tr(),
              style: fonts.subheadingRegular.copyWith(
                color: colors.shade0,
                fontSize: 22.sp,
              ),
            ),
            24.h.verticalSpace,
            Container(
              decoration: BoxDecoration(
                color: colors.darkMode700,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.shade0.withOpacity(0.1)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Text(
                    "+998 ",
                    style: fonts.paragraphP2SemiBold.copyWith(
                      color: colors.shade0,
                      fontSize: 18.sp,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      autofocus: true,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [UzPhoneFormatter()],
                      style: fonts.paragraphP2SemiBold.copyWith(
                        color: colors.shade0,
                        fontSize: 18.sp,
                      ),
                      decoration: InputDecoration(
                        hintText: "(_ _) _ _ _  _ _  _ _",
                        hintStyle: fonts.paragraphP2SemiBold.copyWith(
                          color: colors.shade0.withOpacity(0.3),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            24.h.verticalSpace,
            AuthButton(
              color: colors.blue500,
              onTap: () {
                showPinPutWidget(context);
              },
              textColor: colors.shade0,
              title: "continue".tr(),
            ),
            24.h.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class UzPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final oldText = oldValue.text;
    final newText = newValue.text;

    final oldDigits = oldText.replaceAll(RegExp(r'\D'), '');
    var newDigits = newText.replaceAll(RegExp(r'\D'), '');

    // 1. Overwrite mode: Agar raqamlar 9 tadan oshsa va bu qo'shish bo'lsa
    if (newDigits.length > 9 && newDigits.length > oldDigits.length) {
      final int selectionStart = oldValue.selection.start;
      final int digitsBeforeCursor = oldText
          .substring(0, selectionStart)
          .replaceAll(RegExp(r'\D'), '')
          .length;

      if (digitsBeforeCursor < 9) {
        final String addedDigit = newDigits[digitsBeforeCursor];
        newDigits =
            oldDigits.substring(0, digitsBeforeCursor) +
            addedDigit +
            oldDigits.substring(digitsBeforeCursor + 1);
      } else {
        return oldValue;
      }
    }

    if (newDigits.length > 9) newDigits = newDigits.substring(0, 9);

    // 2. Space Deletion fix: Agar foydalanuvchi bo'shliqni o'chirsa
    bool forcefullyRemoved = false;
    if (newText.length < oldText.length && oldDigits == newDigits) {
      final int selectionEnd = newValue.selection.end;
      final int digitsBeforeOldCursor = oldText
          .substring(0, oldValue.selection.end)
          .replaceAll(RegExp(r'\D'), '')
          .length;

      if (digitsBeforeOldCursor > 0) {
        newDigits =
            oldDigits.substring(0, digitsBeforeOldCursor - 1) +
            oldDigits.substring(digitsBeforeOldCursor);
        forcefullyRemoved = true;
      }
    }

    // 3. Formatlash: XX XXX XX XX
    final buffer = StringBuffer();
    for (int i = 0; i < newDigits.length; i++) {
      buffer.write(newDigits[i]);
      if ((i == 1 || i == 4 || i == 6) && i != newDigits.length - 1) {
        buffer.write(' ');
      }
    }

    final String formatted = buffer.toString();

    // 4. Kursorni hisoblash
    int digitsBeforeCursor = newText
        .substring(0, newValue.selection.end)
        .replaceAll(RegExp(r'\D'), '')
        .length;
    if (forcefullyRemoved) digitsBeforeCursor--;

    int selectionIndex = 0;
    int currentDigits = 0;
    for (
      int i = 0;
      i < formatted.length && currentDigits < digitsBeforeCursor;
      i++
    ) {
      selectionIndex++;
      if (RegExp(r'\d').hasMatch(formatted[i])) {
        currentDigits++;
      }
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
