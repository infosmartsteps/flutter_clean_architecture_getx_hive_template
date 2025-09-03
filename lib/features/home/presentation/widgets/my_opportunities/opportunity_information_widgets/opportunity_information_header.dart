import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import 'package:ksa_real_estates/features/home/domain/entities/opportunity_entity.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/interested_clients/card_header.dart';

import '../../../../../../core/constants/app_colors.dart';

Widget opportunityInformationHeader(OpportunityEntity opportunity) {
  return Container(
    width: responsiveWidth(330),
    decoration: BoxDecoration(
      color: Get.theme.dialogBackgroundColor,
      border: Border.all(color: AppColors.greyColor),
      borderRadius: BorderRadius.circular(responsiveFont(8)),
      boxShadow: [
        BoxShadow(
          color: AppColors.grey700!,
          blurRadius: 20,
          spreadRadius: -4,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    padding: EdgeInsets.all(responsiveWidth(20)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('opportunity_number'.tr, style: Get.theme.textTheme.titleLarge),
      cardHeader(opportunity),
    ]),
  );
}
