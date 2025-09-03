import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/app_button.dart';
import '../dialogs/exit_dialog.dart';

Widget formButtons(void Function() onPressed) {
  return Padding(
    padding: EdgeInsets.all(responsiveFont(10)),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
          child: AppButton(
              onPressed: showExitDialog,
              icon: Icon(Icons.delete, color: AppColors.redColor),
              text: 'cancel'.tr)),
      Spacer(),
      Expanded(
          child: AppButton(
              backgroundColor: AppColors.greenColor,
              onPressed: onPressed,
              icon: Icon(Icons.save, color: Get.theme.colorScheme.onPrimary),
              text: "${'save'.tr}   ")),
    ]),
  );
}
