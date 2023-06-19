import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/controller/home_page_controller.dart';
import 'package:pharmacy1/data/model/medicine_model.dart';
import 'package:pharmacy1/view/widgets/homePage/medicine_card.dart';
import 'package:pharmacy1/view/widgets/homePage/no_data_layout.dart';
import 'package:pharmacy1/view/widgets/homePage/retry_layout.dart';

class GridMedicines extends StatelessWidget {
  const GridMedicines({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      builder: (controller) => controller.isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : controller.searchController.text != "" &&
                  controller.allMedicince.isEmpty
              ? NoDataLayOut(
                  search: controller.searchController.text,
                )
              : controller.allMedicince.isEmpty
                  ? RetryLayOut()
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 6 / 8,
                      ),
                      itemCount: controller.allMedicince.length,
                      itemBuilder: (context, index) {
                        MedicineModel medicineModel =
                            controller.allMedicince[index];
                        return MedicineCard(
                          medicineModel: medicineModel,
                        );
                      },
                    ),
    );
  }
}
