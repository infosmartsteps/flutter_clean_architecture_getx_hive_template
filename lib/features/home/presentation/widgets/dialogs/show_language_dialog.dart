import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/localization/translations/translation_service.dart';

void showLanguageDialog() {
  Get.dialog(AlertDialog(
    title: Text('select_language'.tr),
    content: Column(mainAxisSize: MainAxisSize.min, children: [
      ListTile(
        trailing: Get.locale == LanguageLocals.english
            ? Icon(Icons.check, color: AppColors.greenColor)
            : null,
        title: const Text(Languages.english),
        leading: const Icon(Icons.language),
        onTap: Get.locale == LanguageLocals.english
            ? null
            : () async {
                await TranslationService.changeLocale(LanguageLocals.english);
                Get.back();
              },
      ),
      ListTile(
        trailing: Get.locale == LanguageLocals.arabic
            ? Icon(Icons.check, color: AppColors.greenColor)
            : null,
        title: const Text(Languages.arabic),
        leading: Icon(Icons.language),
        onTap: Get.locale == LanguageLocals.arabic
            ? null
            : () async {
                await TranslationService.changeLocale(LanguageLocals.arabic);
                Get.back();
              },
      ),
    ]),
  ));
}
