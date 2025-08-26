import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../core/utils/responsive_size_helper.dart';

Widget cardDetailRow(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String value,
  bool isLink = false,
}) {
  final textTheme = Theme.of(context).textTheme;
  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, size: responsiveFont(18), color: Colors.grey[600]),
    SizedBox(width: responsiveWidth(12)),
    Expanded(
      child: Column(
          spacing: responsiveHeight(4),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
            isLink
                ? InkWell(
                    onTap: () async {
                      if (await canLaunchUrl(Uri.parse(value))) {
                        await launchUrl(Uri.parse(value));
                      } else {
                        throw 'Could not launch $value';
                      }
                    },
                    child: Text(value,
                        style: textTheme.bodyMedium?.copyWith(
                            color: Colors.blue,
                            decoration: TextDecoration.underline)))
                : Text(value, style: textTheme.bodyMedium),
          ]),
    ),
  ]);
}
