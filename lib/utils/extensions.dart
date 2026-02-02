import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:ustahub/infrastructure/services/local_database/db_service.dart';
import 'package:ustahub/utils/constants.dart';

extension NumberExtention on num? {
  String toFormattedCurrency({
    bool withBillion = false,
    bool withCurrencyS = true,
    // required DBService dbService,
    // required String? currencyS,
  }) {
    if (this == null) {
      return '';
    }
    // String currency = currencyS ?? listCurrency.first;
    // num amount = this!;
    // if (currency != dbService.getCurrencySymbol) {
    //   if (currency == listCurrency.first) {
    //     amount = (amount * (dbService.getCurrencyAmount?.amount ?? 12740))
    //         .roundToDouble();
    //   }
    //   if (currency == listCurrency.last) {
    //     amount = (amount / (dbService.getCurrencyAmount?.amount ?? 12740))
    //         .roundToDouble();
    //   }
    // }
    String result = this!.toCurrencyString(
      shorteningPolicy: ShorteningPolicy.NoShortening,
      thousandSeparator: ThousandSeparator.Space,
    );
    if (result.endsWith('.00')) {
      result = result.replaceAll('.00', '');
    }

    if (withBillion) {
      result = result.replaceFirst("M", "");
    }

    if (withCurrencyS) {
      result = "$result ${"soum".tr()}";
    }

    return result;
  }

  String toDoubleFormattedCurrency({
    bool withBillion = false,
    bool withCurrencyS = true,
    required DBService dbService,
    required String? currencyS,
    required num secondValue,
  }) {
    if (this == null) {
      return '';
    }
    String currency = currencyS ?? listCurrency.first;
    num amount = this!;
    if (currency != dbService.getCurrencySymbol) {
      if (currency == listCurrency.first) {
        amount = (amount * (dbService.getCurrencyAmount?.amount ?? 12740))
            .roundToDouble();
      }
      if (currency == listCurrency.last) {
        amount = (amount / (dbService.getCurrencyAmount?.amount ?? 12740))
            .roundToDouble();
      }
    }
    String result = amount.toCurrencyString(
      shorteningPolicy:
          listCurrency.first == dbService.getCurrencySymbol || !withBillion
          ? ShorteningPolicy.NoShortening
          : ShorteningPolicy.RoundToMillions,
      thousandSeparator: ThousandSeparator.Space,
      trailingSymbol:
          listCurrency.first == dbService.getCurrencySymbol || !withBillion
          ? ''
          : "M",
    );
    if (result.endsWith('.00')) {
      result = result.replaceAll('.00', '');
    }

    if (withBillion) {
      result = result.replaceFirst("M", "");
    }

    if (withCurrencyS) {
      result = "$result ${dbService.getCurrencySymbol.tr()}";
    }
    num amount2 = secondValue;
    if (currency != dbService.getCurrencySymbol) {
      if (currency == listCurrency.first) {
        amount2 = (amount2 * (dbService.getCurrencyAmount?.amount ?? 12740))
            .roundToDouble();
      }
      if (currency == listCurrency.last) {
        amount2 = (amount2 / (dbService.getCurrencyAmount?.amount ?? 12740))
            .roundToDouble();
      }
    }
    String second = amount2.toCurrencyString(
      shorteningPolicy:
          listCurrency.first == dbService.getCurrencySymbol || !withBillion
          ? ShorteningPolicy.NoShortening
          : ShorteningPolicy.RoundToMillions,
      thousandSeparator: ThousandSeparator.Space,
    );
    if (second.endsWith('.00')) {
      second = second.replaceAll('.00', '');
    }

    if (withBillion) {
      second = second.replaceFirst("M", "");
    }

    result = "$second - $result";

    return result;
  }

  double? toFormattedCurrencyDouble({
    required DBService dbService,
    String? currencyS,
  }) {
    if (this == null) {
      return null;
    }
    String currency = currencyS ?? listCurrency.first;
    num amount = this!;
    if (currency != dbService.getCurrencySymbol) {
      if (currency == listCurrency.first) {
        amount = (amount * (dbService.getCurrencyAmount?.amount ?? 12740))
            .roundToDouble();
      }
      if (currency == listCurrency.last) {
        amount = (amount / (dbService.getCurrencyAmount?.amount ?? 12740))
            .roundToDouble();
      }
    }

    return amount.toDouble();
  }
}

