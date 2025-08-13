import 'dart:ui';

import 'package:get/get.dart';

import '../data/local/data/datasources/hive_box_manager.dart';

//lib/core/controllers/lang_controller.dart
class LanguageController extends GetxController {
  var currentLang = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
    String? saved = HiveBoxManager.getLanguage();
    if (saved != null) {
      currentLang.value = saved;
      Get.updateLocale(Locale(saved));
    }
  }

  void changeLanguage(String langCode) {
    currentLang.value = langCode;
    HiveBoxManager.saveLanguage(langCode);
    Get.updateLocale(Locale(langCode));
  }
}
