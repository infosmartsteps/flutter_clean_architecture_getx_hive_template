import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app.dart';
import '../constants/app_colors.dart';
import '../controllers/theme_mode_controller.dart';
import 'app_button.dart';

Widget themeToggleButton() {
  return AppButton(
    type: AppButtonType.secondary,
    icon: Icon(Get.isDarkMode ? Icons.dark_mode : Icons.light_mode,
        color: AppColors.whiteColor),
    // text: Get.isDarkMode ? "Dark" : "Light",
    onPressed: () async => await Get.find<ThemeModeController>().switchTheme(),
  );
}
