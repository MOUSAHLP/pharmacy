import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/core/constant/constant.dart';
import 'package:pharmacy1/core/functions/mysnackbar.dart';
import 'package:pharmacy1/core/routes/routes.dart';
import 'package:pharmacy1/core/services/storage_service.dart';
import 'package:pharmacy1/data/model/pharmacy_model.dart';

class SignUpController extends GetxController {
  @override
  void onInit() {
    if (Get.arguments != null) {
      editInit();
    }
    super.onInit();
  }

  MyServices myServices = Get.find();
  TextEditingController pharmacyNameController = TextEditingController();
  TextEditingController pharmacyPlaceController = TextEditingController();
  TextEditingController pharmacyNumberController = TextEditingController();
  TextEditingController pharmacistNameController = TextEditingController();
  bool isPhoneValidation = false;

  editInit() {
    PharmacyModel pharmacyModel = Get.arguments;
    pharmacyNameController.text = pharmacyModel.pharmacyName!;
    pharmacyPlaceController.text = pharmacyModel.pharmacyPlace!;
    pharmacyNumberController.text = pharmacyModel.pharmacyNumber!;
    pharmacistNameController.text = pharmacyModel.pharmacistName!;
    isPhoneValidation = true;
  }

  String? phoneValidation(text) {
    if (text!.length < 10 || text.substring(0, 2) != "09") {
      isPhoneValidation = false;
      return "يرجى ادخال رقم هاتف صالح";
    }
    isPhoneValidation = true;
    return null;
  }

  bool formValidation() {
    if (pharmacyNameController.text.trim() == "" ||
        pharmacyPlaceController.text.trim() == "" ||
        pharmacyNumberController.text.trim() == "" ||
        pharmacistNameController.text.trim() == "" ||
        !isPhoneValidation) {
      return false;
    }
    return true;
  }

  submit() {
    if (formValidation()) {
      PharmacyModel pharmacyModel = PharmacyModel(
        pharmacyName: pharmacyNameController.text,
        pharmacyPlace: pharmacyPlaceController.text,
        pharmacyNumber: pharmacyNumberController.text,
        pharmacistName: pharmacistNameController.text,
      );
      String sharedModel = jsonEncode(pharmacyModel);
      myServices.sharedPreferences.setString(pharmacyModelKey, sharedModel);
      myServices.sharedPreferences.setBool(isLogedIn, true);
      if (Get.arguments == null) {
        Get.offAllNamed(AppRoute.mainPage);
      } else {
        Get.back();
        mySnackBar("نجاح", "تم تعديل البيانات بنجاح", icon: Icons.done);
      }
    } else {
      mySnackBar(
        "خطأ",
        "يرجى تعبئة بيانات صحيحة",
        icon: Icons.close,
      );
    }
  }
}
