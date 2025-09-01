import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/routes/app_routes.dart';
import 'package:latlong2/latlong.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../domain/entities/property_entity.dart';
import '../../controllers/available_opportunities_controller.dart';
import '../interested_clients/information_screens_header.dart';
import '../interested_clients/property/property_detail_card.dart';

Widget propertyListView(List<PropertyEntity> properties,
    {void Function(int index)? onTap, void Function()? onPressed}) {
  return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: responsiveWidth(12)),
      separatorBuilder: (context, index) => Gap(responsiveHeight(20)),
      itemCount: properties.length,
      itemBuilder: (context, index) {
        final property = properties[index];
        return InkWell(
          onTap: onTap == null ? null : () => onTap(index),
          child: Column(children: [
            informationScreensHeader(
                isForSale: property.realEstateType == 1,
                title: property.propertyName ?? "",
                subtitle: property.unitName ?? '',
                icon: Icons.business),
            propertyDetailCard(
              property,
              propertyLink: "Property_Information_Link".tr,
              onTap: () =>
                  Get.toNamed(AppRoutes.propertyInformationScreen, arguments: {
                'property': property,
                'point': LatLng(
                  property.propertyLocationLat ?? 0,
                  property.propertyLocationLng ?? 0,
                ),
              }),
            ),
            if (onPressed != null)
              AppButton(text: 'interested_client'.tr, onPressed: onPressed)
          ]),
        );
      });
}
