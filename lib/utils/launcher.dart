import 'package:url_launcher/url_launcher.dart';

callLauncher(String phone) async {
  try {
    final url = Uri(path: phone, scheme: "tel");

    await launchUrl(url);
  } catch (e) {
    throw 'Could not launch $e';
  }
}
