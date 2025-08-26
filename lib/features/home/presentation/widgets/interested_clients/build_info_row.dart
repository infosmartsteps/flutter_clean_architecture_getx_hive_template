import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/responsive_size_helper.dart';

Widget buildInfoRow(
    {required IconData icon,
    required String value,
    required int index,
    String? title,
    bool isLink = false,
    void Function()? onTap}) {
  return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: responsiveWidth(8),
        children: [
          Icon(icon,
              size: responsiveFont(16),
              color: isLink ? Colors.blue : Colors.grey[600]),
          RichText(
            text: TextSpan(
              style: Theme.of(Get.context!).textTheme.bodyMedium,
              children: [
                if (title != null)
                  TextSpan(
                    text: '$title: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                TextSpan(
                    text: value,
                    style: !isLink
                        ? null
                        : TextStyle(
                            color: Colors.blue[700],
                            decoration: TextDecoration.underline,
                          )),
              ],
            ),
          ),
        ],
      ));
}
