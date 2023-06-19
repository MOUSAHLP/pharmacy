import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/controller/home_page_controller.dart';

class RetryLayOut extends StatelessWidget {
  const RetryLayOut({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.mood_bad_outlined,
          size: 80,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "انت غير متصل بالانترنت",
          style: Get.textTheme.bodyText1,
        ),
        Text(
          "الرجاء الاتصال بالانترنت والمحاولة مجددا",
          style: Get.textTheme.caption,
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            controller.getAllMedicine();
          },
          child: Text("اعادة المحاولة"),
        ),
      ],
    );
  }
}
