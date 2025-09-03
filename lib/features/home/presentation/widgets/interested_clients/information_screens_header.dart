import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/app_colors.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/interested_clients/property_status_container.dart';
import '../../../../../core/utils/responsive_size_helper.dart';

Widget informationScreensHeader(
    {required String title,
    required String subtitle,
    required IconData icon,
    bool? isForSale}) {
  return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(responsiveFont(12))),
      child: Padding(
        padding: EdgeInsets.all(responsiveFont(8)),
        child: Column(spacing: responsiveHeight(10), children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            if (isForSale != null) ...[
              isForSale
                  ? propertyStatusContainer(
                      Get.theme.colorScheme.primary, "for_sale")
                  : propertyStatusContainer(AppColors.greenColor, "for_rent")
            ],
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: responsiveWidth(12),
                  vertical: responsiveHeight(6)),
              decoration: BoxDecoration(
                color:AppColors.orangeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(responsiveFont(16)),
              ),
              child: Text(
                '${'hot_lead'.tr}🔥',
                style: TextStyle(
                  color:AppColors.orangeColor,
                  fontWeight: FontWeight.bold,
                  fontSize: responsiveFont(12),
                ),
              ),
            ),
          ]),
          Row(children: [
            Container(
              padding: EdgeInsets.all(responsiveFont(12)),
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: responsiveFont(24),
                color: AppColors.whiteColor,
              ),
            ),
            SizedBox(width: responsiveWidth(16)),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Get.theme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: responsiveHeight(4)),
                    Text(subtitle, style: Get.theme.textTheme.bodyMedium),
                  ]),
            ),
          ]),
        ]),
      ));
}
