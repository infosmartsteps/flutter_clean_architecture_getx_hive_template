import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

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