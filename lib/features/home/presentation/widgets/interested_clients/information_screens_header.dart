import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/responsive_size_helper.dart';

Widget informationScreensHeader(BuildContext context,
    {required String title, required String subtitle, required IconData icon}) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(responsiveFont(12))),
    child: Stack(children: [
      Padding(
        padding: EdgeInsets.only(
            top: responsiveFont(5),
            left: responsiveFont(5),
            right: responsiveFont(5)),
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: responsiveWidth(12), vertical: responsiveHeight(6)),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(responsiveFont(16)),
            ),
            child: Text(
              '${'hot_lead'.tr}🔥',
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: responsiveFont(12),
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: responsiveFont(33),
          bottom: responsiveFont(10),
          left: responsiveFont(10),
          right: responsiveFont(10),
        ),
        child: Row(children: [
          Container(
            padding: EdgeInsets.all(responsiveFont(12)),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: responsiveFont(24)),
          ),
          SizedBox(width: responsiveWidth(16)),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: responsiveHeight(4)),
              Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
            ]),
          ),
        ]),
      ),
    ]),
  );
}
