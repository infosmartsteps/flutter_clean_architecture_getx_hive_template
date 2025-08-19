import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/routes/app_routes.dart';
import '../../../../../core/data/local/storage_helper.dart';

void showLogoutConfirmation() {
  Get.dialog(AlertDialog(
    title: Text('logout'.tr),
    content: Text('are_you_sure_logout'.tr),
    actions: [
      TextButton(
        onPressed: () => Get.back(),
        child: Text('cancel'.tr),
      ),
      TextButton(
        onPressed: () async {
          //remove user data from hive using storage helper
          await StorageHelper().logout();
          Get.back();
          Get.offNamed(AppRoutes.logInScreen);
        },
        child: Text('logout'.tr),
      ),
    ],
  ));
}