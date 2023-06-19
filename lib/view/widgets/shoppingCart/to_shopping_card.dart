import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/controller/home_page_controller.dart';
import 'package:pharmacy1/view/widgets/my_header.dart';

class ShoppingCardHead extends StatelessWidget {
  const ShoppingCardHead({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();

    return GestureDetector(
      onTap: () {
        controller.toShoppingCart();
      },
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: MyHeader(
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: Column(children: [
              Text(
                "قم بأدارة قائمة مشترياتك وتواصل مع المندوب",
                style: Get.textTheme.headline6!.copyWith(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              GetBuilder<HomePageController>(builder: (controller) {
                if (controller.shoppingCartList.isNotEmpty) {
                  return Text(
                    "عدد المشتريات الكلي :  ${controller.getCountAllMedicine()}",
                    style: Get.textTheme.headline6!.copyWith(
                      fontSize: 16,
                    ),
                  );
                }
                return Container();
              }),
            ]),
          ),
        ),
      ),
    );
  }
}
