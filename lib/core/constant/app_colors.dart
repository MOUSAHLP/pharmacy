import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColor {
  static Color primaryColorlight = const Color(0xff3fbffe);
  static Color primaryColordark = const Color(0xff3fbffe);
  static Color get primaryColor =>
      Get.isDarkMode ? primaryColordark : primaryColorlight;

  static Color secondaryColorlight = const Color(0xff1fbdf4);
  static Color secondaryColordark = const Color(0xff1fbdf4);

  static Color get secondaryColor =>
      Get.isDarkMode ? secondaryColordark : secondaryColorlight;

  static Color textColorLight = Colors.black;
  static Color textColorDark = Colors.white;
  static Color get textColor => Get.isDarkMode ? textColorDark : textColorLight;

  static Color backgroundLight = Colors.white;
  static Color backgroundDark = const Color(0xff363940);
  static Color get background =>
      Get.isDarkMode ? backgroundDark : backgroundLight;

  static Color backgroundScaffoldLight = const Color(0xfff9f9f9);
  static Color backgroundScaffoldDark = const Color(0xff313237);
  static Color get backgroundScaffold =>
      Get.isDarkMode ? backgroundDark : backgroundLight;
}
