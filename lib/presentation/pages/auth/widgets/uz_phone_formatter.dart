import 'package:flutter/services.dart';

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

    final buffer = StringBuffer();
    for (int i = 0; i < newDigits.length; i++) {
      buffer.write(newDigits[i]);
      if ((i == 1 || i == 4 || i == 6) && i != newDigits.length - 1) {
        buffer.write(' ');
      }
    }

    final String formatted = buffer.toString();

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
