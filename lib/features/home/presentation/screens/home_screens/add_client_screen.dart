import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/add_client_form_controller.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/dialogs/exit_dialog.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/add_client/form_buttons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/enums.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../widgets/add_client/build_drop_down.dart';
import '../../widgets/add_client/build_form_fields.dart';

class AddClientScreen extends GetView<AddClientFormController> {
  const AddClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) => !didPop ? showExitDialog() : null,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'new_client'.tr,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: responsiveWidth(16)),
            child: Form(
              key: controller.state.formKey,
              child: SingleChildScrollView(
                controller: controller.state.scrollController,
                child: Column(
                  spacing: responsiveHeight(20),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildFormFields(controller),
                    buildDropdowns(controller),
                    Gap(responsiveHeight(10)),
                    formButtons(() {
                      if (!controller.state.formKey.currentState!.validate()) {
                        controller.validateAndScrollToFirstError();
                        return;
                      }
                      Get.defaultDialog(
                          title: 'confirm'.tr,
                          content: Text('are_you_sure_confirm'.tr),
                          contentPadding: EdgeInsets.all(responsiveFont(24)),
                          backgroundColor: Get.theme.colorScheme.onSecondary,
                          actions: [
                            AppButton(
                              type: AppButtonType.secondary,
                              onPressed: () => Get.back(),
                              text: 'cancel'.tr,
                            ),
                            AppButton(
                              type: AppButtonType.secondary,
                              backgroundColor: Colors.green,
                              textColor: AppColors.whiteColor,
                              onPressed: () async {
                                await controller.saveForm();
                                Get.back(closeOverlays: true); // This will close dialog AND screen
                              },
                              text: 'confirm'.tr,
                            ),
                          ]);
                    }),
                    Gap(responsiveHeight(10)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
