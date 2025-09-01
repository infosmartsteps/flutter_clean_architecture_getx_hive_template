import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/domain/entities/client_entity.dart';
import '../../../../../../core/utils/responsive_size_helper.dart';
import '../card_detail_row.dart';

Widget clientDetailsCard(ClientEntity client,
    {String? clientDataLink, void Function()? onTap}) {
  return Card(
    child: Padding(
      padding: EdgeInsets.all(responsiveFont(16)),
      child: Column(
        spacing: responsiveHeight(12),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cardDetailRow(
            icon: Icons.numbers_outlined,
            title: 'registration_number'.tr,
            value: client.registrationNumber.toString(),
          ),
          cardDetailRow(
            icon: Icons.person_outline,
            title: 'client_name'.tr,
            value: client.clientName ?? '',
          ),
          cardDetailRow(
            icon: Icons.phone,
            title: 'phone_number'.tr,
            value: client.phoneNumber ?? '',
          ),
          cardDetailRow(
            icon: Icons.email,
            title: 'email'.tr,
            value: client.email ?? '',
          ),
          cardDetailRow(
            icon: Icons.person_rounded,
            title: 'responsible_person'.tr,
            value: client.responsiblePerson ?? '',
          ),
          cardDetailRow(
            icon: Icons.phone_android_outlined,
            title: 'responsible_person_phone'.tr,
            value: client.responsiblePersonPhone.toString(),
          ),
          cardDetailRow(
            icon: Icons.list_alt_outlined,
            title: 'business_sector'.tr,
            value: client.businessSector.toString(),
          ),
          cardDetailRow(
            icon: Icons.location_city_outlined,
            title: 'city'.tr,
            value: client.city.toString(),
          ),
          cardDetailRow(
            icon: Icons.info_outline,
            title: 'information_source'.tr,
            value: client.informationSource.toString(),
          ),
          cardDetailRow(
            icon: Icons.home_outlined,
            title: 'address'.tr,
            value: client.address.toString(),
          ),
          cardDetailRow(
            icon: Icons.link,
            title: 'client_link'.tr,
            value: clientDataLink ?? client.dataUrl ?? '',
            isLink: true,
            onTap: onTap,
          ),
        ].whereType<Widget>().toList(), // removes nulls
      ),
    ),
  );
}
