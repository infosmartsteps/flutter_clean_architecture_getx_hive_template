import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/routes/app_routes.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../controllers/interested_clients_controller.dart';

//lib/features/home/presentation/widgets/interested_clients/opportunity_card.dart
class OpportunityCard extends GetView<InterestedClientsController> {
  final int index;

  const OpportunityCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final opportunity = controller.opportunities[index];
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(responsiveFont(16)),
        ),
        child: Padding(
          padding: EdgeInsets.all(responsiveWidth(16)),
          child: Column(
            spacing: responsiveHeight(16),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with ID and follow button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(opportunity.id,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary)),
                  IconButton(
                    onPressed: () => controller.toggleFollow(index),
                    icon: Icon(
                      opportunity.isFollowed
                          ? Icons.check_circle
                          : Icons.add_circle,
                      color:
                          opportunity.isFollowed ? Colors.green : Colors.blue,
                      size: responsiveFont(30),
                    ),
                  ),
                ],
              ),
              _buildInfoRow(
                icon: Icons.business,
                title: "${"Real_estate_name".tr}: ",
                value: opportunity.propertyName,
              ),
              _buildInfoRow(
                icon: Icons.home_work,
                title: "${"Property_name".tr}: ",
                value: opportunity.unitName,
              ),
              link(
                  rout: AppRoutes.propertyInformationScreen,
                  text: "Property_Information_Link".tr),
              Divider(thickness: responsiveFont(2)),
              _buildInfoRow(
                icon: Icons.person,
                title: '${"client".tr}: ',
                value: opportunity.clientName,
              ),
              link(
                  rout: AppRoutes.clientInformationScreen,
                  text: "Client_information_Link".tr),
              Container(
                decoration: BoxDecoration(
                  color: opportunity.isFollowed
                      ? Colors.green.withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(responsiveFont(20)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: responsiveWidth(6),
                  children: [
                    Icon(
                      opportunity.isFollowed
                          ? Icons.check_circle
                          : Icons.access_time,
                      size: responsiveFont(16),
                      color:
                          opportunity.isFollowed ? Colors.green : Colors.orange,
                    ),
                    Text(
                      opportunity.isFollowed
                          ? "Under_Follow-up".tr
                          : "Requires_Follow-up".tr,
                      style: TextStyle(
                        color: opportunity.isFollowed
                            ? Colors.green
                            : Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: responsiveWidth(8),
      children: [
        Icon(icon, size: responsiveFont(16), color: Colors.grey[600]),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: Theme.of(Get.context!).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: '$title ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget link({
    required String rout,
    required String text,
  }) {
    return InkWell(
      onTap: () => controller.openLink(rout),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: responsiveWidth(8),
        children: [
          Icon(Icons.link, size: responsiveFont(16), color: Colors.blue),
          Text(
            text,
            style: TextStyle(
              color: Colors.blue[700],
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
