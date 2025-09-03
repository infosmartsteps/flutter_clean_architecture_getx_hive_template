import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/domain/entities/property_entity.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/interested_clients/property/property_detail_card.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import 'information_screens_header.dart';
import 'map_widget.dart';

//lib/features/home/presentation/widgets/interested_clients/property_information_screen.dart
class PropertyInformationScreen extends StatelessWidget {
  const PropertyInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PropertyEntity property = Get.arguments['property'];
    return Scaffold(
        appBar: AppBar(title: Text('property_information'.tr)),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(responsiveFont(16)),
          child: Column(
              spacing: responsiveHeight(24),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                informationScreensHeader(
                    isForSale: property.realEstateType == 1,
                    title: property.propertyName ?? "",
                    subtitle: property.unitName ?? '',
                    icon: Icons.business),
                propertyDetailCard(property),
                MapWidget(label: 'property_location'.tr),
              ]),
        ));
  }
}
