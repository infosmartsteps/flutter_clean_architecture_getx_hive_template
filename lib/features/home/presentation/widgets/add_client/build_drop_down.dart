import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/add_client_form_controller.dart';
import '../../../../../core/utils/form_utils.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../../../../core/widgets/app_drop_down.dart';

//lib/features/home/presentation/widgets/add_client/build_drop_down.dart
Widget buildDropdowns(AddClientFormController controller) {
  return Column(
      spacing: responsiveHeight(20),
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() => AppDropDown(
            isLoading: controller.state.isLoadingBusinessSectors.value,
            value: controller.state.selectedBusinessSector.value,
            labelText: 'business_sector'.tr,
            items: controller.state.businessSectors,
            onChanged: (value) =>
                controller.state.selectedBusinessSector.value = value,
            validator: (value) => requiredFieldValidation(
                value, 'please_select_business_sector'.tr))),
        Obx(() => AppDropDown(
            isLoading: controller.state.isLoadingCities.value,
            labelText: 'city'.tr,
            icon: Icons.location_city_outlined,
            value: controller.state.selectedCity.value,
            items: controller.state.cities,
            onChanged: (value) => controller.state.selectedCity.value = value,
            validator: (value) =>
                requiredFieldValidation(value, 'please_enter_city'.tr))),
        Obx(() => AppDropDown(
            isLoading: controller.state.isLoadingInformationSources.value,
            value: controller.state.selectedInformationSource.value,
            labelText: 'information_source'.tr,
            icon: Icons.info_outline,
            items: controller.state.informationSources,
            onChanged: (value) =>
                controller.state.selectedInformationSource.value = value,
            validator: (value) => requiredFieldValidation(
                value, 'Please select information source'.tr))),
      ]);
}
