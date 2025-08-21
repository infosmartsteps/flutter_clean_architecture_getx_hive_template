import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/add_client_form_controller.dart';
import '../../../../../core/utils/form_utils.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../../../../core/widgets/app_drop_down.dart';

Widget buildDropdowns(AddClientFormController controller) {
  return Column(
    spacing: responsiveHeight(20),
    mainAxisSize: MainAxisSize.min,
    children: [
      Obx(() => AppDropDown(
            fieldKey: controller.focusManager.getFieldKey('businessSector'),
            focusNode: controller.focusManager.getFocusNode('businessSector'),
            isLoading: controller.state.isLoadingBusinessSectors.value,
            value: controller.state.selectedBusinessSector.value,
            labelText: 'business_sector'.tr,
            items: controller.state.businessSectors,
            onChanged: (value) =>
                controller.state.selectedBusinessSector.value = value,
            validator: (value) =>
                value == null ? 'please_select_business_sector'.tr : null,
          )),
      Obx(() => AppDropDown(
            fieldKey: controller.focusManager.getFieldKey('city'),
            focusNode: controller.focusManager.getFocusNode('city'),
            isLoading: controller.state.isLoadingCities.value,
            value: controller.state.selectedCity.value,
            labelText: 'city'.tr,
            icon: Icons.location_city_outlined,
            items: controller.state.cities,
            onChanged: (value) => controller.state.selectedCity.value = value,
            validator: (value) =>
                requiredFieldValidation(value, 'please_enter_city'.tr),
          )),
      Obx(() => AppDropDown(
            fieldKey: controller.focusManager.getFieldKey('information_source'),
            focusNode:
                controller.focusManager.getFocusNode('information_source'),
            isLoading: controller.state.isLoadingInformationSources.value,
            value: controller.state.selectedInformationSource.value,
            labelText: 'information_source'.tr,
            icon: Icons.info_outline,
            items: controller.state.informationSources,
            onChanged: (value) =>
                controller.state.selectedInformationSource.value = value,
            validator: (value) => requiredFieldValidation(
                value, 'Please select information source'.tr),
          )),
    ],
  );
}
