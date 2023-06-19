import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pharmacy1/controller/theme_controller.dart';
import 'package:pharmacy1/core/constant/app_colors.dart';
import 'package:pharmacy1/core/functions/awesome_notification.dart';
import 'package:pharmacy1/core/functions/firebase_messaging.dart';
import 'package:pharmacy1/core/routes/routes.dart';
import 'package:pharmacy1/core/services/storage_service.dart';
import 'package:pharmacy1/core/theme/theme.dart';
import 'package:pharmacy1/firebase_options.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialAwesomeNotification();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getInitialMessage();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  sqfliteFfiInit();
  await initialServices();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Locale("ar", "en"),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeApp().light,
      darkTheme: ThemeApp().dark,
      themeMode: ThemeController().handelThemeGet,
      getPages: routes,
    );
  }
}
