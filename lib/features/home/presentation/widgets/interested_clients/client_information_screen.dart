import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/interested_clients_controller.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import 'client/client_details_card.dart';
import 'information_screens_header.dart';
import 'map_widget.dart';

//lib/features/home/presentation/widgets/interested_clients/client_information_screen.dart
class ClientInformationScreen extends GetView<InterestedClientsController> {
  const ClientInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final opportunity = controller.opportunities.isNotEmpty
        ? controller.opportunities[Get.arguments['index']]
        : null;
    return Scaffold(
      appBar: AppBar(title: Text('client_information'.tr)),
      body: opportunity == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(responsiveFont(16)),
              child: Column(
                spacing: responsiveHeight(30),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  informationScreensHeader(context,
                      title: opportunity.clientName,
                      subtitle: 'potential_client'.tr,
                      icon: Icons.person),
                  clientDetailsCard(context, opportunity),
                  MapWidget(label: 'client_location'.tr),
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton.icon(
                              onPressed: () => controller.launchEmail(
                                  mailtoUrl: "yousef.njadat98@gmail.com"),
                              icon: Icon(Icons.email, size: responsiveFont(20)),
                              label: Text('email'.tr),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: responsiveHeight(16)),
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white))),
                      SizedBox(width: responsiveWidth(12)),
                      Expanded(
                          child: ElevatedButton.icon(
                              onPressed: () =>
                                  controller.callCustomer("0790498335"),
                              icon: Icon(Icons.phone, size: responsiveFont(20)),
                              label: Text('call'.tr),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: responsiveHeight(16)),
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white))),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
