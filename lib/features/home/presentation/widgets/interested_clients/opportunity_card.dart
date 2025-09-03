import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/domain/entities/property_entity.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../../domain/entities/client_entity.dart';
import '../../../domain/entities/opportunity_entity.dart';
import 'build_info_row.dart';
import 'card_header.dart';
import 'follow_up_widget.dart';
import 'opportunity_option_buttons.dart';

//lib/features/home/presentation/widgets/interested_clients/opportunity_card.dart
class OpportunityCard extends StatelessWidget {
  final OpportunityEntity opportunity;
  final void Function(PropertyEntity property)? goToPropertyInformationScreen;
  final void Function(ClientEntity client)? goToClientInformationScreen;
  final void Function()? completion, abandonment, cancel, toggleFollow;

  const OpportunityCard(
      {super.key,
      required this.opportunity,
      this.toggleFollow,
      this.goToPropertyInformationScreen,
      this.goToClientInformationScreen,
      this.completion,
      this.abandonment,
      this.cancel});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: EdgeInsets.all(responsiveWidth(12)),
      child: Column(
          spacing: responsiveHeight(16),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cardHeader(opportunity, toggleFollow),
            buildInfoRow(
              icon: Icons.business,
              title: "Real_estate_name".tr,
              value: opportunity.property.propertyName ?? '',
            ),
            buildInfoRow(
              icon: Icons.home_work,
              title: "Property_name".tr,
              value: opportunity.property.unitName ?? '',
            ),
            buildInfoRow(
                isLink: true,
                onTap: () =>
                    goToPropertyInformationScreen!(opportunity.property),
                icon: Icons.link,
                value: "Property_Information_Link".tr),
            Divider(thickness: responsiveFont(2)),
            buildInfoRow(
              icon: Icons.person,
              title: "client".tr,
              value: opportunity.client.clientName ?? '',
            ),
            buildInfoRow(
                isLink: true,
                onTap: () => goToClientInformationScreen!(opportunity.client),
                value: "Client_information_Link".tr,
                icon: Icons.link),
            if (toggleFollow != null) followUpWidget(opportunity),
            SizedBox(),
            if (completion != null || abandonment != null || cancel != null)
              opportunityOptionButtons(completion, abandonment, cancel)
          ]),
    ));
  }
}
