import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';

//lib/config/theme/app_theme.dart
class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    cardTheme: CardTheme(
      shadowColor: Colors.grey[900]!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    drawerTheme: DrawerThemeData(backgroundColor: AppColors.whiteColor),
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
    useMaterial3: true,
    cardTheme: CardTheme(
      shadowColor: Colors.grey[300]!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
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
      useMaterial3: true,
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