extension NumberExtentionFormat on int {
  String formatNumber() {
    final regex = RegExp(r'(\d)(?=(\d{3})+(?!\d))');
    return toString().replaceAllMapped(regex, (Match match) => '${match[1]} ');
  }
}

extension EnumToString on Enum {
  String getName() {
    return toString().split('.')[1];
  }
}

extension StringCasingExtension on String {
  bool get isUrl {
    return startsWith('http://') || startsWith('https://');
  }

  bool get isFilePath {
    return !isUrl;
  }

  String ensureBaseUrl() {
    if (isUrl) {
      return this; // Already contains the base URL
    }

    return '${Constants.baseUrl}$this'; // Prepend base URL

    // return '${Constants.baseUrl}$this'; // Prepend base URL
  }

  String toCapitalized() {
    if (isNotEmpty) {
      return '${this[0].toUpperCase()}${substring(1, length)}';
    } else {
      return this;
    }
  }

  String cleanNumbers() {
    var s = "";
    for (int i = 0; i < length; i++) {
      if (!RegExp(r'^[0-9]').hasMatch(this[i])) {
        s += this[i];
      }
    }
    return s;
  }
}

extension TextAnimation on Text {
  Widget animateText() {
    return Animate(
      effects: [
        const FadeEffect(),
        SlideEffect(duration: 0.6.seconds),
        FadeEffect(begin: 0.0, end: 1.0, duration: 0.5.seconds),
      ],
      child: this,
      // .animate().fade().slideX(duration: 0.5.seconds)
    );
  }
}

//remove spaces
String formatPhoneNumber(String phoneNumber) {
  return phoneNumber.replaceAll(" ", '');
}

// add spaces
String? formatPhoneNumberAddSpaces(String? phoneNumber) {
  if (phoneNumber == null) {
    return null;
  }
  String separatedNumber = phoneNumber.replaceFirstMapped(
    RegExp(r'^(\+\d{3})(\d{2})(\d{3})(\d{2})(\d{2})$'),
    (match) =>
        '${match.group(1)} ${match.group(2)} ${match.group(3)} ${match.group(4)} ${match.group(5)}',
  );
  return separatedNumber;
}

Color colorValue(String? value) {
  if (value == null || value.isEmpty) {
    return Colors.transparent;
  } else {
    int colorValue = int.parse("0xFF${value.replaceAll('#', '')}");
    return Color(colorValue);
  }
}

String dateFormatValue(String? value) {
  if (value == null || value.isEmpty) {
    return "";
  } else {
    DateTime? dateTime = DateTime.tryParse(value);
    if (dateTime == null) {
      return value;
    } else {
      dateTime = dateTime.toLocal();
      String date = "";
      int day = calculateDifference(dateTime);
      dateTime = dateTime.toLocal();
      if (day == 0) {
        date = "${"today".tr()} ${DateFormat("HH:mm").format(dateTime)}";
      } else if (day == -1) {
        date = "${"yesterday".tr()} ${DateFormat("HH:mm").format(dateTime)}";
      } else {
        date = DateFormat("dd.MM.yyyy HH:mm").format(dateTime);
      }
      return date.toCapitalized();
    }
  }
}

String dateFullFormatValue(String? value, String locale) {
  if (value == null || value.isEmpty) {
    return "";
  } else {
    DateTime? dateTime = DateTime.tryParse(value);
    if (dateTime == null) {
      return value;
    } else {
      dateTime = dateTime.toLocal();
      String date = DateFormat("HH:mm dd MMMM yyyy", locale).format(dateTime);

      return date;
    }
  }
}

String dateDayFormatValue(String? value, String locale) {
  if (value == null || value.isEmpty) {
    return "";
  } else {
    DateTime? dateTime = DateTime.tryParse(value);
    if (dateTime == null) {
      return value;
    } else {
      dateTime = dateTime.toLocal();
      String date = DateFormat("d-MMMM", locale).format(dateTime);

      return date;
    }
  }
}

String dateHourFormatValue(String? value, String locale) {
  if (value == null || value.isEmpty) {
    return "";
  } else {
    DateTime? dateTime = DateTime.tryParse(value);
    if (dateTime == null) {
      return value;
    } else {
      dateTime = dateTime.toLocal();
      String date = DateFormat("HH:mm", locale).format(dateTime);

      return date;
    }
  }
}

