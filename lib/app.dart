import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/flavor_config.dart';
import 'config/theme/app_theme.dart';
import 'core/constants/routes/app_pages.dart';
import 'core/constants/routes/app_routes.dart';
import 'core/controllers/theme_mode_controller.dart';
import 'core/localization/translations/translation_service.dart';

//lib/app.dart
class App extends GetView<ThemeModeController> {
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
          darkTheme: AppTheme.dark,
          theme: AppTheme.getTheme(context),
          themeMode: controller.currentTheme.value,

          //localization
          translations: TranslationService(),
          locale: TranslationService.locales.first,
          fallbackLocale: TranslationService.fallbackLocale,
        ));
  }
}
