import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/enums.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../domain/entities/opportunity_entity.dart';

Widget cardHeader(OpportunityEntity opportunity, [Function()? onPressed]) {
  return Row(children: [
    Icon(Icons.numbers),
    Text(opportunity.id,
        style: Get.theme.textTheme.titleLarge
            ?.copyWith(color: Get.theme.colorScheme.primary)),
    if (onPressed != null) ...[
      Spacer(),
      AppButton(
        type: AppButtonType.secondary,
        backgroundColor: AppColors.transparent,
        onPressed: onPressed,
        icon: Icon(
          opportunity.isFollowed ? Icons.check_circle : Icons.add_circle,
          color: opportunity.isFollowed ? AppColors.greenColor :AppColors.blueColor,
          size: responsiveFont(30),
        ),
      ),
    ],
  ]);
}
