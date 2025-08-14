import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_constants.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
    ),
  );

  static final ThemeData dark = ThemeData(
    primarySwatch: Colors.blueGrey,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.grey[900],
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
    ),
  );

  // Add RTL support for Arabic
  static ThemeData getTheme(BuildContext context) {
    final locale = Get.locale;
    final isArabic = locale?.languageCode == LanguageLocals.arabic.languageCode;

    final theme =
        Theme.of(context).brightness == Brightness.dark ? dark : light;

    return theme.copyWith(
      textTheme: isArabic
          ? theme.textTheme.copyWith(
              titleLarge: theme.textTheme.titleLarge?.copyWith(
                fontFamily: 'ArabicFont',
              ),
              bodyLarge: theme.textTheme.bodyLarge?.copyWith(
                fontFamily: 'ArabicFont',
              ),
              bodyMedium: theme.textTheme.bodyMedium?.copyWith(
                fontFamily: 'ArabicFont',
              ),
            )
          : theme.textTheme.copyWith(
              titleLarge: theme.textTheme.titleLarge?.copyWith(
                fontFamily: 'EnglishFont',
              ),
              bodyLarge: theme.textTheme.bodyLarge?.copyWith(
                fontFamily: 'EnglishFont',
              ),
              bodyMedium: theme.textTheme.bodyMedium?.copyWith(
                fontFamily: 'EnglishFont',
              ),
            ),
    );
  }
}
