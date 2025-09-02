import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/routes/app_routes.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/add_client_form_controller.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/dialogs/exit_dialog.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/add_client/form_buttons.dart';
import '../../../../../core/utils/form_utils.dart';
import '../../widgets/add_client/build_drop_down.dart';
import '../../widgets/add_client/build_form_fields.dart';
import '../../widgets/dialogs/save_dialog.dart';

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
              appBar: AppBar(title: Text('new_client'.tr)),
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
                          if (Get.previousRoute ==
                              AppRoutes.interestedClientScreen)
                            Obx(
                              () => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('acquisition'.tr,
                                        style: Get.theme.textTheme.titleLarge),
                                    Switch(
                                        value: controller.acquisition.value,
                                        onChanged: (bool value) =>
                                            controller.acquisition.value =
                                                !controller.acquisition.value),
                                  ]),
                            ),
                          buildFormFields(controller),
                          buildDropdowns(controller),
                          Gap(responsiveHeight(10)),
                          formButtons(() {
                            if (!controller.state.formKey.currentState!
                                .validate()) {
                              validateAndScrollToFirstError(
                                  controller.fieldsToValidate,
                                  controller.state.formKey.currentContext!);
                              return;
                            }
                            showSaveDialog(() async =>
                                await Get.find<AddClientFormController>()
                                    .saveForm());
                          }),
                          Gap(responsiveHeight(10)),
                        ]),
                  ),
                ),
              ),
            )));
  }
}
