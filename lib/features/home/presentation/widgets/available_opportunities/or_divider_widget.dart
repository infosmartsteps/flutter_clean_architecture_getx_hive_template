import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../controllers/available_opportunities_controller.dart';

Widget orDividerWidget(AvailableOpportunitiesController controller) {
  final hasEmptyPhone =
      controller.fieldModel.value.controller?.text.isEmpty ?? true;

  if (controller.selectedClient.value != null || !hasEmptyPhone) {
    return const SizedBox.shrink();
  }

  return Padding(
    padding: EdgeInsets.symmetric(vertical: responsiveHeight(10)),
    child: Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: responsiveWidth(8)),
          child: Text('or'.tr),
        ),
        const Expanded(child: Divider()),
      ],
    ),
  );
}
