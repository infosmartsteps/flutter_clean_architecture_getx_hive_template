import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../core/utils/responsive_size_helper.dart';
import '../../../../../core/constants/app_colors.dart';

Widget? cardDetailRow(
    {required IconData icon,
    required String title,
    required String value,
    bool isLink = false,
    void Function()? onTap}) {
  if (value.isEmpty) return null;
  final textTheme = Get.theme.textTheme;
  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, size: responsiveFont(18), color:AppColors.grey600),
    SizedBox(width: responsiveWidth(12)),
    Expanded(
      child: Column(
          spacing: responsiveHeight(4),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            isLink
                ? InkWell(
                    onTap: onTap ??
                        () async {
                          if (await canLaunchUrl(Uri.parse(value))) {
                            await launchUrl(Uri.parse(value));
                          } else {
                            throw 'Could not launch $value';
                          }
                        },
                    child: Text(value,
                        style: textTheme.bodyMedium?.copyWith(
                            color:AppColors.blueColor,
                            decoration: TextDecoration.underline)))
                : Text(value, style: textTheme.bodyMedium),
          ]),
    ),
  ]);
}
