import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/add_client_form_controller.dart';

import '../../../../../core/utils/form_utils.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../../../../core/widgets/app_text_form_field.dart';

//lib/features/home/presentation/widgets/add_client/build_form_fields.dart
Widget buildFormFields(AddClientFormController controller) {
  return Column(
    spacing: responsiveHeight(20),
    mainAxisSize: MainAxisSize.min,
    children: [
      buildTextField(controller.state.clientNameField, 'client_name'.tr,
          Icons.person_outline),
      buildTextField(controller.state.responsiblePersonField,
          'responsible_person'.tr, Icons.person_pin_outlined),
      buildPhoneField(controller.state.phoneNumberField, 'phone_number'.tr,
          Icons.phone_outlined),
      buildTextField(
          controller.state.addressField, 'address'.tr, Icons.home_outlined),
      buildTextField(controller.state.registrationNumberField,
          'registration_number'.tr, Icons.numbers_outlined),
      buildPhoneField(controller.state.responsiblePersonPhoneField,
          'responsible_person_phone'.tr, Icons.phone_android_outlined),
      AppTextFormField(
        fieldModel: controller.state.emailField,
        keyboardType: TextInputType.emailAddress,
        label: 'email'.tr,
        prefixIcon: Icon(Icons.email_outlined),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        buildLocationFields(
            controller, controller.state.clientLocationLatField),
        buildLocationFields(
            controller, controller.state.clientLocationLngField),
      ]),
    ],
  );
}

