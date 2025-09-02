import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/add_client_form_controller.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../../../../../core/widgets/custom_location_fields.dart';
import '../../../../../core/widgets/custom_phone_field.dart';
import '../../../../../core/widgets/custom_text_field.dart';

//lib/features/home/presentation/widgets/add_client/build_form_fields.dart
Widget buildFormFields(AddClientFormController controller) {
  return Column(
    spacing: responsiveHeight(20),
    mainAxisSize: MainAxisSize.min,
    children: [
      customTextField(controller.state.clientNameField, 'client_name'.tr,
          icon: Icons.person_outline),
      customTextField(
          controller.state.responsiblePersonField, 'responsible_person'.tr,
          icon: Icons.person_pin_outlined),
      customPhoneField(controller.state.phoneNumberField, 'phone_number'.tr,
          Icons.phone_outlined),
      customTextField(controller.state.addressField, 'address'.tr,
          icon: Icons.home_outlined),
      customTextField(
          controller.state.registrationNumberField, 'registration_number'.tr,
          icon: Icons.numbers_outlined),
      customPhoneField(controller.state.responsiblePersonPhoneField,
          'responsible_person_phone'.tr, Icons.phone_android_outlined),
      AppTextFormField(
        fieldModel: controller.state.emailField,
        keyboardType: TextInputType.emailAddress,
        label: 'email'.tr,
        prefixIcon: Icon(Icons.email_outlined),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        customLocationFields(
            controller, controller.state.clientLocationLatField),
        customLocationFields(
            controller, controller.state.clientLocationLngField),
      ]),
    ],
  );
}
