import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/my_previous_operations_controllers/entered_clients_controller.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/dialogs/show_filter_bottom_sheet.dart';
import 'clients_list_view.dart';

class EnteredClientsScreen extends GetView<EnteredClientsController> {
  const EnteredClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async => await controller.getClients(),
                child: clientsListView(controller.clients),
              ),
      ),
      appBar: AppBar(title: Text("entered_clients".tr), actions: [
        IconButton(
            onPressed: () => showFilterBottomSheet(
                  'filter_clients'.tr,
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
