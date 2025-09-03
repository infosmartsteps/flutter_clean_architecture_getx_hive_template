import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/theme/app_theme.dart';
import 'core/constants/app_colors.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/font_family.dart';
import 'core/constants/routes/app_pages.dart';
import 'core/constants/routes/app_routes.dart';
import 'core/controllers/app_controller.dart';
import 'core/localization/translations/translation_service.dart';
import 'core/utils/responsive_size_helper.dart';

//lib/app.dart
class App extends GetView<AppController> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'KSA Real Estate',
          //routes
          getPages: AppPages.pages,
          initialRoute: AppRoutes.initialRoute(),

          //theme
          darkTheme: Get.context == null ? AppTheme2.dark : AppTheme.dark,
          theme: Get.context == null
              ? AppTheme2.getTheme(context)
              : AppTheme.getTheme(context),
          themeMode: controller.currentTheme.value,

          //localization
          translations: TranslationService(),
          locale: controller.currentLocale.value,
          fallbackLocale: TranslationService.fallbackLocale,
        ));
  }
}

class AppTheme2 {
  static final ThemeData light = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primarySwatch: AppColors.blueColor,
      scaffoldBackgroundColor: AppColors.whiteColor,
      cardTheme: cardTheme,
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.whiteColor,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.whiteColor,
        iconTheme: IconThemeData(color: AppColors.blackColor),
        titleTextStyle: TextStyle(
          color: AppColors.blackColor,
          fontSize: Get.context == null ? 20 : responsiveFont(16),
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: textTheme);

  static final ThemeData dark = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primarySwatch: AppColors.blueGreyColor,
      scaffoldBackgroundColor: AppColors.grey900,
      cardTheme: cardTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.grey900,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
        titleTextStyle: TextStyle(
          color: AppColors.whiteColor,
          fontSize: Get.context == null ? 20 : responsiveFont(16),
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: textTheme);

  static final CardThemeData cardTheme = CardThemeData(
    shadowColor: AppColors.grey300,
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
        TextStyle(fontSize: Get.context == null ? 16 : responsiveFont(14)),
    bodyMedium:
        TextStyle(fontSize: Get.context == null ? 14 : responsiveFont(12)),
  );

  static ThemeData getTheme(BuildContext context) {
    final locale = Get.locale;
    final isArabic = locale?.languageCode == LanguageLocals.arabic.languageCode;
    final isDark =
        Get.find<AppController>().currentTheme.value == ThemeMode.dark;
    final theme = isDark ? dark : light;

    return theme.copyWith(
      textTheme: _getLocalizedTextTheme(theme.textTheme, isArabic),
    );
  }

  static TextTheme _getLocalizedTextTheme(TextTheme baseTheme, bool isArabic) {
    final fontFamily = isArabic ? FontFamily.cairo : FontFamily.encodeSans;

    return baseTheme.copyWith(
      titleLarge: baseTheme.titleLarge?.copyWith(fontFamily: fontFamily),
      bodyLarge: baseTheme.bodyLarge?.copyWith(fontFamily: fontFamily),
      bodyMedium: baseTheme.bodyMedium?.copyWith(fontFamily: fontFamily),
    );
  }
}
