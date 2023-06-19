import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoDataLayOut extends StatelessWidget {
  final String search;
  const NoDataLayOut({super.key, required this.search});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "لا يوجد نتائج لبحثك عن",
            style: Get.textTheme.bodyText2,
          ),
          Text(
            search,
            style: Get.textTheme.bodyText1!.copyWith(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
