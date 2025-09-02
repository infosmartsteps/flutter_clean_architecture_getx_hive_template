import 'package:flutter/material.dart';
import '../utils/form_utils.dart';
import '../widgets/app_text_form_field.dart';

Widget customPhoneField(FormFieldModel field, String label, IconData icon,
    {Function(String)? onChanged}) {
  return AppTextFormField(
      onChanged: onChanged,
      fieldModel: field,
      keyboardType: TextInputType.phone,
      label: label,
      prefixIcon: Icon(icon));
}
