import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_size_helper.dart';

Widget buildInfoRow({
  required IconData icon,
  required String value,
  String? title,
  bool isLink = false,
  void Function()? onTap,
}) {
  return InkWell(
      onTap: onTap,
      child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon,
                size: responsiveFont(16),
                color: isLink ?AppColors.blueColor :AppColors.grey600),
            SizedBox(width: responsiveWidth(8)),
            Expanded(
                child: RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis, // Add overflow handling
              text: TextSpan(
                  style: Theme.of(Get.context!).textTheme.bodyMedium,
                  children: [
                    if (title != null)
                      TextSpan(
                          text: '$title: ',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: value,
                        style: !isLink
                            ? null
                            : TextStyle(
                                color:AppColors.blueColor[700],
                                decoration: TextDecoration.underline))
                  ]),
            )),
          ]));
}
