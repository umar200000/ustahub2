import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ustahub/core/services/support_service.dart';

/// Fallback — SupportService yuklangandan keyin avtomatik ishlatiladi
const String supportTelegramUsername = 'MT1707';

callLauncher(String phone) async {
  try {
    final url = Uri(path: phone, scheme: "tel");
    await launchUrl(url);
  } catch (e) {
    throw 'Could not launch $e';
  }
}

Future<void> openSupportTelegram() async {
  final url = Uri.parse(SupportService().telegramUrl);
  try {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } catch (e) {
    debugPrint('Could not launch telegram: $e');
  }
}

Future<void> openSupportPhone() async {
  final url = Uri(scheme: 'tel', path: SupportService().phone);
  try {
    await launchUrl(url);
  } catch (e) {
    debugPrint('Could not launch phone: $e');
  }
}
