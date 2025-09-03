import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_colors.dart';

Widget popUpMenuButton(
    {void Function(String)? onSelected, required String value}) {
  return PopupMenuButton<String>(
    icon: Icon(Icons.filter_list),
    onSelected: onSelected,
    itemBuilder: (BuildContext context) {
      return [
        buildPopMenu('1', 'for_sale', value),
        buildPopMenu('0', 'for_rent', value),
        buildPopMenu('', 'all', value),
      ];
    },
  );
}

PopupMenuEntry<String> buildPopMenu(String val, String label, String value) {
  return PopupMenuItem<String>(
      value: val,
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label.tr),
          if (value == val) Icon(Icons.check, color: AppColors.greenColor)
        ]),
        Divider()
      ]));
}
