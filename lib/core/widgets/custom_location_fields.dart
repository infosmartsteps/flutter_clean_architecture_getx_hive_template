import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/home/presentation/controllers/add_client_form_controller.dart';
import '../utils/form_utils.dart';
import '../utils/responsive_size_helper.dart';
import '../widgets/app_text_form_field.dart';

Widget customLocationFields(
    AddClientFormController controller, FormFieldModel formFieldModel) {
  return AppTextFormField(
      readOnly: true,
      width: responsiveWidth(180),
      onTap: controller.openClientLocation,
      prefixIcon: const Icon(Icons.location_history_outlined),
      fieldModel: formFieldModel,
      label: 'client_location'.tr);
}