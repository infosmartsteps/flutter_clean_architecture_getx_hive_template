import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/responsive_size_helper.dart';
import '../../../../domain/entities/opportunity_entity.dart';
import '../../../controllers/interested_clients_controller.dart';
import '../card_detail_row.dart';

// Property Details Card
Widget propertyDetailCard(BuildContext context, OpportunityEntity opportunity) {
  return Card(
    child: Padding(
      padding: EdgeInsets.all(responsiveFont(16)),
      child: Column(
        spacing: responsiveHeight(12),
        children: [
          cardDetailRow(
            context,
            icon: Icons.confirmation_number,
            title: 'property_id'.tr,
            value: opportunity.id,
          ),
          cardDetailRow(
            context,
            icon: Icons.home_work,
            title: 'Real_estate_name'.tr,
            value: opportunity.propertyName,
          ),
          cardDetailRow(
            context,
            icon: Icons.meeting_room,
            title: 'Property_name'.tr,
            value: opportunity.realEstateName,
          ),
          cardDetailRow(
            context,
            icon: Icons.link,
            title: 'property_link'.tr,
            value: opportunity.propertyLink,
            isLink: true,
          ),
        ],
      ),
    ),
  );
}