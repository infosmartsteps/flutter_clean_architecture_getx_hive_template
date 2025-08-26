import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';

// lib/config/theme/app_theme.dart
class AppTheme {
  static final ThemeData light = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      cardTheme: cardTheme,
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.whiteColor,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: Get.context == null ? 20 : responsiveFont(16),
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: textTheme);

  static final ThemeData dark = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primarySwatch: Colors.blueGrey,
      scaffoldBackgroundColor: Colors.grey[900],
      cardTheme: cardTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: Get.context == null ? 20 : responsiveFont(16),
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: textTheme);

  static final CardThemeData cardTheme = CardThemeData(
    shadowColor: Colors.grey[300]!,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.circular(Get.context == null ? 12 : responsiveFont(16)),
    ),
  );

  static final TextTheme textTheme = TextTheme(
    titleLarge: TextStyle(
      fontSize: Get.context == null ? 20 : responsiveFont(16),
      fontWeight: FontWeight.bold,
    ),
    bodyLarge:
        TextStyle(fontSize: Get.context == null ? 16 : responsiveFont(15)),
    bodyMedium:
        TextStyle(fontSize: Get.context == null ? 14 : responsiveFont(12)),
  );

  static ThemeData getTheme(BuildContext context) {
    final locale = Get.locale;
    final isArabic = locale?.languageCode == LanguageLocals.arabic.languageCode;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = isDark ? dark : light;

    return theme.copyWith(
      textTheme: _getLocalizedTextTheme(theme.textTheme, isArabic),
    );
  }

  static TextTheme _getLocalizedTextTheme(TextTheme baseTheme, bool isArabic) {
    final fontFamily = isArabic ? 'ArabicFont' : 'EnglishFont';

    return baseTheme.copyWith(
      titleLarge: baseTheme.titleLarge?.copyWith(fontFamily: fontFamily),
      bodyLarge: baseTheme.bodyLarge?.copyWith(fontFamily: fontFamily),
      bodyMedium: baseTheme.bodyMedium?.copyWith(fontFamily: fontFamily),
    );
  }
}
