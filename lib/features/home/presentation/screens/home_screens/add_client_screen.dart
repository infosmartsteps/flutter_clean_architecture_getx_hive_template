import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import 'package:ksa_real_estates/core/widgets/app_text_form_field.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/add_client_form_controller.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/dialogs/exit_dialog.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/form_buttons.dart';

import '../../../../../core/utils/functions/validation.dart';
import '../../../../../core/widgets/app_drop_down.dart';

class AddClientScreen extends GetView<AddClientFormController> {
  const AddClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (!didPop) {
            showExitDialog();
          }
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child:  Scaffold(
            appBar: AppBar(
                title: Text('new_client'.tr,
                    style: Theme.of(context).textTheme.headlineSmall)),
            body:Padding(
              padding: EdgeInsets.symmetric(horizontal: responsiveWidth(16)),
              child: Form(
                key: controller.formKey,
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  child: Column(
                    spacing: responsiveHeight(20),
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Client Name
                      AppTextFormField(
                        focusNode: controller.clientNameFocus,
                        controller: controller.clientNameController,
                        label: 'client_name'.tr,
                        prefixIcon: const Icon(Icons.person_outline),
                        validator: (value) => requiredFieldValidation(
                            value, 'please_enter_client_name'.tr),
                      ),
                      // Responsible Person
                      AppTextFormField(
                        focusNode: controller.responsiblePersonFocus,
                        controller: controller.responsiblePersonController,
                        label: 'responsible_person'.tr,
                        prefixIcon: const Icon(Icons.person_pin_outlined),
                        validator: requiredFieldValidation,
                      ),
                      // Phone Number
                      AppTextFormField(
                        focusNode: controller.phoneNumberFocus,
                        controller: controller.phoneNumberController,
                        keyboardType: TextInputType.phone,
                        label: 'phone_number'.tr,
                        prefixIcon: const Icon(Icons.phone_outlined),
                        validator: phoneNumberValidation,
                      ),
                      // Address
                      AppTextFormField(
                        focusNode: controller.addressFocus,
                        controller: controller.addressController,
                        label: 'address'.tr,
                        prefixIcon: const Icon(Icons.home_outlined),
                        validator: requiredFieldValidation,
                      ),
                      // Registration Number
                      AppTextFormField(
                        focusNode: controller.registrationNumberFocus,
                        controller: controller.registrationNumberController,
                        label: 'registration_number'.tr,
                        prefixIcon: const Icon(Icons.numbers_outlined),
                        validator: requiredFieldValidation,
                      ),
                      // Responsible Person Phone
                      AppTextFormField(
                        focusNode: controller.responsiblePersonPhoneFocus,
                        controller: controller.responsiblePersonPhoneController,
                        keyboardType: TextInputType.phone,
                        label: 'responsible_person_phone'.tr,
                        prefixIcon: const Icon(Icons.phone_android_outlined),
                        validator: requiredFieldValidation,
                      ),
                      // Email
                      AppTextFormField(
                        focusNode: controller.emailFocus,
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        label: 'email'.tr,
                        prefixIcon: const Icon(Icons.email_outlined),
                        validator: emailValidation,
                      ),
                      // Client location
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: responsiveWidth(180),
                            child: AppTextFormField(
                              readOnly: true,
                              controller:
                                  controller.clientLocationLatController,
                              keyboardType: TextInputType.url,
                              label: 'client_location'.tr,
                              prefixIcon:
                                  const Icon(Icons.location_history_outlined),
                              onTap: controller.openClientLocation,
                            ),
                          ),
                          SizedBox(
                              width: responsiveWidth(180),
                              child: AppTextFormField(
                                readOnly: true,
                                controller:
                                    controller.clientLocationLngController,
                                keyboardType: TextInputType.url,
                                label: 'client_location'.tr,
                                prefixIcon:
                                    const Icon(Icons.location_history_outlined),
                                onTap: controller.openClientLocation,
                              ))
                        ],
                      ),
                      appDropDown(
                        focusNode: controller.businessSectorFocus,
                        value: controller.selectedBusinessSector,
                        labelText: 'business_sector'.tr,
                        icon: Icons.business_outlined,
                        items: controller.businessSectors,
                        onChanged: controller.selectBusinessSector,
                        validator: (value) => requiredFieldValidation(
                            value, 'please_select_business_sector'.tr),
                      ),
                      appDropDown(
                          focusNode: controller.cityFocus,
                          value: controller.selectedCity,
                          labelText: 'city'.tr,
                          icon: Icons.location_city_outlined,
                          onChanged: controller.selectCity,
                          validator: (value) => requiredFieldValidation(
                              value, 'please_enter_city'.tr),
                          items: controller.cities),
                      appDropDown(
                        focusNode: controller.informationSourceFocus,
                        value: controller.selectedInformationSource,
                        labelText: 'information_source'.tr,
                        icon: Icons.info_outline,
                        items: controller.informationSources,
                        onChanged: controller.selectInformationSource,
                        validator: (value) => requiredFieldValidation(
                            value, 'Please select information source'.tr),
                      ),
                      Gap(responsiveHeight(10)),
                      formButtons(() => controller.saveForm()),
                      Gap(responsiveHeight(10)),
                    ],
                  ),
                ),
              ),
            ),
        )));
  }
}
