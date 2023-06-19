import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/core/constant/constant.dart';
import 'package:pharmacy1/core/functions/firebase_messaging.dart';
import 'package:pharmacy1/core/functions/mysnackbar.dart';
import 'package:pharmacy1/core/routes/routes.dart';
import 'package:pharmacy1/core/services/storage_service.dart';
import 'package:pharmacy1/data/dataSource/local_database.dart';
import 'package:pharmacy1/data/model/medicine_model.dart';
import 'package:pharmacy1/data/model/pharmacy_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class HomePageController extends GetxController {
  @override
  void onInit() {
    getAllMedicine();
    super.onInit();
  }

  bool isloading = false;
  int activeCompany = 0;
  MyServices myServices = Get.find();
  TextEditingController searchController = TextEditingController();
  List<MedicineModel> allMedicince = [];
  Map<MedicineModel, int> shoppingCartList = {};
  List<String> allCompany = ["الكل"];

  Map getDataToSave() {
    Map json = {"data": {}, "version": ""};
    Map<String, List<Map>> map = {};
    print("csds");

    for (var element in allMedicince) {
      List<Map> temp = [];
      if (map.containsKey(element.company)) {
        temp = (map[element.company]!);
        temp.add(element.toJson());
        map[element.company!] = temp;
      } else {
        map.addAll({
          element.company!: [element.toJson()]
        });
      }
    }

    json["data"] = map;
    json["version"] = "0";
    return json;
  }

  fetchData() async {
    try {
      print("start");
      var getSha = await http.get(
        Uri.parse(
            "https://api.github.com/repos/RLC-Company/pharmacy/contents/myAPI.json"),
      );
      var responeSha = jsonDecode(getSha.body);
      var sha = responeSha["sha"];
      print(responeSha);
      print(sha);
      var req = await http.put(
          Uri.parse(
              "https://api.github.com/repos/RLC-Company/pharmacy/contents/myAPI.json"),
          body: jsonEncode(
            {
              "message": "message",
              "content":
                  base64.encode(utf8.encode(jsonEncode(getDataToSave()))),
              "sha": "$sha"
            },
          ),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer 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"
          });
      var res = req.body;

      print(res);
      print("end");
    } catch (e) {
      print(e);
    }
  }

  Future<bool> didVersionChange() async {
    SharedPreferences background = await getshared();
    String newVersion = background.getString(newVersionKey) ?? "0";
    String oldVersion =
        myServices.sharedPreferences.getString(myVersionKey) ?? "0";

    if (oldVersion == "0") {
      return true;
    } else {
      bool hasChanged = newVersion != oldVersion;
      return hasChanged;
    }
  }

  Future<Map?> getdataFromServer() async {
    print("get start");
    try {
      var getData = await http.get(
        Uri.parse(myAPIUrl),
      );
      var respone = jsonDecode(getData.body);
      print(respone);
      print("get end");
      return respone;
    } catch (e) {
      print(e);
      return null;
    }
  }

  getAllMedicine() async {
    isloading = true;
    update();
    print("didVersionChange============================= ");
    print(await didVersionChange());
    print("didVersionChange=============================");
    if (await didVersionChange()) {
      Map? data = await getdataFromServer();
      SharedPreferences background = await getshared();

      String newVersion = background.getString(newVersionKey) ?? "0";

      if ((data != null && data["version"] == newVersion) ||
          newVersion == "0") {
        await DatabaseHelper.instance.clearTable();

        DatabaseHelper databaseHelper = DatabaseHelper.instance;

        Database? db = await databaseHelper.database;
        var batch = db!.batch();
        data!["data"].forEach((companyName, allMedicinceValue) {
          allMedicinceValue.forEach((medicine) async {
            MedicineModel medicineModel = MedicineModel.fromJson(medicine);
            medicineModel.id = null;

            batch.insert(DatabaseHelper.table, medicineModel.toJson());
            // await DatabaseHelper.instance.insert(medicineModel);
          });
        });
        await batch.commit(noResult: true);

        SharedPreferences background = await getshared();
        await background.setString(newVersionKey, data["version"]);
        await background.setString(myVersionKey, data["version"]);
      }
    }
    await updateFromLocalDatabase();
    isloading = false;
    update();
  }
  // getAllMedicine() async {
  //   isloading = true;
  //   update();
  //   allMedicince.clear();
  //   DatabaseHelper.instance.clearTable();

  //   await rootBundle.loadString('assets/data.txt').then((String value) {
  //     List s = value.split("\n");
  //     for (int i = 0; i < s.length; i++) {
  //       MedicineModel medicineModel = MedicineModel();
  //       medicineModel.name = s[i].split("،")[0];
  //       medicineModel.price = s[i].split("،")[1];
  //       if (i > 4) {
  //         medicineModel.company = "ابن سينا";
  //       } else {
  //         medicineModel.company = "الفا";
  //       }
  //       if (!allCompany.contains(medicineModel.company)) {
  //         allCompany.add(medicineModel.company ?? "a");
  //       }

  //       medicineModel.notes = "حسم 10% تاريخ 2023/11";

  //       DatabaseHelper.instance.insert(medicineModel);
  //     }
  //     updateFromLocalDatabase();
  //     isloading = false;
  //     update();
  //   });
  // }

  updateFromLocalDatabase() async {
    allMedicince.clear();
    allCompany.clear();
    allCompany.add("الكل");
    allMedicince
        .addAll(await DatabaseHelper.instance.queryAllRows(orderBy: "ASC"));

    for (var medicince in allMedicince) {
      allCompany.addIf(
          !allCompany.contains(medicince.company!), medicince.company!);
    }
  }

  Future<void> makeAnOrder() async {
    PharmacyModel pharmacyModel = PharmacyModel.fromJson(
        jsonDecode(myServices.sharedPreferences.getString(pharmacyModelKey)!));

    Map<String, int> order = {};
    shoppingCartList.forEach((key, value) {
      order["${key.name}"] = value;
    });
    String usertoken = await FirebaseMessaging.instance.getToken() ?? "null";
    Map orderData = {
      "pharmacyModel": pharmacyModel,
      "order": order,
      "totalPrice": getTotalPrice(),
      "token": usertoken,
      "date": DateTime.now().toString()
    };
    await sendPushMessage(
        title: "طلب جديد",
        body: "طلبت صيدلية ${pharmacyModel.pharmacyName} "
            " طلبا جديدا ",
        data: orderData,
        to: "admin");
  }

  Future<void> sendPushMessage(
      {required String title,
      required String body,
      required Map data,
      required String to}) async {
    try {
      var res = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAmNrqVwA:APA91bHpa79I0hQ4SHljmTEutTASl3mSr1n1RsYasdxoZESVHKBMqiPg6Ft-9iaZlz419e00r_yNkZ9nb_juUyW71s-ThN1XGQmE8GDNgNY5IYtlMlkaF5Ng_68CMIiMsKeNgSrYapSJ',
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': {
              'notification': <String, dynamic>{'title': title, 'body': body},
              "data": data
            },
            "to": "/topics/$to"
            // "dDJzdbCkTWKDQ04xRebqte:APA91bGAYoUSPSgaK1ugxOljrZlZzToYMhZBUJZtMZYU2lbGZ1BfuS6-ZMIsWvrKprPRN1bHiX8abLqvd9LC_OLPzulnAI9pbyfAwIR0XkUM02xwB9ulcdG3sGEzm32ZurOqmTLWUh02",
          },
        ),
      );
      print("res.body=================");
      print(res.body);
      if (res.statusCode == 200) {
        Get.back();
        shoppingCartList.clear();
        mySnackBar("نجاح", "تم اشعار المندوب وسيتم التواصل معك",
            icon: Icons.done);
      }
    } catch (e) {
      print(e);
      print(" e e e e e");
      mySnackBar("خطا", "حدث خطأ ما الرجاء التأكد من الانترنت",
          icon: Icons.close);
    }
  }

  search() async {
    if (searchController.text == "" && activeCompany == 0) {
      getAllMedicine();
    } else {
      allMedicince.clear();
      if (activeCompany == 0) {
        allMedicince.addAll(await DatabaseHelper.instance
            .queryAllRows(where: "name LIKE '%${searchController.text}%'"));
      } else {
        allMedicince.addAll(await DatabaseHelper.instance.queryAllRows(
            where:
                "name LIKE '%${searchController.text.trim()}%' AND company = '${allCompany[activeCompany]}' "));
      }
    }
    update();
  }

  void companyFilter(int index) async {
    activeCompany = index;
    search();
  }

  void addToShopinngCart(MedicineModel medicineModel) {
    if (shoppingCartList.containsKey(medicineModel)) {
      shoppingCartList.update(medicineModel, (value) => value + 1);
    } else {
      shoppingCartList.addAll({medicineModel: 1});
      // mySnackBar("نجاح", "لقد اضفت ${medicineModel.name} الى قائمة مشترياتك",
      //     icon: Icons.close);
    }
    update();
  }

  void plusShopping(MedicineModel medicineModel, {int count = 1}) {
    shoppingCartList.update(medicineModel, (value) => value + count);
    update();
  }

  void minusShopping(MedicineModel medicineModel, {int count = 1}) {
    if (shoppingCartList[medicineModel]! > count) {
      shoppingCartList.update(medicineModel, (value) => value - count);
    } else {
      shoppingCartList.remove(medicineModel);
    }
    update();
  }

  void removeShopping(MedicineModel medicineModel) {
    shoppingCartList.remove(medicineModel);
    update();
  }

  getNumberOfMedicine(MedicineModel medicineModel) {
    if (shoppingCartList.containsKey(medicineModel)) {
      return shoppingCartList[medicineModel];
    }
    return null;
  }

  getCountAllMedicine() {
    int count = 0;
    shoppingCartList.forEach((key, value) {
      count += value;
    });
    return count;
  }

  String getTotalPrice() {
    int totalPrice = 0;
    shoppingCartList.forEach((key, value) {
      totalPrice += int.parse(key.price!) * value;
    });

    String formatedPrice = "";

    for (int i = totalPrice.toString().length - 1; i >= 0; i--) {
      formatedPrice +=
          totalPrice.toString()[totalPrice.toString().length - 1 - i];
      if (i % 3 == 0 && i != 0) {
        formatedPrice += ",";
      }
    }
    return "$formatedPrice ل.س";
  }

  sendWhatsapp() async {
    PharmacyModel pharmacyModel = PharmacyModel.fromJson(
        jsonDecode(myServices.sharedPreferences.getString(pharmacyModelKey)!));
    String text = "اسم الصيدلية : ${pharmacyModel.pharmacyName} ";
    text += "\n موقع الصيدلية : ${pharmacyModel.pharmacyPlace}";
    text += "\n اسم الصيدلي : ${pharmacyModel.pharmacistName}";
    text += "\n";
    text += "\n";
    text += "الطلبية : ";
    text += "\n";
    shoppingCartList.forEach((key, value) {
      text += "\n";
      text += "${key.name} : $value";
    });
    text += "\n";
    text += "\n";
    text += "السعر الاجمالي : ${getTotalPrice()}";
    var url =
        Uri.parse("whatsapp://send?phone=$hamedNumberWithoutPlus&text=$text");
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
      );
    }
  }

  toShoppingCart() {
    Get.toNamed(AppRoute.shoppingPage)!.then((value) {
      update();
    });
  }
}
