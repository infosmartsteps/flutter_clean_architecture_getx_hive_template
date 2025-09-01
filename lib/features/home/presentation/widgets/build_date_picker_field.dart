import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/app_text_form_field.dart';

Widget buildDatePickerFiled({label, controller, initialDate}) {
  return Expanded(
    child: AppTextFormField(
      label: label,
      controller: controller,
      prefixIcon: Icon(Icons.date_range),
      readOnly: true,
      onTap: () async {
        final selectedDate = await showDatePicker(
          initialDate: initialDate ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
          context: Get.context!,
        );
        controller.text = selectedDate.toString();
      },
    ),
  );
}
