import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/responsive_size_helper.dart';
import '../card_detail_row.dart';

Widget clientDetailsCard(BuildContext context,opportunity){
  return Card(
    child: Padding(
      padding: EdgeInsets.all(responsiveFont(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cardDetailRow(
            context,
            icon: Icons.person_outline,
            title: 'client_name'.tr,
            value: opportunity.clientName,
          ),
          SizedBox(height: responsiveHeight(12)),
          cardDetailRow(
            context,
            icon: Icons.phone,
            title: 'phone_number'.tr,
            value: '+966 55 123 4567',
          ),
          SizedBox(height: responsiveHeight(12)),
          cardDetailRow(
            context,
            icon: Icons.email,
            title: 'email'.tr,
            value: 'client@example.com',
          ),
          SizedBox(height: responsiveHeight(12)),
          cardDetailRow(
            context,
            icon: Icons.business,
            title: 'company'.tr,
            value: 'شركة التقنية المحدودة',
          ),
          SizedBox(height: responsiveHeight(12)),
          cardDetailRow(
            context,
            icon: Icons.link,
            title: 'client_link'.tr,
            value: opportunity.clientLink,
            isLink: true,
          ),
        ],
      ),
    ),
  );
}