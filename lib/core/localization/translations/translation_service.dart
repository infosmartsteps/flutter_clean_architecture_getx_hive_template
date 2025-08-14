import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_constants.dart';
import '../../data/local/storage_helper.dart';
import 'en_US.dart';
import 'ar_JO.dart';

//lib/core/localization/translations/translation_service.dart
class TranslationService extends Translations {
  static Locale fallbackLocale =
      Locale(LanguageLocals.english.languageCode, LanguagesCountries.us);

  static final locales = [
    Locale(LanguageLocals.english.languageCode, LanguagesCountries.us),
    Locale(LanguageLocals.arabic.languageCode, LanguagesCountries.jo)
  ];

  @override
  Map<String, Map<String, String>> get keys => {'en_US': en_US, 'ar_JO': ar_JO};

  static Locale? getLocaleFromLanguage(Locale languageCode) {
    switch (languageCode) {
      case LanguageLocals.english:
        return Locale(
            LanguageLocals.english.languageCode, LanguagesCountries.us);
      case LanguageLocals.arabic:
        return Locale(
            LanguageLocals.arabic.languageCode, LanguagesCountries.jo);
      default:
        return Get.deviceLocale;
    }
  }

  static void changeLocale(Locale lang) async{
    await StorageHelper().setAppLang(lang);
    final locale = getLocaleFromLanguage(lang);
    if (locale != null) {
      Get.updateLocale(locale);
    }
  }
}
