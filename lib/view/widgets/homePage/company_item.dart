import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyItem extends StatelessWidget {
  final String companyName;
  final bool isActive;
  final Function() function;
  const CompanyItem(
      {super.key,
      required this.companyName,
      required this.isActive,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: isActive ? Get.theme.primaryColor : Get.theme.backgroundColor,
          border: Border.all(
            color: Get.theme.primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          companyName,
          style: isActive ? Get.textTheme.headline6 : Get.textTheme.bodyText2,
        ),
      ),
    );
  }
}
