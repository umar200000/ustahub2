import 'package:flutter/material.dart';
import 'package:ustahub/utils/constants.dart';

class AppConfig {
  String appName = "";
  String baseUrl = "";
  Color primaryColor = const Color(0xFF02BDC6);

  static AppConfig shared = AppConfig.create();

  factory AppConfig.create({
    String appName = Constants.appName,
    String baseUrl = Constants.baseUrlP,
    Color primaryColor = const Color(0xFF02BDC6),
  }) {
    shared = AppConfig(appName, baseUrl, primaryColor);
    return shared;
  }

  AppConfig(this.appName, this.baseUrl, this.primaryColor);
}
