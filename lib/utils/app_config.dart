import 'package:flutter/material.dart';
import 'package:ustahub/utils/constants.dart';

class AppConfig {
  String appName = "";
  String baseUrl = "";
  MaterialColor primaryColor = Colors.blue;

  static AppConfig shared = AppConfig.create();

  factory AppConfig.create({
    String appName = Constants.appName,
    String baseUrl = Constants.baseUrlP,
    MaterialColor primaryColor = Colors.blue,
  }) {
    shared = AppConfig(appName, baseUrl, primaryColor);
    return shared;
  }

  AppConfig(this.appName, this.baseUrl, this.primaryColor);
}
