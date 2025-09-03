import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/available_opportunities/pop_up_menu_button.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/available_opportunities/property_list_view.dart';
import '../../controllers/available_opportunities_controller.dart';

// lib/features/home/presentation/screens/home_screens/available_opportunities_screen.dart
class AvailableOpportunitiesScreen
    extends GetView<AvailableOpportunitiesController> {
  const AvailableOpportunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('available_opportunities'.tr), actions: [
          Obx(() => popUpMenuButton(
                value: controller.filterValue.value,
                onSelected: (String value) {
                  controller.filterValue.value = value;
                  controller.getProperties(
                      value: value.isNotEmpty ? value : null);
                },
              ))
        ]),
        body: Obx(() => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async => await controller.getProperties(),
                child: propertyListView(controller.properties,
                    onPressed: controller.interestedClient))));
  }
}
