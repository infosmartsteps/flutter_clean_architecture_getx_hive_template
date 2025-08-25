import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/theme/app_theme.dart';
import 'core/constants/app_colors.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/routes/app_pages.dart';
import 'core/constants/routes/app_routes.dart';
import 'core/controllers/app_controller.dart';
import 'core/localization/translations/translation_service.dart';

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
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    cardTheme: CardTheme(
      shadowColor: Colors.grey[900]!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.whiteColor,
    ),
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
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
    ),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primarySwatch: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.grey[900],
    cardTheme: CardTheme(
      shadowColor: Colors.grey[300]!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
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
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
    ),
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
