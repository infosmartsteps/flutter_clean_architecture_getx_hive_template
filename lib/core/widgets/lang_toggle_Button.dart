import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../localization/translations/translation_service.dart';
import 'app_button.dart';

Widget languageToggleButton() {
  return AppButton(
    type: AppButtonType.secondary,
    icon: Icon(Icons.language, color: AppColors.whiteColor),
    text: Get.locale != null && Get.locale == LanguageLocals.english
        ? Languages.arabic
        : Languages.english,
    onPressed: ()async => await TranslationService.changeLocale(
        Get.locale != null && Get.locale == LanguageLocals.english
            ? LanguageLocals.arabic
            : LanguageLocals.english),
  );
}
