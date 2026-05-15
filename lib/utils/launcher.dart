import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final url = Uri.parse('https://t.me/$supportTelegramUsername');
  try {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } catch (e) {
    debugPrint('Could not launch telegram: $e');
  }
}
