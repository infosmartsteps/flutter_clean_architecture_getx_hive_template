import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/responsive_size_helper.dart';
import '../../../../domain/entities/property_entity.dart';
import '../card_detail_row.dart';

// lib/features/home/presentation/widgets/interested_clients/property/property_detail_card.dart
Widget propertyDetailCard(PropertyEntity property,{String? propertyLink,void Function()? onTap}) {
  return Card(
    child: Padding(
      padding: EdgeInsets.all(responsiveFont(16)),
      child: Column(
          spacing: responsiveHeight(12),
          children: [
            cardDetailRow(
              icon: Icons.numbers,
              title: 'property_id'.tr,
              value: property.id ?? '',
            ),
            cardDetailRow(
              icon: Icons.home_work,
              title: 'Real_estate_name'.tr,
              value: property.propertyName ?? '',
            ),
            cardDetailRow(
              icon: Icons.meeting_room,
              title: 'Property_name'.tr,
              value: property.unitName ?? '',
            ),
            cardDetailRow(
              icon: Icons.trending_up,
              title: 'maxPrice'.tr,
              value: property.maxPrice.toString(),
            ),
            cardDetailRow(
              icon: Icons.trending_down,
              title: 'minPrice'.tr,
              value: property.minPrice.toString(),
            ),
            cardDetailRow(
              icon: Icons.link,
              title: 'property_link'.tr,
              value: propertyLink ?? property.dataUrl ?? '',
              isLink: true,
              onTap: onTap
            ),
          ].whereType<Widget>().toList()),
    ),
  );
}
