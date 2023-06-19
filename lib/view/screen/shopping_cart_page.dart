import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/controller/home_page_controller.dart';
import 'package:pharmacy1/view/widgets/shoppingCart/contact_shopping_page.dart';
import 'package:pharmacy1/view/widgets/shoppingCart/empty_page.dart';
import 'package:pharmacy1/view/widgets/shoppingCart/sopping_item.dart';
import 'package:pharmacy1/view/widgets/shoppingCart/to_shopping_card.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "قائمة المشتريات",
          style: Get.textTheme.headline6!.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          const ShoppingCardHead(),
          Expanded(
            child: GetBuilder<HomePageController>(
              builder: (controller) {
                if (controller.shoppingCartList.isEmpty) {
                  return const EmptyPage();
                }

                return ListView.builder(
                  itemCount: controller.shoppingCartList.length,
                  itemBuilder: (context, index) {
                    return ShopinngItem(
                      medicineModel:
                          controller.shoppingCartList.keys.toList()[index],
                    );
                  },
                );
              },
            ),
          ),
          GetBuilder<HomePageController>(
            builder: (controller) {
              if (controller.shoppingCartList.isNotEmpty) {
                return const ContactShoppingPage();
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
