import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/localization/translations/translation_service.dart';
import 'package:ksa_real_estates/core/widgets/app_button.dart';
import '../../features/auth/presentation/controller/auth_controller.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

Widget languageToggleButton() {
  return AppButton(
    type: AppButtonType.secondary,
    icon: Icon(Icons.language, color: AppColors.whiteColor),
    text: Get.locale != null && Get.locale == LanguageLocals.english
        ? Languages.arabic
        : Languages.english,
    onPressed: () => TranslationService.changeLocale(
        Get.locale != null && Get.locale == LanguageLocals.english
            ? LanguageLocals.arabic
            : LanguageLocals.english),
  );
}
