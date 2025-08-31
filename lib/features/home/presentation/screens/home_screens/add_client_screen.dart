import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/routes/app_routes.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/add_client_form_controller.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/dialogs/exit_dialog.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/add_client/form_buttons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/enums.dart';
import '../../../../../core/widgets/app_button.dart';
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
                    if (Get.previousRoute == AppRoutes.interestedClientScreen)
                      Obx(
                        () => Row(
                          children: [
                            Text(
                              'acquisition'.tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.color,
                              ),
                            ),
                            Switch(
                              value: controller.acquisition.value,
                              activeTrackColor: Colors.indigo.withOpacity(0.4),
                              inactiveTrackColor: Colors.amber.withOpacity(0.4),
                              onChanged: (bool value) => controller.acquisition
                                  .value = !controller.acquisition.value,
                            ),
                          ],
                        ),
                      ),
                    buildFormFields(controller),
                    buildDropdowns(controller),
                    Gap(responsiveHeight(10)),
                    formButtons(() {
                      showSaveDialog();
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
