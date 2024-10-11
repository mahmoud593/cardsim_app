import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games_app/styles/colors/color_manager.dart';

ThemeData getApplicationTheme(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: ColorManager.background,
    primaryColor: ColorManager.primary,
    useMaterial3: true,
    fontFamily: 'Tajawal',
    // App bar theme for light mode
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: ColorManager.white,
      titleTextStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
        color: ColorManager.backgroundText,
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.sizeOf(context).height * 0.025,
        fontFamily: 'Tajawal',
      ),
      iconTheme: const IconThemeData(
        color: ColorManager.black,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    // Additional theme properties (buttons, input decorations, etc.)
  );
}

ThemeData getDarkTheme(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: ColorManager.darkThemeBackground,
    primaryColor: ColorManager.darkThemeBackgroundLight,

    useMaterial3: true,
    fontFamily: 'Tajawal',
    brightness: Brightness.dark,
    primaryColorDark: ColorManager.darkThemeBackgroundLight,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: ColorManager.darkThemeBackgroundLight,
      titleTextStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
        color: ColorManager.white,
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.sizeOf(context).height * 0.025,
        fontFamily: 'Tajawal',
      ),
      iconTheme: const IconThemeData(
        color: ColorManager.white,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    // Additional theme properties for dark mode
  );
}
