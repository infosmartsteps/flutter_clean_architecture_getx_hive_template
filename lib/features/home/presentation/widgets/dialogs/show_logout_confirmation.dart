import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/routes/app_routes.dart';
import '../../../../../core/data/local/storage_helper.dart';
import '../../../../../core/widgets/app_button.dart';

void showLogoutConfirmation() {
  Get.dialog(AlertDialog(
      title: Text('logout'.tr),
      content: Text('are_you_sure_logout'.tr),
      actions: [
        AppButton(
          onPressed: () => Get.back(),
          text:'cancel'.tr,
        ),
        AppButton(
          onPressed: () async {
            await StorageHelper().logout();
            Get.back();
            Get.offNamed(AppRoutes.logInScreen);
          },
          text: ('logout'.tr),
        ),
      ]));
}
