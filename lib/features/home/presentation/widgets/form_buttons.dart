import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/widgets/app_button.dart';
import 'dialogs/exit_dialog.dart';

Widget formButtons(void Function() onPressed) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      AppButton(
          type: AppButtonType.secondary,
          onPressed: showExitDialog,
          icon: Icon(Icons.delete, color: Colors.red),
          text: 'cancel'.tr),
      AppButton(
          type: AppButtonType.secondary,
          onPressed: onPressed,
          icon: Icon(Icons.save, color: Colors.green),
          text: "${'save'.tr}   "),
    ],
  );
}
