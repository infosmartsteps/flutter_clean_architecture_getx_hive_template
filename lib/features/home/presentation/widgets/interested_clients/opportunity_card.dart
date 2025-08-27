import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/routes/app_routes.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../controllers/interested_clients_controller.dart';
import 'build_info_row.dart';
import 'card_header.dart';
import 'follow_up_widget.dart';

//lib/features/home/presentation/widgets/interested_clients/opportunity_card.dart
class OpportunityCard extends GetView<InterestedClientsController> {
  final int index;

  const OpportunityCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final opportunity = controller.opportunities[index];
      return Card(
        child: Padding(
          padding: EdgeInsets.all(responsiveWidth(16)),
          child: Column(
            spacing: responsiveHeight(16),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cardHeader(
                  context: context,
                  index: index,
                  controller: controller,
                  opportunity: opportunity),
              buildInfoRow(
                index: index,
                icon: Icons.business,
                title: "Real_estate_name".tr,
                value: opportunity.propertyName,
              ),
              buildInfoRow(
                index: index,
                icon: Icons.home_work,
                title: "Property_name".tr,
                value: opportunity.realEstateName,
              ),
              buildInfoRow(
                  index: index,
                  isLink: true,
                  onTap: () => controller.goToInformationScreen(
                      AppRoutes.propertyInformationScreen, index),
                  icon: Icons.link,
                  value: "Property_Information_Link".tr),
              Divider(thickness: responsiveFont(2)),
              buildInfoRow(
                index: index,
                icon: Icons.person,
                title: "client".tr,
                value: opportunity.clientName,
              ),
              buildInfoRow(
                  index: index,
                  isLink: true,
                  onTap: () => controller.goToInformationScreen(
                      AppRoutes.clientInformationScreen, index),
                  value: "Client_information_Link".tr,
                  icon: Icons.link),
              followUpWidget(opportunity)
            ],
          ),
        ),
      );
    });
  }
}
