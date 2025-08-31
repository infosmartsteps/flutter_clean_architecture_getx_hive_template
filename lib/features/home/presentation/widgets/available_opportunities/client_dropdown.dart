import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/form_utils.dart';
import '../../../../../core/widgets/app_drop_down.dart';
import '../../controllers/available_opportunities_controller.dart';

Widget clientDropdown(AvailableOpportunitiesController controller) {
  final hasEmptyPhone =
      controller.fieldModel.value.controller?.text.isEmpty ?? true;

  if (!hasEmptyPhone) {
    return const SizedBox.shrink();
  }

  return Obx(
        () => AppDropDown(
      icon: Icons.person,
      labelText: 'choose_client'.tr,
      fieldKey: controller.focusManager.getFieldKey('choose_client'),
      focusNode: controller.focusManager.getFocusNode('choose_client'),
      validator: (value) =>
          requiredFieldValidation(value, 'please_select_business_sector'.tr),
      items: controller.clientsLookups,
      isLoading: controller.isLoading.value,
      value: controller.selectedClient.value,
      onChanged: (value) => controller.selectedClient.value = value,
    ),
  );
}
