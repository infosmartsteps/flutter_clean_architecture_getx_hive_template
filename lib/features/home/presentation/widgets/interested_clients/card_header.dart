import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../../domain/entities/opportunity_entity.dart';

Widget cardHeader(OpportunityEntity opportunity, [Function()? onPressed]) {
  return Row(children: [
    Icon(Icons.numbers),
    Text(opportunity.id,
        style: Get.theme.textTheme.titleLarge
            ?.copyWith(color: Get.theme.colorScheme.primary)),
    if (onPressed != null) ...[
      Spacer(),
      IconButton(
        onPressed: onPressed,
        icon: Icon(
          opportunity.isFollowed ? Icons.check_circle : Icons.add_circle,
          color: opportunity.isFollowed ? Colors.green : Colors.blue,
          size: responsiveFont(30),
        ),
      ),
    ],
  ]);
}
