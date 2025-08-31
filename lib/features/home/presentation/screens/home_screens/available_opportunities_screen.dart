import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/routes/app_routes.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import 'package:ksa_real_estates/core/widgets/app_button.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/dialogs/save_dialog.dart';
import '../../controllers/available_opportunities_controller.dart';
import '../../widgets/dialogs/location_info_dialog.dart';
import '../../widgets/flutter_map_widget.dart';
import '../../widgets/interested_clients/information_screens_header.dart';
import '../../widgets/interested_clients/property/property_detail_card.dart';

// lib/features/home/presentation/screens/home_screens/available_opportunities_screen.dart
class AvailableOpportunitiesScreen
    extends GetView<AvailableOpportunitiesController> {
  const AvailableOpportunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('available_opportunities'.tr)),
        body: Obx(() => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async => await controller.getProperties(),
                child: ListView.separated(
                    padding:
                        EdgeInsets.symmetric(horizontal: responsiveWidth(12)),
                    separatorBuilder: (context, index) =>
                        Gap(responsiveHeight(20)),
                    itemCount: controller.properties.length,
                    itemBuilder: (context, index) {
                      final property = controller.properties[index];
                      return InkWell(
                        onTap: () =>
                            controller.goToPropertyInformationScreen(property),
                        child: Column(children: [
                          informationScreensHeader(
                              title: property.propertyName ?? "",
                              subtitle: property.unitName ?? '',
                              icon: Icons.business),
                          propertyDetailCard(property),
                          AppButton(
                              text: 'interested_client'.tr,
                              onPressed: controller.interestedClient)
                        ]),
                      );
                    }))));
  }
}
