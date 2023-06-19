import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharmacy1/core/constant/app_colors.dart';

class ThemeApp {
  get light => ThemeData(
        fontFamily: "cairo",
        primaryColor: AppColor.primaryColorlight,
        // ignore: deprecated_member_use
        accentColor: AppColor.secondaryColorlight,
        backgroundColor: AppColor.backgroundLight,
        scaffoldBackgroundColor: AppColor.backgroundScaffoldLight,
        primaryTextTheme:
            ThemeData.light().textTheme.apply(fontFamily: "cairo"),
        textTheme: TextTheme(
          bodyText1: TextStyle(
              color: AppColor.primaryColorlight,
              fontSize: 16,
              fontWeight: FontWeight.bold),
          bodyText2: const TextStyle(color: Colors.black, fontSize: 16),
          headline6: const TextStyle(color: Colors.white, fontSize: 16),
          headline1: TextStyle(
              color: AppColor.primaryColorlight,
              fontSize: 20,
              fontWeight: FontWeight.bold),
          headline2: const TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        snackBarTheme: SnackBarThemeData(
            backgroundColor: AppColor.primaryColorlight,
            actionTextColor: Colors.white),
        appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
            ),
            backgroundColor: AppColor.primaryColorlight,
            elevation: 0,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
            actionsIconTheme: const IconThemeData(color: Colors.white)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColorlight)),
        listTileTheme: ListTileThemeData(
          tileColor: AppColor.primaryColorlight,
          textColor: AppColor.backgroundLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        switchTheme: SwitchThemeData(
            thumbColor: MaterialStateProperty.all(AppColor.secondaryColorlight),
            trackColor: MaterialStateProperty.all(AppColor.backgroundLight)),
        brightness: Brightness.light,
      );

  get dark => ThemeData(
      fontFamily: "cairo",
      primaryColor: AppColor.primaryColordark,
      // ignore: deprecated_member_use
      accentColor: AppColor.secondaryColordark,
      backgroundColor: AppColor.backgroundDark,
      scaffoldBackgroundColor: AppColor.backgroundScaffoldDark,
      primaryTextTheme: ThemeData.dark().textTheme.apply(fontFamily: "cairo"),
      textTheme: TextTheme(
        bodyText1: TextStyle(
            color: AppColor.primaryColordark,
            fontSize: 16,
            fontWeight: FontWeight.bold),
        bodyText2: const TextStyle(color: Colors.white, fontSize: 16),
        headline6: const TextStyle(color: Colors.black, fontSize: 16),
        headline1: TextStyle(
            color: AppColor.primaryColordark,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        headline2: const TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
      ),
      appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
          backgroundColor: AppColor.primaryColordark,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          actionsIconTheme: const IconThemeData(color: Colors.black)),
      snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColor.primaryColordark,
          actionTextColor: Colors.black),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColordark)),
      brightness: Brightness.dark,
      listTileTheme: ListTileThemeData(
        tileColor: AppColor.primaryColordark,
        textColor: AppColor.backgroundDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(AppColor.secondaryColordark),
          trackColor: MaterialStateProperty.all(AppColor.backgroundDark)));
}
