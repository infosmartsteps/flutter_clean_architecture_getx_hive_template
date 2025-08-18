import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../constants/app_constants.dart';
import '../data/local/storage_helper.dart';

//lib/core/controllers/app_controller.dart
class AppController extends GetxController {
  // initializing with the current theme of the device
  Rx<ThemeMode> currentTheme = ThemeMode.system.obs;
  Rx<Locale> currentLocale = Locale(LanguageCodes.english, LanguagesCountries.us).obs;

  @override
  void onInit() async {
    final themeMode = await StorageHelper().getAppThemeMode();
    currentTheme.value = themeMode ?? currentTheme.value;
    final locale = await StorageHelper().getAppLang();
    currentLocale.value = locale;
    Get.updateLocale(locale);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    await StorageHelper().setAppInfo(packageInfo);

    super.onInit();
  }

  // function to switch between themes
  Future<void> switchTheme({ThemeMode? themeMode}) async {
    currentTheme.value = themeMode ?? (currentTheme.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light);
    update();
    await StorageHelper().setAppThemeMode(currentTheme.value);
  }
}
