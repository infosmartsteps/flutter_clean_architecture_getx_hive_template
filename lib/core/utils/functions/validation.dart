import 'package:get/get.dart';

String? phoneNumberValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'please_enter_valid_phone'.tr;
  }
  if (!RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
      .hasMatch(value)) {
    return 'please_enter_valid_phone'.tr;
  }
  return null;
}

String? emailValidation(String? value) {
  if (value != null && value.isNotEmpty) {
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'please_enter_valid_email'.tr;
    }
  } else {
    return requiredFieldValidation(value);
  }
  return null;
}

String? requiredFieldValidation(String? value, [String? text]) {
  if (value == null || value.isEmpty) {
    return text ?? 'Required field'.tr;
  }
  return null;
}