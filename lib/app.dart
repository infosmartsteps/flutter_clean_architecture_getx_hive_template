import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'config/flavor_config.dart';
import 'config/theme/app_theme.dart';
import 'core/constants/routes/app_pages.dart';
import 'core/constants/routes/app_routes.dart';
import 'core/data/local/storage_helper.dart';
import 'core/localization/translations/translation_service.dart';

//lib/app.dart
class App extends GetView<ThemeModeController> {
  final FlavorConfig flavorConfig;

  const App({super.key, required this.flavorConfig});

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

class ThemeModeController extends GetxController {
  // initializing with the current theme of the device
  Rx<ThemeMode> currentTheme = ThemeMode.system.obs;

  @override
  void onInit() async {
    final themeMode = await StorageHelper().getAppThemeMode();
    currentTheme.value = themeMode ?? currentTheme.value;
    final locale = await StorageHelper().getAppLang();

    Get.updateLocale(locale);
    super.onInit();
  }

  // function to switch between themes
  Future<void> switchTheme() async {
    currentTheme.value = currentTheme.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    update();
    await StorageHelper().setAppThemeMode(currentTheme.value);
  }
}
