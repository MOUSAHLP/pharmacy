import 'package:get/get.dart';
import 'package:pharmacy1/core/middleware/my_middleware.dart';
import 'package:pharmacy1/view/screen/main_page.dart';
import 'package:pharmacy1/view/screen/setting_page.dart';
import 'package:pharmacy1/view/screen/shopping_cart_page.dart';
import 'package:pharmacy1/view/screen/signup.dart';

class AppRoute {
  static const String firstPage = "/";
  static const String mainPage = "/mainPage";
  static const String signUpPage = "/signUpPage";
  static const String editPage = "/editPage";
  static const String sittingPage = "/sittingPage";
  static const String shoppingPage = "/ShoppingPage";
}

List<GetPage<dynamic>>? routes = [
  GetPage(name: AppRoute.firstPage, page: () => const Signup(), middlewares: [
    MyMiddleWare(),
  ]),
  GetPage(
    name: AppRoute.mainPage,
    page: () => const MainPage(),
  ),
  GetPage(
    name: AppRoute.signUpPage,
    page: () => const Signup(),
  ),
  GetPage(
    name: AppRoute.editPage,
    page: () => const Signup(),
  ),
  GetPage(
    name: AppRoute.sittingPage,
    page: () => const SettingPage(),
  ),
  GetPage(
    name: AppRoute.shoppingPage,
    page: () => const ShoppingCartPage(),
  ),
];
