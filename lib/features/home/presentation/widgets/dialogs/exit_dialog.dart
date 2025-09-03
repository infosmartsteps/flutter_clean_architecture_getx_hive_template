import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/app_colors.dart';
import 'package:ksa_real_estates/core/constants/enums.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import 'package:ksa_real_estates/core/widgets/app_button.dart';

showExitDialog({void Function()? onExit}) {
  Get.defaultDialog(
      title: 'exit'.tr,
      content: Text('are_you_sure_exit'.tr),
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
            onPressed: () async {
              onExit == null ? null : onExit();
              Get.back(
                  closeOverlays: true); // This will close dialog AND screen
            },
            text: 'exit'.tr),
      ]);
}
