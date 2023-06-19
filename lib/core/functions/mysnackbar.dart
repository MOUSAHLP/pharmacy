import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/core/services/my_platform.dart';

mySnackBar(title, message, {IconData? icon}) {
  if (!Get.isSnackbarOpen) {
    Get.snackbar(title, message,
        backgroundColor: Get.theme.primaryColor,
        margin: MyPlatform.isWindows
            ? EdgeInsets.only(left: Get.width - 220, right: 20, bottom: 20)
            : EdgeInsets.zero,
        borderRadius: MyPlatform.isWindows ? 20 : 0,
        isDismissible: true,
        icon: Icon(
          icon,
          color: Get.theme.backgroundColor,
          size: 30,
        ),
        duration: const Duration(seconds: 2),
        colorText: Get.theme.backgroundColor,
        snackPosition: SnackPosition.BOTTOM);
  }
}
