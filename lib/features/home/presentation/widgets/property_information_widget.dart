import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/routes/app_routes.dart';
import '../../../../core/widgets/app_button.dart';
import '../../domain/entities/property_entity.dart';
import 'interested_clients/information_screens_header.dart';
import 'interested_clients/property/property_detail_card.dart';

Widget propertyInformationWidget(
    PropertyEntity property, [Function()? onPressed]) {
  return Column(children: [
    informationScreensHeader(
        isForSale: property.realEstateType == 1,
        title: property.propertyName ?? "",
        subtitle: property.unitName ?? '',
        icon: Icons.business),
    propertyDetailCard(
      property,
      propertyLink: "Property_Information_Link".tr,
      onTap: () => Get.toNamed(AppRoutes.propertyInformationScreen, arguments: {
        'property': property,
        'point': LatLng(
          property.propertyLocationLat ?? 0,
          property.propertyLocationLng ?? 0,
        ),
      }),
    ),
    if (onPressed != null)
      AppButton(text: 'interested_client'.tr, onPressed: onPressed)
  ]);
}
