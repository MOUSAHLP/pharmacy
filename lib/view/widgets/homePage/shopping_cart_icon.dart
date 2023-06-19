import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/data/model/medicine_model.dart';

class ShoppingCartIcon extends StatelessWidget {
  final MedicineModel medicineModel;
  const ShoppingCartIcon({super.key, required this.medicineModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(
          10,
        ),
        border: Border.all(
          width: 2,
          color: Get.theme.primaryColor,
        ),
      ),
      child: Icon(
        Icons.add_shopping_cart_outlined,
        color: Get.theme.primaryColor,
        size: 20,
      ),
    );
  }
}
