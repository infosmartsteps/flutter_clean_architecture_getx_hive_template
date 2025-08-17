import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/local/storage_helper.dart';

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