String chatDateFormatValue(String? value, String locale) {
  if (value == null || value.isEmpty) {
    return "";
  } else {
    DateTime? dateTime = DateTime.tryParse(value);
    if (dateTime == null) {
      return value;
    } else {
      dateTime = dateTime.toLocal();
      String date = "";
      int day = calculateDifference(dateTime);
      if (day == 0) {
        date = "today".tr();
      } else if (day == -1) {
        date = "yesterday".tr();
      } else if (dateTime.year == DateTime.now().year) {
        date = DateFormat("dd MMMM", locale).format(dateTime);
      } else {
        date = DateFormat("dd MMMM yyy", locale).format(dateTime);
      }
      return date.toCapitalized();
    }
  }
}

String roomDateFormatValue(String? value, String locale) {
  if (value == null || value.isEmpty) {
    return "";
  } else {
    DateTime? dateTime = DateTime.tryParse(value);
    if (dateTime == null) {
      return value;
    } else {
      dateTime = dateTime;
      String date = "";
      int day = calculateDifference(dateTime);
      if (day == 0) {
        date = DateFormat("hh:mm", locale).format(dateTime);
      } else if (day == -1) {
        date = "yesterday".tr();
      } else {
        date = DateFormat("dd MMMM", locale).format(dateTime);
      }
      return date.toCapitalized();
    }
  }
}

int calculateDifference(DateTime date) {
  DateTime now = DateTime.now();
  return DateTime(
    date.year,
    date.month,
    date.day,
  ).difference(DateTime(now.year, now.month, now.day)).inDays;
}

extension PercentageCalculation on double {
  String percentageIncrease(double originalValue) {
    double difference = this - originalValue;
    if (originalValue == 0) {
      return "";
    }
    return ((difference / originalValue) * 100).toInt().toString();
  }

  String percentageDecrease(double originalValue) {
    double difference = originalValue - this;
    return ((difference / originalValue) * 100).toInt().toString();
  }

  String format() {
    if (this % 1 == 0) {
      return toInt().toString();
    } else {
      return toString();
    }
  }
}

DateTime? parseDateString(String dateString) {
  DateTime? parsedDate;

  DateFormat dateFormat = DateFormat("dd.MM.yyyy");
  parsedDate = dateFormat.tryParse(dateString);

  if (parsedDate == null) {
    DateFormat dateFormat2 = DateFormat("yyyy-MM-dd");
    parsedDate = dateFormat2.tryParse(dateString);
  }

  return parsedDate;
}

String obfuscateName(String name) {
  final parts = name.split(' ');

  final obfuscatedParts = parts.map((part) {
    if (part.isEmpty) return part;
    return '${part[0]}${'*' * (part.length - 1)}';
  }).toList();

  return obfuscatedParts.join(' ');
}

String? toFilterString(
  dynamic to,
  dynamic from,
  String type,
  String locale, {
  bool hasFormat = true,
}) {
  if (to == null && from == null) {
    return null;
  } else {
    if (hasFormat) {
      to = double.tryParse(to.toString()) ?? to;
      if (to is double) {
        to = to.toCurrencyString(
          thousandSeparator: ThousandSeparator.Space,
          mantissaLength: 0,
        );
      }
      from = double.tryParse(from.toString()) ?? from;
      if (from is double) {
        from = from.toCurrencyString(
          thousandSeparator: ThousandSeparator.Space,
          mantissaLength: 0,
        );
      }
    }
    if (to != null && from != null) {
      return "$to - $from ${type.toLowerCase()}";
    }
    if (to != null) {
      if (locale == "uz") {
        return "$to ${type.toLowerCase()} ${"from".tr()}";
      } else {
        return "${"from".tr()} $to ${type.toLowerCase()}";
      }
    }

    if (from != null) {
      if (locale == "uz") {
        return "$from ${type.toLowerCase()} ${"to".tr()}";
      } else {
        return "${"to".tr()} $from ${type.toLowerCase()}";
      }
    }
  }
  return null;
}

String obscurePhoneNumber(String phoneNumber) {
  if (phoneNumber.length < 8) {
    return ""; // return as is if length is too short
  }

  String prefix = phoneNumber.substring(0, phoneNumber.length - 7);
  String suffix = phoneNumber.substring(phoneNumber.length - 4);

  return '$prefix***$suffix';
}

String formattedDate(DateTime selectedDate) =>
    DateFormat('MM-dd-yyyy').format(selectedDate);

