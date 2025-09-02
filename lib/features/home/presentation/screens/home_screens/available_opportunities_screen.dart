import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import 'package:ksa_real_estates/core/widgets/app_button.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/available_opportunities/property_list_view.dart';
import '../../controllers/available_opportunities_controller.dart';
import '../../widgets/interested_clients/information_screens_header.dart';
import '../../widgets/interested_clients/property/property_detail_card.dart';

// lib/features/home/presentation/screens/home_screens/available_opportunities_screen.dart
class AvailableOpportunitiesScreen
    extends GetView<AvailableOpportunitiesController> {
  const AvailableOpportunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('available_opportunities'.tr),
          actions: [
            PopupMenuButton<String>(
              icon: Icon(Icons.filter_list),
              onSelected: (String value) {
                controller.getProperties(
                    value: value.isNotEmpty ? value : null);
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: '1',
                    child: Text('for_sale'.tr),
                  ),
                  PopupMenuItem<String>(
                    value: '0',
                    child: Text('for_rent'.tr),
                  ),
                  PopupMenuItem<String>(
                    value: '',
                    child: Text('all'.tr),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Obx(() => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async => await controller.getProperties(),
                child: propertyListView(
                  controller.properties,
                  onPressed: controller.interestedClient,
                ))));
  }
}
