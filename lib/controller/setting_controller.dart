import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/core/constant/app_colors.dart';
import 'package:pharmacy1/core/constant/constant.dart';
import 'package:pharmacy1/core/functions/firebase_messaging.dart';
import 'package:pharmacy1/core/routes/routes.dart';
import 'package:pharmacy1/core/services/storage_service.dart';
import 'package:pharmacy1/data/model/pharmacy_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingController extends GetxController {
  @override
  void onInit() {
    isdark = Get.isDarkMode;
    super.onInit();
  }

  MyServices shared = Get.find();
  MyServices myServices = Get.find();
  bool isdark = false;

  changeThemeMode() async {
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      shared.sharedPreferences.setBool("isDark", false);
      isdark = false;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor:
            AppColor.backgroundScaffoldLight, // Navigation bar
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: AppColor.backgroundScaffoldLight,
        statusBarColor: AppColor.primaryColor, // Status bar
        statusBarIconBrightness: Brightness.light,
      ));
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      shared.sharedPreferences.setBool("isDark", true);
      isdark = true;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor:
            AppColor.backgroundScaffoldDark, // Navigation bar
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: AppColor.backgroundScaffoldDark,
        statusBarColor: AppColor.primaryColor, // Status bar
        statusBarIconBrightness: Brightness.dark,
      ));
    }

    update();
  }

  void contactPhone({required bool withMe}) {
    String number = withMe ? myNumber : hamedNumber;
    launchUrl(
      Uri.parse("tel:$number"),
    );
  }

  Future<void> contactWhatsapp({required bool withMe}) async {
    String number = withMe ? myNumber : hamedNumber;
    String text = withMe ? "" : "";
    var url = Uri.parse("whatsapp://send?phone=$number&text=$text");
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
      );
    }
  }

  Future<void> contactFaceBook() async {
    var url = Uri.parse(myFaceBookId);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void toEditPage() {
    PharmacyModel pharmacyModel = PharmacyModel.fromJson(
        jsonDecode(myServices.sharedPreferences.getString(pharmacyModelKey)!));
    Get.toNamed(AppRoute.editPage, arguments: pharmacyModel);
  }

  void logout() {
    myServices.sharedPreferences.remove(isLogedIn);
    myServices.sharedPreferences.remove(pharmacyModelKey);
    Get.offAllNamed(AppRoute.signUpPage);
  }
}
