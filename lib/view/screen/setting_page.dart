import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/controller/setting_controller.dart';
import 'package:pharmacy1/view/widgets/settingPage/contact_with_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: Get.height - Get.statusBarHeight - 60,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    controller.toEditPage();
                  },
                  title: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: context.theme.backgroundColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("تعديل معلومات الصيدلية"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GetBuilder<SettingController>(
                  builder: (controller) => SwitchListTile(
                    title: Row(
                      children: [
                        Icon(
                          controller.isdark
                              ? Icons.mode_night_outlined
                              : Icons.light_mode_outlined,
                          color: context.theme.backgroundColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("الوضع الداكن"),
                      ],
                    ),
                    value: controller.isdark,
                    onChanged: (val) {
                      controller.changeThemeMode();
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const ContactWith(
                  name: "المندوب",
                ),
                const SizedBox(
                  height: 40,
                ),
                const ContactWith(
                  name: "المطور",
                  facebook: "",
                ),
                const Spacer(),
                ListTile(
                  onTap: () {
                    controller.logout();
                  },
                  title: Row(
                    children: [
                      Icon(
                        Icons.login_outlined,
                        color: context.theme.backgroundColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("تسجيل الخروج"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
