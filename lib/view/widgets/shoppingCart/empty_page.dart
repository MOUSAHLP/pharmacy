import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.remove_shopping_cart_outlined,
          size: 80,
          color: Get.theme.primaryColor,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("لم تضف أي عناصر الى قائمة المشتريات بعد "),
      ],
    );
  }
}
