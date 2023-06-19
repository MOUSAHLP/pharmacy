import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/controller/home_page_controller.dart';
import 'package:pharmacy1/view/widgets/custom_input.dart';
import 'package:pharmacy1/view/widgets/homePage/company_item.dart';
import 'package:pharmacy1/view/widgets/homePage/grid_medicines.dart';
import 'package:pharmacy1/view/widgets/homePage/sopping_cart_action.dart';
import 'package:pharmacy1/view/widgets/my_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomePageController());

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "الصفحة الرئيسية",
            style: Get.textTheme.headline6!.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: const [
            ShoppingCartAction(),
          ]),
      body: Column(
        children: [
          MyHeader(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "تصفح أدوية مستودع كريم الدين الاتختصاصي\n و تواصل مع المندوب",
                    style: Get.textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyInput(
                    hint: "ابحث عن الدواء",
                    mycontroller: controller.searchController,
                    isText: true,
                    icon: Icons.search,
                    function: (text) async {
                      await controller.search();
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          GetBuilder<HomePageController>(
            builder: (controller) =>
                controller.isloading || controller.allMedicince.isEmpty
                    ? const SizedBox()
                    : Container(
                        height: 50,
                        margin: const EdgeInsets.all(10),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.allCompany.length,
                          itemBuilder: (context, index) {
                            return CompanyItem(
                              companyName: controller.allCompany[index],
                              function: () async {
                                controller.companyFilter(index);
                              },
                              isActive: index == controller.activeCompany,
                            );
                          },
                        ),
                      ),
          ),
          const Expanded(
            child: GridMedicines(),
          )
        ],
      ),
    );
  }
}
