import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/enums.dart';
import '../../../../../core/widgets/app_button.dart';

Widget opportunityOptionButtons(
    void Function()? completion, abandonment, cancel) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    AppButton(
        backgroundColor: AppColors.greenColor,
        type: AppButtonType.secondary,
        text: "completion".tr,
        onPressed: completion!),
    AppButton(
        backgroundColor: Get.theme.colorScheme.primary,
        type: AppButtonType.secondary,
        text: "abandonment".tr,
        onPressed: abandonment!),
    AppButton(
        type: AppButtonType.secondary, text: "cancel".tr, onPressed: cancel!)
  ]);
}
