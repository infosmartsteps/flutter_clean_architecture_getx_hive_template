import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../../domain/entities/opportunity_entity.dart';

Widget followUpWidget(OpportunityEntity opportunity) {
  return Container(
    decoration: BoxDecoration(
      color: opportunity.isFollowed
          ? AppColors.greenColor.withOpacity(0.1)
          :AppColors.orangeColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(responsiveFont(20)),
    ),
    child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: responsiveWidth(6),
        children: [
          Icon(
            opportunity.isFollowed ? Icons.check_circle : Icons.access_time,
            size: responsiveFont(16),
            color: opportunity.isFollowed ? AppColors.greenColor :AppColors.orangeColor,
          ),
          Text(
            opportunity.isFollowed
                ? "Under_Follow-up".tr
                : "Requires_Follow-up".tr,
            style: TextStyle(
              color: opportunity.isFollowed ? AppColors.greenColor :AppColors.orangeColor,
            ),
          ),
        ]),
  );
}
