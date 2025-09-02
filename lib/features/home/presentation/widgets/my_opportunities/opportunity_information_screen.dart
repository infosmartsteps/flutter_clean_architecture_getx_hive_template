import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import 'package:ksa_real_estates/core/widgets/custom_text_field.dart';
import 'package:ksa_real_estates/features/home/domain/entities/opportunity_entity.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/my_opportunities_controller.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/client_information_widget.dart';
import '../dialogs/exit_dialog.dart';
import 'opportunity_information_widgets/opportunity_information_header.dart';
import '../property_information_widget.dart';
import 'opportunity_information_widgets/opportunity_information_action_button.dart';

// lib/features/home/presentation/widgets/my_opportunities/opportunity_information_screen.dart
class OpportunityInformationScreen extends GetView<MyOpportunitiesController> {
  const OpportunityInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OpportunityEntity opportunity = Get.arguments['opportunity'];
    final String from = Get.arguments['from'];
    if (from.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('error'.tr)),
        body: Center(child: Text('invalid_arguments'.tr)),
      );
    }
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) => !didPop
            ? showExitDialog(onExit: () => controller.clearControllers(didPop))
            : null,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
              appBar: AppBar(title: Text(from.tr)),
              body: Form(
                  key: controller.formKey,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: responsiveWidth(14)),
                    child: SingleChildScrollView(
                        child: Column(spacing: responsiveHeight(20), children: [
                      opportunityInformationHeader(opportunity),
                      if (from == 'completion')
                        customTextField(controller.priceField.value, 'price'.tr,
                            icon: Icons.attach_money),
                      customTextField(controller.noteField.value, 'notes'.tr,
                          maxLines: 6,
                          showLabel: true,
                          textInputAction: TextInputAction.done),
                      clientInformationWidget(opportunity.client),
                      Divider(),
                      propertyInformationWidget(opportunity.property),
                      SizedBox(width: responsiveHeight(70))
                    ])),
                  )),
              floatingActionButton: OpportunityInformationActionButton(
                  from: from, opportunity: opportunity)),
        ));
  }
}
