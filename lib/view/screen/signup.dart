import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/controller/signup_controller.dart';
import 'package:pharmacy1/view/widgets/custom_input.dart';
import 'package:pharmacy1/view/widgets/my_header.dart';

class Signup extends StatelessWidget {
  const Signup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 150,
              child: MyHeader(
                child: Column(
                  children: [
                    if (Get.arguments != null)
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Get.theme.backgroundColor,
                          ),
                        ),
                      ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        Get.arguments == null
                            ? "عرفنا عن نفسك"
                            : "تعديل البيانات",
                        style: Get.textTheme.headline6!.copyWith(
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyInput(
                    hint: "اسم الصيدلية",
                    mycontroller: controller.pharmacyNameController,
                    function: (s) {},
                    icon: Icons.local_pharmacy_outlined,
                    textInputAction: TextInputAction.next,
                    maxLength: 15,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyInput(
                    hint: "مكان الصيدلية",
                    mycontroller: controller.pharmacyPlaceController,
                    function: (s) {},
                    icon: Icons.location_on_outlined,
                    textInputAction: TextInputAction.next,
                    maxLength: 15,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyInput(
                    hint: "اسم الصيدلي",
                    mycontroller: controller.pharmacistNameController,
                    function: (s) {},
                    icon: Icons.person,
                    textInputAction: TextInputAction.next,
                    maxLength: 15,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyInput(
                    hint: "رقم الصيدلية",
                    mycontroller: controller.pharmacyNumberController,
                    icon: Icons.phone_in_talk_outlined,
                    function: (s) {},
                    validatorFun: controller.phoneValidation,
                    isText: false,
                    maxLength: 10,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                controller.submit();
              },
              child: Text(
                Get.arguments == null ? "تسجيل الدخول" : "تعديل",
                style: Get.textTheme.headline6,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
