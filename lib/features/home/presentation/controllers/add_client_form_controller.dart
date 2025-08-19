import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../widgets/map_screen.dart';

class AddClientFormController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final scrollController = ScrollController();

  // Field focus nodes
  final clientNameFocus = FocusNode();
  final responsiblePersonFocus = FocusNode();
  final phoneNumberFocus = FocusNode();
  final businessSectorFocus = FocusNode();
  final locationFocus = FocusNode();
  final addressFocus = FocusNode();
  final registrationNumberFocus = FocusNode();
  final responsiblePersonPhoneFocus = FocusNode();
  final cityFocus = FocusNode();
  final informationSourceFocus = FocusNode();
  final emailFocus = FocusNode();

  // controllers
  final clientNameController = TextEditingController();
  final responsiblePersonController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final locationController = TextEditingController();
  final addressController = TextEditingController();
  final registrationNumberController = TextEditingController();
  final responsiblePersonPhoneController = TextEditingController();
  final emailController = TextEditingController();
  final clientWebsiteController = TextEditingController();

  String? selectedBusinessSector;
  String? selectedCity;
  String? selectedInformationSource;

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

  // Dropdown options
  final RxList<String> businessSectors = <String>[].obs;

  final RxList<String> cities = <String>[].obs;

  final RxList<String> informationSources = <String>[].obs;

  void getBusinessSectors() {
    businessSectors.value = [
      'تجزئة',
      'تصنيع',
      'رعاية صحية',
      'تعليم',
      'تكنولوجيا',
      'تمويل',
      'ضيافة',
      'بناء',
      'نقل',
      'أخرى'
    ];
  }

  void getCities() {
    cities.value = [
      'الرياض',
      'جدة',
      'مكة',
      'المدينة المنورة',
      'الدمام',
      'الخبر',
      'الطائف',
      'بريدة',
      'تبوك',
      'أبها'
    ];
  }

  void getInformationSources() {
    informationSources.value = [
      'الإنترنت',
      'إعلان',
      'معرض',
      'توصية',
      'وسائل التواصل الاجتماعي',
      'أخرى'
    ];
  }

  void selectCity(String? value) {
    selectedCity = value;
  }

  void selectInformationSource(String? value) {
    selectedInformationSource = value;
  }

  void selectBusinessSector(String? value) {
    selectedBusinessSector = value;
  }

  // Helper function to scroll to and focus on a field
  void scrollToField(FocusNode focusNode, [double offset = 0]) async {
    scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    if (focusNode.hasFocus) {
      Get.focusScope?.unfocus();
      await Future.delayed(const Duration(milliseconds: 300));
    }
    focusNode.requestFocus();
  }

  openLocation() {
    Get.to(MapScreen());
  }

  void saveForm() {
    final form = formKey.currentState!;
    if (!form.validate()) {
      // Find the first field with an error and scroll to it
      if (clientNameController.text.isEmpty) {
        scrollToField(clientNameFocus);
      } else if (requiredFieldValidation(responsiblePersonController.text) !=
          null) {
        scrollToField(responsiblePersonFocus);
      } else if (phoneNumberValidation(phoneNumberController.text) != null) {
        scrollToField(phoneNumberFocus);
      } else if (selectedBusinessSector == null) {
        scrollToField(businessSectorFocus, 200);
      } else if (requiredFieldValidation(locationController.text) != null) {
        scrollToField(locationFocus);
      } else if (selectedCity == null) {
        scrollToField(cityFocus, 300);
      } else if (requiredFieldValidation(addressController.text) != null) {
        scrollToField(addressFocus);
      } else if (requiredFieldValidation(registrationNumberController.text) !=
          null) {
        scrollToField(registrationNumberFocus);
      } else if (requiredFieldValidation(
              responsiblePersonPhoneController.text) !=
          null) {
        scrollToField(responsiblePersonPhoneFocus);
      } else if (selectedInformationSource == null) {
        scrollToField(informationSourceFocus, 400);
      } else if (emailValidation(emailController.text) != null) {
        scrollToField(emailFocus);
      }
      return;
    }
    // If form is valid, proceed with saving
    Get.back();
    Get.snackbar(
      'Success'.tr,
      'Client added successfully'.tr,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onInit() {
    getBusinessSectors();
    getCities();
    getInformationSources();
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    clientNameFocus.dispose();
    phoneNumberFocus.dispose();
    businessSectorFocus.dispose();
    cityFocus.dispose();
    informationSourceFocus.dispose();
    emailFocus.dispose();
    clientNameController.dispose();
    responsiblePersonController.dispose();
    phoneNumberController.dispose();
    locationController.dispose();
    addressController.dispose();
    registrationNumberController.dispose();
    responsiblePersonPhoneController.dispose();
    emailController.dispose();
    clientWebsiteController.dispose();
    super.dispose();
  }
}