bool isToday(DateTime startTime) {
  DateTime now = DateTime.now();
  return startTime.year == now.year &&
      startTime.month == now.month &&
      startTime.day == now.day;
}

/// Normalizes time string for comparison by ensuring consistent formatting
/// Handles both "0:00 - 1:00" and "00:00 - 01:00" formats
/// Converts single-digit hours to double-digit format (e.g., "0:00" -> "00:00")
String normalizeTimeString(String time) {
  if (time.isEmpty) return time;
  // Replace single digit hours with double digits (e.g., "0:00" -> "00:00")
  // This regex matches a single digit followed by colon and two digits
  return time.replaceAllMapped(RegExp(r'(\d):(\d{2})'), (match) {
    final hour = match.group(1)!;
    final minutes = match.group(2)!;
    // Only pad if it's a single digit hour (0-9)
    if (hour.length == 1) {
      return '0$hour:$minutes';
    }
    return match.group(0)!;
  });
}

class TimeSlot {
  final String title;
  final DateTime startTime;
  final DateTime endTime;

  TimeSlot(this.title, this.startTime, this.endTime);
}

List<TimeSlot> get generateTimeSlots {
  DateTime now = DateTime.now();
  DateTime start = DateTime(now.year, now.month, now.day, now.hour, now.minute);

  start = start
      .add(const Duration(hours: 2))
      .subtract(Duration(minutes: start.minute));

  List<TimeSlot> slots = [];
  DateTime slotStart = start;
  DateTime tomorrow = DateTime(
    now.year,
    now.month,
    now.day,
  ).add(const Duration(days: 1));
  DateTime endOfDay = DateTime(
    tomorrow.year,
    tomorrow.month,
    tomorrow.day,
    0,
    0,
  ); // Midnight of next day

  while (slotStart.isBefore(endOfDay)) {
    DateTime slotEnd = slotStart.add(const Duration(hours: 1));
    String title =
        '${DateFormat("HH:mm").format(slotStart)} - ${DateFormat("HH:mm").format(slotEnd)}';
    slots.add(TimeSlot(title, slotStart, slotEnd));
    slotStart = slotEnd;
  }

  slotStart = DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 0, 0);
  endOfDay = DateTime(tomorrow.year, tomorrow.month, tomorrow.day, now.hour, 0);

  while (slotStart.isBefore(endOfDay)) {
    DateTime slotEnd = slotStart.add(const Duration(hours: 1));
    String title =
        '${DateFormat("HH:mm").format(slotStart)} - ${DateFormat("HH:mm").format(slotEnd)}';
    slots.add(TimeSlot(title, slotStart, slotEnd));
    slotStart = slotEnd;
  }

  return slots;
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) return newValue;
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final value = int.tryParse(newValue.text.replaceAll(',', ''));
    if (value == null) {
      return oldValue;
    }

    final formatted = value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class CardMMYYFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1 && i != text.length - 1) {
        buffer.write('/');
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

extension DateTimeExtension on DateTime {
  String formatTimeDifference(
    DateTime? endDate, {
    bool isReceived = false,
    BuildContext? context,
  }) {
    if (endDate == null) {
      return "0 ${"min".tr()}";
    }

    final difference = endDate.difference(this);
    final minutes = difference.inMinutes;
    final hours = difference.inHours;

    if (minutes < 1) {
      return "1 ${"min".tr()} ${"before".tr()}";
    }

    if (minutes < 60) {
      return "$minutes ${"min".tr()} ${"before".tr()}";
    }

    if (hours < 2) {
      return "$hours ${"hour".tr()} ${"before".tr()}";
    }

    // Check if the date is today, yesterday or older
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final startDay = DateTime(year, month, day);

    final timeFormat = DateFormat('HH:mm');
    final formattedTime = timeFormat.format(this);

    if (startDay.isAtSameMomentAs(today)) {
      return "${"today".tr()} $formattedTime";
    } else if (startDay.isAtSameMomentAs(yesterday)) {
      return "${"yesterday".tr()} $formattedTime";
    } else {
      // Use the DateFormat with current locale for short month name (3 letters)
      final monthFormat = DateFormat(
        'MMM',
        context?.locale.languageCode ?? 'en',
      );
      final day = this.day;
      final month = monthFormat.format(this).toLowerCase();
      return "$day $month $formattedTime";
    }
  }
}
