import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/my_opportunities_controller.dart';

import '../dialogs/show_filter_bottom_sheet.dart';

class FilterOpportunitiesButton extends GetView<MyOpportunitiesController> {
  const FilterOpportunitiesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildFilterButton();
  }

  Widget _buildFilterButton() {
    return IconButton(
      onPressed: _showFilterBottomSheet,
      icon: const Icon(Icons.filter_list),
    );
  }

  void _showFilterBottomSheet() {
    showFilterBottomSheet(
      propertyName: controller.propertyName.value,
      propertyNumber: controller.propertyNumber.value,
      'filter_opportunities'.tr,
      controller.clientName.value,
      controller.fromDate.value,
      controller.toDate.value,
      controller.cancelFilter,
      controller.applyFilter,
    );
  }
}
