import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy1/core/class/notification_listener.dart';

initialAwesomeNotification() async {
  AwesomeNotifications().initialize(
    "resource://drawable/logo",
    [
      NotificationChannel(
        channelGroupKey: 'my_foreground',
        channelKey: 'Notify',
        channelName: 'Pharmacy',
        channelDescription: 'Notification For Notifying The User',
        defaultColor: Colors.transparent,
        ledColor: Colors.black,
        playSound: true,
        enableVibration: true,
      ),
    ],
  );
  AwesomeNotifications().setListeners(
    onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    onNotificationCreatedMethod:
        (ReceivedNotification receivedNotification) async {
      NotificationController.onNotificationCreatedMethod(receivedNotification);
    },
    onNotificationDisplayedMethod:
        (ReceivedNotification receivedNotification) async {
      NotificationController.onNotificationDisplayedMethod(
          receivedNotification);
    },
    onDismissActionReceivedMethod: (ReceivedAction receivedAction) async {
      NotificationController.onDismissActionReceivedMethod(receivedAction);
    },
  );
}

Future<void> pushNotification(
    {required int id, required String title, required String body}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: 'Notify',
      title: title,
      body: body,
      actionType: ActionType.KeepOnTop,
    ),
  );
}
