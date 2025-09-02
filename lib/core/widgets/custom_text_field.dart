import 'package:flutter/material.dart';
import '../utils/form_utils.dart';
import '../widgets/app_text_form_field.dart';

Widget customTextField(FormFieldModel field, String label,
    {IconData? icon,
    maxLines,
    bool showLabel = false,
    TextInputAction textInputAction = TextInputAction.next}) {
  return AppTextFormField(
    showLabel: showLabel,
    maxLines: maxLines,
    fieldModel: field,
    label: label,
    prefixIcon: Icon(icon),
    textInputAction: textInputAction,
  );
}
