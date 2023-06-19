import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/core/constant/constant.dart';
import 'package:pharmacy1/core/routes/routes.dart';
import 'package:pharmacy1/core/services/storage_service.dart';

class MyMiddleWare extends GetMiddleware {
  int? get priority => 1;

  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getBool(isLogedIn) == true) {
      return const RouteSettings(name: AppRoute.mainPage);
    }
    return null;
  }
}
