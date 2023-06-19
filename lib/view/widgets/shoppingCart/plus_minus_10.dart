import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/controller/home_page_controller.dart';
import 'package:pharmacy1/data/model/medicine_model.dart';

class PlusMInus10 extends StatelessWidget {
  final bool isPlus;
  final MedicineModel medicineModel;
  const PlusMInus10(
      {super.key, required this.isPlus, required this.medicineModel});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();
    return GestureDetector(
      onTap: (() {
        if (isPlus) {
          controller.plusShopping(medicineModel, count: 10);
        } else {
          controller.minusShopping(medicineModel, count: 10);
        }
      }),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Get.theme.primaryColor, width: 2)),
        child: Text(
          isPlus ? "10+" : "10-",
          style: Get.textTheme.caption!
              .copyWith(color: Get.theme.primaryColor, fontSize: 8),
        ),
      ),
    );
  }
}
