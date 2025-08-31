import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';

import '../../features/home/presentation/controllers/add_client_form_controller.dart';
import '../widgets/app_text_form_field.dart';

//lib/core/utils/form_utils.dart
class FormFocusManager {
  final Map<String, FocusNode> _focusNodes = {};
  final Map<String, GlobalKey> _fieldKeys = {};

  FocusNode getFocusNode(String fieldName) {
    return _focusNodes.putIfAbsent(fieldName, () => FocusNode());
  }

  GlobalKey getFieldKey(String fieldName) {
    return _fieldKeys.putIfAbsent(fieldName, () => GlobalKey());
  }

  void requestFocus(String fieldName) {
    _focusNodes[fieldName]?.requestFocus();
  }

  void dispose() {
    for (var node in _focusNodes.values) {
      node.dispose();
    }
    _focusNodes.clear();
    _fieldKeys.clear();
  }
}

class FormFieldModel {
  final String? name;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final GlobalKey? key;
  final String? Function(String?)? validator;

  FormFieldModel({
    this.name,
    this.controller,
    this.focusNode,
    this.key,
    this.validator,
  });

  void dispose() {
    controller?.dispose();
    focusNode?.dispose();
  }
}

FormFieldModel createFieldModel(String key,
    [String? Function(String?)? validation]) {
  final FormFocusManager focusManager = FormFocusManager();
  return FormFieldModel(
      name: key,
      focusNode: focusManager.getFocusNode(key),
      key: focusManager.getFieldKey(key),
      controller: TextEditingController(),
      validator: validation);
}

// Validation functions
String? requiredFieldValidation(String? value, [String? message]) {
  if (value == null || value.isEmpty) {
    return message ?? 'This field is required';
  }
  return null;
}

String? phoneNumberValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  }
  // Add phone validation logic
  return null;
}

String? emailValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  if (!GetUtils.isEmail(value)) {
    return 'Enter a valid email';
  }
  return null;
}

Widget buildTextField(FormFieldModel field, String label, IconData icon) {
  return AppTextFormField(
      fieldModel: field, label: label, prefixIcon: Icon(icon));
}

Widget buildPhoneField(FormFieldModel field, String label, IconData icon,
    {Function(String)? onChanged}) {
  return AppTextFormField(
      onChanged: onChanged,
      fieldModel: field,
      keyboardType: TextInputType.phone,
      label: label,
      prefixIcon: Icon(icon));
}

Widget buildLocationFields(
    AddClientFormController controller, FormFieldModel formFieldModel) {
  return AppTextFormField(
      readOnly: true,
      width: responsiveWidth(180),
      onTap: controller.openClientLocation,
      prefixIcon: const Icon(Icons.location_history_outlined),
      fieldModel: formFieldModel,
      label: 'client_location'.tr);
}
