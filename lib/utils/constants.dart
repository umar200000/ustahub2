import 'package:easy_localization/easy_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Constants {
  static const String appName = "ustahub";
  // ---- JAMOLIDDIN ----
  // static const String baseUrlP = "http://10.0.36.201:8000/api/v1/";
  // ---- NURMUHAMMAD ----
  // static const String baseUrlP = "http://10.0.36.151:8000/api/v1/";
  // ---- SERVER ----
  static const String baseUrlP = "https://api.xolodilnik.uz/api/v1/";

  // --------------

  // ---- JAMOLIDDIN ----
  // static const String baseUrl = "http://10.0.36.201:8000";
  // ---- NURMUHAMMAD ----
  // static const String baseUrl = "http://10.0.36.151:8000";
  // ---- SERVER ----
  static const String baseUrl = "https://api.xolodilnik.uz";

  static const String websiteUrl = "https://xolodilnik.uz";
  static const String supportUrl = "https://xolodilnik.uz/support";
  static const String publicOfferta = "https://xolodilnik.uz/terms";
  static const String privacyPolicy = "https://xolodilnik.uz/privacy-policy";
  static const String appStoreUrl =
      "https://apps.apple.com/uz/app/sazu-market/id6745017870";
  static const String googlePlayUrl =
      "https://play.google.com/store/apps/details?id=com.asoschi.sazu_market";

  static String addLanguageUrl(String path) =>
      "$websiteUrl/${"app_lang".tr()}$path";
  static const String googleMapsApiKey =
      "AIzaSyDZHqWmGCX66NREG5QjvSP1QvEemhhijY0";
}

List<String> listProvince = <String>[
  "tashkent".tr(),
  "andijon".tr(),
  "bukhoro".tr(),
  "farghona".tr(),
  "jizzakh".tr(),
  "khorazm".tr(),
  "namangan".tr(),
  "navoiy".tr(),
  "kashkadaryo".tr(),
  "samarkand".tr(),
  "sirdaryo".tr(),
  "surkhondaryo".tr(),
  "korkalpogiston".tr(),
];

List<String> listCurrency = <String>["usd", "uzs"];

const List<LatLng> tashkentBoundary = [
  // First boundary section
  LatLng(41.1692538, 69.2277054),
  LatLng(41.1760901, 69.2049777),
  LatLng(41.2011516, 69.1852366),
  LatLng(41.2228466, 69.2001712),
  LatLng(41.2272363, 69.194163),
  LatLng(41.225679, 69.1849939),
  LatLng(41.2289147, 69.1751086),
  LatLng(41.2509166, 69.1632901),
  LatLng(41.2614987, 69.1478406),
  LatLng(41.2727901, 69.132377),
  LatLng(41.3058101, 69.1514314),
  LatLng(41.3302962, 69.1608097),
  LatLng(41.3524338, 69.1526756),
  LatLng(41.3709582, 69.1684628),
  LatLng(41.387012, 69.1852328),
  LatLng(41.3957443, 69.199658),
  LatLng(41.3952545, 69.2283275),
  LatLng(41.3983009, 69.2356588),
  LatLng(41.3972063, 69.260893),
  LatLng(41.3838928, 69.2843342),
  LatLng(41.3847181, 69.3173264),
  LatLng(41.3698797, 69.3243717),
  LatLng(41.3562439, 69.343214),
  LatLng(41.3632475, 69.3827119),
  // Second boundary section
  LatLng(41.3631086, 69.3824835),
  LatLng(41.3432102, 69.3945565),
  LatLng(41.3315157, 69.3759155),
  LatLng(41.3244842, 69.3882145),
  LatLng(41.3129453, 69.3699325),
  LatLng(41.3061758, 69.3410076),
  LatLng(41.289511, 69.3594733),
  LatLng(41.289962, 69.3729369),
  LatLng(41.2759013, 69.3798892),
  LatLng(41.2682049, 69.3655909),
  LatLng(41.2470512, 69.351313),
  LatLng(41.2369832, 69.3296836),
  LatLng(41.2189215, 69.279698),
  LatLng(41.1981127, 69.2496787),
  LatLng(41.1689951, 69.2277773),
];
