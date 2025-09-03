import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/responsive_size_helper.dart';

Widget propertyStatusContainer(Color color, String label) {
  return Container(
      padding: EdgeInsets.symmetric(
          horizontal: responsiveWidth(12), vertical: responsiveHeight(10)),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(responsiveFont(16)),
      ),
      child: Text(
        label.tr,
        style: TextStyle(color: Get.theme.colorScheme.onPrimary),
      ));
}
