import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/utils/form_utils.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import 'package:ksa_real_estates/core/widgets/app_button.dart';
import 'package:ksa_real_estates/core/widgets/app_drop_down.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/available_opportunities_controller.dart';

//lib/features/home/presentation/widgets/available_opportunities/interested_client_screen.dart
class InterestedClientScreen extends GetView<AvailableOpportunitiesController> {
  const InterestedClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text('interested_client'.tr)),
        body: GetBuilder<AvailableOpportunitiesController>(
          builder: (controller1) => Obx(
            () => Form(
              key: controller.formKey.value,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: responsiveWidth(16)),
                child: Column(spacing: responsiveHeight(20), children: [
                  if (controller.selectedClient.value == null)
                    buildPhoneField(
                      controller.fieldModel.value,
                      "client_phone_number".tr,
                      Icons.phone,
                      onChanged: (p0) => controller.update(),
                    ),
                  if (controller.fieldModel.value.controller?.value.text ==
                      '') ...[
                    Row(
                      spacing: responsiveWidth(10),
                      children: [
                        Expanded(child: Divider()),
                        Text('or'),
                        Expanded(child: Divider()),
                      ],
                    ),
                    Obx(
                      () => AppDropDown(
                        icon: Icons.person,
                        labelText: "choose_client".tr,
                        fieldKey: controller.focusManager
                            .getFieldKey('choose_client'),
                        focusNode: controller.focusManager
                            .getFocusNode('choose_client'),
                        validator: (value) => requiredFieldValidation(
                            value, 'please_select_business_sector'.tr),
                        items: controller.clientsLookups,
                        isLoading: controller.isLoading.value,
                        value: controller.selectedClient.value,
                        onChanged: (value) =>
                            controller.selectedClient.value = value,
                      ),
                    ),
                  ],
                  if (controller.selectedClient.value == null &&
                      controller.fieldModel.value.controller!.value.text ==
                          '') ...[
                    Row(
                      spacing: responsiveWidth(10),
                      children: [
                        Expanded(child: Divider()),
                        Text('or'),
                        Expanded(child: Divider()),
                      ],
                    ),
                    AppButton(
                        backgroundColor: Get.theme.primaryColor,
                        onPressed: controller.goToAddClient,
                        text: 'add_client'.tr),
                  ],
                  Gap(responsiveHeight(20)),
                  AppButton(onPressed: controller.validate, text: 'done'.tr)
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
