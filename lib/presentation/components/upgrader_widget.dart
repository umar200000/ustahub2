// import 'dart:io';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:upgrader/upgrader.dart';

// class UpgraderWidget extends StatelessWidget {
//   final Widget child;

//   const UpgraderWidget({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return UpgradeAlert(
//       showIgnore: false,
//       dialogStyle: Platform.isIOS
//           ? UpgradeDialogStyle.cupertino
//           : UpgradeDialogStyle.material,
//       upgrader: Upgrader(
//           languageCode: context.locale.languageCode == "ru" ? 'ru' : 'en',
//           countryCode: context.locale.countryCode == "RU" ? 'RU' : null,
//           messages: MyUzbekMessages(
//               context.locale.languageCode == "ru" ? 'ru' : 'en')),
//       child: child,
//     );
//   }
// }

// class MyUzbekMessages extends UpgraderMessages {
//   @override
//   final String languageCode;

//   MyUzbekMessages(this.languageCode);

//   @override
//   String? message(UpgraderMessage messageKey) {
//     if (languageCode == 'en') {
//       switch (messageKey) {
//         case UpgraderMessage.body:
//           return '{{appName}} ilovasining yangi versiyasi chiqdi! Yangi versiya: {{currentAppStoreVersion}}, joriy versiya: {{currentInstalledVersion}}.';
//         case UpgraderMessage.buttonTitleIgnore:
//           return "E'tibor bermaslik";
//         case UpgraderMessage.buttonTitleLater:
//           return 'Keyinroq';
//         case UpgraderMessage.buttonTitleUpdate:
//           return 'Hozir yangilash';
//         case UpgraderMessage.prompt:
//           return 'Yangilashni xohlaysizmi?';
//         case UpgraderMessage.releaseNotes:
//           return 'Yangilanshda:';
//         case UpgraderMessage.title:
//           return 'Ilova yangilansinmi?';
//       }
//     }
//     return super.message(messageKey);
//   }
// }
