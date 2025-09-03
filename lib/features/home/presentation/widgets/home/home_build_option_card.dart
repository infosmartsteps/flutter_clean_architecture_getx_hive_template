import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/responsive_size_helper.dart';

Widget homeBuildOptionCard({
  required IconData icon,
  required String title,
  required Color color,
  required VoidCallback onTap,
}) {
  return Card(
      child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(responsiveWidth(16)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: responsiveHeight(10),
                children: [
                  Container(
                    padding: EdgeInsets.all(responsiveWidth(12)),
                    decoration: BoxDecoration(
                        color: color.withOpacity(0.2), shape: BoxShape.circle),
                    child: Icon(icon, size: responsiveFont(30), color: color),
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Get.theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ]),
          )));
}
