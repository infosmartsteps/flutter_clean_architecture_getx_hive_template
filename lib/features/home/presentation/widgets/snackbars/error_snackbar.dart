import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/app_colors.dart';

void showErrorSnackBar(String title, String body) {
  Get.snackbar(title, body,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.error,
      colorText: AppColors.whiteColor);
}
