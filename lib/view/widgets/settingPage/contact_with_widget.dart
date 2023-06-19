import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/controller/setting_controller.dart';
import 'package:pharmacy1/core/class/responsive.dart';

class ContactWith extends StatelessWidget {
  final String name;
  final String? facebook;
  const ContactWith({super.key, required this.name, this.facebook});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "تواصل مع $name ",
          style: Get.textTheme.bodyText1!.copyWith(
            fontSize: isSmall ? 16 : 18,
          ),
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  controller.contactWhatsapp(withMe: facebook != null);
                },
                icon: const Icon(
                  Icons.whatsapp,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: isSmall ? 10 : 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Get.theme.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  controller.contactPhone(withMe: facebook != null);
                },
                icon: const Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: isSmall ? 10 : 20,
            ),
            if (facebook != null)
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () async {
                    await controller.contactFaceBook();
                  },
                  icon: const Icon(
                    Icons.facebook,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
