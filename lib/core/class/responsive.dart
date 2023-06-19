import 'package:get/get.dart';

bool get isSmall {
  print(Get.size.width);
  return Get.size.width < 350;
}
