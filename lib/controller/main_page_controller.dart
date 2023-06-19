import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/core/constant/constant.dart';
import 'package:pharmacy1/core/functions/awesome_notification.dart';
import 'package:pharmacy1/core/functions/firebase_messaging.dart';
import 'package:pharmacy1/view/screen/home_page.dart';
import 'package:pharmacy1/view/screen/setting_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MainPageController extends GetxController {
  List<Widget> pages = const [HomePage(), SettingPage()];
  PageController pageController = PageController(initialPage: 0);
  @override
  void onInit() {
    listenFCM();
    super.onInit();
  }

  int index = 0;

  void changePage(newIndex) {
    index = newIndex;
    pageController.jumpToPage(
      newIndex,
    );
    update();
  }
  //////////////////////////// for fcm messaging /////////////////////////

  void sendPushMessage() async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=BI8FS9SEKlPzCYgudr9QlJjDwZjuvVrT5nqtj5gihON5Y7Mf6uuBPD2Ck9BRhy6fB8nEuGNpCBgQavOzmZugPN0',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': 'Test Body',
              'title': 'Test Title 2'
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            // "to": "$token",
          },
        ),
      );
    } catch (e) {}
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await FirebaseMessaging.instance.subscribeToTopic("xpositron");

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
    } else {}
  }

  Future<String> _base64encodedImage(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    final String base64Data = base64Encode(response.bodyBytes);
    return base64Data;
  }

  notifyPermision() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void listenFCM() async {
    print(await FirebaseMessaging.instance.getToken());
    await FirebaseMessaging.instance.subscribeToTopic("users");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

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
      print(
          "send send send send send send send send send send send send send send send send ");
    });
  }
}
