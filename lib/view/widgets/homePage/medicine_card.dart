import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/controller/home_page_controller.dart';
import 'package:pharmacy1/core/constant/app_colors.dart';
import 'package:pharmacy1/data/model/medicine_model.dart';
import 'package:badges/badges.dart' as badges;
import 'package:pharmacy1/view/widgets/homePage/shopping_cart_icon.dart';

class MedicineCard extends StatelessWidget {
  final MedicineModel medicineModel;
  const MedicineCard({
    super.key,
    required this.medicineModel,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();
    return GestureDetector(
      onTap: () {
        controller.addToShopinngCart(medicineModel);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${medicineModel.company}",
                  style: Get.textTheme.bodyText2,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${medicineModel.name}",
                      style: Get.textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                    ),
                    if (medicineModel.notes != null)
                      Text(
                        "${medicineModel.notes}",
                        style: Get.textTheme.caption!.copyWith(
                          fontSize: 8,
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    controller.getNumberOfMedicine(medicineModel) != null
                        ? badges.Badge(
                            badgeContent: Text(
                              controller.shoppingCartList[medicineModel]
                                  .toString(),
                              style: Get.textTheme.headline6!
                                  .copyWith(fontSize: 10),
                            ),
                            position: BadgePosition.topStart(
                              start: -7,
                              top: -7,
                            ),
                            badgeAnimation: const BadgeAnimation.scale(),
                            child: ShoppingCartIcon(
                              medicineModel: medicineModel,
                            ))
                        : ShoppingCartIcon(
                            medicineModel: medicineModel,
                          ),
                    Text(
                      "${medicineModel.price}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
