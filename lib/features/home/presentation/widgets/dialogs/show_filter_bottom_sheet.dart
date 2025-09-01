import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../build_date_picker_field.dart';

void showFilterBottomSheet(
    String title,
    String clientName,
    DateTime? from,
    DateTime? to,
    void Function() cancel,
    void Function(String clientName, String from, String to) apply) {
  final clientNameController = TextEditingController(text: clientName);
  final fromController = TextEditingController(text: from.toString());
  final toController = TextEditingController(text: to.toString());
  Get.bottomSheet(Scaffold(
    resizeToAvoidBottomInset: false,
    body: Padding(
      padding: EdgeInsets.all(responsiveFont(16)),
      child: SingleChildScrollView(
        child: Column(spacing: responsiveHeight(20), children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title, style: Get.theme.textTheme.titleLarge),
            Icon(Icons.filter_list)
          ]),
          Divider(),
          AppTextFormField(
              label: 'client_name'.tr,
              controller: clientNameController,
              prefixIcon: Icon(Icons.person)),
          Row(spacing: responsiveWidth(20), children: [
            buildDatePickerFiled(
                label: 'from_date'.tr,
                controller: fromController,
                initialDate: from),
            buildDatePickerFiled(
                label: 'to_date'.tr, controller: toController, initialDate: to),
          ]),
          Gap(responsiveHeight(20)),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(child: AppButton(onPressed: cancel, text: 'cancel'.tr)),
            Spacer(),
            Expanded(
                child: AppButton(
                    onPressed: () => apply(clientNameController.text,
                        fromController.text, toController.text),
                    text: 'apply'.tr,
                    backgroundColor: Colors.green)),
          ]),
          Gap(responsiveHeight(10)),
        ]),
      ),
    ),
  ));
}
