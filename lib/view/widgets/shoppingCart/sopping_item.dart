import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/controller/home_page_controller.dart';
import 'package:pharmacy1/data/model/medicine_model.dart';
import 'package:pharmacy1/view/widgets/shoppingCart/plus_minus_10.dart';

class ShopinngItem extends StatelessWidget {
  final MedicineModel medicineModel;
  const ShopinngItem({super.key, required this.medicineModel});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicineModel.name!,
                    style: Get.textTheme.bodyText2!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${medicineModel.price}",
                    style: Get.textTheme.bodyText2!.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GetBuilder<HomePageController>(
              builder: (controller) => Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          PlusMInus10(
                              medicineModel: medicineModel, isPlus: true),
                          IconButton(
                            onPressed: () {
                              controller.plusShopping(medicineModel);
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: Get.theme.primaryColor,
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${controller.getNumberOfMedicine(medicineModel)}",
                      ),
                      Row(
                        children: [
                          PlusMInus10(
                              medicineModel: medicineModel, isPlus: false),
                          IconButton(
                            onPressed: () {
                              controller.minusShopping(medicineModel);
                            },
                            icon: Icon(
                              Icons.remove_circle_outline_outlined,
                              color: Get.theme.primaryColor,
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        controller.removeShopping(medicineModel);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 32,
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
