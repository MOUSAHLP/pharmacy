import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pharmacy1/core/constant/constant.dart';
import 'package:pharmacy1/core/functions/awesome_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {
  SharedPreferences sharedPreferences = await getshared();
  sharedPreferences.reload().then((value) async {
    Map<String, dynamic> messageData = message.data;
    if (messageData != {}) {
      print(messageData);
      if (messageData["version"] != null) {
        await sharedPreferences.setString(
            newVersionKey, messageData["version"].toString());
        Future.delayed(Duration(minutes: 10), () async {
          Map notificationData = jsonDecode(messageData["notification"]);
          await pushNotification(
              id: 1,
              title: notificationData["title"] ?? "",
              body: notificationData["body"] ?? "");
        });
      } else {
        Map notificationData = jsonDecode(messageData["notification"]);
        await pushNotification(
            id: 1,
            title: notificationData["title"] ?? "",
            body: notificationData["body"] ?? "");
      }
    }
  });
}

Future<SharedPreferences> getshared() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.reload();
  return sharedPreferences;
}
