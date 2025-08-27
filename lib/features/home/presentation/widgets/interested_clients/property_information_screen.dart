import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/interested_clients_controller.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/interested_clients/property/property_detail_card.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import 'information_screens_header.dart';
import 'map_widget.dart';

//lib/features/home/presentation/widgets/interested_clients/property_information_screen.dart
class PropertyInformationScreen extends GetView<InterestedClientsController> {
  const PropertyInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final opportunity = controller.opportunities.isNotEmpty
        ? controller.opportunities[Get.arguments['index']]
        : null;
    return Scaffold(
        appBar: AppBar(title: Text('property_information'.tr)),
        body: opportunity == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.all(responsiveFont(16)),
                child: Column(
                  spacing: responsiveHeight(24),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    informationScreensHeader(context,
                        title: opportunity.propertyName,
                        subtitle: opportunity.realEstateName,
                        icon: Icons.business),
                    propertyDetailCard(context, opportunity),
                    MapWidget(label: 'property_location'.tr),
                  ],
                ),
              ));
  }
}
