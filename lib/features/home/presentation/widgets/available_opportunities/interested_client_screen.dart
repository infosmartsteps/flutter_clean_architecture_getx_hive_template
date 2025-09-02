import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/enums.dart';
import 'package:ksa_real_estates/core/utils/form_utils.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import 'package:ksa_real_estates/core/widgets/app_button.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/available_opportunities_controller.dart';
import '../../../../../core/widgets/custom_phone_field.dart';
import 'client_dropdown.dart';
import 'or_divider_widget.dart';

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
            builder: (controller) => Obx(
              () => Form(
                key: controller.formKey.value,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: responsiveWidth(16)),
                  child: Column(spacing: responsiveHeight(5), children: [
                    if (controller.selectedClient.value == null)
                      customPhoneField(
                        controller.fieldModel.value,
                        'client_phone_number'.tr,
                        Icons.phone,
                        onChanged: (_) => controller.update(),
                      ),
                    orDividerWidget(controller),
                    clientDropdown(controller),
                    orDividerWidget(controller),
                    if (controller.selectedClient.value == null &&
                        controller.fieldModel.value.controller!.text.isEmpty)
                      AppButton(
                        type: AppButtonType.secondary,
                        icon: Icon(Icons.add),
                        backgroundColor: Colors.green,
                        onPressed: controller.goToAddClient,
                        text: 'add_client'.tr,
                      ),
                    Gap(responsiveHeight(30)),
                    AppButton(
                      onPressed: controller.validate,
                      text: 'done'.tr,
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ));
  }
}
