import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/font_family.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/controllers/app_controller.dart';

class AppTheme {
  // Common theme properties
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.blueColor,
    primarySwatch: AppColors.blueColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    cardTheme: cardTheme,
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.whiteColor,
    ),
    appBarTheme: _appBarTheme(AppColors.blackColor, AppColors.whiteColor),
    textTheme: textTheme,
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primarySwatch: AppColors.blueGreyColor,
    scaffoldBackgroundColor: AppColors.grey900,
    cardTheme: cardTheme,
    appBarTheme: _appBarTheme(AppColors.whiteColor, AppColors.grey900!),
    textTheme: textTheme,
  );

  // Helper method for app bar theme
  static AppBarTheme _appBarTheme(Color iconColor, Color backgroundColor) {
    return AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(color: iconColor),
      titleTextStyle: TextStyle(
        color: iconColor,
        fontSize: _responsiveFont(16),
        fontWeight: FontWeight.bold,
        fontFamily: FontFamily.getFontFamily(),
      ),
    );
  }

  // Card theme
  static final CardTheme cardTheme = CardTheme(
    shadowColor: AppColors.grey300!,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_responsiveFont(16)),
    ),
  );

  // Text theme
  static final TextTheme textTheme = TextTheme(
    titleLarge: TextStyle(
      fontSize: _responsiveFont(16),
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      fontSize: _responsiveFont(15),
      fontFamily: FontFamily.getFontFamily(),
    ),
    bodyMedium: TextStyle(
      fontSize: _responsiveFont(12),
      fontFamily: FontFamily.getFontFamily(),
    ),
  );

  // Helper methods
  static double _responsiveFont(double size) {
    return Get.context == null ? size + 4 : responsiveFont(size);
  }

  // Theme getter
  static ThemeData getTheme(BuildContext context) {
    final isDark =
        Get.find<AppController>().currentTheme.value == ThemeMode.dark;
    return isDark ? dark : light;
  }
}
