import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/enums.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../../../../core/widgets/app_button.dart';

void showSaveDialog(Function() confirm) {
  Get.defaultDialog(
      title: 'confirm'.tr,
      content: Text('are_you_sure_confirm'.tr),
      contentPadding: EdgeInsets.all(responsiveFont(24)),
      backgroundColor: Get.theme.colorScheme.onSecondary,
      actions: [
        AppButton(
            type: AppButtonType.secondary,
            onPressed: () => Get.back(),
            text: 'cancel'.tr),
        AppButton(
            type: AppButtonType.secondary,
            backgroundColor: AppColors.greenColor,
            textColor: AppColors.whiteColor,
            text: 'confirm'.tr,
            onPressed: confirm),
      ]);
}
