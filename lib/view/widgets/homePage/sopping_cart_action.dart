import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/controller/home_page_controller.dart';
import 'package:badges/badges.dart' as badges;

class ShoppingCartAction extends StatelessWidget {
  const ShoppingCartAction({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      builder: (controller) => IconButton(
        onPressed: () {
          controller.toShoppingCart();
        },
        icon: controller.shoppingCartList.keys.length > 0
            ? badges.Badge(
                badgeContent: Text(
                  controller.shoppingCartList.keys.length.toString(),
                  style: Get.textTheme.headline6!.copyWith(fontSize: 10),
                ),
                position: BadgePosition.topStart(
                  start: -15,
                  top: -15,
                ),
                badgeAnimation: const BadgeAnimation.scale(),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Get.theme.backgroundColor,
                ),
              )
            : Icon(
                Icons.shopping_cart_outlined,
                color: Get.theme.backgroundColor,
              ),
      ),
    );
  }
}
