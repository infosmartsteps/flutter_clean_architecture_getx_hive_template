import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/add_client_form_controller.dart';

import '../../../../../core/utils/form_utils.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../../../../core/widgets/app_text_form_field.dart';

Widget buildFormFields(AddClientFormController controller) {
  return Column(
    spacing: responsiveHeight(20),
    mainAxisSize: MainAxisSize.min,
    children: [
      _buildTextField(controller.state.clientNameField, 'client_name'.tr,
          Icons.person_outline),
      _buildTextField(controller.state.responsiblePersonField,
          'responsible_person'.tr, Icons.person_pin_outlined),
      _buildPhoneField(controller.state.phoneNumberField, 'phone_number'.tr,
          Icons.phone_outlined),
      _buildTextField(
          controller.state.addressField, 'address'.tr, Icons.home_outlined),
      _buildTextField(controller.state.registrationNumberField,
          'registration_number'.tr, Icons.numbers_outlined),
      _buildPhoneField(controller.state.responsiblePersonPhoneField,
          'responsible_person_phone'.tr, Icons.phone_android_outlined),
      AppTextFormField(
        fieldModel: controller.state.emailField,
        keyboardType: TextInputType.emailAddress,
        label: 'email'.tr,
        prefixIcon: Icon(Icons.email_outlined),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _buildLocationFields(
            controller, controller.state.clientLocationLatField),
        _buildLocationFields(
            controller, controller.state.clientLocationLngField),
      ]),
    ],
  );
}

Widget _buildTextField(FormFieldModel field, String label, IconData icon) {
  return AppTextFormField(
    fieldModel: field,
    label: label,
    prefixIcon: Icon(icon),
  );
}

Widget _buildPhoneField(FormFieldModel field, String label, IconData icon) {
  return AppTextFormField(
    fieldModel: field,
    keyboardType: TextInputType.phone,
    label: label,
    prefixIcon: Icon(icon),
  );
}

Widget _buildLocationFields(
    AddClientFormController controller, FormFieldModel formFieldModel) {
  return AppTextFormField(
      readOnly: true,
      width: responsiveWidth(180),
      onTap: controller.openClientLocation,
      prefixIcon: const Icon(Icons.location_history_outlined),
      fieldModel: formFieldModel,
      label: 'client_location'.tr);
}
