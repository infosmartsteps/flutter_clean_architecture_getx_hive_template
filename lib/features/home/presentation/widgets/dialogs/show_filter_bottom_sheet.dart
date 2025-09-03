import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
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
    void Function(String clientName, String from, String to,
            String? propertyName, String? propertyNumber)
        apply,
    {String? propertyName,
    String? propertyNumber}) {
  final clientNameController = TextEditingController(text: clientName);
  final propertyNameController = TextEditingController(text: propertyName);
  final propertyNumberController = TextEditingController(text: propertyNumber);
  final fromController = TextEditingController(text: from.toString());
  final toController = TextEditingController(text: to.toString());
  Get.bottomSheet(Scaffold(
    resizeToAvoidBottomInset: false,
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: responsiveWidth(16)),
      child: SingleChildScrollView(
        child: Column(spacing: responsiveHeight(20), children: [
          SizedBox(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title, style: Get.theme.textTheme.titleLarge),
            Icon(Icons.filter_list)
          ]),
          Divider(),
          AppTextFormField(
              label: 'client_name'.tr,
              controller: clientNameController,
              prefixIcon: Icon(Icons.person)),
          if (propertyName != null)
            AppTextFormField(
                label: 'Property_name'.tr,
                controller: propertyNameController,
                prefixIcon: Icon(Icons.meeting_room)),
          if (propertyNumber != null)
            AppTextFormField(
                keyboardType: TextInputType.number,
                label: 'Property_number'.tr,
                controller: propertyNumberController,
                prefixIcon: Icon(Icons.numbers)),
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
                    onPressed: () => apply(
                        clientNameController.text,
                        fromController.text,
                        toController.text,
                        propertyNameController.text,
                        propertyNumberController.text),
                    text: 'apply'.tr,
                    backgroundColor: AppColors.greenColor)),
          ]),
          Gap(responsiveHeight(10)),
        ]),
      ),
    ),
  ));
}
