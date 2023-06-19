import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/controller/main_page_controller.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainPageController>(
      builder: (controller) => Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Get.theme.primaryColor,
                width: 2,
              ),
            ),
          ),
          child: BottomBarBubble(
            color: Get.theme.primaryColor,
            selectedIndex: controller.index,
            backgroundColor: context.theme.scaffoldBackgroundColor,
            items: [
              BottomBarItem(
                iconData: Icons.home,
              ),
              BottomBarItem(iconData: Icons.settings),
            ],
            onSelect: controller.changePage,
          ),
        ),
      ),
    );
  }
}
