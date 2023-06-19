import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/core/services/storage_service.dart';

class ThemeController {
  MyServices shared = Get.find();
  String key = "isDark";
  handelTheme() {
    bool? isDark = shared.sharedPreferences.getBool(key);
    final phoneTheme =
        SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
    if (isDark == null) {
      shared.sharedPreferences.setBool(key, phoneTheme);
      return phoneTheme;
    }

    return isDark;
  }

  ThemeMode get handelThemeGet =>
      handelTheme() ? ThemeMode.dark : ThemeMode.light;
}
