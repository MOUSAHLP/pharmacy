import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/controller/main_page_controller.dart';
import 'package:pharmacy1/core/constant/app_colors.dart';
import 'package:pharmacy1/view/widgets/mainPage/my_bottom_navigation_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MainPageController());

    if (Get.isDarkMode) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor:
            AppColor.backgroundScaffoldDark, // Navigation bar
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: AppColor.backgroundScaffoldDark,
        statusBarColor: AppColor.primaryColor, // Status bar
        statusBarIconBrightness: Brightness.light,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor:
            AppColor.backgroundScaffoldLight, // Navigation bar
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: AppColor.backgroundScaffoldLight,
        statusBarColor: AppColor.primaryColor, // Status bar
        statusBarIconBrightness: Brightness.dark,
      ));
    }

    return Scaffold(
      bottomNavigationBar: const MyBottomNavigationBar(),
      body: GetBuilder<MainPageController>(
        builder: (controller) => PageView(
          controller: controller.pageController,
          reverse: true,
          onPageChanged: controller.changePage,
          children: controller.pages,
        ),
      ),
    );
  }
}
