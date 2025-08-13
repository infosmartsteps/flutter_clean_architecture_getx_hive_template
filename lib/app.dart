import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/flavor_config.dart';
import 'core/constants/app_pages.dart';
import 'core/constants/app_routes.dart';
import 'core/controllers/lang_controller.dart';
import 'lang/translation_service.dart';

//lib/app.dart
class App extends GetView<LanguageController> {
  final FlavorConfig flavorConfig;

  const App({super.key, required this.flavorConfig});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KSA Real Estate',
      getPages: AppPages.pages,
      initialRoute: AppRoutes.initialRoute(),

      locale: Locale(controller.currentLang.value),
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),

      theme: ThemeData(
        scaffoldBackgroundColor: flavorConfig.colorPrimary,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
