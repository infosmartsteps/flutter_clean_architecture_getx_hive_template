import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/my_previous_operations_controllers/entered_opportunities_controller.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/dialogs/show_filter_bottom_sheet.dart';
import '../../../../../core/widgets/app_button.dart';
import '../available_opportunities/property_list_view.dart';

class EnteredOpportunitiesScreen
    extends GetView<EnteredOpportunitiesController> {
  const EnteredOpportunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async =>
                    await controller.getEnteredOpportunities(),
                child: propertyListView(controller.properties),
              ),
      ),
      appBar: AppBar(title: Text("entered_opportunities".tr), actions: [
        AppButton(
            onPressed: () => showFilterBottomSheet(
                  'filter_opportunities'.tr,
                  controller.clientName.value,
                  controller.from.value,
                  controller.to.value,
                  controller.cancel,
                  (clientName, from, to, propertyName, propertyNumber) =>
                      controller.apply(clientName, from, to),
                ),
            icon: Icon(Icons.filter_list))
      ]),
    );
  }
}
