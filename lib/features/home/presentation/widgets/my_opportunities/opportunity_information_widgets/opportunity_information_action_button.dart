import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/my_opportunities_controller.dart';
import '../../../../../../core/constants/enums.dart';
import '../../../../../../core/utils/form_utils.dart';
import '../../../../../../core/utils/responsive_size_helper.dart';
import '../../../../../../core/widgets/app_button.dart';
import '../../../../domain/entities/opportunity_entity.dart';
import '../../dialogs/save_dialog.dart';
import '../../snackbars/error_snackbar.dart';

class OpportunityInformationActionButton
    extends GetView<MyOpportunitiesController> {
  final String from;
  final OpportunityEntity opportunity;

  const OpportunityInformationActionButton({
    super.key,
    required this.from,
    required this.opportunity,
  });

  Widget opportunityInformationActionButton() {
    return AppButton(
      padding: EdgeInsets.all(responsiveFont(14)),
      backgroundColor: Get.theme.colorScheme.primary,
      type: AppButtonType.secondary,
      text: from.tr,
      onPressed: () => _handleAction(from, opportunity),
    );
  }

  void _handleAction(String from, OpportunityEntity opportunity) {
    if (!controller.formKey.currentState!.validate()) {
      final fieldsToValidate = (from == 'completion')
          ? [controller.priceField.value, controller.noteField.value]
          : [controller.noteField.value];

      validateAndScrollToFirstError(
        fieldsToValidate,
        controller.formKey.currentContext!,
      );
      return;
    }

    showSaveDialog(() => _processOpportunityAction(from, opportunity));
  }

  void _processOpportunityAction(String from, OpportunityEntity opportunity) {
    try {
      switch (from) {
        case 'completion':
          controller.completeOpportunity(opportunity);
          break;
        case 'abandonment':
          controller.abandonOpportunity(opportunity);
          break;
        case 'cancel':
          controller.cancelOpportunity(opportunity);
          break;
        default:
          showErrorSnackBar('Invalid action type', from);
      }
      controller.clearControllers(false);
      Get.back(closeOverlays: true);
    } catch (e) {
      controller.clearControllers(false);
      Get.log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return opportunityInformationActionButton();
  }
}
