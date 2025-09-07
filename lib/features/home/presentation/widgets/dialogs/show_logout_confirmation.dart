import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/enums.dart';
import '../../../../../core/constants/routes/app_routes.dart';
import '../../../../../core/data/local/storage_helper.dart';
import '../../../../../core/widgets/app_button.dart';

void showLogoutConfirmation() {
  Get.dialog(AlertDialog(
      title: Text('logout'.tr),
      content: Text('are_you_sure_logout'.tr),
      actions: [
        AppButton(
          type: AppButtonType.secondary,
          onPressed: () => Get.back(),
          text:'cancel'.tr,
        ),
        AppButton(
          type: AppButtonType.secondary,
          backgroundColor: Get.theme.colorScheme.primary,
          onPressed: () async {
            await StorageHelper().logout();
            Get.back();
            Get.offNamed(AppRoutes.logInScreen);
          },
          text: ('logout'.tr),
        ),
      ]));
}
